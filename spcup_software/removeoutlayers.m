function [ENFNew] = removeoutlayers(ENFOld,alpha)
% Remove outlayers using interpolation
[b,indx,~] = deleteoutliers(ENFOld,alpha);

n = 1:length(ENFOld);
n1 = n;
n1(indx) = [];
ENFOld(indx) = [];

ENFNew =  interp1(n1,b,n,'linear');
end