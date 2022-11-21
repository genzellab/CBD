%% Rat 6

%% SD1 - OR - Veh

%% presleep

%% posttrial1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD1_OR_20210706.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD1_OR_20210706\2021-07-06_12-44-55_posttrial1'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,2},1)
    peak=ripple_timestamps_short{1,2}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD1_posttrial1_short=x;


clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD1_OR_veh_pt1

%% posttrial2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD1_OR_20210706.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD1_OR_20210706\2021-07-06_13-35-27_posttrial2'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,3},1)
    peak=ripple_timestamps_short{1,3}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD1_posttrial2_short=x;


clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD1_OR_veh_pt2

%% posttrial3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD1_OR_20210706.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD1_OR_20210706\2021-07-06_14-26-36_posttrial3'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,4},1)
    peak=ripple_timestamps_short{1,4}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD1_posttrial3_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,4},1)
    peak=ripple_timestamps_long{1,4}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD1_posttrial3_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD1_OR_veh_pt3

%% posttrial4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD1_OR_20210706.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD1_OR_20210706\2021-07-06_15-20-52_posttrial4'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,5},1)
    peak=ripple_timestamps_short{1,5}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD1_posttrial4_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,5},1)
    peak=ripple_timestamps_long{1,5}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD1_posttrial4_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD1_OR_veh_pt4

%% posttrial5-1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD1_OR_20210706.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD1_OR_20210706\2021-07-06_16-11-47_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,6},1)
    peak=ripple_timestamps_short{1,6}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD1_posttrial51_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,6},1)
    peak=ripple_timestamps_long{1,6}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD1_posttrial51_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD1_OR_veh_pt51

%% posttrial15-2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD1_OR_20210706.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD1_OR_20210706\2021-07-06_16-11-47_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,7},1)
    peak=ripple_timestamps_short{1,7}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD1_posttrial52_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,7},1)
    peak=ripple_timestamps_long{1,7}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD1_posttrial52_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD1_OR_veh_pt52

%% posttrial5-3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD1_OR_20210706.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD1_OR_20210706\2021-07-06_16-11-47_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,8},1)
    peak=ripple_timestamps_short{1,8}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD1_posttrial53_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,8},1)
    peak=ripple_timestamps_long{1,8}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD1_posttrial53_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD1_OR_veh_pt53

%% posttrial5-4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD1_OR_20210706.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD1_OR_20210706\2021-07-06_16-11-47_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,9},1)
    peak=ripple_timestamps_short{1,9}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD1_posttrial54_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,9},1)
    peak=ripple_timestamps_long{1,9}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD1_posttrial54_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD1_OR_veh_pt54

%% SD2 - OR - CBD

%% presleep

%% posttrial1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD2_OR_20210708.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD2_OR_20210708\2021-07-08_12-21-19_posttrial1'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,2},1)
    peak=ripple_timestamps_short{1,2}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD2_posttrial1_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,2},1)
    peak=ripple_timestamps_long{1,2}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD2_posttrial1_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD2_OR_cbd_pt1

%% posttrial2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD2_OR_20210708.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD2_OR_20210708\2021-07-08_13-12-07_posttrial2'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,3},1)
    peak=ripple_timestamps_short{1,3}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD2_posttrial2_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,3},1)
    peak=ripple_timestamps_long{1,3}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD2_posttrial2_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD2_OR_cbd_pt2

%% posttrial3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD2_OR_20210708.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD2_OR_20210708\2021-07-08_14-03-03_posttrial3'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,4},1)
    peak=ripple_timestamps_short{1,4}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD2_posttrial3_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,4},1)
    peak=ripple_timestamps_long{1,4}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD2_posttrial3_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD2_OR_cbd_pt3

%% posttrial4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD2_OR_20210708.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD2_OR_20210708\2021-07-08_14-54-08_posttrial4'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,5},1)
    peak=ripple_timestamps_short{1,5}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD2_posttrial4_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,5},1)
    peak=ripple_timestamps_long{1,5}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD2_posttrial4_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD2_OR_cbd_pt4

%% posttrial5-1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD2_OR_20210708.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD2_OR_20210708\2021-07-08_15-45-03_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,6},1)
    peak=ripple_timestamps_short{1,6}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD2_posttrial51_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,6},1)
    peak=ripple_timestamps_long{1,6}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD2_posttrial51_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD2_OR_cbd_pt51

%% posttrial15-2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD2_OR_20210708.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD2_OR_20210708\2021-07-08_15-45-03_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,7},1)
    peak=ripple_timestamps_short{1,7}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD2_posttrial52_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,7},1)
    peak=ripple_timestamps_long{1,7}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD2_posttrial52_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD2_OR_cbd_pt52

%% posttrial5-3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD2_OR_20210708.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD2_OR_20210708\2021-07-08_15-45-03_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,8},1)
    peak=ripple_timestamps_short{1,8}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD2_posttrial53_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,8},1)
    peak=ripple_timestamps_long{1,8}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD2_posttrial53_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD2_OR_cbd_pt53

%% posttrial5-4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD2_OR_20210708.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD2_OR_20210708\2021-07-08_15-45-03_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,9},1)
    peak=ripple_timestamps_short{1,9}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD2_posttrial54_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,9},1)
    peak=ripple_timestamps_long{1,9}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD2_posttrial54_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD2_OR_cbd_pt54

%% SD3 - OD - CBD

%% presleep
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD3_OD_20210714.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD3_OD_20210714\2021-07-14_11-33-17_presleep'
load 'PFC_100_CH12_2_0.continuous.mat'
load 'HPC_100_CH15_2_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,1},1)
    peak=ripple_timestamps_short{1,1}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD3_presleep_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,1},1)
    peak=ripple_timestamps_long{1,1}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD3_presleep_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD3_OD_cbd_pre

%% posttrial1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD3_OD_20210714.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD3_OD_20210714\2021-07-14_12-58-02_posttrial1'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,2},1)
    peak=ripple_timestamps_short{1,2}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD3_posttrial1_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,2},1)
    peak=ripple_timestamps_long{1,2}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD3_posttrial1_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD3_OD_cbd_pt1

%% posttrial2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD3_OD_20210714.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD3_OD_20210714\2021-07-14_13-35-01_posttrial2'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,3},1)
    peak=ripple_timestamps_short{1,3}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD3_posttrial2_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,3},1)
    peak=ripple_timestamps_long{1,3}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD3_posttrial2_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD3_OD_cbd_pt2

%% posttrial3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD3_OD_20210714.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD3_OD_20210714\2021-07-14_14-25-54_posttrial3'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,4},1)
    peak=ripple_timestamps_short{1,4}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD3_posttrial3_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,4},1)
    peak=ripple_timestamps_long{1,4}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD3_posttrial3_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD3_OD_cbd_pt3

%% posttrial4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD3_OD_20210714.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD3_OD_20210714\2021-07-14_15-16-47_posttrial4'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,5},1)
    peak=ripple_timestamps_short{1,5}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD3_posttrial4_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,5},1)
    peak=ripple_timestamps_long{1,5}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD3_posttrial4_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD3_OD_cbd_pt4

%% posttrial5-1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD3_OD_20210714.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD3_OD_20210714\2021-07-14_16-07-39_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,6},1)
    peak=ripple_timestamps_short{1,6}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD3_posttrial51_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,6},1)
    peak=ripple_timestamps_long{1,6}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD3_posttrial51_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD3_OD_cbd_pt51

%% posttrial15-2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD3_OD_20210714.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD3_OD_20210714\2021-07-14_16-07-39_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,7},1)
    peak=ripple_timestamps_short{1,7}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD3_posttrial52_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,7},1)
    peak=ripple_timestamps_long{1,7}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD3_posttrial52_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD3_OD_cbd_pt52

%% posttrial5-3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD3_OD_20210714.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD3_OD_20210714\2021-07-14_16-07-39_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,8},1)
    peak=ripple_timestamps_short{1,8}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD3_posttrial53_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,8},1)
    peak=ripple_timestamps_long{1,8}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD3_posttrial53_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD3_OD_cbd_pt53

%% posttrial5-4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD3_OD_20210714.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD3_OD_20210714\2021-07-14_16-07-39_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,9},1)
    peak=ripple_timestamps_short{1,9}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD3_posttrial54_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,9},1)
    peak=ripple_timestamps_long{1,9}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD3_posttrial54_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD3_OD_cbd_pt54


%% SD4 - HC - Veh

%% presleep
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD4_HC_20210716.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD4_HC_20210716\2021-07-16_10-32-33_presleep'
load 'PFC_100_CH12_2_0.continuous.mat'
load 'HPC_100_CH15_2_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,1},1)
    peak=ripple_timestamps_short{1,1}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD4_presleep_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,1},1)
    peak=ripple_timestamps_long{1,1}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD4_presleep_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD4_HC_veh_pre

%% posttrial1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD4_HC_20210716.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD4_HC_20210716\2021-07-16_11-33-25_posttrial1'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,2},1)
    peak=ripple_timestamps_short{1,2}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD4_posttrial1_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,2},1)
    peak=ripple_timestamps_long{1,2}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD4_posttrial1_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD4_HC_veh_pt1

%% posttrial2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD4_HC_20210716.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD4_HC_20210716\2021-07-16_12-23-39_posttrial2'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,3},1)
    peak=ripple_timestamps_short{1,3}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD4_posttrial2_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,3},1)
    peak=ripple_timestamps_long{1,3}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD4_posttrial2_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD4_HC_veh_pt2

%% posttrial3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD4_HC_20210716.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD4_HC_20210716\2021-07-16_13-14-43_posttrial3'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,4},1)
    peak=ripple_timestamps_short{1,4}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD4_posttrial3_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,4},1)
    peak=ripple_timestamps_long{1,4}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD4_posttrial3_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD4_HC_veh_pt3

%% posttrial4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD4_HC_20210716.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD4_HC_20210716\2021-07-16_14-05-05_posttrial4'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,5},1)
    peak=ripple_timestamps_short{1,5}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD4_posttrial4_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,5},1)
    peak=ripple_timestamps_long{1,5}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD4_posttrial4_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD4_HC_veh_pt4

%% posttrial5-1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD4_HC_20210716.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD4_HC_20210716\2021-07-16_15-42-04_posttrial5'
load 'PFC_100_CH12_2_0.continuous.mat'
load 'HPC_100_CH15_2_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,6},1)
    peak=ripple_timestamps_short{1,6}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD4_posttrial51_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,6},1)
    peak=ripple_timestamps_long{1,6}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD4_posttrial51_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD4_HC_veh_pt51

%% posttrial15-2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD4_HC_20210716.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD4_HC_20210716\2021-07-16_15-42-04_posttrial5'
load 'PFC_100_CH12_2_0.continuous.mat'
load 'HPC_100_CH15_2_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,7},1)
    peak=ripple_timestamps_short{1,7}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD4_posttrial52_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,7},1)
    peak=ripple_timestamps_long{1,7}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD4_posttrial52_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD4_HC_veh_pt52

%% posttrial5-3

%% posttrial5-4

%% SD5 - OD - Veh

%% presleep

%% posttrial1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD5_OD_20210717.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD5_OD_20210717\2021-07-17_12-20-20_posttrial1'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,2},1)
    peak=ripple_timestamps_short{1,2}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD5_posttrial1_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,2},1)
    peak=ripple_timestamps_long{1,2}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD5_posttrial1_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD5_OD_veh_pt1

%% posttrial2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD5_OD_20210717.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD5_OD_20210717\2021-07-17_13-11-16_posttrial2'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,3},1)
    peak=ripple_timestamps_short{1,3}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD5_posttrial2_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,3},1)
    peak=ripple_timestamps_long{1,3}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD5_posttrial2_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD5_OD_veh_pt2

%% posttrial3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD5_OD_20210717.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD5_OD_20210717\2021-07-17_14-01-57_posttrial3'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,4},1)
    peak=ripple_timestamps_short{1,4}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD5_posttrial3_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,4},1)
    peak=ripple_timestamps_long{1,4}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD5_posttrial3_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD5_OD_veh_pt3

%% posttrial4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD5_OD_20210717.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD5_OD_20210717\2021-07-17_14-52-57_posttrial4'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,5},1)
    peak=ripple_timestamps_short{1,5}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD5_posttrial4_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,5},1)
    peak=ripple_timestamps_long{1,5}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD5_posttrial4_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD5_OD_veh_pt4

%% posttrial5-1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD5_OD_20210717.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD5_OD_20210717\2021-07-17_15-43-48_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,6},1)
    peak=ripple_timestamps_short{1,6}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD5_posttrial51_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,6},1)
    peak=ripple_timestamps_long{1,6}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD5_posttrial51_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD5_OD_veh_pt51

%% posttrial15-2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD5_OD_20210717.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD5_OD_20210717\2021-07-17_15-43-48_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,7},1)
    peak=ripple_timestamps_short{1,7}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD5_posttrial52_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,7},1)
    peak=ripple_timestamps_long{1,7}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD5_posttrial52_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD5_OD_veh_pt52

%% posttrial5-3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD5_OD_20210717.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD5_OD_20210717\2021-07-17_15-43-48_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,8},1)
    peak=ripple_timestamps_short{1,8}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD5_posttrial53_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,8},1)
    peak=ripple_timestamps_long{1,8}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD5_posttrial53_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD5_OD_veh_pt53

%% posttrial5-4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD5_OD_20210717.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD5_OD_20210717\2021-07-17_15-43-48_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,9},1)
    peak=ripple_timestamps_short{1,9}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD5_posttrial54_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,9},1)
    peak=ripple_timestamps_long{1,9}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD5_posttrial54_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD5_OD_veh_pt54




%% SD6 - HC - CBD

%% presleep

%% posttrial1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD6_HC_20210719.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD6_HC_20210719\2021-07-19_11-31-43_posttrial1'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,2},1)
    peak=ripple_timestamps_short{1,2}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD6_posttrial1_short=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD6_HC_cbd_pt1


%% posttrial2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD6_HC_20210719.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD6_HC_20210719\2021-07-19_12-22-12_posttrial2'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,3},1)
    peak=ripple_timestamps_short{1,3}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD6_posttrial2_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,3},1)
    peak=ripple_timestamps_long{1,3}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD6_posttrial2_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD6_HC_cbd_pt2

%% posttrial3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD6_HC_20210719.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD6_HC_20210719\2021-07-19_13-12-27_posttrial3'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,4},1)
    peak=ripple_timestamps_short{1,4}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD6_posttrial3_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,4},1)
    peak=ripple_timestamps_long{1,4}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD6_posttrial3_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD6_HC_cbd_pt3

%% posttrial4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD6_HC_20210719.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD6_HC_20210719\2021-07-19_14-02-48_posttrial4'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,5},1)
    peak=ripple_timestamps_short{1,5}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD6_posttrial4_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,5},1)
    peak=ripple_timestamps_long{1,5}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD6_posttrial4_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD6_HC_cbd_pt4

%% posttrial5-1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD6_HC_20210719.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD6_HC_20210719\2021-07-19_14-53-23_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,6},1)
    peak=ripple_timestamps_short{1,6}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD6_posttrial51_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,6},1)
    peak=ripple_timestamps_long{1,6}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD6_posttrial51_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD6_HC_cbd_pt51


%% posttrial15-2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD6_HC_20210719.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD6_HC_20210719\2021-07-19_14-53-23_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,7},1)
    peak=ripple_timestamps_short{1,7}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD6_posttrial52_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,7},1)
    peak=ripple_timestamps_long{1,7}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD6_posttrial51_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD6_HC_cbd_pt52

%% posttrial5-3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD6_HC_20210719.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD6_HC_20210719\2021-07-19_14-53-23_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,8},1)
    peak=ripple_timestamps_short{1,8}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD6_posttrial53_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,8},1)
    peak=ripple_timestamps_long{1,8}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD6_posttrial53_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD6_HC_cbd_pt53

%% posttrial5-4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\6\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD6_HC_20210719.mat
cd 'F:\OSF\chronic\UMAP - All study days\6\Rat_OS_Ephys_cbd_chronic_Rat6_411357_SD6_HC_20210719\2021-07-19_14-53-23_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH15_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,9},1)
    peak=ripple_timestamps_short{1,9}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD6_posttrial54_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,9},1)
    peak=ripple_timestamps_long{1,9}(i,2);
    if 2500*peak<5001 || 2500*peak+5000>size(PFC,1)
    else
        PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
        HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
        x{i,1}(1,:)=PFC_ripple;
        x{i,1}(2,:)=HPC_ripple;
    end
end
rat6_SD6_posttrial54_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat6
save rat6_SD6_HC_cbd_pt54


