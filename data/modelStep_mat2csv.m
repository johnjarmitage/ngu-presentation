# script to export model output mat file to csv

cHeader = {'time' 'ice_sheet' 'erupt_rate' 'CO2_flux' 'Nb'}; %dummy header
commaHeader = [cHeader;repmat({','},1,numel(cHeader))]; %insert commaas
commaHeader = commaHeader(:)';
textHeader = cell2mat(commaHeader); %cHeader in text with commas

%write header to file
fid = fopen('modelStep_1e-7.csv','w'); 
fprintf(fid,'%s\n',textHeader)
fclose(fid)

% load data
load('/media/armitage/Portable_Ba/code/FEM/1d_melting/data/iceland/Step_10^21_1450_200_10mmyr_Te10_k1e-7_800.mat')

% some constants
kappa = 1e-6;
lz    = 300e3;
year  = 365*24*60*60;
kyr   = 1e-3*lz*lz/(kappa*year);
myr   = year*kappa/lz;
kmMyr = 1e3*year*kappa/lz;

melt_density  = 2700;
area_volcanes = 30000e6;
ppm2wtpyr     = 3.67*1e-9*1e-5*melt_density*area_volcanes*myr;

% extract a time window
n = find(kyr*time >= 4840 & kyr*time <= 4960);

time_out = abs(4960-kyr*time(n));
ice_sheet = 1e-3*glacier(n)/920/9.81;
erupt_rate = kmMyr*merupt(n);
CO2_flux = ppm2wtpyr*topCMelt(15,n).*merupt(n);
Nb_out = 1.2*topCMelt(16,n);

%write data to end of file
dlmwrite('modelStep_1e-7.csv',[time_out' ice_sheet' erupt_rate' CO2_flux' Nb_out'],'-append');