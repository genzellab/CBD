%% Pelin Ozsezer

%% CBD Project

% MANUAL - Run rat by rat

%% RatIDs of Veh: 3, 4, 9, 201, 203, 206, 210, 211, 213
%% RatIDs of CBD: 2, 5, 10, 11, 204, 205, 207, 209, 212, 214

clc
clear
cd /home/genzellab/Desktop/Pelin/detections_final
load('detections214.mat');
cd /home/genzellab/Desktop/Pelin

%%%%%%%%%
%% HPC %%
%%%%%%%%%

%% Ripples 

    %% HPC

    % take sleep_state=2 (NREM)
    S = table2array(grouped_oscil_table(:,8));
    NREM_idx = find(S==2);
    NREM_grouped_oscil_table = grouped_oscil_table(NREM_idx,:);

    % Depth 
    for ch=1:32
        
        temp_var = strcat( "NREM_grouped_wave_forms = (detection_ratID214_HPC",num2str(ch),...
            "_cbd(NREM_idx,:)); % event x time(sample*6s)");
        eval(sprintf('%s',temp_var));

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
        
        
        temp_var = strcat( "ripple_grouped_oscil_table_HPC",num2str(ch),"_ratID214 = ripple_grouped_oscil_table;");
        eval(sprintf('%s',temp_var));

        temp_var = strcat( "GC_ripple_waveforms_HPC",num2str(ch),"_ratID214 = GC_ripple_waveforms;");
        eval(sprintf('%s',temp_var));
    end



%% SW 

    %% HPC
    % Depth 
    for ch=1:32
        % event x time(sample*6s)
        temp_var = strcat( "NREM_grouped_wave_forms = (detection_ratID214_HPC",num2str(ch),"_cbd(NREM_idx,:));");
        eval(sprintf('%s',temp_var));
    
        
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
        
        temp_var = strcat( " sw_grouped_oscil_table_HPC",num2str(ch),"_ratID214 = sw_grouped_oscil_table;");
        eval(sprintf('%s',temp_var));
    
        
        temp_var = strcat( "GC_sw_waveforms_HPC",num2str(ch),"_ratID214 = GC_sw_waveforms;");
        eval(sprintf('%s',temp_var));
    end
    
    
%% SWR 

    %% HPC
    % take sleep_state=2 (NREM)
    S = table2array(grouped_oscil_table(:,8));
    NREM_idx = find(S==2);
    NREM_grouped_oscil_table = grouped_oscil_table(NREM_idx,:);

    % Depth 
    for ch= 1:32
        % event x time(sample*6s)
        temp_var = strcat( "NREM_grouped_wave_forms = (detection_ratID214_HPC",num2str(ch),"_cbd(NREM_idx,:));");
        eval(sprintf('%s',temp_var));
        
        swr_idx=find(NREM_grouped_oscil_table{:,1}=="simple");
        swr_grouped_oscil_table=NREM_grouped_oscil_table(swr_idx,:);
        swr_waveforms=(NREM_grouped_wave_forms(swr_idx,:)); % event x time(sample*6s)
        GC_swr_waveforms=cell(size(swr_waveforms,1),1);
        for i=1:size(swr_waveforms,1)
            i
            GC_swr_waveforms{i}=swr_waveforms(i,:);
        end
        
        temp_var = strcat( "swr_HPC",num2str(ch),"_idx_ratID214 = swr_idx;");
        eval(sprintf('%s',temp_var));
        
        temp_var = strcat( "swr_grouped_oscil_table_HPC",num2str(ch),"_ratID214 = swr_grouped_oscil_table;");
        eval(sprintf('%s',temp_var));
        
        temp_var = strcat( "GC_swr_waveforms_HPC",num2str(ch),"_ratID214 = GC_swr_waveforms;");
        eval(sprintf('%s',temp_var));
    end
 

%% Complex SWR 

    %% HPC
    % take sleep_state=2 (NREM)
    S = table2array(grouped_oscil_table(:,8));
    NREM_idx = find(S==2);
    NREM_grouped_oscil_table = grouped_oscil_table(NREM_idx,:);

    for ch=1:32
        % Depth 
        % event x time(sample*6s)
        temp_var = strcat( "NREM_grouped_wave_forms = (detection_ratID214_HPC",num2str(ch),"_cbd(NREM_idx,:)); ");
        eval(sprintf('%s',temp_var));
        
        complex_swr_idx=find(NREM_grouped_oscil_table{:,1}=="complex");
        complex_swr_grouped_oscil_table=NREM_grouped_oscil_table(complex_swr_idx,:);
        complex_swr_waveforms=(NREM_grouped_wave_forms(complex_swr_idx,:)); % event x time(sample*6s)
        GC_complex_swr_waveforms=cell(size(complex_swr_idx,1),1);
        for i=1:size(complex_swr_waveforms,1)
            i
            GC_complex_swr_waveforms{i}=complex_swr_waveforms(i,:);
        end
    
        
        temp_var = strcat( "complex_swr_HPC",num2str(ch),"_idx_ratID214 = complex_swr_idx;");
        eval(sprintf('%s',temp_var));
        
        temp_var = strcat( "complex_swr_grouped_oscil_table_HPC",num2str(ch),"_ratID214 = complex_swr_grouped_oscil_table;");
        eval(sprintf('%s',temp_var));
   
        temp_var = strcat( "GC_complex_swr_waveforms_HPC",num2str(ch),"_ratID214 = GC_complex_swr_waveforms;");
        eval(sprintf('%s',temp_var));
    end

  
%%      
save('ratID214_HPC_cbd.mat','-v7.3');






