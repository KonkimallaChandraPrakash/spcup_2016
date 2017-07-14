close all;
clear all;
clc;
load see_50;
y = (mat4_main_50.Features);
y = y';
t = mat4_main_50.Grid';
x  = y;
setdemorandstream(391418381);
net_50 = feedforwardnet([12 35 20]);
net_50.trainFcn = 'trainoss';
[net_50,tr] = train(net_50,x,t);
save net_50
nntraintool
disp('training is done')
testX = x(:,tr.testInd);
testT = t(:,tr.testInd);
testY = net_50(testX);

testIndices = vec2ind(testY);
plotconfusion(testT,testY)


[c,cm] = confusion(testT,testY)

fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);