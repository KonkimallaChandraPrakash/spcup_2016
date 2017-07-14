function nominal=power_50_or_60(X,fs)
    num_50_har=floor(fs/(2*50));
    num_60_har=floor(fs/(2*60));
    signal_max=1;%general case
    lowerbound_50=50-signal_max;
    upperbound_50=50+signal_max;
    lowerbound_60=60-signal_max;
    upperbound_60=60+signal_max;
    limits_50=zeros(num_50_har,2);
    limits_60=zeros(num_60_har,2);
    for i=1:num_50_har
        limits_50(i,1)=ceil(i*lowerbound_50*length(X)/fs);
        limits_50(i,2)=ceil(i*upperbound_50*length(X)/fs);
    end
    
    for i=1:num_60_har
        limits_60(i,1)=ceil(i*lowerbound_60*length(X)/fs);
        limits_60(i,2)=ceil(i*upperbound_60*length(X)/fs);
    end
    
    sum_50_power=0;
    for i=1:num_50_har
        sum_50_power=sum(X(limits_50(i,1):limits_50(i,2)))+sum_50_power;
    end
    sum_60_power=0;
    for i=1:num_60_har
        sum_60_power=sum(X(limits_60(i,1):limits_60(i,2)))+sum_60_power;
    end
    if sum_60_power>sum_50_power
        nominal=60;
    else
        nominal=50;
    end
end