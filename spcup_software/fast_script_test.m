function [ENFNew]=fast_script_test(filename,nominal)
    ENFNew=ENFExtraction7(filename,nominal);
    thres=detect_b_case(nominal,ENFNew,filename);
    if thres>0.5
       ENFNew=ENFExtractionBGrid(filename,nominal);
    end
end