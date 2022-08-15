%% Pelin Ozsezer

%% convert data to 4-by-3601 format

clc
clear
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/functions');
% load combined detections

%%%%%%%%%
%% VEH %%
%%%%%%%%%
load('detections_HPCpyra_veh_wa.mat');
load('detections_HPCbelo_veh_wa.mat');
load('detections_PFCshal_veh_wa.mat');
load('detections_PFCdeep_veh_wa.mat');

%% Ripple
for i=1:size(GC_detections_PFCshal_ripple_veh,1)
    GC_ripple_veh.waveforms{i,1}(1,:)=GC_detections_PFCshal_ripple_veh{i,1}(1,:);
    GC_ripple_veh.waveforms{i,1}(2,:)=GC_detections_HPCpyra_ripple_veh{i,1}(1,:);
    GC_ripple_veh.waveforms{i,1}(4,:)=GC_detections_PFCdeep_ripple_veh{i,1}(1,:);
    GC_ripple_veh.waveforms{i,1}(3,:)=GC_detections_HPCbelo_ripple_veh{i,1}(1,:);
end

GC_ripple_veh.grouped_oscil_table=ripple_grouped_oscil_table_HPCpyra_veh;

%% SW
for i=1:size(GC_detections_PFCshal_sw_veh,1)
    GC_sw_veh.waveforms{i,1}(1,:)=GC_detections_PFCshal_sw_veh{i,1}(1,:);
    GC_sw_veh.waveforms{i,1}(2,:)=GC_detections_HPCpyra_sw_veh{i,1}(1,:);
    GC_sw_veh.waveforms{i,1}(4,:)=GC_detections_PFCdeep_sw_veh{i,1}(1,:);
    GC_sw_veh.waveforms{i,1}(3,:)=GC_detections_HPCbelo_sw_veh{i,1}(1,:);
end

GC_sw_veh.grouped_oscil_table=sw_grouped_oscil_table_HPCpyra_veh;

%% SWR
for i=1:size(GC_detections_PFCshal_swr_veh,1)
    GC_swr_veh.waveforms{i,1}(1,:)=GC_detections_PFCshal_swr_veh{i,1}(1,:);
    GC_swr_veh.waveforms{i,1}(2,:)=GC_detections_HPCpyra_swr_veh{i,1}(1,:);
    GC_swr_veh.waveforms{i,1}(4,:)=GC_detections_PFCdeep_swr_veh{i,1}(1,:);
    GC_swr_veh.waveforms{i,1}(3,:)=GC_detections_HPCbelo_swr_veh{i,1}(1,:);
end

GC_swr_veh.grouped_oscil_table=swr_grouped_oscil_table_HPCpyra_veh;

%% Complex SWR
for i=1:size(GC_detections_PFCshal_complex_swr_veh,1)
    GC_complex_swr_veh.waveforms{i,1}(1,:)=GC_detections_PFCshal_complex_swr_veh{i,1}(1,:);
    GC_complex_swr_veh.waveforms{i,1}(2,:)=GC_detections_HPCpyra_complex_swr_veh{i,1}(1,:);
    GC_complex_swr_veh.waveforms{i,1}(4,:)=GC_detections_PFCdeep_complex_swr_veh{i,1}(1,:);
    GC_complex_swr_veh.waveforms{i,1}(3,:)=GC_detections_HPCbelo_complex_swr_veh{i,1}(1,:);
end

GC_complex_swr_veh.grouped_oscil_table=complex_swr_grouped_oscil_table_HPCpyra_veh;

clearvars -except GC_ripple_veh GC_sw_veh GC_swr_veh GC_complex_swr_veh
data_info=['1)PFCshal; 2)HPCpyra; 3)HPCbelo; 4)PFCdeep'];
save GC_veh


%%%%%%%%%
%% CBD %%
%%%%%%%%%
clear
load('detections_HPCpyra_cbd_wa.mat');
load('detections_HPCbelo_cbd_wa.mat');
load('detections_PFCshal_cbd_wa.mat');
load('detections_PFCdeep_cbd_wa.mat');

%% Ripple
for i=1:size(GC_detections_PFCshal_ripple_cbd,1)
    GC_ripple_cbd.waveforms{i,1}(1,:)=GC_detections_PFCshal_ripple_cbd{i,1}(1,:);
    GC_ripple_cbd.waveforms{i,1}(2,:)=GC_detections_HPCpyra_ripple_cbd{i,1}(1,:);
    GC_ripple_cbd.waveforms{i,1}(4,:)=GC_detections_PFCdeep_ripple_cbd{i,1}(1,:);
    GC_ripple_cbd.waveforms{i,1}(3,:)=GC_detections_HPCbelo_ripple_cbd{i,1}(1,:);
end

GC_ripple_cbd.grouped_oscil_table=ripple_grouped_oscil_table_HPCpyra_cbd;

%% SW
for i=1:size(GC_detections_PFCshal_sw_cbd,1)
    GC_sw_cbd.waveforms{i,1}(1,:)=GC_detections_PFCshal_sw_cbd{i,1}(1,:);
    GC_sw_cbd.waveforms{i,1}(2,:)=GC_detections_HPCpyra_sw_cbd{i,1}(1,:);
    GC_sw_cbd.waveforms{i,1}(4,:)=GC_detections_PFCdeep_sw_cbd{i,1}(1,:);
    GC_sw_cbd.waveforms{i,1}(3,:)=GC_detections_HPCbelo_sw_cbd{i,1}(1,:);
end

GC_sw_cbd.grouped_oscil_table=sw_grouped_oscil_table_HPCpyra_cbd;

%% SWR
for i=1:size(GC_detections_PFCshal_swr_cbd,1)
    GC_swr_cbd.waveforms{i,1}(1,:)=GC_detections_PFCshal_swr_cbd{i,1}(1,:);
    GC_swr_cbd.waveforms{i,1}(2,:)=GC_detections_HPCpyra_swr_cbd{i,1}(1,:);
    GC_swr_cbd.waveforms{i,1}(4,:)=GC_detections_PFCdeep_swr_cbd{i,1}(1,:);
    GC_swr_cbd.waveforms{i,1}(3,:)=GC_detections_HPCbelo_swr_cbd{i,1}(1,:);
end

GC_swr_cbd.grouped_oscil_table=swr_grouped_oscil_table_HPCpyra_cbd;

%% Complex SWR
for i=1:size(GC_detections_PFCshal_complex_swr_cbd,1)
    GC_complex_swr_cbd.waveforms{i,1}(1,:)=GC_detections_PFCshal_complex_swr_cbd{i,1}(1,:);
    GC_complex_swr_cbd.waveforms{i,1}(2,:)=GC_detections_HPCpyra_complex_swr_cbd{i,1}(1,:);
    GC_complex_swr_cbd.waveforms{i,1}(4,:)=GC_detections_PFCdeep_complex_swr_cbd{i,1}(1,:);
    GC_complex_swr_cbd.waveforms{i,1}(3,:)=GC_detections_HPCbelo_complex_swr_cbd{i,1}(1,:);
end

GC_complex_swr_cbd.grouped_oscil_table=complex_swr_grouped_oscil_table_HPCpyra_cbd;


clearvars -except GC_ripple_cbd GC_sw_cbd GC_swr_cbd GC_complex_swr_cbd
data_info=['1)PFCshal; 2)HPCpyra; 3)HPCbelo; 4)PFCdeep'];
save GC_cbd