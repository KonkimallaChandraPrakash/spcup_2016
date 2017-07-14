function [ENF,harmonic] = ENF4Signal(Signal,Mtrx,AllFrq,N,NOvrlp,NumHarmncs)

% Input
% Signal  Signal for which ENF to be calculated
% Mtrx     Selected frequency Fourier matrix
% AllFrq  Vector having corresponding freq considered in matrix
% N           Length of one frame (Frame time * Fs)
% NOvrlp Overlapping length  (Overlap time * Fs)
% NumHarmncs Number of harmonics considered

% Output
% ENF signal

%% Normal frequency from harmonics (Index)
L = length(AllFrq);
Seprtr = floor(L/NumHarmncs);
temp = zeros(size(AllFrq));
Whchharmons = 1;
for i = 1:NumHarmncs
    temp((i-1)*Seprtr + 1: (i*Seprtr)) = Whchharmons;
    Whchharmons = Whchharmons + 1;
end

NormFreq = AllFrq./temp;

%clear L temp
%% Calculating ENF for the signal
L = length(Signal);
FramShft = N - NOvrlp;
NumFram = floor((L - NOvrlp)/FramShft);
ENF = zeros(1,NumFram);

% Computing over all frames
for i = 1:NumFram
    x = Signal( (i-1)*FramShft + 1 : (i-1)*FramShft + N);
    b = abs(Mtrx*x);
    [~,Indx] = max(b);
    ENFofFram = NormFreq(Indx);
    whichharmonic(i)=temp(Indx);
    ENF(i) = ENFofFram;
end
%%
for i=1:NumHarmncs
    count(i)=sum(whichharmonic==i);
end
[~,harmonic]=max(count);
end