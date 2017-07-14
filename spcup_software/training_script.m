str1='/Users/CHANDU/Desktop/desktop/SP_CUP/MATLAB/Train_Grid_';
%str2_1='_P';str2_2='_A';
str2={'_P','_A'};
str3='.wav';
str_grid_array=['A','B','C','D','E','F','G','H','I'];nominal=[60,50,60,50,50,50,50,50,60];
num_times=[9,10,11,11,11,8,11,11,11;2,2,2,2,2,2,2,2,2];
cell_power_names=cell(2,9,max(max(num_times)));
enf_audio_power=cell(2,9,max(max(num_times)));
for k=1:2
    for i=1:9
        for j=1:num_times(k,i)
            cell_power_names{k,i,j}=strcat(str1,str_grid_array(i),str2{k},num2str(j),str3);
        end
    end
end
k=2;
%for k=1:2
    for i=1:9   
        for j=1:num_times(k,i)
            enf_audio_power{k,i,j}=first_edition(cell_power_names{k,i,j});
        end
    end
%end