function thres=detect_b_case(nominal,enf,filename)
%close all;
% [signal,fs] = wavread('/home/francis/PhD/SP_CUP/spcup_Programs/Database/Train_Grid_E_A2.wav');
% [signal,fs] = wavread('/home/francis/PhD/SP_CUP/spcup_Programs/Database/Practice_28.wav');
% [signal,fs] = wavread('/home/francis/PhD/SP_CUP/spcup_Programs/Database/Test_40.wav');
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
%%
%figure;spectrogram(signal,N_frame,N_Ovrlp,Nfft,fs);
[~,F,T,P1]=spectrogram(signal,N_frame,N_Ovrlp,Nfft,fs);
nominal = InitalNomnlFreq(P1,F,harmonic_multiples,width_band, width_signal,N_Prdur,N_signal,N_FrmPrdur );
nominalENF  = Actualnominal(P1,F,nominal,width_band,harmonic_multiples);
%thres=max(abs(nominalENF-enf));
thres=max(abs(nominal-enf));