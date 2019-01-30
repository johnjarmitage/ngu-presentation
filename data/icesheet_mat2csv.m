# script to export ice sheet history mat file to csv

cHeader = {'time' 'ice5g' 'pico' 'lambeck'}; %dummy header
commaHeader = [cHeader;repmat({','},1,numel(cHeader))]; %insert commaas
commaHeader = commaHeader(:)';
textHeader = cell2mat(commaHeader); %cHeader in text with commas

%write header to file
fid = fopen('iceland.csv','w'); 
fprintf(fid,'%s\n',textHeader)
fclose(fid)

# load data
load("/media/armitage/Portable_Ba/code/FEM/1d_melting/data/iceland/iceland_rescaled_120k.mat")

%write data to end of file
dlmwrite('iceland.csv',[IcelandV.time IcelandV.ICE5G_res IcelandV.PC2_res IcelandV.Lambeck_res],'-append');