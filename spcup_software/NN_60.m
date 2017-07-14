close all;
clear all;
clc;
load see_60;
y = (mat4_main_60.Features);
y = y';
t = mat4_main_60.Grid';
x  = y;
setdemorandstream(391418381);
net_60 = feedforwardnet([12 12 20]);
net_60.trainFcn = 'trainscg';
view(net_60);
[net_60,tr] = train(net_60,x,t);
save net_60
nntraintool
disp('training is done')
disp(tr)

testX = x(:,tr.testInd);
testT = t(:,tr.testInd);
testY = net_60(testX);
testIndices = vec2ind(testY);
plotconfusion(testT,testY)


[c,cm] = confusion(testT,testY)

fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);