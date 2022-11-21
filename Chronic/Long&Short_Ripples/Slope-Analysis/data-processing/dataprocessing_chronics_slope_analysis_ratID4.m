%% Pelin Ozsezer

%% Data info:
% Original sampling rate: 30000 Hz; Downsampled to 2500 Hz
% Conditions:
% HC - Home Cage; OR - Overlapping (Over Reinstatement); OD - Stable (Object Displacement)
% Rat 4
% Within subject design - Veh & CBD in each rat

%% Process the chronics data to be computed for slope analysis
clc
clear
cd F:\OSF\chronic\'UMAP - All study days'

% ripple_timestamps: each cell is trial 
% -> row is 'ripple count'
% -> columns 1,2,3 are start,peak,end with respect to the whole recording.

%% Rat 4

%% SD1 - OR - Veh
%% presleep

%% posttrial1

%% posttrial2
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD1_OR_20210601.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD1_OR_20210601'

% SHORT
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD1_OR_20210601\2021-06-01_11-21-01_posttrial2'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,3},1)
    peak=ripple_timestamps_short{1,3}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD1_posttrial2_short=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD1_OR_veh_pt2

%% posttrial3
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD1_OR_20210601.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD1_OR_20210601'

% SHORT
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD1_OR_20210601\2021-06-01_12-11-46_posttrial3'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,4},1)
    peak=ripple_timestamps_short{1,4}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD1_posttrial3_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,4},1)
    peak=ripple_timestamps_long{1,4}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD1_posttrial3_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD1_OR_veh_pt3


%% posttrial4
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD1_OR_20210601.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD1_OR_20210601'

% SHORT
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD1_OR_20210601\2021-06-01_13-02-26_posttrial4'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,5},1)
    peak=ripple_timestamps_short{1,5}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD1_posttrial4_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,5},1)
    peak=ripple_timestamps_long{1,5}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD1_posttrial4_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD1_OR_veh_pt4

%% posttrial5-1
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD1_OR_20210601.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD1_OR_20210601'

% SHORT
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD1_OR_20210601\2021-06-01_13-53-04_posttrial5'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,6},1)
    peak=ripple_timestamps_short{1,6}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD1_posttrial51_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,6},1)
    peak=ripple_timestamps_long{1,6}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD1_posttrial51_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD1_OR_veh_pt51

%% posttrial5-2
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD1_OR_20210601.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD1_OR_20210601'

% SHORT
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD1_OR_20210601\2021-06-01_13-53-04_posttrial5'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,7},1)
    peak=ripple_timestamps_short{1,7}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD1_posttrial52_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,7},1)
    peak=ripple_timestamps_long{1,7}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD1_posttrial52_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD1_OR_veh_pt52

%% posttrial5-3
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD1_OR_20210601.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD1_OR_20210601'

% SHORT
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD1_OR_20210601\2021-06-01_13-53-04_posttrial5'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,8},1)
    peak=ripple_timestamps_short{1,8}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD1_posttrial53_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,8},1)
    peak=ripple_timestamps_long{1,8}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD1_posttrial53_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD1_OR_veh_pt53

%% posttrial5-4
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD1_OR_20210601.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD1_OR_20210601'

% SHORT
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD1_OR_20210601\2021-06-01_13-53-04_posttrial5'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,9},1)
    peak=ripple_timestamps_short{1,9}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD1_posttrial54_short=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD1_OR_veh_pt54



%% SD2 - HC - Veh


%% presleep

%% posttrial1


% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD2_HC_20210603.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD2_HC_20210603\2021-06-03_10-16-28_posttrial1'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,2},1)
    peak=ripple_timestamps_short{1,2}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD2_posttrial1_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,2},1)
    peak=ripple_timestamps_long{1,2}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD2_posttrial1_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD2_HC_veh_pt1



%% posttrial2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD2_HC_20210603.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD2_HC_20210603\2021-06-03_11-06-57_posttrial2'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,3},1)
    peak=ripple_timestamps_short{1,3}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD2_posttrial2_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,3},1)
    peak=ripple_timestamps_long{1,3}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD2_posttrial2_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD2_HC_veh_pt2

%% posttrial3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD2_HC_20210603.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD2_HC_20210603\2021-06-03_11-57-21_posttrial3'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,4},1)
    peak=ripple_timestamps_short{1,4}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD2_posttrial3_short=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD2_HC_veh_pt3

%% posttrial4

%% posttrial5-1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD2_HC_20210603.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD2_HC_20210603\2021-06-03_13-38-14_posttrial5'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,6},1)
    peak=ripple_timestamps_short{1,6}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD2_posttrial51_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,6},1)
    peak=ripple_timestamps_long{1,6}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD2_posttrial51_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD2_HC_veh_pt51

%% posttrial5-2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD2_HC_20210603.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD2_HC_20210603\2021-06-03_13-38-14_posttrial5'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,7},1)
    peak=ripple_timestamps_short{1,7}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD2_posttrial52_short=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD2_HC_veh_pt52

%% posttrial5-3

%% posttrial5-4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD2_HC_20210603.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD2_HC_20210603\2021-06-03_13-38-14_posttrial5'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,9},1)
    peak=ripple_timestamps_short{1,9}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD2_posttrial54_short=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD2_HC_veh_pt53


%% SD3 - OR - CBD

%% presleep
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD3_OR_20210604.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD3_OR_20210604\2021-06-04_09-29-23_presleep'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,1},1)
    peak=ripple_timestamps_short{1,1}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD3_presleep_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,1},1)
    peak=ripple_timestamps_long{1,1}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD3_presleep_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD3_OR_cbd_pre

%% posttrial1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD3_OR_20210604.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD3_OR_20210604\2021-06-04_10-30-41_posttrial1'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,2},1)
    peak=ripple_timestamps_short{1,2}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD3_posttrial1_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,2},1)
    peak=ripple_timestamps_long{1,2}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD3_posttrial1_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD3_OR_cbd_pt1

%% posttrial2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD3_OR_20210604.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD3_OR_20210604\2021-06-04_11-21-11_posttrial2'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,3},1)
    peak=ripple_timestamps_short{1,3}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD3_posttrial2_short=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD3_OR_cbd_pt2

%% posttrial3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD3_OR_20210604.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD3_OR_20210604\2021-06-04_12-11-49_posttrial3'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,4},1)
    peak=ripple_timestamps_short{1,4}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD3_posttrial3_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,4},1)
    peak=ripple_timestamps_long{1,4}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD3_posttrial3_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD3_OR_cbd_pt3

%% posttrial4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD3_OR_20210604.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD3_OR_20210604\2021-06-04_13-03-27_posttrial4'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,5},1)
    peak=ripple_timestamps_short{1,5}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD3_posttrial4_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,5},1)
    peak=ripple_timestamps_long{1,5}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD3_posttrial4_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD3_OR_cbd_pt4

%% posttrial5-1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD3_OR_20210604.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD3_OR_20210604\2021-06-04_13-54-11_posttrial5'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,6},1)
    peak=ripple_timestamps_short{1,6}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD3_posttrial51_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,6},1)
    peak=ripple_timestamps_long{1,6}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD3_posttrial51_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD3_OR_cbd_pt51

%% posttrial5-2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD3_OR_20210604.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD3_OR_20210604\2021-06-04_13-54-11_posttrial5'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
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
rat4_SD3_posttrial52_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,7},1)
    peak=ripple_timestamps_long{1,7}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD3_posttrial52_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD3_OR_cbd_pt52

%% posttrial5-3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD3_OR_20210604.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD3_OR_20210604\2021-06-04_13-54-11_posttrial5'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,8},1)
    peak=ripple_timestamps_short{1,8}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD3_posttrial53_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,8},1)
    peak=ripple_timestamps_long{1,8}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD3_posttrial53_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD3_OR_cbd_pt53

%% posttrial5-4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD3_OR_20210604.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD3_OR_20210604\2021-06-04_13-54-11_posttrial5'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,9},1)
    peak=ripple_timestamps_short{1,9}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD3_posttrial54_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,9},1)
    peak=ripple_timestamps_long{1,9}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD3_posttrial54_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD3_OR_cbd_pt54



%% SD4 - OD - CBD

%% presleep
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD4_OD_20210607.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD4_OD_20210607\2021-06-07_10-15-48_presleep'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,1},1)
    peak=ripple_timestamps_short{1,1}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD4_presleep_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,1},1)
    peak=ripple_timestamps_long{1,1}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD4_presleep_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD4_OD_cbd_pre

%% posttrial1

%% posttrial2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD4_OD_20210607.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD4_OD_20210607\2021-06-07_12-07-03_posttrial2'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,3},1)
    peak=ripple_timestamps_short{1,3}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD4_posttrial2_short=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD4_OD_cbd_pt2


%% posttrial3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD4_OD_20210607.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD4_OD_20210607\2021-06-07_12-57-50_posttrial3'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,4},1)
    peak=ripple_timestamps_short{1,4}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD4_posttrial3_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,4},1)
    peak=ripple_timestamps_long{1,4}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD4_posttrial3_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD4_OD_cbd_pt3

%% posttrial4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD4_OD_20210607.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD4_OD_20210607\2021-06-07_13-48-35_posttrial4'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,5},1)
    peak=ripple_timestamps_short{1,5}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD4_posttrial4_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,5},1)
    peak=ripple_timestamps_long{1,5}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD4_posttrial4_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD4_OD_cbd_pt4

%% posttrial5-1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD4_OD_20210607.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD4_OD_20210607\2021-06-07_14-39-27_posttrial5'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,6},1)
    peak=ripple_timestamps_short{1,6}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD4_posttrial51_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,6},1)
    peak=ripple_timestamps_long{1,6}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD4_posttrial51_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD4_OD_cbd_pt51

%% posttrial5-2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD4_OD_20210607.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD4_OD_20210607\2021-06-07_14-39-27_posttrial5'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
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
rat4_SD4_posttrial52_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,7},1)
    peak=ripple_timestamps_long{1,7}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD4_posttrial52_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD4_OD_cbd_pt52

%% posttrial5-3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD4_OD_20210607.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD4_OD_20210607\2021-06-07_14-39-27_posttrial5'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,8},1)
    peak=ripple_timestamps_short{1,8}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD4_posttrial53_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,8},1)
    peak=ripple_timestamps_long{1,8}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD4_posttrial53_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD4_OD_cbd_pt53

%% posttrial5-4

%% SD6 - OD - Veh

%% presleep

%% posttrial1

%% posttrial2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD6_OD_20210610.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD6_OD_20210610\2021-06-10_11-30-16_posttrial2'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,3},1)
    peak=ripple_timestamps_short{1,3}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD6_posttrial2_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,3},1)
    peak=ripple_timestamps_long{1,3}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD6_posttrial2_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD6_OD_veh_pt2

%% posttrial3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD6_OD_20210610.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD6_OD_20210610\2021-06-10_12-21-12_posttrial3'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,4},1)
    peak=ripple_timestamps_short{1,4}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD6_posttrial3_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,4},1)
    peak=ripple_timestamps_long{1,4}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD6_posttrial3_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD6_OD_veh_pt3

%% posttrial4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD6_OD_20210610.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD6_OD_20210610\2021-06-10_13-12-11_posttrial4'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,5},1)
    peak=ripple_timestamps_short{1,5}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD6_posttrial4_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,5},1)
    peak=ripple_timestamps_long{1,5}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD6_posttrial4_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD6_OD_veh_pt4

%% posttrial5-1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD6_OD_20210610.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD6_OD_20210610\2021-06-10_14-03-03_posttrial5'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,6},1)
    peak=ripple_timestamps_short{1,6}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD6_posttrial51_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,6},1)
    peak=ripple_timestamps_long{1,6}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD6_posttrial51_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD6_OD_veh_pt51

%% posttrial5-2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD6_OD_20210610.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD6_OD_20210610\2021-06-10_14-03-03_posttrial5'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,7},1)
    peak=ripple_timestamps_short{1,7}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD6_posttrial52_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,7},1)
    peak=ripple_timestamps_long{1,7}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD6_posttrial52_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD6_OD_veh_pt52



%% posttrial5-3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD6_OD_20210610.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD6_OD_20210610\2021-06-10_14-03-03_posttrial5'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,8},1)
    peak=ripple_timestamps_short{1,8}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD6_posttrial53_short=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD6_OD_veh_pt53



%% posttrial5-4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD6_OD_20210610.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD6_OD_20210610\2021-06-10_14-03-03_posttrial5'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
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
rat4_SD6_posttrial54_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,9},1)
    peak=ripple_timestamps_long{1,9}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD6_posttrial54_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD6_OD_veh_pt54

%% SD7 - HC - CBD

%% presleep


%% posttrial1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD7_HC_20210614.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD7_HC_20210614\2021-06-14_10-51-15_posttrial1'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,2},1)
    peak=ripple_timestamps_short{1,2}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD7_posttrial1_short=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD7_HC_cbd_pt1


%% posttrial2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD7_HC_20210614.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD7_HC_20210614\2021-06-14_11-41-31_posttrial2'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,3},1)
    peak=ripple_timestamps_short{1,3}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD7_posttrial2_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,3},1)
    peak=ripple_timestamps_long{1,3}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD7_posttrial2_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD7_HC_cbd_pt2

%% posttrial3
%% posttrial4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD7_HC_20210614.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD7_HC_20210614\2021-06-14_13-22-20_posttrial4'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,5},1)
    peak=ripple_timestamps_short{1,5}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD7_posttrial4_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,5},1)
    peak=ripple_timestamps_long{1,5}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD7_posttrial4_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD7_HC_cbd_pt4

%% posttrial5-1
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD7_HC_20210614.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD7_HC_20210614\2021-06-14_14-12-36_posttrial5'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,6},1)
    peak=ripple_timestamps_short{1,6}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD7_posttrial51_short=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD7_HC_cbd_pt51

%% posttrial5-2
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD7_HC_20210614.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD7_HC_20210614\2021-06-14_14-12-36_posttrial5'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
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
rat4_SD7_posttrial52_short=x;

% LONG
x=[];
for i=1:size(ripple_timestamps_long{1,7},1)
    peak=ripple_timestamps_long{1,7}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD7_posttrial52_long=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD7_HC_cbd_pt52

%% posttrial5-3
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD7_HC_20210614.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD7_HC_20210614\2021-06-14_14-12-36_posttrial5'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,8},1)
    peak=ripple_timestamps_short{1,8}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD7_posttrial53_short=x;

clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD7_HC_cbd_pt53

%% posttrial5-4
% SHORT
clear
cd 'F:\OSF\chronic\UMAP - All study days\4\Long_Short_Ripple'
load Long_Short_Ripple_Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD7_HC_20210614.mat
cd 'F:\OSF\chronic\UMAP - All study days\4\Rat_OS_Ephys_cbd_chronic_Rat4_407699_SD7_HC_20210614\2021-06-14_14-12-36_posttrial5'
load 'PFC_100_CH22_0.continuous.mat'
load 'HPC_100_CH18_0.continuous.mat'
x=[];
for i=1:size(ripple_timestamps_short{1,9},1)
    peak=ripple_timestamps_short{1,9}(i,2);
    PFC_ripple=PFC(2500*peak-5000:2500*peak+5000);
    HPC_ripple=HPC(2500*peak-5000:2500*peak+5000);
    x{i,1}(1,:)=PFC_ripple;
    x{i,1}(2,:)=HPC_ripple;
end
rat4_SD7_posttrial54_short=x;


clearvars -except -regexp rat
cd C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\rat4
save rat4_SD7_HC_cbd_pt54


