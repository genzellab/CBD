
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

    %% HPC
    cd /home/genzellab/Desktop/Pelin/detections
    rat=[3, 4, 9, 201, 203, 206, 210, 211, 213,2, 5, 10, 11, 204, 205, 207, 209, 212, 214];
    rat=sort(rat);
    idx=find(rat==rat_no);
    load([num2str(rat_no) '.mat']); % from detections_group_info
    
    for ch=1:32
        cd /home/genzellab/Desktop/Pelin/processed_data
        sprintf(['channel: HPC' num2str(ch)])

        temp_var = strcat( "load('processed_HPC",num2str(ch),".mat');");
        eval(sprintf('%s',temp_var));
    
        cd /home/genzellab/Desktop/Pelin/detections_only
        
        waveforms=[];
        for i=1:size(grouped_oscil_table,1)
            x=signals(idx,round(table2array(grouped_oscil_table(i,4)))-1800:...
                round(table2array(grouped_oscil_table(i,4)))+1800);
            waveforms=[waveforms;x];
        end
        temp_var = strcat( "detection_ratID",num2str(rat_no),"_HPC",num2str(ch),"_veh=waveforms;");
        eval(sprintf('%s',temp_var));
    end 

    %% Save 
    temp_var = strcat( 'clearvars -except -regexp rat_no grouped detection_ratID',num2str(rat_no));
    eval(sprintf('%s',temp_var));

    temp_var = strcat( 'save detection',num2str(rat_no),'.mat');
    eval(sprintf('%s',temp_var));

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

    %% HPC
    cd /home/genzellab/Desktop/Pelin/detections
    rat=[3, 4, 9, 201, 203, 206, 210, 211, 213,2, 5, 10, 11, 204, 205, 207, 209, 212, 214];
    rat=sort(rat);
    idx=find(rat==rat_no);
    load([num2str(rat_no) '.mat']); % from detections_group_info
    
    for ch=1:32
        cd /home/genzellab/Desktop/Pelin/processed_data
        sprintf(['channel: HPC' num2str(ch)])

        temp_var = strcat( "load('processed_HPC",num2str(ch),".mat');");
        eval(sprintf('%s',temp_var));
    
        cd /home/genzellab/Desktop/Pelin/detections_only
        
        waveforms=[];
        for i=1:size(grouped_oscil_table,1)
            x=signals(idx,round(table2array(grouped_oscil_table(i,4)))-1800:...
                round(table2array(grouped_oscil_table(i,4)))+1800);
            waveforms=[waveforms;x];
        end
        temp_var = strcat( "detection_ratID",num2str(rat_no),"_HPC",num2str(ch),"_cbd=waveforms;");
        eval(sprintf('%s',temp_var));
    end 

    %% Save 
    temp_var = strcat( 'clearvars -except -regexp rat_no grouped detection_ratID',num2str(rat_no));
    eval(sprintf('%s',temp_var));

    temp_var = strcat( 'save detection',num2str(rat_no),'.mat');
    eval(sprintf('%s',temp_var));

    rats_cbd=[2 5 10 11 204 205 207 209 212 214];
end
