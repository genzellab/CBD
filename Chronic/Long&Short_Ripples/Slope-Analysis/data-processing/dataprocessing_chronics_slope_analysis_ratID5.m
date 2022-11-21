
%% Rat 5

%% SD1 - OR - CBD

%% presleep

%% posttrial1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD1_OR_6_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD1_OR_6_07_2021\2021-07-06_12-25-59_posttrial1'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD1_posttrial1_short=x;

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
rat5_SD1_posttrial1_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD1_OR_cbd_pt1

%% posttrial2

% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD1_OR_6_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD1_OR_6_07_2021\2021-07-06_13-16-37_posttrial2'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD1_posttrial2_short=x;

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
rat5_SD1_posttrial2_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD1_OR_cbd_pt2

%% posttrial3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD1_OR_6_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD1_OR_6_07_2021\2021-07-06_14-07-30_posttrial3'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD1_posttrial3_short=x;

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
rat5_SD1_posttrial3_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD1_OR_cbd_pt3

%% posttrial4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD1_OR_6_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD1_OR_6_07_2021\2021-07-06_14-58-28_posttrial4'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD1_posttrial4_short=x;

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
rat5_SD1_posttrial4_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD1_OR_cbd_pt4

%% posttrial5-1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD1_OR_6_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD1_OR_6_07_2021\2021-07-06_15-49-34_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD1_posttrial51_short=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD1_OR_cbd_pt51

%% posttrial15-2


%% posttrial5-3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD1_OR_6_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD1_OR_6_07_2021\2021-07-06_15-49-34_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD1_posttrial53_short=x;

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
rat5_SD1_posttrial53_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD1_OR_cbd_pt53

%% posttrial5-4


%% SD2 - OR - Veh
%% presleep

%% posttrial1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD2_OR_9_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD2_OR_9_07_2021\2021-07-09_12-41-42_posttrial1'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD2_posttrial1_short=x;

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
rat5_SD2_posttrial1_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD2_OR_veh_pt1

%% posttrial2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD2_OR_9_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD2_OR_9_07_2021\2021-07-09_13-44-23_posttrial2'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD2_posttrial2_short=x;

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
rat5_SD2_posttrial2_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD2_OR_veh_pt2

%% posttrial3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD2_OR_9_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD2_OR_9_07_2021\2021-07-09_14-35-12_posttrial3'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD2_posttrial3_short=x;

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
rat5_SD2_posttrial3_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD2_OR_veh_pt3

%% posttrial4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD2_OR_9_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD2_OR_9_07_2021\2021-07-09_15-37-26_posttrial4'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD2_posttrial4_short=x;

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
rat5_SD2_posttrial4_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD2_OR_veh_pt4

%% posttrial5-1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD2_OR_9_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD2_OR_9_07_2021\2021-07-09_16-28-31_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD2_posttrial1_short=x;

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
rat5_SD2_posttrial51_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD2_OR_veh_pt51

%% posttrial15-2

%% posttrial5-3

%% posttrial5-4

%% SD3 - OD - Veh

%% presleep

%% posttrial1

%% posttrial2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD3_OD_14-15_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD3_OD_14-15_07_2021\2021-07-14_13-43-51_posttrial2'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD3_posttrial2_short=x;

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
rat5_SD3_posttrial2_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD3_OD_veh_pt2

%% posttrial3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD3_OD_14-15_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD3_OD_14-15_07_2021\2021-07-14_14-34-53_posttrial3'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD3_posttrial3_short=x;

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
rat5_SD3_posttrial3_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD3_OD_veh_pt3

%% posttrial4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD2_OR_9_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD3_OD_14-15_07_2021\2021-07-14_15-25-54_posttrial4'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD3_posttrial4_short=x;

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
rat5_SD3_posttrial4_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD3_OD_veh_pt4

%% posttrial5-1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD2_OR_9_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD3_OD_14-15_07_2021\2021-07-14_16-17-11_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD3_posttrial51_short=x;

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
rat5_SD3_posttrial51_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD3_OD_veh_pt51

%% posttrial15-2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD3_OD_14-15_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD3_OD_14-15_07_2021\2021-07-14_16-17-11_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD3_posttrial52_short=x;

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
rat5_SD3_posttrial52_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD3_OD_veh_pt52

%% posttrial5-3

%% posttrial5-4

%% SD4 - HC - Veh

%% presleep

%% posttrial1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD4_HC_16_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD4_HC_16_07_2021\2021-07-16_11-23-25_posttrial1'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD4_posttrial1_short=x;

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
rat5_SD4_posttrial1_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD4_HC_veh_pt1

%% posttrial2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD4_HC_16_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD4_HC_16_07_2021\2021-07-16_12-13-39_posttrial2'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD4_posttrial2_short=x;

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
rat5_SD4_posttrial2_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD4_HC_veh_pt2

%% posttrial3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD4_HC_16_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD4_HC_16_07_2021\2021-07-16_13-09-26_posttrial3'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD4_posttrial3_short=x;

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
rat5_SD4_posttrial3_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD4_HC_veh_pt3

%% posttrial4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD4_HC_16_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD4_HC_16_07_2021\2021-07-16_13-59-43_posttrial4'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD4_posttrial4_short=x;

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
rat5_SD4_posttrial4_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD4_HC_veh_pt4

%% posttrial5-1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD4_HC_16_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD4_HC_16_07_2021\2021-07-16_14-49-56_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD4_posttria51_short=x;

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
rat5_SD4_posttrial51_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD4_HC_veh_pt51

%% posttrial15-2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD4_HC_16_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD4_HC_16_07_2021\2021-07-16_14-49-56_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD4_posttria52_short=x;

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
rat5_SD4_posttrial52_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD4_HC_veh_pt52

%% posttrial5-3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD4_HC_16_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD4_HC_16_07_2021\2021-07-16_14-49-56_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD4_posttria53_short=x;

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
rat5_SD4_posttrial53_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD4_HC_veh_pt53

%% posttrial5-4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD4_HC_16_07_2021.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD4_HC_16_07_2021\2021-07-16_14-49-56_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD4_posttria54_short=x;

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
rat5_SD4_posttrial54_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD4_HC_veh_pt54

%% SD5 - OD - CBD

%% presleep
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD5_OD_20210717.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD5_OD_20210717\2021-07-17_11-07-12_presleep'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD5_presleep_short=x;

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
rat5_SD5_presleep_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD5_OD_cbd_pre

%% posttrial1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD5_OD_20210717.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD5_OD_20210717\2021-07-17_12-10-34_posttrial1'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD5_posttrial1_short=x;

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
rat5_SD5_posttrial1_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD5_OD_cbd_pt1

%% posttrial2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD5_OD_20210717.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD5_OD_20210717\2021-07-17_13-01-39_posttrial2'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD5_posttrial2_short=x;

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
rat5_SD5_posttrial2_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD5_OD_cbd_pt2

%% posttrial3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD5_OD_20210717.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD5_OD_20210717\2021-07-17_13-52-48_posttrial3'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD5_posttrial3_short=x;

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
rat5_SD5_posttrial3_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD5_OD_cbd_pt3

%% posttrial4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD5_OD_20210717.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD5_OD_20210717\2021-07-17_14-43-53_posttrial4'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD5_posttrial4_short=x;

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
rat5_SD5_posttrial4_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD5_OD_cbd_pt4

%% posttrial5-1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD5_OD_20210717.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD5_OD_20210717\2021-07-17_15-34-48_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD5_posttrial51_short=x;

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
rat5_SD5_posttrial51_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD5_OD_cbd_pt51

%% posttrial15-2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD5_OD_20210717.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD5_OD_20210717\2021-07-17_15-34-48_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD5_posttrial52_short=x;

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
rat5_SD5_posttrial52_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD5_OD_cbd_pt52

%% posttrial5-3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD5_OD_20210717.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD5_OD_20210717\2021-07-17_15-34-48_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD5_posttrial53_short=x;

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
rat5_SD5_posttrial53_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD5_OD_cbd_pt53

%% posttrial5-4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD5_OD_20210717.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD5_OD_20210717\2021-07-17_15-34-48_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD5_posttrial54_short=x;

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
rat5_SD5_posttrial54_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD5_OD_cbd_pt54

%% SD6 - HC - CBD

%% presleep
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD6_HC_20210719.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD6_HC_20210719\2021-07-19_10-10-04_presleep'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD6_presleep_short=x;

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
rat5_SD6_presleep_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD6_HC_cbd_pre

%% posttrial1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD6_HC_20210719.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD6_HC_20210719\2021-07-19_11-22-20_posttrial1'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD6_posttrial1_short=x;


clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD6_HC_cbd_pt1

%% posttrial2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD6_HC_20210719.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD6_HC_20210719\2021-07-19_12-14-30_posttrial2'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD6_posttrial2_short=x;

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
rat5_SD6_posttrial2_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD6_HC_cbd_pt2

%% posttrial3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD6_HC_20210719.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD6_HC_20210719\2021-07-19_13-04-46_posttrial3'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD6_posttrial3_short=x;

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
rat5_SD6_posttrial3_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD6_HC_cbd_pt3

%% posttrial4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD6_HC_20210719.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD6_HC_20210719\2021-07-19_13-55-07_posttrial4'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD6_posttrial4_short=x;

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
rat5_SD6_posttrial4_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD6_HC_cbd_pt4

%% posttrial5-1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD6_HC_20210719.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD6_HC_20210719\2021-07-19_14-48-05_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD6_posttrial51_short=x;


clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD6_HC_cbd_pt51

%% posttrial15-2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD6_HC_20210719.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD6_HC_20210719\2021-07-19_14-48-05_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD6_posttrial52_short=x;

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
rat5_SD6_posttrial52_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD6_HC_cbd_pt52

%% posttrial5-3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD6_HC_20210719.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD6_HC_20210719\2021-07-19_14-48-05_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD6_posttrial53_short=x;

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
rat5_SD6_posttrial53_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD6_HC_cbd_pt53

%% posttrial5-4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\5\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD6_HC_20210719.mat
cd 'F:\OSF\chronic\UMAP - All study days\5\Rat_OS_Ephys_cbd_chronic_Rat5_411358_SD6_HC_20210719\2021-07-19_14-48-05_posttrial5'
load 'PFC_100_CH12_0.continuous.mat'
load 'HPC_100_CH14_0.continuous.mat'
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
rat5_SD6_posttrial54_short=x;

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
rat5_SD6_posttrial54_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat5
save rat5_SD6_HC_cbd_pt54
