function [output] = ClassificationNN_Power(ENF,nominal)
    [Features,Grid] = total_feature(240,120,ENF',{'0,0,0,0,0,0,0,0,0,1'});
    mat4ENF = struct('Features',Features,'Grid',Grid);
    if (nominal == 50)
        [label,confi] = testnet_power_50(mat4ENF);
    elseif (nominal == 60)
        [label,confi] = testnet_power_60(mat4ENF);
    end
    [output] = [label confi];
end