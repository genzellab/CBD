%% Pelin Ozsezer

%% RatIDs of Veh: 3, 4, 9, 201, 203, 206, 210, 211, 213
%% RatIDs of CBD: 2, 5, 10, 11, 204, 205, 207, 209, 212, 214


%%%%%%%%%
%% VEH %%
%%%%%%%%%

clc
clear
format compact
rats_veh=[3 4 9 201 203 206 210 211 213];
for i=1:length(rats_veh)
    rat_no=rats_veh(i);
    sprintf(['rat number: ' num2str(rat_no) ' of Vehicle'])

    %% HPCpyra
%     cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project
%     cd binned-data/detections_group_info
    rat=[3, 4, 9, 201, 203, 206, 210, 211, 213,2, 5, 10, 11, 204, 205, 207, 209, 212, 214];
    rat=sort(rat);
    idx=find(rat==rat_no);
    load([num2str(rat_no) '.mat']); % from detections_group_info
    cd ..
    cd processed_data
    load('processed_HPCpyra.mat');
    cd ..
    cd detections_only
    
    waveforms=[];
    for i=1:size(grouped_oscil_table,1)
        x=signals(idx,round(table2array(grouped_oscil_table(i,4)))-1800:...
            round(table2array(grouped_oscil_table(i,4)))+1800);
        waveforms=[waveforms;x];
    end
    temp_var = strcat( 'detection_ratID',num2str(rat_no),'_HPCpyra_veh=waveforms;');
    eval(sprintf('%s',temp_var));
    
    %% HPCbelo
    cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/processed_data
    load('processed_HPCbelo.mat');
    cd ..
    cd detections_only
    
    waveforms=[];
    for i=1:size(grouped_oscil_table,1)
        x=signals(idx,round(table2array(grouped_oscil_table(i,4)))-1800:...
            round(table2array(grouped_oscil_table(i,4)))+1800);
        waveforms=[waveforms;x];
    end
    temp_var = strcat( 'detection_ratID',num2str(rat_no),'_HPCbelo_veh=waveforms;');
    eval(sprintf('%s',temp_var));
    
    %% PFCshal
    cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/processed_data
    load('processed_PFCshal.mat');
    cd ..
    cd detections_only
    
    waveforms=[];
    for i=1:size(grouped_oscil_table,1)
        x=signals(idx,round(table2array(grouped_oscil_table(i,4)))-1800:...
            round(table2array(grouped_oscil_table(i,4)))+1800);
        waveforms=[waveforms;x];
    end
    temp_var = strcat( 'detection_ratID',num2str(rat_no),'_PFCshal_veh=waveforms;');
    eval(sprintf('%s',temp_var));
    
    %% PFCdeep
    cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/processed_data
    load('processed_PFCdeep.mat');
    cd ..
    cd detections_only
    
    waveforms=[];
    for i=1:size(grouped_oscil_table,1)
        x=signals(idx,round(table2array(grouped_oscil_table(i,4)))-1800:...
            round(table2array(grouped_oscil_table(i,4)))+1800);
        waveforms=[waveforms;x];
    end
    temp_var = strcat( 'detection_ratID',num2str(rat_no),'_PFCdeep_veh=waveforms;');
    eval(sprintf('%s',temp_var));    
    
    %% Save 
    temp_var = strcat( 'clearvars -except -regexp rat_no grouped detection_ratID',num2str(rat_no));
    eval(sprintf('%s',temp_var));
    
    cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/detections_only

    temp_var = strcat( 'save detection',num2str(rat_no),'.mat');
    eval(sprintf('%s',temp_var));

    cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project
    rats_veh=[3 4 9 201 203 206 210 211 213];
end


%%%%%%%%%
%% CBD %%
%%%%%%%%%
clc
clear
format compact
rats_cbd=[2 5 10 11 204 205 207 209 212 214];
for i=1:length(rats_cbd)
    rat_no=rats_cbd(i);
    sprintf(['rat number: ' num2str(rat_no) ' of CBD'])

    %% HPCpyra
    cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project
    cd binned-data/detections_group_info
    rat=[3, 4, 9, 201, 203, 206, 210, 211, 213,2, 5, 10, 11, 204, 205, 207, 209, 212, 214];
    rat=sort(rat);
    idx=find(rat==rat_no);
    load([num2str(rat_no) '.mat']); % from detections_group_info
    cd ..
    cd processed_data
    load('processed_HPCpyra.mat');
    cd ..
    cd detections_only
    
    waveforms=[];
    for i=1:size(grouped_oscil_table,1)
        x=signals(idx,round(table2array(grouped_oscil_table(i,4)))-1800:...
            round(table2array(grouped_oscil_table(i,4)))+1800);
        waveforms=[waveforms;x];
    end
    temp_var = strcat( 'detection_ratID',num2str(rat_no),'_HPCpyra_cbd=waveforms;');
    eval(sprintf('%s',temp_var));    
    
    %% HPCbelo
    cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/processed_data
    load('processed_HPCbelo.mat');
    cd ..
    cd detections_only
    
    waveforms=[];
    for i=1:size(grouped_oscil_table,1)
        x=signals(idx,round(table2array(grouped_oscil_table(i,4)))-1800:...
            round(table2array(grouped_oscil_table(i,4)))+1800);
        waveforms=[waveforms;x];
    end
    temp_var = strcat( 'detection_ratID',num2str(rat_no),'_HPCbelo_cbd=waveforms;');
    eval(sprintf('%s',temp_var));
       
    %% PFCshal
    cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/processed_data
    load('processed_PFCshal.mat');
    cd ..
    cd detections_only
    
    waveforms=[];
    for i=1:size(grouped_oscil_table,1)
        x=signals(idx,round(table2array(grouped_oscil_table(i,4)))-1800:...
            round(table2array(grouped_oscil_table(i,4)))+1800);
        waveforms=[waveforms;x];
    end
    temp_var = strcat( 'detection_ratID',num2str(rat_no),'_PFCshal_cbd=waveforms;');
    eval(sprintf('%s',temp_var));
    
    %% PFCdeep
    cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/processed_data
    load('processed_PFCdeep.mat');
    cd ..
    cd detections_only
    
    waveforms=[];
    for i=1:size(grouped_oscil_table,1)
        x=signals(idx,round(table2array(grouped_oscil_table(i,4)))-1800:...
            round(table2array(grouped_oscil_table(i,4)))+1800);
        waveforms=[waveforms;x];
    end
    temp_var = strcat( 'detection_ratID',num2str(rat_no),'_PFCdeep_cbd=waveforms;');
    eval(sprintf('%s',temp_var));   
    
    %% Save 
    temp_var = strcat( 'clearvars -except -regexp rat_no grouped detection_ratID',num2str(rat_no));
    eval(sprintf('%s',temp_var));
    
    cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/detections_only

    temp_var = strcat( 'save detection',num2str(rat_no),'.mat');
    eval(sprintf('%s',temp_var));

    cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project
    rats_cbd=[2 5 10 11 204 205 207 209 212 214];
end