function [feat,grid]=total_feature(no_samples,no_overlap,array,char)
grid=[];
feat = [];
k=1;
start_elem=1;
end_elem=no_samples;
while end_elem<length(array)
    feat(k,:) = features_gmm(array(start_elem:end_elem,1));
    start_elem=start_elem+no_samples-no_overlap;
    end_elem=end_elem+no_samples-no_overlap;
    k=k+1;
end
for i=1:k-1
    grid=[grid ; char];
end
end