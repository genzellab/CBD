%% Pelin Ozsezer - 25.5.2022
%% CBD Project

% MANUAL - Run rat by rat 
% Change rat number and also treatment (i.e., veh, cbd)

%% RatIDs of Veh: 3, 4, 9, 201, 203, 206, 210, 211, 213
%% RatIDs of CBD: 2, 5, 10, 11, 204, 205, 207, 209, 212, 214

clc
clear
cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/detections_final
load('detections214.mat');
cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project

%%%%%%%%%%%%%
%% PFCshal %%
%%%%%%%%%%%%%

%% Process data - generate r - sw - swr - complex swr
% from grouped_oscil_table

% take sleep_state=2 (NREM)
S = table2array(grouped_oscil_table(:,8));
NREM_idx = find(S==2);
NREM_grouped_oscil_table = grouped_oscil_table(NREM_idx,:);
% Depth 
NREM_grouped_wave_forms = (detection_ratID214_PFCshal_cbd(NREM_idx,:)); % event x time(sample*6s)

% singles
singles_idx=find(NREM_grouped_oscil_table{:,1}=="singles");
singles_grouped_oscil_table=NREM_grouped_oscil_table(singles_idx,:);
singles_waveforms=(NREM_grouped_wave_forms(singles_idx,:)); % event x time(sample*6s)

x = cell2mat(table2array(singles_grouped_oscil_table(:,2)));
sw_idx=find(x==1);
ripple_idx=find(x==2);

sw_grouped_oscil_table=singles_grouped_oscil_table(sw_idx,:);
ripple_grouped_oscil_table=singles_grouped_oscil_table(ripple_idx,:);

sw_waveforms=(singles_waveforms(sw_idx,:));
GC_sw_waveforms=cell(size(sw_waveforms,1),1);
for i=1:size(sw_waveforms,1)
    i
    GC_sw_waveforms{i}=sw_waveforms(i,:);
end

ripple_waveforms=(singles_waveforms(ripple_idx,:));
GC_ripple_waveforms=cell(size(ripple_waveforms,1),1);
for i=1:size(ripple_waveforms,1)
    i
    GC_ripple_waveforms{i}=ripple_waveforms(i,:);
end

% swr
swr_idx=find(NREM_grouped_oscil_table{:,1}=="simple");
swr_grouped_oscil_table=NREM_grouped_oscil_table(swr_idx,:);
swr_waveforms=(NREM_grouped_wave_forms(swr_idx,:)); % event x time(sample*6s)
GC_swr_waveforms=cell(size(swr_waveforms,1),1);
for i=1:size(swr_waveforms,1)
    i
    GC_swr_waveforms{i}=swr_waveforms(i,:);
end

% complex swr
complex_swr_idx=find(NREM_grouped_oscil_table{:,1}=="complex");
complex_swr_grouped_oscil_table=NREM_grouped_oscil_table(complex_swr_idx,:);
complex_swr_waveforms=(NREM_grouped_wave_forms(complex_swr_idx,:)); % event x time(sample*6s)
GC_complex_swr_waveforms=cell(size(complex_swr_waveforms,1),1);
for i=1:size(complex_swr_waveforms,1)
    i
    GC_complex_swr_waveforms{i}=complex_swr_waveforms(i,:);
end

clearvars -except sw_grouped_oscil_table GC_sw_waveforms...
    ripple_grouped_oscil_table GC_ripple_waveforms...
    swr_grouped_oscil_table GC_swr_waveforms...
    complex_swr_grouped_oscil_table GC_complex_swr_waveforms

%%
sw_grouped_oscil_table_PFCshal_ratID214              = sw_grouped_oscil_table;
GC_sw_waveforms_PFCshal_ratID214                     = GC_sw_waveforms;

ripple_grouped_oscil_table_PFCshal_ratID214          = ripple_grouped_oscil_table;
GC_ripple_waveforms_PFCshal_ratID214                 = GC_ripple_waveforms;

swr_grouped_oscil_table_PFCshal_ratID214             = swr_grouped_oscil_table;
GC_swr_waveforms_PFCshal_ratID214                    = GC_swr_waveforms;

complex_swr_grouped_oscil_table_PFCshal_ratID214     = complex_swr_grouped_oscil_table;
GC_complex_swr_waveforms_PFCshal_ratID214            = GC_complex_swr_waveforms;

% save
save('ratID214_PFCshal_cbd.mat','sw_grouped_oscil_table_PFCshal_ratID214','GC_sw_waveforms_PFCshal_ratID214',...
    'ripple_grouped_oscil_table_PFCshal_ratID214','GC_ripple_waveforms_PFCshal_ratID214',...
    'swr_grouped_oscil_table_PFCshal_ratID214','GC_swr_waveforms_PFCshal_ratID214',...
    'complex_swr_grouped_oscil_table_PFCshal_ratID214','GC_complex_swr_waveforms_PFCshal_ratID214','-v7.3')



%%
%%%%%%%%%%%%%
%% PFCdeep %%
%%%%%%%%%%%%%
clc
clear
cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/detections_final
load('detections214.mat');
cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project

%% Process data - generate r - sw - swr - complex swr
% from grouped_oscil_table

% take sleep_state=2 (NREM)
S = table2array(grouped_oscil_table(:,8));
NREM_idx = find(S==2);
NREM_grouped_oscil_table = grouped_oscil_table(NREM_idx,:);
% Depth 
NREM_grouped_wave_forms = (detection_ratID214_PFCdeep_cbd(NREM_idx,:)); % event x time(sample*6s)

% singles
singles_idx=find(NREM_grouped_oscil_table{:,1}=="singles");
singles_grouped_oscil_table=NREM_grouped_oscil_table(singles_idx,:);
singles_waveforms=(NREM_grouped_wave_forms(singles_idx,:)); % event x time(sample*6s)

x = cell2mat(table2array(singles_grouped_oscil_table(:,2)));
sw_idx=find(x==1);
ripple_idx=find(x==2);

sw_grouped_oscil_table=singles_grouped_oscil_table(sw_idx,:);
ripple_grouped_oscil_table=singles_grouped_oscil_table(ripple_idx,:);

sw_waveforms=(singles_waveforms(sw_idx,:));
GC_sw_waveforms=cell(size(sw_waveforms,1),1);
for i=1:size(sw_waveforms,1)
    i
    GC_sw_waveforms{i}=sw_waveforms(i,:);
end

ripple_waveforms=(singles_waveforms(ripple_idx,:));
GC_ripple_waveforms=cell(size(ripple_waveforms,1),1);
for i=1:size(ripple_waveforms,1)
    i
    GC_ripple_waveforms{i}=ripple_waveforms(i,:);
end

% swr
swr_idx=find(NREM_grouped_oscil_table{:,1}=="simple");
swr_grouped_oscil_table=NREM_grouped_oscil_table(swr_idx,:);
swr_waveforms=(NREM_grouped_wave_forms(swr_idx,:)); % event x time(sample*6s)
GC_swr_waveforms=cell(size(swr_waveforms,1),1);
for i=1:size(swr_waveforms,1)
    i
    GC_swr_waveforms{i}=swr_waveforms(i,:);
end

% complex swr
complex_swr_idx=find(NREM_grouped_oscil_table{:,1}=="complex");
complex_swr_grouped_oscil_table=NREM_grouped_oscil_table(complex_swr_idx,:);
complex_swr_waveforms=(NREM_grouped_wave_forms(complex_swr_idx,:)); % event x time(sample*6s)
GC_complex_swr_waveforms=cell(size(complex_swr_waveforms,1),1);
for i=1:size(complex_swr_waveforms,1)
    i
    GC_complex_swr_waveforms{i}=complex_swr_waveforms(i,:);
end

clearvars -except sw_grouped_oscil_table GC_sw_waveforms...
    ripple_grouped_oscil_table GC_ripple_waveforms...
    swr_grouped_oscil_table GC_swr_waveforms...
    complex_swr_grouped_oscil_table GC_complex_swr_waveforms

%%
sw_grouped_oscil_table_PFCdeep_ratID214              = sw_grouped_oscil_table;
GC_sw_waveforms_PFCdeep_ratID214                     = GC_sw_waveforms;

ripple_grouped_oscil_table_PFCdeep_ratID214          = ripple_grouped_oscil_table;
GC_ripple_waveforms_PFCdeep_ratID214                 = GC_ripple_waveforms;

swr_grouped_oscil_table_PFCdeep_ratID214             = swr_grouped_oscil_table;
GC_swr_waveforms_PFCdeep_ratID214                    = GC_swr_waveforms;

complex_swr_grouped_oscil_table_PFCdeep_ratID214     = complex_swr_grouped_oscil_table;
GC_complex_swr_waveforms_PFCdeep_ratID214            = GC_complex_swr_waveforms;

% save
save('ratID214_PFCdeep_cbd.mat','sw_grouped_oscil_table_PFCdeep_ratID214','GC_sw_waveforms_PFCdeep_ratID214',...
    'ripple_grouped_oscil_table_PFCdeep_ratID214','GC_ripple_waveforms_PFCdeep_ratID214',...
    'swr_grouped_oscil_table_PFCdeep_ratID214','GC_swr_waveforms_PFCdeep_ratID214',...
    'complex_swr_grouped_oscil_table_PFCdeep_ratID214','GC_complex_swr_waveforms_PFCdeep_ratID214','-v7.3')








