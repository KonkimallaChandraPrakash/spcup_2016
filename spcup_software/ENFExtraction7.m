function ENFNew=ENFExtraction7(filename,nominal)
%function ENFNew=ENFExtraction7(filename,nominal)%,width_signal,width_band)
%close all;
% [signal,fs] = wavread('/home/francis/PhD/SP_CUP/spcup_Programs/Database/Train_Grid_E_A2.wav');
% [signal,fs] = wavread('/home/francis/PhD/SP_CUP/spcup_Programs/Database/Practice_28.wav');
% [signal,fs] = audioread('/Users/CHANDU/Desktop/Testing_dataset/Test_97.wav');
[signal,fs] = audioread(filename);
x = signal;
%% Variable
N_signal = length(signal);                                       
N_frame = fs*5;
N_Ovrlp = fs*3;
Nfft         = fs*20;
% Strip computing variable
width_band = 1;
harmonic_multiples = 1:4;
N_harmns = length(harmonic_multiples);
% Weight computing variable
dur_wht = 10;   % min
width_signal = 0.5;

% N_Prdur = dur_wht*60*fs;
N_Prdur = length(x);
N_dur = ceil(N_signal/N_Prdur);
N_FrmPrdur = ceil((N_Prdur - N_frame + 1)/(N_frame - N_Ovrlp));

%figure;spectrogram(signal,N_frame,0,Nfft,fs,'yaxis');
[~,F,T,P1]=spectrogram(signal,N_frame,N_Ovrlp,Nfft,fs);
%% Find nominal freq
%nominal = InitalNomnlFreq(P1,F,harmonic_multiples,width_band, width_signal,N_Prdur,N_signal,N_FrmPrdur );
%nominalENF  = Actualnominal(P1,F,nominal,width_band,harmonic_multiples) 
    
%% Find Spectral strips
F_up = harmonic_multiples*(nominal + width_band);
F_dn = harmonic_multiples*(nominal - width_band);

SupFreq = zeros(N_harmns ,2);
SpecStrips = cell(N_harmns ,1);
StripFreq  = cell(N_harmns ,1);
for i = 1: N_harmns 
    indx = find(F>=F_dn(i) & F<=F_up(i));
    SpecStrips{i} = P1(indx,:);
    StripFreq{i} =  F(indx);
end


    

%% Compute weight
Weights = zeros(N_harmns ,N_dur);
SignalFreq = cell(N_harmns ,1);
NoiseFreq = cell(N_harmns,1);
SignalStrip = cell(N_harmns ,1);
NoiseStrip = cell(N_harmns ,1);
N_Frames = size(P1,2);

F_up = harmonic_multiples*(nominal + width_signal);
F_dn = harmonic_multiples*(nominal - width_signal);

for i = 1: N_harmns 
    indx = [1:length(StripFreq{i})]';
    indxSignl = find(StripFreq{i}>= F_dn(i) & StripFreq{i}<= F_up(i));
    indxNois = setdiff(indx,indxSignl);
    SignalStrip{i} = SpecStrips{i}(indxSignl,:);
    SignalFreq{i} =  StripFreq{i}(indxSignl);
    
    NoiseStrip{i} = SpecStrips{i}(indxNois,:);
    NoiseFreq{i} =  StripFreq{i}(indxNois);
    
    for j = 1:N_dur
        FrmIndx = (j-1)*N_FrmPrdur+1: min(size(P1,2) , j*N_FrmPrdur);
        insid_mean = mean(mean(SignalStrip{i}(:,FrmIndx)));
        outr_mean  = mean(mean(NoiseStrip{i}(:,FrmIndx)));
        
        if insid_mean< outr_mean
            Weights(i, j) = 0;
        else
            Weights(i, j) = insid_mean/outr_mean;
        end
        
    end
end

% Normalize weightspectrogram(signal,N_frame,N_Ovrlp,Nfft,fs)
Weights = Weights./(ones(size(Weights,1),1)*sum(Weights));
[~,WhrENF] = max(Weights);
% StripMean = mean(SignalStrip{WhrENF},2);
% StripMean = StripMean/max(StripMean);
% SignalStrip{WhrENF} = diag(StripMean)*SignalStrip{WhrENF};

%% ENF extraction
StripWidth = size(SignalStrip{WhrENF},1);
Lmt = 5;
ENF = zeros(1,N_Frames);
[~, index] = max(SignalStrip{WhrENF}(:,1));
temp = SignalStrip{WhrENF};
% SignalFreq{WhrENF} = SignalFreq{WhrENF};
for i = 1:N_Frames
    [~,delta] = QuadInterpFunction(temp(:,i), index);
    if index == 1
        ENF(i) = (SignalFreq{WhrENF}(index)  - fs*(1-delta)/Nfft)/WhrENF + (fs/Nfft)/WhrENF;
    else
        ENF(i) = (SignalFreq{WhrENF}(index-1)  + fs*delta/Nfft)/WhrENF + (fs/Nfft)/WhrENF;
    end
    RoI = findRoI(StripWidth,index,Lmt);
    temp(:,i) = temp(:,i).*RoI;
    [~, index] = max(temp(:,i));
end

%% Remove outlayers
% figure;plot(ENF);title('Original ENF')
alpha =width_signal*1e-3;
% alpha = 1e-4;
[ENFNew] = removeoutlayers(ENF,alpha);
%figure;plot(ENFNew);title('ENF Outlayers removed')

%Spectral strips
% str = sprintf('Selected nominal = %d,Harmonics =  %d',nominal, WhrENF);
% figure; subplot(5,1,1)
% imagesc(10*log10(SignalStrip{WhrENF} ))
% title(str)
% 
%  subplot(5,1,2)
% imagesc(10*log10(SignalStrip{1} ))
% 
% subplot(5,1,3)
% imagesc(10*log10(SignalStrip{2} ))
% 
% subplot(5,1,4)
% imagesc(10*log10(SignalStrip{3} ))
% 
%  subplot(5,1,5)
% imagesc(10*log10(SignalStrip{4} ))