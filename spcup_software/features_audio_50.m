function [final_features]=features_audio_50(freq_vector)
%x is enf
x=freq_vector;
size(x);
x=x(:,1);
mean_of_data=mean(x);
range_of_data=log(max(x)-min(x));
variance_of_log=log(var(x));


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


[B ,~]=prony(x,3,3);

for i=3:length(x)
    val_detail_1=log(var(sig_detail_1));
end

data=freq_vector;
num = 3;
dem = 3;
stmcb_G.stmcb_num = zeros(1,num+1);
stmcb_G.stmcb_dem = zeros(1,dem+1);
[stmcb_G.stmcb_num, stmcb_G.stmcb_dem] = stmcb(data,num,dem);


a5 = stmcb_G.stmcb_dem(:)';
final_features=[mean_of_data range_of_data variance_of_log val_appox_4 val_detail_4 val_detail_3 val_detail_2 val_detail_1 B(1:3) stmcb_G.stmcb_num(:)' a5(2:end)];
