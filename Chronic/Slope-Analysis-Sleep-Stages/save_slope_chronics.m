

%% save variables for slope analysis
clc
clear
cd /home/genzellab/Desktop/Pelin/november_periodograms/slope-analysis/chronics

%% REM
load('rem_chronics_spectrum.mat');

rem_cbd_PFC_chronics=SpectrumAllCBDPFC(:,1:164);
rem_cbd_HPC_chronics=SpectrumAllCBDHPC(:,1:164);
rem_veh_PFC_chronics=SpectrumAllControlPFC(:,1:164);
rem_veh_HPC_chronics=SpectrumAllControlHPC(:,1:164);

% unlog the spectrum
% spectrum=20*log10(spectrum)
rem_cbd_PFC_chronics=10.^(rem_cbd_PFC_chronics/20);                                                                                                                                                                                                                                                                                                                                            
rem_cbd_HPC_chronics=10.^(rem_cbd_HPC_chronics/20); 
rem_veh_PFC_chronics=10.^(rem_veh_PFC_chronics/20);                                                                                                                                                                                                                                                                                                                                            
rem_veh_HPC_chronics=10.^(rem_veh_HPC_chronics/20);                                                                                                                                                                                                                                                                                                                                            

save rem_cbd_PFC_chronics.mat rem_cbd_PFC_chronics
save rem_cbd_HPC_chronics.mat rem_cbd_HPC_chronics
save rem_veh_PFC_chronics.mat rem_veh_PFC_chronics
save rem_veh_HPC_chronics.mat rem_veh_HPC_chronics

%% NREM
clear
load('nrem_chronics_spectrum.mat');
nrem_cbd_PFC_chronics=SpectrumAllCBDPFC(:,1:164);
nrem_cbd_HPC_chronics=SpectrumAllCBDHPC(:,1:164);
nrem_veh_PFC_chronics=SpectrumAllControlPFC(:,1:164);
nrem_veh_HPC_chronics=SpectrumAllControlHPC(:,1:164);

% unlog the spectrum
% spectrum=20*log10(spectrum)
nrem_cbd_PFC_chronics=10.^(nrem_cbd_PFC_chronics/20);                                                                                                                                                                                                                                                                                                                                            
nrem_cbd_HPC_chronics=10.^(nrem_cbd_HPC_chronics/20); 
nrem_veh_PFC_chronics=10.^(nrem_veh_PFC_chronics/20);                                                                                                                                                                                                                                                                                                                                            
nrem_veh_HPC_chronics=10.^(nrem_veh_HPC_chronics/20); 

save nrem_cbd_PFC_chronics.mat nrem_cbd_PFC_chronics
save nrem_cbd_HPC_chronics.mat nrem_cbd_HPC_chronics
save nrem_veh_PFC_chronics.mat nrem_veh_PFC_chronics
save nrem_veh_HPC_chronics.mat nrem_veh_HPC_chronics

%%
clear
load('freq.mat')
freq=freq(1:164);
save freq.mat freq
clear
FileData = load('freq.mat');
csvwrite('freq.csv', FileData.freq)

%% rem
clear
FileData = load('rem_cbd_PFC_chronics.mat');
csvwrite('rem_cbd_PFC_chronics.csv', FileData.rem_cbd_PFC_chronics)

clear
FileData = load('rem_cbd_HPC_chronics.mat');
csvwrite('rem_cbd_HPC_chronics.csv', FileData.rem_cbd_HPC_chronics)

clear
FileData = load('rem_veh_PFC_chronics.mat');
csvwrite('rem_veh_PFC_chronics.csv', FileData.rem_veh_PFC_chronics)

clear
FileData = load('rem_veh_HPC_chronics.mat');
csvwrite('rem_veh_HPC_chronics.csv', FileData.rem_veh_HPC_chronics)

%% nrem
clear
FileData = load('nrem_cbd_PFC_chronics.mat');
csvwrite('nrem_cbd_PFC_chronics.csv', FileData.nrem_cbd_PFC_chronics)

clear
FileData = load('nrem_cbd_HPC_chronics.mat');
csvwrite('nrem_cbd_HPC_chronics.csv', FileData.nrem_cbd_HPC_chronics)

clear
FileData = load('nrem_veh_PFC_chronics.mat');
csvwrite('nrem_veh_PFC_chronics.csv', FileData.nrem_veh_PFC_chronics)

clear
FileData = load('nrem_veh_HPC_chronics.mat');
csvwrite('nrem_veh_HPC_chronics.csv', FileData.nrem_veh_HPC_chronics)



