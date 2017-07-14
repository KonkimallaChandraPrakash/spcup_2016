function output=first_edition(filePath)
    disp(filePath);
    [ratio,X,fs]=power_or_audio(filePath);
    if ratio>0.99
        %disp('Power');
        nominal=power_50_or_60(X,fs);
        %disp(nominal);
        	ENF=fast_script_test(filePath,nominal);
        	output = ClassificationNN_Power(ENF,nominal);
        
    else
        %disp('Audio');
        nominal = ComputeNominal(filePath);
        %disp(nominal);
        [ENF]=fast_script_test(filePath,nominal);
        output = ClassificationNN_audio(ENF,nominal);
    end
end
