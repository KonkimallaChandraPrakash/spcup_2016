function [final_features]=features_gmm(freq_vector)
%x is enf
x=freq_vector;
size(x);
x=x(:,1);
mean_of_data=mean(x);
range_of_data=log(max(x)-min(x));
variance_of_log=log(var(x));
second_moment_of_data=real(log(moment(x,3)));
third_moment_of_data=real(log(moment(x,3)));
fourth_moment_of_data=real(log(moment(x,4)));
fifth_moment_of_data=real(log(moment(x,5)));

[c,l] = wavedec(x,4,'db1');
sig_appox_4=c(1:l(1));
sig_detail_4=c(l(1)+1:l(1)+l(2));
sig_detail_3=c(l(1)+l(2)+1:l(1)+l(2)+l(3));
sig_detail_2=c(l(1)+l(2)+l(3)+1:l(1)+l(2)+l(3)+l(4));
sig_detail_1=c(l(1)+l(2)+l(3)+l(4)+1:l(1)+l(2)+l(3)+l(4)+l(5));

val_appox_4=log(var(sig_appox_4));
val_detail_4=log(var(sig_detail_4));
val_detail_3=log(var(sig_detail_3));
val_detail_2=log(var(sig_detail_2));
%disp(size(x));
arcoeffs = aryule(x,2);

[B A]=prony(x,3,3);

for i=3:length(x)
    v(i-2)=x(i)+arcoeffs(2)*x(i-1)+arcoeffs(3)*x(i-2);
    val_detail_1=log(var(sig_detail_1));
end
innovation_signal=var(v);
% var(x)
% var(v)
% model = arima('Constant',freq_vector(1),'AR',arcoeffs,'Variance',0.1);%francis 
% Y = simulate(model,length(x));
% innovation_signal=var(Y);
%model = arima('ARLags',1:2,'Constant',0)

% options=statset('MaxIter',200,'TolFun',1e-2);
% GMModel4 = gmdistribution.fit(x,4,'SharedCov',logical(1),'Options',options);
% 
% gmmean=GMModel4.mu;
% gmvariance=GMModel4.Sigma;

%L = length(x);
%  N = 1000;  % Size of window
%  itr = floor(L/N)
data=freq_vector;
 Ordr = 5;
 AR_A.aryule_coeffs  = zeros(1,Ordr+1);
 AR_A.arburg_coeffs  = zeros(1,Ordr+1);
 AR_A.arcov_coeffs  = zeros(1,Ordr+1);
 AR_A.armcov_coeffs  = zeros(1,Ordr+1);
 num = 3;
dem = 3;
 stmcb_G.stmcb_num = zeros(1,num+1);
stmcb_G.stmcb_dem = zeros(1,dem+1);
[stmcb_G.stmcb_num, stmcb_G.stmcb_dem] = stmcb(data,num,dem);
 %for i = 1:itr
     %data = x(N*(i-1) + 1: N*i);
%      AR_A.aryule_coeffs(i,:)  = aryule(data,Ordr);
%      AR_A.arburg_coeffs(i,:) = arburg(data,Ordr);
%      AR_A.arcov_coeffs(i,:)   =arcov(data,Ordr); 
%      AR_A.armcov_coeffs(i,:)=armcov(data,Ordr);
 %end
AR_A.aryule_coeffs = aryule(data,Ordr);
AR_A.arburg_coeffs = arburg(data,Ordr);
AR_A.arcov_coeffs  = arcov(data,Ordr); 
AR_A.armcov_coeffs = armcov(data,Ordr);
%  ARyule=AR_A.aryule_coeffs;
%  ARburg=AR_A.arburg_coeffs;
%  ARcov =AR_A.arcov_coeffs;
%  ARmcov =AR_A.armcov_coeffs;

%final_features=[mean_of_data range_of_data val_appox_4 val_detail_4 val_detail_3 val_detail_2 val_detail_1 arcoeffs(2:3) innovation_signal];
%final_features=[mean_of_data variance_of_data range_of_data second_moment_of_data third_moment_of_data fourth_moment_of_data fifth_moment_of_data gmmean(:)' gmvariance(:)' AR_A.aryule_coeffs(i,:)  AR_A.arburg_coeffs(i,:) AR_A.arcov_coeffs(i,:) AR_A.armcov_coeffs(i,:) val_appox_4];
%final_features=[mean_of_data range_of_data AR_A.arburg_coeffs(:)' AR_A.arcov_coeffs(:)' AR_A.armcov_coeffs(:)' B val_appox_4];
%final_features=[mean_of_data range_of_data AR_A.arburg_coeffs(:)' B A val_appox_4];
%final_features=[mean_of_data range_of_data AR_A.arcov_coeffs(:)' B A val_appox_4];
feat_gm = [];
options=statset('MaxIter',200,'TolFun',1e-2);
% GMModel4 = gmdistribution.fit(x,4,'SharedCov',logical(1),'Options',options);
% obj = gmdistribution.fit(x,2,'Options',options);
% disp(size(obj.mu));
% disp(size(obj.Sigma));
% feat_gm = [obj.mu(1,1) obj.mu(2,1) obj.Sigma(:,:,1) obj.Sigma(:,:,2)];
save obj;
a1 = AR_A.aryule_coeffs(:)' ;
a2 = AR_A.arburg_coeffs(:)' ;
a3 = AR_A.arcov_coeffs(:)';
a4 = AR_A.armcov_coeffs(:)';
a5 = stmcb_G.stmcb_dem(:)';
% final_features=[mean_of_data range_of_data variance_of_log val_appox_4 val_detail_4 val_detail_3 val_detail_2 val_detail_1 arcoeffs(2:3) innovation_signal AR_A.aryule_coeffs(:)' AR_A.arburg_coeffs(:)' AR_A.arcov_coeffs(:)' AR_A.armcov_coeffs(:)'  B A(2:end) stmcb_G.stmcb_num(:)' stmcb_G.stmcb_dem(:)'];
final_features=[mean_of_data range_of_data variance_of_log val_appox_4 val_detail_4 val_detail_3 val_detail_2 val_detail_1 arcoeffs(2:3) innovation_signal a1(2:end) a2(2:end) a3(2:end) a4(2:end)  B A(2:end) stmcb_G.stmcb_num(:)' a5(2:end)];
% feature_support=[1 1 1 1 1 1 1 1 3 length(AR_A.aryule_coeffs(:)') length(AR_A.arburg_coeffs(:)') length(AR_A.arcov_coeffs(:)') length(AR_A.armcov_coeffs(:)')  length(B)+length(A) length(stmcb_G.stmcb_num(:)') length(stmcb_G.stmcb_dem(:)')];
% save Feature_Support.mat feature_support
%save AR_coefficients AR_A