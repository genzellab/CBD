%% CBD Project
%% RatIDs of Veh: 3, 4, 9, 201, 203, 206, 210, 211, 213
%% RatIDs of CBD: 2, 5, 10, 11, 204, 205, 207, 209, 212, 214

clc
clear
load('detections214.mat');

%%%%%%%%%
%% HPC %%
%%%%%%%%%

%% Ripples - HPCpyra
% take sleep_state=2 (NREM)
S = table2array(grouped_oscil_table(:,8));
NREM_idx = find(S==2);
NREM_grouped_oscil_table = grouped_oscil_table(NREM_idx,:);
% Depth 
NREM_grouped_wave_forms = (grouped_wave_forms.HPCpyra(:,NREM_idx))'; % event x time(sample*6s)

% singles
singles_idx_HPC=find(NREM_grouped_oscil_table{:,1}=="singles");
singles_grouped_oscil_table=NREM_grouped_oscil_table(singles_idx_HPC,:);
singles_waveforms=(NREM_grouped_wave_forms(singles_idx_HPC,:)); % event x time(sample*6s)

x = cell2mat(table2array(singles_grouped_oscil_table(:,2)));
ripple_idx_HPC=find(x==2);
ripple_grouped_oscil_table=singles_grouped_oscil_table(ripple_idx_HPC,:);

ripple_waveforms=(singles_waveforms(ripple_idx_HPC,:));
GC_ripple_waveforms=cell(size(ripple_waveforms,1),1);
for i=1:size(ripple_waveforms,1)
    i
    GC_ripple_waveforms{i}=ripple_waveforms(i,:);
end

ripple_grouped_oscil_table_HPCpyra_ratID214          = ripple_grouped_oscil_table;
GC_ripple_waveforms_HPCpyra_ratID214                 = GC_ripple_waveforms;

%% SW - HPCbelo
% Depth 
NREM_grouped_wave_forms = (grouped_wave_forms.HPCbelo(:,NREM_idx))'; % event x time(sample*6s)

% singles
singles_idx_HPC=find(NREM_grouped_oscil_table{:,1}=="singles");
singles_grouped_oscil_table=NREM_grouped_oscil_table(singles_idx_HPC,:);
singles_waveforms=(NREM_grouped_wave_forms(singles_idx_HPC,:)); % event x time(sample*6s)

x = cell2mat(table2array(singles_grouped_oscil_table(:,2)));
sw_idx_HPC=find(x==1);
sw_grouped_oscil_table=singles_grouped_oscil_table(sw_idx_HPC,:);

sw_waveforms=(singles_waveforms(sw_idx_HPC,:));
GC_sw_waveforms=cell(size(sw_waveforms,1),1);
for i=1:size(sw_waveforms,1)
    i
    GC_sw_waveforms{i}=sw_waveforms(i,:);
end

sw_grouped_oscil_table_HPCbelo_ratID214              = sw_grouped_oscil_table;
GC_sw_waveforms_HPCbelo_ratID214                     = GC_sw_waveforms;

%% SWR - HPCpyra & HPCbelo

    %% HPCpyra
    % take sleep_state=2 (NREM)
    S = table2array(grouped_oscil_table(:,8));
    NREM_idx = find(S==2);
    NREM_grouped_oscil_table = grouped_oscil_table(NREM_idx,:);
    % Depth 
    NREM_grouped_wave_forms = (grouped_wave_forms.HPCpyra(:,NREM_idx))'; % event x time(sample*6s)
    
    swr_idx=find(NREM_grouped_oscil_table{:,1}=="simple");
    swr_grouped_oscil_table=NREM_grouped_oscil_table(swr_idx,:);
    swr_waveforms=(NREM_grouped_wave_forms(swr_idx,:)); % event x time(sample*6s)
    GC_swr_waveforms=cell(size(swr_waveforms,1),1);
    for i=1:size(swr_waveforms,1)
        i
        GC_swr_waveforms{i}=swr_waveforms(i,:);
    end

    swr_HPCpyra_idx_ratID214                             = swr_idx;
    swr_grouped_oscil_table_HPCpyra_ratID214             = swr_grouped_oscil_table;
    GC_swr_waveforms_HPCpyra_ratID214                    = GC_swr_waveforms;

    %% HPCbelo
    % take sleep_state=2 (NREM)
    S = table2array(grouped_oscil_table(:,8));
    NREM_idx = find(S==2);
    NREM_grouped_oscil_table = grouped_oscil_table(NREM_idx,:);
    % Depth 
    NREM_grouped_wave_forms = (grouped_wave_forms.HPCbelo(:,NREM_idx))'; % event x time(sample*6s)
    
    swr_idx=find(NREM_grouped_oscil_table{:,1}=="simple");
    swr_grouped_oscil_table=NREM_grouped_oscil_table(swr_idx,:);
    swr_waveforms=(NREM_grouped_wave_forms(swr_idx,:)); % event x time(sample*6s)
    GC_swr_waveforms=cell(size(swr_waveforms,1),1);
    for i=1:size(swr_waveforms,1)
        i
        GC_swr_waveforms{i}=swr_waveforms(i,:);
    end

    swr_HPCbelo_idx_ratID214                             = swr_idx;
    swr_grouped_oscil_table_HPCbelo_ratID214             = swr_grouped_oscil_table;
    GC_swr_waveforms_HPCbelo_ratID214                    = GC_swr_waveforms;

%% Complex SWR - HPCpyra & HPCbelo

    %% HPCpyra
    % take sleep_state=2 (NREM)
    S = table2array(grouped_oscil_table(:,8));
    NREM_idx = find(S==2);
    NREM_grouped_oscil_table = grouped_oscil_table(NREM_idx,:);
    % Depth 
    NREM_grouped_wave_forms = (grouped_wave_forms.HPCpyra(:,NREM_idx))'; % event x time(sample*6s)
    
    complex_swr_idx=find(NREM_grouped_oscil_table{:,1}=="complex");
    complex_swr_grouped_oscil_table=NREM_grouped_oscil_table(complex_swr_idx,:);
    complex_swr_waveforms=(NREM_grouped_wave_forms(complex_swr_idx,:)); % event x time(sample*6s)
    GC_complex_swr_waveforms=cell(size(complex_swr_idx,1),1);
    for i=1:size(complex_swr_waveforms,1)
        i
        GC_complex_swr_waveforms{i}=complex_swr_waveforms(i,:);
    end

    complex_swr_HPCpyra_idx_ratID214                             = complex_swr_idx;
    complex_swr_grouped_oscil_table_HPCpyra_ratID214             = complex_swr_grouped_oscil_table;
    GC_complex_swr_waveforms_HPCpyra_ratID214                    = GC_complex_swr_waveforms;

    %% HPCbelo
    % take sleep_state=2 (NREM)
    S = table2array(grouped_oscil_table(:,8));
    NREM_idx = find(S==2);
    NREM_grouped_oscil_table = grouped_oscil_table(NREM_idx,:);
    % Depth 
    NREM_grouped_wave_forms = (grouped_wave_forms.HPCbelo(:,NREM_idx))'; % event x time(sample*6s)
    
    complex_swr_idx=find(NREM_grouped_oscil_table{:,1}=="complex");
    complex_swr_grouped_oscil_table=NREM_grouped_oscil_table(complex_swr_idx,:);
    complex_swr_waveforms=(NREM_grouped_wave_forms(complex_swr_idx,:)); % event x time(sample*6s)
    GC_complex_swr_waveforms=cell(size(complex_swr_idx,1),1);
    for i=1:size(complex_swr_waveforms,1)
        i
        GC_complex_swr_waveforms{i}=complex_swr_waveforms(i,:);
    end

    complex_swr_HPCbelo_idx_ratID214                             = complex_swr_idx;
    complex_swr_grouped_oscil_table_HPCbelo_ratID214             = complex_swr_grouped_oscil_table;
    GC_complex_swr_waveforms_HPCbelo_ratID214                    = GC_complex_swr_waveforms;

%%
clearvars -except ripple_idx ripple_grouped_oscil_table_HPCpyra_ratID214 GC_ripple_waveforms_HPCpyra_ratID214...
    sw_idx sw_grouped_oscil_table_HPCbelo_ratID214 GC_sw_waveforms_HPCbelo_ratID214...
     swr_HPCpyra_idx_ratID214 swr_grouped_oscil_table_HPCpyra_ratID214 GC_swr_waveforms_HPCpyra_ratID214... 
    swr_HPCbelo_idx_ratID214 swr_grouped_oscil_table_HPCbelo_ratID214 GC_swr_waveforms_HPCbelo_ratID214... 
       complex_swr_HPCpyra_idx_ratID214 complex_swr_grouped_oscil_table_HPCpyra_ratID214 GC_complex_swr_waveforms_HPCpyra_ratID214...
       complex_swr_HPCbelo_idx_ratID214 complex_swr_grouped_oscil_table_HPCbelo_ratID214 GC_complex_swr_waveforms_HPCbelo_ratID214
       
save('ratID214_HPC_cbd.mat','-v7.3');






