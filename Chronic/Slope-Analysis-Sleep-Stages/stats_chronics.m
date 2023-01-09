

clear
cd /home/genzellab/Desktop/Pelin/november_periodograms/slope-analysis/chronics

%% SLOPES %%

%% rem
%
slopes_rem_cbd_PFC_chronics = readmatrix("slopes_rem_cbd_PFC_chronics.csv");
slopes_rem_cbd_PFC_chronics=-1*slopes_rem_cbd_PFC_chronics(2:end,2);

save slopes_rem_cbd_PFC_chronics.mat slopes_rem_cbd_PFC_chronics

clear
FileData = load('slopes_rem_cbd_PFC_chronics.mat');
csvwrite('slopes_rem_cbd_PFC_chronics.csv', FileData.slopes_rem_cbd_PFC_chronics);

%
slopes_rem_cbd_HPC_chronics = readmatrix("slopes_rem_cbd_HPC_chronics.csv");
slopes_rem_cbd_HPC_chronics=-1*slopes_rem_cbd_HPC_chronics(2:end,2);

save slopes_rem_cbd_HPC_chronics.mat slopes_rem_cbd_HPC_chronics

clear
FileData = load('slopes_rem_cbd_HPC_chronics.mat');
csvwrite('slopes_rem_cbd_HPC_chronics.csv', FileData.slopes_rem_cbd_HPC_chronics);

%
slopes_rem_veh_PFC_chronics = readmatrix("slopes_rem_veh_PFC_chronics.csv");
slopes_rem_veh_PFC_chronics=-1*slopes_rem_veh_PFC_chronics(2:end,2);

save slopes_rem_veh_PFC_chronics.mat slopes_rem_veh_PFC_chronics

clear
FileData = load('slopes_rem_veh_PFC_chronics.mat');
csvwrite('slopes_rem_veh_PFC_chronics.csv', FileData.slopes_rem_veh_PFC_chronics);

%
slopes_rem_veh_HPC_chronics = readmatrix("slopes_rem_veh_HPC_chronics.csv");
slopes_rem_veh_HPC_chronics=-1*slopes_rem_veh_HPC_chronics(2:end,2);

save slopes_rem_veh_HPC_chronics.mat slopes_rem_veh_HPC_chronics

clear
FileData = load('slopes_rem_veh_HPC_chronics.mat');
csvwrite('slopes_rem_veh_HPC_chronics.csv', FileData.slopes_rem_veh_HPC_chronics);



%% nrem
%
slopes_nrem_cbd_PFC_chronics = readmatrix("slopes_nrem_cbd_PFC_chronics.csv");
slopes_nrem_cbd_PFC_chronics=-1*slopes_nrem_cbd_PFC_chronics(2:end,2);

save slopes_nrem_cbd_PFC_chronics.mat slopes_nrem_cbd_PFC_chronics

clear
FileData = load('slopes_nrem_cbd_PFC_chronics.mat');
csvwrite('slopes_nrem_cbd_PFC_chronics.csv', FileData.slopes_nrem_cbd_PFC_chronics);

%
slopes_nrem_cbd_HPC_chronics = readmatrix("slopes_nrem_cbd_HPC_chronics.csv");
slopes_nrem_cbd_HPC_chronics=-1*slopes_nrem_cbd_HPC_chronics(2:end,2);

save slopes_nrem_cbd_HPC_chronics.mat slopes_nrem_cbd_HPC_chronics

clear
FileData = load('slopes_nrem_cbd_HPC_chronics.mat');
csvwrite('slopes_nrem_cbd_HPC_chronics.csv', FileData.slopes_nrem_cbd_HPC_chronics);

%
slopes_nrem_veh_PFC_chronics = readmatrix("slopes_nrem_veh_PFC_chronics.csv");
slopes_nrem_veh_PFC_chronics=-1*slopes_nrem_veh_PFC_chronics(2:end,2);

save slopes_nrem_veh_PFC_chronics.mat slopes_nrem_veh_PFC_chronics

clear
FileData = load('slopes_nrem_veh_PFC_chronics.mat');
csvwrite('slopes_nrem_veh_PFC_chronics.csv', FileData.slopes_nrem_veh_PFC_chronics);

%
slopes_nrem_veh_HPC_chronics = readmatrix("slopes_nrem_veh_HPC_chronics.csv");
slopes_nrem_veh_HPC_chronics=-1*slopes_nrem_veh_HPC_chronics(2:end,2);

save slopes_nrem_veh_HPC_chronics.mat slopes_nrem_veh_HPC_chronics

clear
FileData = load('slopes_nrem_veh_HPC_chronics.mat');
csvwrite('slopes_nrem_veh_HPC_chronics.csv', FileData.slopes_nrem_veh_HPC_chronics);


%% data preparation

%% data v2-8groups
clear
load('slopes_rem_cbd_PFC_chronics.mat');
load('slopes_rem_cbd_HPC_chronics.mat');
load('slopes_rem_veh_PFC_chronics.mat');
load('slopes_rem_veh_HPC_chronics.mat');

load('slopes_nrem_cbd_PFC_chronics.mat');
load('slopes_nrem_cbd_HPC_chronics.mat');
load('slopes_nrem_veh_PFC_chronics.mat');
load('slopes_nrem_veh_HPC_chronics.mat');


x1=ones(33,1);
x2=2*ones(33,1);
x3=3*ones(46,1);
x4=4*ones(46,1);
x5=5*ones(34,1);
x6=6*ones(34,1);
x7=7*ones(48,1);
x8=8*ones(48,1);

data_8groups_slopes_chronics=[x1 slopes_rem_veh_HPC_chronics;...
    x2 slopes_rem_veh_PFC_chronics;...
    x3 slopes_nrem_veh_HPC_chronics;...
    x4 slopes_nrem_veh_PFC_chronics;...
    x5 slopes_rem_cbd_HPC_chronics;...
    x6 slopes_rem_cbd_PFC_chronics;...
    x7 slopes_nrem_cbd_HPC_chronics;...
    x8 slopes_nrem_cbd_PFC_chronics];

save data_8groups_slopes_chronics.mat data_8groups_slopes_chronics 

clear
FileData = load('data_8groups_slopes_chronics.mat');
csvwrite('data_8groups_slopes_chronics.csv', FileData.data_8groups_slopes_chronics);


%% data 

clear
load('slopes_rem_cbd_PFC_chronics.mat');
load('slopes_rem_cbd_HPC_chronics.mat');
load('slopes_rem_veh_PFC_chronics.mat');
load('slopes_rem_veh_HPC_chronics.mat');

load('slopes_nrem_cbd_PFC_chronics.mat');
load('slopes_nrem_cbd_HPC_chronics.mat');
load('slopes_nrem_veh_PFC_chronics.mat');
load('slopes_nrem_veh_HPC_chronics.mat');



data_slopes_chronics=[...
    ones(33,1),ones(33,1),ones(33,1) slopes_rem_veh_HPC_chronics;...
    ones(33,1),ones(33,1),2*ones(33,1) slopes_rem_veh_PFC_chronics;...
    ones(46,1),2*ones(46,1),ones(46,1) slopes_nrem_veh_HPC_chronics;...
    ones(46,1),2*ones(46,1),2*ones(46,1) slopes_nrem_veh_PFC_chronics;...
    2*ones(34,1),ones(34,1),ones(34,1) slopes_rem_cbd_HPC_chronics;...
    2*ones(34,1),ones(34,1),2*ones(34,1) slopes_rem_cbd_PFC_chronics;...
    2*ones(48,1),2*ones(48,1),ones(48,1) slopes_nrem_cbd_HPC_chronics;...
    2*ones(48,1),2*ones(48,1),2*ones(48,1) slopes_nrem_cbd_PFC_chronics];

save data_slopes_chronics.mat data_slopes_chronics 

clear
FileData = load('data_slopes_chronics.mat');
csvwrite('data_slopes_chronics.csv', FileData.data_slopes_chronics);












%% OFFSETS %%
%% rem
%
offsets_rem_cbd_PFC_chronics = readmatrix("offsets_rem_cbd_PFC_chronics.csv");
offsets_rem_cbd_PFC_chronics=offsets_rem_cbd_PFC_chronics(2:end,2);

save offsets_rem_cbd_PFC_chronics.mat offsets_rem_cbd_PFC_chronics

clear
FileData = load('offsets_rem_cbd_PFC_chronics.mat');
csvwrite('offsets_rem_cbd_PFC_chronics.csv', FileData.offsets_rem_cbd_PFC_chronics);

%
offsets_rem_cbd_HPC_chronics = readmatrix("offsets_rem_cbd_HPC_chronics.csv");
offsets_rem_cbd_HPC_chronics=offsets_rem_cbd_HPC_chronics(2:end,2);

save offsets_rem_cbd_HPC_chronics.mat offsets_rem_cbd_HPC_chronics

clear
FileData = load('offsets_rem_cbd_HPC_chronics.mat');
csvwrite('offsets_rem_cbd_HPC_chronics.csv', FileData.offsets_rem_cbd_HPC_chronics);

%
offsets_rem_veh_PFC_chronics = readmatrix("offsets_rem_veh_PFC_chronics.csv");
offsets_rem_veh_PFC_chronics=offsets_rem_veh_PFC_chronics(2:end,2);

save offsets_rem_veh_PFC_chronics.mat offsets_rem_veh_PFC_chronics

clear
FileData = load('offsets_rem_veh_PFC_chronics.mat');
csvwrite('offsets_rem_veh_PFC_chronics.csv', FileData.offsets_rem_veh_PFC_chronics);

%
offsets_rem_veh_HPC_chronics = readmatrix("offsets_rem_veh_HPC_chronics.csv");
offsets_rem_veh_HPC_chronics=offsets_rem_veh_HPC_chronics(2:end,2);

save offsets_rem_veh_HPC_chronics.mat offsets_rem_veh_HPC_chronics

clear
FileData = load('offsets_rem_veh_HPC_chronics.mat');
csvwrite('offsets_rem_veh_HPC_chronics.csv', FileData.offsets_rem_veh_HPC_chronics);



%% nrem
%
offsets_nrem_cbd_PFC_chronics = readmatrix("offsets_nrem_cbd_PFC_chronics.csv");
offsets_nrem_cbd_PFC_chronics=offsets_nrem_cbd_PFC_chronics(2:end,2);

save offsets_nrem_cbd_PFC_chronics.mat offsets_nrem_cbd_PFC_chronics

clear
FileData = load('offsets_nrem_cbd_PFC_chronics.mat');
csvwrite('offsets_nrem_cbd_PFC_chronics.csv', FileData.offsets_nrem_cbd_PFC_chronics);

%
offsets_nrem_cbd_HPC_chronics = readmatrix("offsets_nrem_cbd_HPC_chronics.csv");
offsets_nrem_cbd_HPC_chronics=offsets_nrem_cbd_HPC_chronics(2:end,2);

save offsets_nrem_cbd_HPC_chronics.mat offsets_nrem_cbd_HPC_chronics

clear
FileData = load('offsets_nrem_cbd_HPC_chronics.mat');
csvwrite('offsets_nrem_cbd_HPC_chronics.csv', FileData.offsets_nrem_cbd_HPC_chronics);

%
offsets_nrem_veh_PFC_chronics = readmatrix("offsets_nrem_veh_PFC_chronics.csv");
offsets_nrem_veh_PFC_chronics=offsets_nrem_veh_PFC_chronics(2:end,2);

save offsets_nrem_veh_PFC_chronics.mat offsets_nrem_veh_PFC_chronics

clear
FileData = load('offsets_nrem_veh_PFC_chronics.mat');
csvwrite('offsets_nrem_veh_PFC_chronics.csv', FileData.offsets_nrem_veh_PFC_chronics);

%
offsets_nrem_veh_HPC_chronics = readmatrix("offsets_nrem_veh_HPC_chronics.csv");
offsets_nrem_veh_HPC_chronics=offsets_nrem_veh_HPC_chronics(2:end,2);

save offsets_nrem_veh_HPC_chronics.mat offsets_nrem_veh_HPC_chronics

clear
FileData = load('offsets_nrem_veh_HPC_chronics.mat');
csvwrite('offsets_nrem_veh_HPC_chronics.csv', FileData.offsets_nrem_veh_HPC_chronics);


%% data preparation

%% data v2-8groups
clear
load('offsets_rem_cbd_PFC_chronics.mat');
load('offsets_rem_cbd_HPC_chronics.mat');
load('offsets_rem_veh_PFC_chronics.mat');
load('offsets_rem_veh_HPC_chronics.mat');

load('offsets_nrem_cbd_PFC_chronics.mat');
load('offsets_nrem_cbd_HPC_chronics.mat');
load('offsets_nrem_veh_PFC_chronics.mat');
load('offsets_nrem_veh_HPC_chronics.mat');


x1=ones(33,1);
x2=2*ones(33,1);
x3=3*ones(46,1);
x4=4*ones(46,1);
x5=5*ones(34,1);
x6=6*ones(34,1);
x7=7*ones(48,1);
x8=8*ones(48,1);

data_8groups_offsets_chronics=[x1 offsets_rem_veh_HPC_chronics;...
    x2 offsets_rem_veh_PFC_chronics;...
    x3 offsets_nrem_veh_HPC_chronics;...
    x4 offsets_nrem_veh_PFC_chronics;...
    x5 offsets_rem_cbd_HPC_chronics;...
    x6 offsets_rem_cbd_PFC_chronics;...
    x7 offsets_nrem_cbd_HPC_chronics;...
    x8 offsets_nrem_cbd_PFC_chronics];

save data_8groups_offsets_chronics.mat data_8groups_offsets_chronics 

clear
FileData = load('data_8groups_offsets_chronics.mat');
csvwrite('data_8groups_offsets_chronics.csv', FileData.data_8groups_offsets_chronics);


%% data 

clear
load('offsets_rem_cbd_PFC_chronics.mat');
load('offsets_rem_cbd_HPC_chronics.mat');
load('offsets_rem_veh_PFC_chronics.mat');
load('offsets_rem_veh_HPC_chronics.mat');

load('offsets_nrem_cbd_PFC_chronics.mat');
load('offsets_nrem_cbd_HPC_chronics.mat');
load('offsets_nrem_veh_PFC_chronics.mat');
load('offsets_nrem_veh_HPC_chronics.mat');



data_offsets_chronics=[...
    ones(33,1),ones(33,1),ones(33,1) offsets_rem_veh_HPC_chronics;...
    ones(33,1),ones(33,1),2*ones(33,1) offsets_rem_veh_PFC_chronics;...
    ones(46,1),2*ones(46,1),ones(46,1) offsets_nrem_veh_HPC_chronics;...
    ones(46,1),2*ones(46,1),2*ones(46,1) offsets_nrem_veh_PFC_chronics;...
    2*ones(34,1),ones(34,1),ones(34,1) offsets_rem_cbd_HPC_chronics;...
    2*ones(34,1),ones(34,1),2*ones(34,1) offsets_rem_cbd_PFC_chronics;...
    2*ones(48,1),2*ones(48,1),ones(48,1) offsets_nrem_cbd_HPC_chronics;...
    2*ones(48,1),2*ones(48,1),2*ones(48,1) offsets_nrem_cbd_PFC_chronics];

save data_offsets_chronics.mat data_offsets_chronics 

clear
FileData = load('data_offsets_chronics.mat');
csvwrite('data_offsets_chronics.csv', FileData.data_offsets_chronics);


