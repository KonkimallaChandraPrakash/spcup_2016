function [nominal] = Actualnominal(P1,F,nominal,width_band,harmonic_multiples) 
N_harmns = length(harmonic_multiples);
%% Update nominal Frequency
F_up = harmonic_multiples*(nominal + width_band);
F_dn = harmonic_multiples*(nominal - width_band);

SpecStrips = cell(N_harmns ,1);
StripFreq  = cell(N_harmns ,1);


Pmean = [];
Freq = [];

for i = 1: N_harmns
    indx = find(F>=F_dn(i) & F<=F_up(i));
    SpecStrips{i} = P1(indx,:);
    StripFreq{i} =  F(indx);
    
    Pmean = [Pmean;mean(P1(indx,:),2)/max(max(P1))];
    Freq =  [Freq; F(indx)/i];
end

[~,normIndx] = max(Pmean);
 nominal = Freq(normIndx);
end