%% 2000 closest to the median
%% per treatment & per event type

clc
clear
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD_project/fieldtrip');

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

%% SWR - ofvsComplexSWR (1810 events)
data=GC_detections_HPCpyra_swr_veh;

data = (cellfun(@(equis1) max(abs(hilbert(equis1(1,3001-50:3001+50)))),data));

[~,r_nl]=sort(abs(data-median(data)),'ascend');

% PFCshal
data_sorted = GC_detections_PFCshal_swr_veh;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:1810);

GC_PFCshal_swr_median1810_veh = data_sorted;
save GC_PFCshal_swr_median1810_veh.mat GC_PFCshal_swr_median1810_veh

% PFCdeep
data_sorted = GC_detections_PFCdeep_swr_veh;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:1810);

GC_PFCdeep_swr_median1810_veh = data_sorted;
save GC_PFCdeep_swr_median1810_veh.mat GC_PFCdeep_swr_median1810_veh


%% Complex SWR - ofvsSWR (1810 events)
data=GC_detections_HPCpyra_complex_swr_veh;

data = (cellfun(@(equis1) max(abs(hilbert(equis1(1,3001-50:3001+50)))),data));

[~,r_nl]=sort(abs(data-median(data)),'ascend');

% PFCshal
data_sorted = GC_detections_PFCshal_complex_swr_veh;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:1810);

GC_PFCshal_complex_swr_median1810_veh = data_sorted;
save GC_PFCshal_complex_swr_median1810_veh.mat GC_PFCshal_complex_swr_median1810_veh

% PFCdeep
data_sorted = GC_detections_PFCdeep_complex_swr_veh;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:1810);

GC_PFCdeep_complex_swr_median1810_veh = data_sorted;
save GC_PFCdeep_complex_swr_median1810_veh.mat GC_PFCdeep_complex_swr_median1810_veh


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

%% SWR - ofvsComplexSWR (1300 events)
data=GC_detections_HPCpyra_swr_cbd;

data = (cellfun(@(equis1) max(abs(hilbert(equis1(1,3001-50:3001+50)))),data));

[~,r_nl]=sort(abs(data-median(data)),'ascend');

% PFCshal
data_sorted = GC_detections_PFCshal_swr_cbd;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:1300);

GC_PFCshal_swr_median1300_cbd = data_sorted;
save GC_PFCshal_swr_median1300_cbd.mat GC_PFCshal_swr_median1300_cbd

% PFCdeep
data_sorted = GC_detections_PFCdeep_swr_cbd;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:1300);

GC_PFCdeep_swr_median1300_cbd = data_sorted;
save GC_PFCdeep_swr_median1300_cbd.mat GC_PFCdeep_swr_median1300_cbd

%% Complex SWR - ofvsSWR (1300 events)
data=GC_detections_HPCpyra_complex_swr_cbd;

data = (cellfun(@(equis1) max(abs(hilbert(equis1(1,3001-50:3001+50)))),data));

[~,r_nl]=sort(abs(data-median(data)),'ascend');

% PFCshal
data_sorted = GC_detections_PFCshal_complex_swr_cbd;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:1300);

GC_PFCshal_complex_swr_median1300_cbd = data_sorted;
save GC_PFCshal_complex_swr_median1300_cbd.mat GC_PFCshal_complex_swr_median1300_cbd

% PFCdeep
data_sorted = GC_detections_PFCdeep_complex_swr_cbd;
data_sorted=data_sorted(r_nl);
data_sorted=data_sorted(1:1300);

GC_PFCdeep_complex_swr_median1300_cbd = data_sorted;
save GC_PFCdeep_complex_swr_median1300_cbd.mat GC_PFCdeep_complex_swr_median1300_cbd


