

clear
cd /home/genzellab/Desktop/Pelin/november_periodograms/slope-analysis/acutes

%% SLOPES %%

%% rem
%
slopes_rem_cbd_PFC_acutes = readmatrix("slopes_rem_cbd_PFC_acutes.csv");
slopes_rem_cbd_PFC_acutes=-1*slopes_rem_cbd_PFC_acutes(2:end,2);

save slopes_rem_cbd_PFC_acutes.mat slopes_rem_cbd_PFC_acutes

clear
FileData = load('slopes_rem_cbd_PFC_acutes.mat');
csvwrite('slopes_rem_cbd_PFC_acutes.csv', FileData.slopes_rem_cbd_PFC_acutes);

%
slopes_rem_cbd_HPC_acutes = readmatrix("slopes_rem_cbd_HPC_acutes.csv");
slopes_rem_cbd_HPC_acutes=-1*slopes_rem_cbd_HPC_acutes(2:end,2);

save slopes_rem_cbd_HPC_acutes.mat slopes_rem_cbd_HPC_acutes

clear
FileData = load('slopes_rem_cbd_HPC_acutes.mat');
csvwrite('slopes_rem_cbd_HPC_acutes.csv', FileData.slopes_rem_cbd_HPC_acutes);

%
slopes_rem_veh_PFC_acutes = readmatrix("slopes_rem_veh_PFC_acutes.csv");
slopes_rem_veh_PFC_acutes=-1*slopes_rem_veh_PFC_acutes(2:end,2);

save slopes_rem_veh_PFC_acutes.mat slopes_rem_veh_PFC_acutes

clear
FileData = load('slopes_rem_veh_PFC_acutes.mat');
csvwrite('slopes_rem_veh_PFC_acutes.csv', FileData.slopes_rem_veh_PFC_acutes);

%
slopes_rem_veh_HPC_acutes = readmatrix("slopes_rem_veh_HPC_acutes.csv");
slopes_rem_veh_HPC_acutes=-1*slopes_rem_veh_HPC_acutes(2:end,2);

save slopes_rem_veh_HPC_acutes.mat slopes_rem_veh_HPC_acutes

clear
FileData = load('slopes_rem_veh_HPC_acutes.mat');
csvwrite('slopes_rem_veh_HPC_acutes.csv', FileData.slopes_rem_veh_HPC_acutes);



%% nrem
%
slopes_nrem_cbd_PFC_acutes = readmatrix("slopes_nrem_cbd_PFC_acutes.csv");
slopes_nrem_cbd_PFC_acutes=-1*slopes_nrem_cbd_PFC_acutes(2:end,2);

save slopes_nrem_cbd_PFC_acutes.mat slopes_nrem_cbd_PFC_acutes

clear
FileData = load('slopes_nrem_cbd_PFC_acutes.mat');
csvwrite('slopes_nrem_cbd_PFC_acutes.csv', FileData.slopes_nrem_cbd_PFC_acutes);

%
slopes_nrem_cbd_HPC_acutes = readmatrix("slopes_nrem_cbd_HPC_acutes.csv");
slopes_nrem_cbd_HPC_acutes=-1*slopes_nrem_cbd_HPC_acutes(2:end,2);

save slopes_nrem_cbd_HPC_acutes.mat slopes_nrem_cbd_HPC_acutes

clear
FileData = load('slopes_nrem_cbd_HPC_acutes.mat');
csvwrite('slopes_nrem_cbd_HPC_acutes.csv', FileData.slopes_nrem_cbd_HPC_acutes);

%
slopes_nrem_veh_PFC_acutes = readmatrix("slopes_nrem_veh_PFC_acutes.csv");
slopes_nrem_veh_PFC_acutes=-1*slopes_nrem_veh_PFC_acutes(2:end,2);

save slopes_nrem_veh_PFC_acutes.mat slopes_nrem_veh_PFC_acutes

clear
FileData = load('slopes_nrem_veh_PFC_acutes.mat');
csvwrite('slopes_nrem_veh_PFC_acutes.csv', FileData.slopes_nrem_veh_PFC_acutes);

%
slopes_nrem_veh_HPC_acutes = readmatrix("slopes_nrem_veh_HPC_acutes.csv");
slopes_nrem_veh_HPC_acutes=-1*slopes_nrem_veh_HPC_acutes(2:end,2);

save slopes_nrem_veh_HPC_acutes.mat slopes_nrem_veh_HPC_acutes

clear
FileData = load('slopes_nrem_veh_HPC_acutes.mat');
csvwrite('slopes_nrem_veh_HPC_acutes.csv', FileData.slopes_nrem_veh_HPC_acutes);


%% data preparation

% %% data v2-8groups
% clear
% load('slopes_rem_cbd_PFC_acutes.mat');
% load('slopes_rem_cbd_HPC_acutes.mat');
% load('slopes_rem_veh_PFC_acutes.mat');
% load('slopes_rem_veh_HPC_acutes.mat');
% 
% load('slopes_nrem_cbd_PFC_acutes.mat');
% load('slopes_nrem_cbd_HPC_acutes.mat');
% load('slopes_nrem_veh_PFC_acutes.mat');
% load('slopes_nrem_veh_HPC_acutes.mat');
% 
% 
% x1=ones(9,1);
% x2=2*ones(9,1);
% x3=3*ones(46,1);
% x4=4*ones(46,1);
% x5=5*ones(34,1);
% x6=6*ones(34,1);
% x7=7*ones(48,1);
% x8=8*ones(48,1);
% 
% data_8groups_slopes_acutes=[x1 slopes_rem_veh_HPC_acutes;...
%     x2 slopes_rem_veh_PFC_acutes;...
%     x3 slopes_nrem_veh_HPC_acutes;...
%     x4 slopes_nrem_veh_PFC_acutes;...
%     x5 slopes_rem_cbd_HPC_acutes;...
%     x6 slopes_rem_cbd_PFC_acutes;...
%     x7 slopes_nrem_cbd_HPC_acutes;...
%     x8 slopes_nrem_cbd_PFC_acutes];
% 
% save data_8groups_slopes_acutes.mat data_8groups_slopes_acutes 
% 
% clear
% FileData = load('data_8groups_slopes_acutes.mat');
% csvwrite('data_8groups_slopes_acutes.csv', FileData.data_8groups_slopes_acutes);
% 

%% data 

clear
load('slopes_rem_cbd_PFC_acutes.mat');
load('slopes_rem_cbd_HPC_acutes.mat');
load('slopes_rem_veh_PFC_acutes.mat');
load('slopes_rem_veh_HPC_acutes.mat');

load('slopes_nrem_cbd_PFC_acutes.mat');
load('slopes_nrem_cbd_HPC_acutes.mat');
load('slopes_nrem_veh_PFC_acutes.mat');
load('slopes_nrem_veh_HPC_acutes.mat');

% take equal size of each array
rng(13);
slopes_nrem_cbd_HPC_acutes=slopes_nrem_cbd_HPC_acutes(randperm(length(slopes_nrem_cbd_HPC_acutes)));
slopes_nrem_cbd_HPC_acutes=slopes_nrem_cbd_HPC_acutes(1:203);

slopes_nrem_cbd_PFC_acutes=slopes_nrem_cbd_PFC_acutes(randperm(length(slopes_nrem_cbd_PFC_acutes)));
slopes_nrem_cbd_PFC_acutes=slopes_nrem_cbd_PFC_acutes(1:203);

slopes_rem_cbd_HPC_acutes=slopes_rem_cbd_HPC_acutes(randperm(length(slopes_rem_cbd_HPC_acutes)));
slopes_rem_cbd_HPC_acutes=slopes_rem_cbd_HPC_acutes(1:203);


slopes_rem_cbd_PFC_acutes=slopes_rem_cbd_PFC_acutes(randperm(length(slopes_rem_cbd_PFC_acutes)));
slopes_rem_cbd_PFC_acutes=slopes_rem_cbd_PFC_acutes(1:203);


%
data_slopes_acutes=[...
    ones(203,1),ones(203,1),ones(203,1) slopes_rem_veh_HPC_acutes;...
    ones(203,1),ones(203,1),2*ones(203,1) slopes_rem_veh_PFC_acutes;...
    ones(203,1),2*ones(203,1),ones(203,1) slopes_nrem_veh_HPC_acutes;...
    ones(203,1),2*ones(203,1),2*ones(203,1) slopes_nrem_veh_PFC_acutes;...
    2*ones(203,1),ones(203,1),ones(203,1) slopes_rem_cbd_HPC_acutes;...
    2*ones(203,1),ones(203,1),2*ones(203,1) slopes_rem_cbd_PFC_acutes;...
    2*ones(203,1),2*ones(203,1),ones(203,1) slopes_nrem_cbd_HPC_acutes;...
    2*ones(203,1),2*ones(203,1),2*ones(203,1) slopes_nrem_cbd_PFC_acutes];

save data_slopes_acutes.mat data_slopes_acutes 

clear
FileData = load('data_slopes_acutes.mat');
csvwrite('data_slopes_acutes.csv', FileData.data_slopes_acutes);












%% OFFSETS %%
%% rem
%
offsets_rem_cbd_PFC_acutes = readmatrix("offsets_rem_cbd_PFC_acutes.csv");
offsets_rem_cbd_PFC_acutes=offsets_rem_cbd_PFC_acutes(2:end,2);

save offsets_rem_cbd_PFC_acutes.mat offsets_rem_cbd_PFC_acutes

clear
FileData = load('offsets_rem_cbd_PFC_acutes.mat');
csvwrite('offsets_rem_cbd_PFC_acutes.csv', FileData.offsets_rem_cbd_PFC_acutes);

%
offsets_rem_cbd_HPC_acutes = readmatrix("offsets_rem_cbd_HPC_acutes.csv");
offsets_rem_cbd_HPC_acutes=offsets_rem_cbd_HPC_acutes(2:end,2);

save offsets_rem_cbd_HPC_acutes.mat offsets_rem_cbd_HPC_acutes

clear
FileData = load('offsets_rem_cbd_HPC_acutes.mat');
csvwrite('offsets_rem_cbd_HPC_acutes.csv', FileData.offsets_rem_cbd_HPC_acutes);

%
offsets_rem_veh_PFC_acutes = readmatrix("offsets_rem_veh_PFC_acutes.csv");
offsets_rem_veh_PFC_acutes=offsets_rem_veh_PFC_acutes(2:end,2);

save offsets_rem_veh_PFC_acutes.mat offsets_rem_veh_PFC_acutes

clear
FileData = load('offsets_rem_veh_PFC_acutes.mat');
csvwrite('offsets_rem_veh_PFC_acutes.csv', FileData.offsets_rem_veh_PFC_acutes);

%
offsets_rem_veh_HPC_acutes = readmatrix("offsets_rem_veh_HPC_acutes.csv");
offsets_rem_veh_HPC_acutes=offsets_rem_veh_HPC_acutes(2:end,2);

save offsets_rem_veh_HPC_acutes.mat offsets_rem_veh_HPC_acutes

clear
FileData = load('offsets_rem_veh_HPC_acutes.mat');
csvwrite('offsets_rem_veh_HPC_acutes.csv', FileData.offsets_rem_veh_HPC_acutes);



%% nrem
%
offsets_nrem_cbd_PFC_acutes = readmatrix("offsets_nrem_cbd_PFC_acutes.csv");
offsets_nrem_cbd_PFC_acutes=offsets_nrem_cbd_PFC_acutes(2:end,2);

save offsets_nrem_cbd_PFC_acutes.mat offsets_nrem_cbd_PFC_acutes

clear
FileData = load('offsets_nrem_cbd_PFC_acutes.mat');
csvwrite('offsets_nrem_cbd_PFC_acutes.csv', FileData.offsets_nrem_cbd_PFC_acutes);

%
offsets_nrem_cbd_HPC_acutes = readmatrix("offsets_nrem_cbd_HPC_acutes.csv");
offsets_nrem_cbd_HPC_acutes=offsets_nrem_cbd_HPC_acutes(2:end,2);

save offsets_nrem_cbd_HPC_acutes.mat offsets_nrem_cbd_HPC_acutes

clear
FileData = load('offsets_nrem_cbd_HPC_acutes.mat');
csvwrite('offsets_nrem_cbd_HPC_acutes.csv', FileData.offsets_nrem_cbd_HPC_acutes);

%
offsets_nrem_veh_PFC_acutes = readmatrix("offsets_nrem_veh_PFC_acutes.csv");
offsets_nrem_veh_PFC_acutes=offsets_nrem_veh_PFC_acutes(2:end,2);

save offsets_nrem_veh_PFC_acutes.mat offsets_nrem_veh_PFC_acutes

clear
FileData = load('offsets_nrem_veh_PFC_acutes.mat');
csvwrite('offsets_nrem_veh_PFC_acutes.csv', FileData.offsets_nrem_veh_PFC_acutes);

%
offsets_nrem_veh_HPC_acutes = readmatrix("offsets_nrem_veh_HPC_acutes.csv");
offsets_nrem_veh_HPC_acutes=offsets_nrem_veh_HPC_acutes(2:end,2);

save offsets_nrem_veh_HPC_acutes.mat offsets_nrem_veh_HPC_acutes

clear
FileData = load('offsets_nrem_veh_HPC_acutes.mat');
csvwrite('offsets_nrem_veh_HPC_acutes.csv', FileData.offsets_nrem_veh_HPC_acutes);


%% data preparation

% %% data v2-8groups
% clear
% load('offsets_rem_cbd_PFC_acutes.mat');
% load('offsets_rem_cbd_HPC_acutes.mat');
% load('offsets_rem_veh_PFC_acutes.mat');
% load('offsets_rem_veh_HPC_acutes.mat');
% 
% load('offsets_nrem_cbd_PFC_acutes.mat');
% load('offsets_nrem_cbd_HPC_acutes.mat');
% load('offsets_nrem_veh_PFC_acutes.mat');
% load('offsets_nrem_veh_HPC_acutes.mat');
% 
% 
% x1=ones(33,1);
% x2=2*ones(33,1);
% x3=3*ones(46,1);
% x4=4*ones(46,1);
% x5=5*ones(34,1);
% x6=6*ones(34,1);
% x7=7*ones(48,1);
% x8=8*ones(48,1);
% 
% data_8groups_offsets_acutes=[x1 offsets_rem_veh_HPC_acutes;...
%     x2 offsets_rem_veh_PFC_acutes;...
%     x3 offsets_nrem_veh_HPC_acutes;...
%     x4 offsets_nrem_veh_PFC_acutes;...
%     x5 offsets_rem_cbd_HPC_acutes;...
%     x6 offsets_rem_cbd_PFC_acutes;...
%     x7 offsets_nrem_cbd_HPC_acutes;...
%     x8 offsets_nrem_cbd_PFC_acutes];
% 
% save data_8groups_offsets_acutes.mat data_8groups_offsets_acutes 
% 
% clear
% FileData = load('data_8groups_offsets_acutes.mat');
% csvwrite('data_8groups_offsets_acutes.csv', FileData.data_8groups_offsets_acutes);
% 

%% data 
clear
load('offsets_rem_cbd_PFC_acutes.mat');
load('offsets_rem_cbd_HPC_acutes.mat');
load('offsets_rem_veh_PFC_acutes.mat');
load('offsets_rem_veh_HPC_acutes.mat');

load('offsets_nrem_cbd_PFC_acutes.mat');
load('offsets_nrem_cbd_HPC_acutes.mat');
load('offsets_nrem_veh_PFC_acutes.mat');
load('offsets_nrem_veh_HPC_acutes.mat');

% take equal size of each array
rng(13);
offsets_nrem_cbd_HPC_acutes=offsets_nrem_cbd_HPC_acutes(randperm(length(offsets_nrem_cbd_HPC_acutes)));
offsets_nrem_cbd_HPC_acutes=offsets_nrem_cbd_HPC_acutes(1:203);

offsets_nrem_cbd_PFC_acutes=offsets_nrem_cbd_PFC_acutes(randperm(length(offsets_nrem_cbd_PFC_acutes)));
offsets_nrem_cbd_PFC_acutes=offsets_nrem_cbd_PFC_acutes(1:203);

offsets_rem_cbd_HPC_acutes=offsets_rem_cbd_HPC_acutes(randperm(length(offsets_rem_cbd_HPC_acutes)));
offsets_rem_cbd_HPC_acutes=offsets_rem_cbd_HPC_acutes(1:203);


offsets_rem_cbd_PFC_acutes=offsets_rem_cbd_PFC_acutes(randperm(length(offsets_rem_cbd_PFC_acutes)));
offsets_rem_cbd_PFC_acutes=offsets_rem_cbd_PFC_acutes(1:203);


%
data_offsets_acutes=[...
    ones(203,1),ones(203,1),ones(203,1) offsets_rem_veh_HPC_acutes;...
    ones(203,1),ones(203,1),2*ones(203,1) offsets_rem_veh_PFC_acutes;...
    ones(203,1),2*ones(203,1),ones(203,1) offsets_nrem_veh_HPC_acutes;...
    ones(203,1),2*ones(203,1),2*ones(203,1) offsets_nrem_veh_PFC_acutes;...
    2*ones(203,1),ones(203,1),ones(203,1) offsets_rem_cbd_HPC_acutes;...
    2*ones(203,1),ones(203,1),2*ones(203,1) offsets_rem_cbd_PFC_acutes;...
    2*ones(203,1),2*ones(203,1),ones(203,1) offsets_nrem_cbd_HPC_acutes;...
    2*ones(203,1),2*ones(203,1),2*ones(203,1) offsets_nrem_cbd_PFC_acutes];

save data_offsets_acutes.mat data_offsets_acutes 

clear
FileData = load('data_offsets_acutes.mat');
csvwrite('data_offsets_acutes.csv', FileData.data_offsets_acutes);







