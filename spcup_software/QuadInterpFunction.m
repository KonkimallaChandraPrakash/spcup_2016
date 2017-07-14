function [ k_star,delta ] = QuadInterpFunction( vector, index )
%QUAD_INTERP_FUNC Summary of this function goes here
%   This function finds the index 'k_star' of the maximum value in 'vector'
%   about 'index', computed using quadratic interpolation

if index == 1
    index = 2;
elseif index == length(vector)
    index = length(vector) - 1;
end
alpha = 20 * log10(abs(vector(index - 1)));
beta = 20* log10(abs(vector(index)));
gamma = 20*log10(abs(vector(index + 1)));
delta = 0.5*(alpha - gamma)/(alpha - 2*beta + gamma);
kmax = index - 1;
k_star = kmax + delta;
end