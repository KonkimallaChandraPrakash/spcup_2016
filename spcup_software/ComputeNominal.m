%% Computing Nominal Frequency
function [nominal] = ComputeNominal(InputFileName)
%% Load Signal
[Data,Fs] = audioread(InputFileName);

%% Initialize
%Fs = 1000;                                                                           % Sampling Freq
Time = 30;                                                                           % Sec
N = Fs*Time;                                                                       % Number of samples to compute ENF
TimeOvrlp = 29;                                                                  % Sec
NOrlp = Fs*TimeOvrlp;                                                     % Number of samples overlaping

NumHarmncs = 4;                                                             % Considering 4 harminics
Frq = [50 60 2*50 2*60 3*50 3*60 4*50 4*60];          %  Freq looking 4
Signal_sideBand = 1;                                                       % 1Hz 
Resol  = Fs/N;                                                                    % Frequency resolution
Lmts = zeros(2,length(Frq));
Lmts(1,:) = round((Frq-Signal_sideBand).*(1/Resol));                          % Limits of freq intex bins
Lmts(2,:) = round((Frq+Signal_sideBand).*(1/Resol)); 

%% Freq bin intex
m =[];
for i = 1: length(Frq)
    temp = linspace(Lmts(1,i), Lmts(2,i),100);
    m = [m temp];
end
NUFreq = m.*Resol;
%% Forming Fractional DFT matrix
n = 0:N-1;
W = zeros(length(m),N);

for i = 1:length(m)
    W(i,:) = (1/sqrt(N)).* exp(-1i*2*pi*m(i)*n/N);
end

%% ENF extraction
[ENF,harmonic] = ENF4Signal(Data,W,NUFreq,N,NOrlp ,NumHarmncs);

%% Computing Nominal
if sum(ENF>55)> sum(ENF<55)
    nominal=60;
else
    nominal=50;
end
end