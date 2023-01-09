

%% save variables for slope analysis
clc
clear
cd /home/genzellab/Desktop/Pelin/november_periodograms/slope-analysis/acutes

%% REM
load('rem_acutes_spectrum.mat');

rem_cbd_PFC_acutes=SpectrumAllCBDPFC(:,1:171);
rem_cbd_HPC_acutes=SpectrumAllCBDHPC(:,1:171);
rem_veh_PFC_acutes=SpectrumAllControlPFC(:,1:171);
rem_veh_HPC_acutes=SpectrumAllControlHPC(:,1:171);

% unlog the spectrum
% spectrum=20*log10(spectrum)
rem_cbd_PFC_acutes=10.^(rem_cbd_PFC_acutes/20);                                                                                                                                                                                                                                                                                                                                            
rem_cbd_HPC_acutes=10.^(rem_cbd_HPC_acutes/20); 
rem_veh_PFC_acutes=10.^(rem_veh_PFC_acutes/20);                                                                                                                                                                                                                                                                                                                                            
rem_veh_HPC_acutes=10.^(rem_veh_HPC_acutes/20);                                                                                                                                                                                                                                                                                                                                            

save rem_cbd_PFC_acutes.mat rem_cbd_PFC_acutes
save rem_cbd_HPC_acutes.mat rem_cbd_HPC_acutes
save rem_veh_PFC_acutes.mat rem_veh_PFC_acutes
save rem_veh_HPC_acutes.mat rem_veh_HPC_acutes

%% NREM
clear
load('nrem_acutes_spectrum.mat');
nrem_cbd_PFC_acutes=SpectrumAllCBDPFC(:,1:171);
nrem_cbd_HPC_acutes=SpectrumAllCBDHPC(:,1:171);
nrem_veh_PFC_acutes=SpectrumAllControlPFC(:,1:171);
nrem_veh_HPC_acutes=SpectrumAllControlHPC(:,1:171);

% unlog the spectrum
% spectrum=20*log10(spectrum)
nrem_cbd_PFC_acutes=10.^(nrem_cbd_PFC_acutes/20);                                                                                                                                                                                                                                                                                                                                            
nrem_cbd_HPC_acutes=10.^(nrem_cbd_HPC_acutes/20); 
nrem_veh_PFC_acutes=10.^(nrem_veh_PFC_acutes/20);                                                                                                                                                                                                                                                                                                                                            
nrem_veh_HPC_acutes=10.^(nrem_veh_HPC_acutes/20); 

save nrem_cbd_PFC_acutes.mat nrem_cbd_PFC_acutes
save nrem_cbd_HPC_acutes.mat nrem_cbd_HPC_acutes
save nrem_veh_PFC_acutes.mat nrem_veh_PFC_acutes
save nrem_veh_HPC_acutes.mat nrem_veh_HPC_acutes

%%
clear
load('freq.mat')
freq=freq(1:171);
save freq.mat freq
clear
FileData = load('freq.mat');
csvwrite('freq.csv', FileData.freq)

%% rem
clear
FileData = load('rem_cbd_PFC_acutes.mat');
csvwrite('rem_cbd_PFC_acutes.csv', FileData.rem_cbd_PFC_acutes)

clear
FileData = load('rem_cbd_HPC_acutes.mat');
csvwrite('rem_cbd_HPC_acutes.csv', FileData.rem_cbd_HPC_acutes)

clear
FileData = load('rem_veh_PFC_acutes.mat');
csvwrite('rem_veh_PFC_acutes.csv', FileData.rem_veh_PFC_acutes)

clear
FileData = load('rem_veh_HPC_acutes.mat');
csvwrite('rem_veh_HPC_acutes.csv', FileData.rem_veh_HPC_acutes)

%% nrem
clear
FileData = load('nrem_cbd_PFC_acutes.mat');
csvwrite('nrem_cbd_PFC_acutes.csv', FileData.nrem_cbd_PFC_acutes)

clear
FileData = load('nrem_cbd_HPC_acutes.mat');
csvwrite('nrem_cbd_HPC_acutes.csv', FileData.nrem_cbd_HPC_acutes)

clear
FileData = load('nrem_veh_PFC_acutes.mat');
csvwrite('nrem_veh_PFC_acutes.csv', FileData.nrem_veh_PFC_acutes)

clear
FileData = load('nrem_veh_HPC_acutes.mat');
csvwrite('nrem_veh_HPC_acutes.csv', FileData.nrem_veh_HPC_acutes)



