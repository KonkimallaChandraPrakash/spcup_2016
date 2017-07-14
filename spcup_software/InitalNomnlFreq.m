function [nominal] = InitalNomnlFreq(P1,F,harmonic_multiples,width_band, width_signal,N_Prdur,N_signal,N_FrmPrdur )
%%             %%%%%%%% Signal strips %%%%%%%%%%%%%%
N_harmns = length(harmonic_multiples);
N_dur = ceil(N_signal/N_Prdur);
%% Strips for 50
nominal = 50;
F_up = harmonic_multiples*(nominal + width_band);
F_dn = harmonic_multiples*(nominal - width_band);

SpecStrips50 = cell(N_harmns ,1);
StripFreq50  = cell(N_harmns ,1);
for i = 1: N_harmns
    indx = find(F>=F_dn(i) & F<=F_up(i));
    SpecStrips50{i} = P1(indx,:);
    StripFreq50{i} =  F(indx);
end


%% SNR for 50
SNR = zeros(N_harmns ,N_dur);
SignalFreq50 = cell(N_harmns ,1);
NoiseFreq50 = cell(N_harmns,1);
SignalStrip50 = cell(N_harmns ,1);
NoiseStrip50 = cell(N_harmns ,1);


F_up = harmonic_multiples*(nominal + width_signal);
F_dn = harmonic_multiples*(nominal - width_signal);

for i = 1: N_harmns
    indx = [1:length(StripFreq50{i})]';
    indxSignl = find(StripFreq50{i}>= F_dn(i) & StripFreq50{i}<= F_up(i));
    indxNois = setdiff(indx,indxSignl);
    SignalStrip50{i} = SpecStrips50{i}(indxSignl,:);
    SignalFreq50{i} =  StripFreq50{i}(indxSignl);
    
    NoiseStrip50{i} = SpecStrips50{i}(indxNois,:);
    NoiseFreq50{i} =  StripFreq50{i}(indxNois);
    
    for j = 1:N_dur
        FrmIndx = (j-1)*N_FrmPrdur+1: min(size(P1,2) , j*N_FrmPrdur);
        insid_mean = mean(mean(SignalStrip50{i}(:,FrmIndx)));
        outr_mean  = mean(mean(NoiseStrip50{i}(:,FrmIndx)));
        
        
        SNR(i, j) = insid_mean/outr_mean;
        
    end
end

% Normalize SNR
SNR50 = SNR./(ones(size(SNR,1),1)*sum(SNR));

%% Strips for 60
nominal = 60;
F_up = harmonic_multiples*(nominal + width_band);
F_dn = harmonic_multiples*(nominal - width_band);

SpecStrips60 = cell(N_harmns ,1);
StripFreq60  = cell(N_harmns ,1);
for i = 1: N_harmns
    indx = find(F>=F_dn(i) & F<=F_up(i));
    SpecStrips60{i} = P1(indx,:);
    StripFreq60{i} =  F(indx);
end




%% SNR for 60
SNR = zeros(N_harmns ,N_dur);
SignalFreq60 = cell(N_harmns ,1);
NoiseFreq60 = cell(N_harmns,1);
SignalStrip60 = cell(N_harmns ,1);
NoiseStrip60 = cell(N_harmns ,1);


F_up = harmonic_multiples*(nominal + width_signal);
F_dn = harmonic_multiples*(nominal - width_signal);

for i = 1: N_harmns
    indx = [1:length(StripFreq60{i})]';
    indxSignl = find(StripFreq60{i}>= F_dn(i) & StripFreq60{i}<= F_up(i));
    indxNois = setdiff(indx,indxSignl);
    SignalStrip60{i} = SpecStrips60{i}(indxSignl,:);
    SignalFreq60{i} =  StripFreq60{i}(indxSignl);
    
    NoiseStrip60{i} = SpecStrips60{i}(indxNois,:);
    NoiseFreq60{i} =  StripFreq60{i}(indxNois);
    
    for j = 1:N_dur
        FrmIndx = (j-1)*N_FrmPrdur+1: min(size(P1,2) , j*N_FrmPrdur);
        insid_mean = mean(mean(SignalStrip60{i}(:,FrmIndx)));
        outr_mean  = mean(mean(NoiseStrip60{i}(:,FrmIndx)));

        SNR(i, j) = insid_mean/outr_mean;
        
    end
end

% Normalize SNR
SNR60 = SNR./(ones(size(SNR,1),1)*sum(SNR));

%% Find Best nominal
if max(mean(SNR50,2)) > max(mean(SNR60,2))
    nominal = 50;
else
    nominal = 60;
end
end