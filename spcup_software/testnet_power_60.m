%NN for predicting the label of a power sample of nominal frequency 60Hz
function [ Label,confi ] = testnet_power_60(mat4Test)
load net_60;
y23 = (mat4Test.Features);
testX1 = y23';
Label = [];
threshold = 0.65;
testY1 = net_60(testX1);
testY1 = sum(testY1,2)/size(testY1,2);
     [m1,m1_index] = max(testY1);
     if(m1 < threshold)
         Label = 10;
         confi = 0;
     else
         Label = m1_index;
         confi = m1;
     end
 
end