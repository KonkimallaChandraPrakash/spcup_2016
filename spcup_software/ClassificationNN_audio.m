function [output]=ClassificationNN_audio(ENF,nominal)
no_samples = 240;
no_overlap = 120;
threshold = 0.5;

    if nominal==50
        load Net_audio_50.mat;
        [feat,~]=total_feature_audio_50(no_samples,no_overlap,ENF(:),' ');
        test_50 = Net_Audio_50(feat');
        Test_50 = sum(test_50,2)/size(test_50,2);
        [m1,m1_index] = max(Test_50);
            if(m1 < threshold)
                testIndices_50 = 10;
                Confidence = 0;
            else
                testIndices_50 = m1_index;
                Confidence = m1;
            end
        Grid = testIndices_50;
        
    else
        load Net_audio_60.mat;
        [feat,~]=total_feature(no_samples,no_overlap,ENF(:),' ');
        test_60 = Net_Audio_60(feat');
        Test_60 = sum(test_60,2)/size(test_60,2);
        [m1,m1_index] = max(Test_60);
            if(m1 < threshold)
                testIndices_60 = 10;
                Confidence = 0;
            else
                testIndices_60 = m1_index;
                Confidence = m1;
            end
         Grid = testIndices_60;   
    
    end
    [output] = [Grid Confidence];
end