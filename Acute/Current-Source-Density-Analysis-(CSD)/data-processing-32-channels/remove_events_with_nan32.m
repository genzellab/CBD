%% Pelin Ozsezer

%% REMOVE EVENTS THAT:
% 1)DID NOT STARTED AFTER 3 SECS FROM THE START OF THE RECORDING
% 2)DID NOT FINISH 3 SECS BEFORE THE END OF THE RECORDING

% for HPC data

%% RatIDs of Veh: 3, 4, 9, 201, 203, 206, 210, 211, 213
%% RatIDs of CBD: 2, 5, 10, 11, 204, 205, 207, 209, 212, 214
clc
clear

%% Vehicle
rats_veh=[3 4 9 201 203 206 210 211 213];
for rat_no=1:length(rats_veh)
    rat=rats_veh(rat_no);

    %% load the data
    cd /home/genzellab/Desktop/Pelin/detections_only
    temp_var = strcat( 'load detection',num2str(rat),'.mat;');
    eval(sprintf('%s',temp_var));

    %% check if there is NaN, then remove

    % HPC channels
    for ch=1:32
        temp_var = strcat( 'x',num2str(ch),'=any(isnan(detection_ratID',num2str(rat),...
            '_HPC',num2str(ch),'_veh),2);');
        eval(sprintf('%s',temp_var));
    
        temp_var = strcat( 'detection_ratID',num2str(rat),'_HPC',num2str(ch),...
            '_veh(x',num2str(ch),',:)=[];');
        eval(sprintf('%s',temp_var));
    end

    %% save
    clearvars -except -regexp detection grouped rat x

    temp_var = strcat( 'save detections',num2str(rat),'.mat;');
    eval(sprintf('%s',temp_var));

    clear
    rats_veh=[3 4 9 201 203 206 210 211 213];
end


%% CBD
clear
rats_cbd=[2 5 10 11 204 205 207 209 212 214];
for rat_no=1:length(rats_cbd)
    rat=rats_cbd(rat_no);

    %% load the data
    cd /home/genzellab/Desktop/Pelin/detections_only
    temp_var = strcat( 'load detection',num2str(rat),'.mat;');
    eval(sprintf('%s',temp_var));

    %% check if there is NaN, then remove

    % HPC channel
    for ch=1:32
        temp_var = strcat( 'x',num2str(ch),'=any(isnan(detection_ratID',num2str(rat),...
            '_HPC',num2str(ch),'_cbd),2);');
        eval(sprintf('%s',temp_var));
    
        temp_var = strcat( 'detection_ratID',num2str(rat),'_HPC',num2str(ch),...
            '_cbd(x',num2str(ch),',:)=[];');
        eval(sprintf('%s',temp_var));
    end

    %% save
    clearvars -except -regexp detection grouped rat x

    temp_var = strcat( 'save detections',num2str(rat),'.mat;');
    eval(sprintf('%s',temp_var));

    clear
    rats_cbd=[2 5 10 11 204 205 207 209 212 214];
end

%% remove nans in groupep_oscil_table %%
clear
rats=[2	3	4	5	9	10	11	201	203	204	205	206	207	209	210	211	212	213	214];
for rat_no=1:length(rats)
    rat=rats(rat_no);
    sprintf(['rat ', num2str(rat)])

    temp_var = strcat( 'load detections',num2str(rat),'.mat;');
    eval(sprintf('%s',temp_var));

    for i=1:32
        temp_var = strcat( 'a',num2str(i),'=find(x',num2str(i),'==1);');
        eval(sprintf('%s',temp_var));
    end

    all=[];
    for i=1:32   
        temp_var = strcat( 'all=[all;a',num2str(i),'];');
        eval(sprintf('%s',temp_var));
    end

    [all,m1,n1] = unique(all,'first');
    [c1,d1] =sort(m1);
    rmv = all(d1);
    grouped_oscil_table(rmv,:)=[];
    clearvars -except -regexp detection grouped rat

    temp_var = strcat('save detections',num2str(rat),'.mat;');
    eval(sprintf('%s',temp_var));
    
    clear
    rats=[2	3	4	5	9	10	11	201	203	204	205	206	207	209	210	211	212	213	214];
end

% cut and paste into /binned-data/detections_final_unfiltered

