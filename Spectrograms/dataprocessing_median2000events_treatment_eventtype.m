%% Pelin Ozsezer

%% select 2000 closest events to the median
%% per treatment & per event type

clc
clear
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/fieldtrip');

%%%%%%%%%%%%%
%% Vehicle %%
%%%%%%%%%%%%%

load('detections_HPC_veh.mat'); 
load('detections_PFCshal_veh.mat');
load('detections_PFCdeep_veh.mat');

%% Ripple
data=GC_detections_HPCpyra_ripple_veh;

data = (cellfun(@(equis1) max(abs(hilbert(equis1(1,3001-50:3001+50)))),data));

[~,r_nl]=sort(abs(data-median(data)),'ascend');

% PFCshal
data_sorted = GC_detections_PFCshal_ripple_veh;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:2000);

GC_PFCshal_ripple_median2000_veh = data_sorted;
save GC_PFCshal_ripple_median2000_veh.mat GC_PFCshal_ripple_median2000_veh

% PFCdeep
data_sorted = GC_detections_PFCdeep_ripple_veh;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:2000);

GC_PFCdeep_ripple_median2000_veh = data_sorted;
save GC_PFCdeep_ripple_median2000_veh.mat GC_PFCdeep_ripple_median2000_veh

%% SW
data=GC_detections_HPCbelo_sw_veh;

data = (cellfun(@(equis1) min(abs(hilbert(equis1(1,3001-50:3001+50)))),data));

[~,r_nl]=sort(abs(data-median(data)),'ascend');

% PFCshal
data_sorted = GC_detections_PFCshal_sw_veh;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:2000);

GC_PFCshal_sw_median2000_veh = data_sorted;
save GC_PFCshal_sw_median2000_veh.mat GC_PFCshal_sw_median2000_veh

% PFCdeep
data_sorted = GC_detections_PFCdeep_sw_veh;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:2000);

GC_PFCdeep_sw_median2000_veh = data_sorted;
save GC_PFCdeep_sw_median2000_veh.mat GC_PFCdeep_sw_median2000_veh

%% SWR
data=GC_detections_HPCpyra_swr_veh;

data = (cellfun(@(equis1) max(abs(hilbert(equis1(1,3001-50:3001+50)))),data));

[~,r_nl]=sort(abs(data-median(data)),'ascend');

% PFCshal
data_sorted = GC_detections_PFCshal_swr_veh;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:2000);

GC_PFCshal_swr_median2000_veh = data_sorted;
save GC_PFCshal_swr_median2000_veh.mat GC_PFCshal_swr_median2000_veh

% PFCdeep
data_sorted = GC_detections_PFCdeep_swr_veh;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:2000);

GC_PFCdeep_swr_median2000_veh = data_sorted;
save GC_PFCdeep_swr_median2000_veh.mat GC_PFCdeep_swr_median2000_veh

%% SWR - ofvsComplexSWR (1781 events)
data=GC_detections_HPCpyra_swr_veh;

data = (cellfun(@(equis1) max(abs(hilbert(equis1(1,3001-50:3001+50)))),data));

[~,r_nl]=sort(abs(data-median(data)),'ascend');

% PFCshal
data_sorted = GC_detections_PFCshal_swr_veh;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:1781);

GC_PFCshal_swr_median1781_veh = data_sorted;
save GC_PFCshal_swr_median1781_veh.mat GC_PFCshal_swr_median1781_veh

% PFCdeep
data_sorted = GC_detections_PFCdeep_swr_veh;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:1781);

GC_PFCdeep_swr_median1781_veh = data_sorted;
save GC_PFCdeep_swr_median1781_veh.mat GC_PFCdeep_swr_median1781_veh

%% Complex SWR - ofvsSWR (1781 events)
data=GC_detections_HPCpyra_complex_swr_veh;

data = (cellfun(@(equis1) max(abs(hilbert(equis1(1,3001-50:3001+50)))),data));

[~,r_nl]=sort(abs(data-median(data)),'ascend');

% PFCshal
data_sorted = GC_detections_PFCshal_complex_swr_veh;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:1781);

GC_PFCshal_complex_swr_median1781_veh = data_sorted;
save GC_PFCshal_complex_swr_median1781_veh.mat GC_PFCshal_complex_swr_median1781_veh

% PFCdeep
data_sorted = GC_detections_PFCdeep_complex_swr_veh;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:1781);

GC_PFCdeep_complex_swr_median1781_veh = data_sorted;
save GC_PFCdeep_complex_swr_median1781_veh.mat GC_PFCdeep_complex_swr_median1781_veh


%%%%%%%%%
%% CBD %%
%%%%%%%%%

clc
clear

load('detections_HPC_cbd.mat'); 
load('detections_PFCshal_cbd.mat');
load('detections_PFCdeep_cbd.mat');

%% Ripple
data=GC_detections_HPCpyra_ripple_cbd;

data = (cellfun(@(equis1) max(abs(hilbert(equis1(1,3001-50:3001+50)))),data));

[~,r_nl]=sort(abs(data-median(data)),'ascend');

% PFCshal
data_sorted = GC_detections_PFCshal_ripple_cbd;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:2000);

GC_PFCshal_ripple_median2000_cbd = data_sorted;
save GC_PFCshal_ripple_median2000_cbd.mat GC_PFCshal_ripple_median2000_cbd

% PFCdeep
data_sorted = GC_detections_PFCdeep_ripple_cbd;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:2000);

GC_PFCdeep_ripple_median2000_cbd = data_sorted;
save GC_PFCdeep_ripple_median2000_cbd.mat GC_PFCdeep_ripple_median2000_cbd

%% SW
data=GC_detections_HPCbelo_sw_cbd;

data = (cellfun(@(equis1) min(abs(hilbert(equis1(1,3001-50:3001+50)))),data));

[~,r_nl]=sort(abs(data-median(data)),'ascend');

% PFCshal
data_sorted = GC_detections_PFCshal_sw_cbd;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:2000);

GC_PFCshal_sw_median2000_cbd = data_sorted;
save GC_PFCshal_sw_median2000_cbd.mat GC_PFCshal_sw_median2000_cbd

% PFCdeep
data_sorted = GC_detections_PFCdeep_sw_cbd;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:2000);

GC_PFCdeep_sw_median2000_cbd = data_sorted;
save GC_PFCdeep_sw_median2000_cbd.mat GC_PFCdeep_sw_median2000_cbd

%% SWR
data=GC_detections_HPCpyra_swr_cbd;

data = (cellfun(@(equis1) max(abs(hilbert(equis1(1,3001-50:3001+50)))),data));

[~,r_nl]=sort(abs(data-median(data)),'ascend');

% PFCshal
data_sorted = GC_detections_PFCshal_swr_cbd;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:2000);

GC_PFCshal_swr_median2000_cbd = data_sorted;
save GC_PFCshal_swr_median2000_cbd.mat GC_PFCshal_swr_median2000_cbd

% PFCdeep
data_sorted = GC_detections_PFCdeep_swr_cbd;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:2000);

GC_PFCdeep_swr_median2000_cbd = data_sorted;
save GC_PFCdeep_swr_median2000_cbd.mat GC_PFCdeep_swr_median2000_cbd

%% SWR - ofvsComplexSWR (1274 events)
data=GC_detections_HPCpyra_swr_cbd;

data = (cellfun(@(equis1) max(abs(hilbert(equis1(1,3001-50:3001+50)))),data));

[~,r_nl]=sort(abs(data-median(data)),'ascend');

% PFCshal
data_sorted = GC_detections_PFCshal_swr_cbd;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:1274);

GC_PFCshal_swr_median1274_cbd = data_sorted;
save GC_PFCshal_swr_median1274_cbd.mat GC_PFCshal_swr_median1274_cbd

% PFCdeep
data_sorted = GC_detections_PFCdeep_swr_cbd;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:1274);

GC_PFCdeep_swr_median1274_cbd = data_sorted;
save GC_PFCdeep_swr_median1274_cbd.mat GC_PFCdeep_swr_median1274_cbd

%% Complex SWR - ofvsSWR (1274 events)
data=GC_detections_HPCpyra_complex_swr_cbd;

data = (cellfun(@(equis1) max(abs(hilbert(equis1(1,3001-50:3001+50)))),data));

[~,r_nl]=sort(abs(data-median(data)),'ascend');

% PFCshal
data_sorted = GC_detections_PFCshal_complex_swr_cbd;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:1274);

GC_PFCshal_complex_swr_median1274_cbd = data_sorted;
save GC_PFCshal_complex_swr_median1274_cbd.mat GC_PFCshal_complex_swr_median1274_cbd

% PFCdeep
data_sorted = GC_detections_PFCdeep_complex_swr_cbd;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:1274);

GC_PFCdeep_complex_swr_median1274_cbd = data_sorted;
save GC_PFCdeep_complex_swr_median1274_cbd.mat GC_PFCdeep_complex_swr_median1274_cbd


