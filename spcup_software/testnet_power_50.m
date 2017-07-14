%NN for predicting the label of a power sample of nominal frequency 50Hz
function [ Label,confi ] = testnet_power_50(mat4Test)
    load net_50
    y2 = (mat4Test.Features);
    t2 = (mat4Test.Grid);
    testX1 = y2';
    Label = [];
    threshold = 0.65;
    testY1 = net_50(testX1);
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