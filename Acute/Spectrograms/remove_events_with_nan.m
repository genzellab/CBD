%% Pelin Ozsezer

%% REMOVE EVENTS THAT:
% 1)DID NOT STARTED AFTER 3 SECS OF RECORDING
% 2)DID NOT FINISH 3 SECS BEFORE THE END OF THE RECORDING

% for PFC & HPC data

%% RatIDs of Veh: 3, 4, 9, 201, 203, 206, 210, 211, 213
%% RatIDs of CBD: 2, 5, 10, 11, 204, 205, 207, 209, 212, 214
clc
clear

%% Vehicle
rats_veh=[3 4 9 201 203 206 210 211 213];
for rat_no=1:length(rats_veh)
    rat=rats_veh(rat_no);

    %% load the data
    cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/detections_only
    temp_var = strcat( 'load detection',num2str(rat),'.mat;');
    eval(sprintf('%s',temp_var));

    %% check if there is NaN, then remove

    % HPC belo
    temp_var = strcat( 'x1=any(isnan(detection_ratID',num2str(rat),'_HPCbelo_veh),2);');
    eval(sprintf('%s',temp_var));

    temp_var = strcat( 'detection_ratID',num2str(rat),'_HPCbelo_veh(x1,:)=[];');
    eval(sprintf('%s',temp_var));

    % HPCpyra
    temp_var = strcat( 'x2=any(isnan(detection_ratID',num2str(rat),'_HPCpyra_veh),2);');
    eval(sprintf('%s',temp_var));

    temp_var = strcat( 'detection_ratID',num2str(rat),'_HPCpyra_veh(x2,:)=[];');
    eval(sprintf('%s',temp_var));

    % PFCshal
    temp_var = strcat( 'x3=any(isnan(detection_ratID',num2str(rat),'_PFCshal_veh),2);');
    eval(sprintf('%s',temp_var));

    temp_var = strcat( 'detection_ratID',num2str(rat),'_PFCshal_veh(x3,:)=[];');
    eval(sprintf('%s',temp_var));

    % PFCdeep
    temp_var = strcat( 'x4=any(isnan(detection_ratID',num2str(rat),'_PFCdeep_veh),2);');
    eval(sprintf('%s',temp_var));

    temp_var = strcat( 'detection_ratID',num2str(rat),'_PFCdeep_veh(x4,:)=[];');
    eval(sprintf('%s',temp_var));

    %% save
    clearvars -except -regexp detection grouped rat x

    temp_var = strcat( 'save detections',num2str(rat),'.mat;');
    eval(sprintf('%s',temp_var));

    clear
    rats_veh=[3 4 9 201 203 206 210 211 213];
end


%% CBD
rats_cbd=[2 5 10 11 204 205 207 209 212 214];
for rat_no=1:length(rats_cbd)
    rat=rats_cbd(rat_no);

    %% load the data
    cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/detections_only
    temp_var = strcat( 'load detection',num2str(rat),'.mat;');
    eval(sprintf('%s',temp_var));

    %% check if there is NaN, then remove

    % HPC belo
    temp_var = strcat( 'x1=any(isnan(detection_ratID',num2str(rat),'_HPCbelo_cbd),2);');
    eval(sprintf('%s',temp_var));

    temp_var = strcat( 'detection_ratID',num2str(rat),'_HPCbelo_cbd(x1,:)=[];');
    eval(sprintf('%s',temp_var));

    % HPCpyra
    temp_var = strcat( 'x2=any(isnan(detection_ratID',num2str(rat),'_HPCpyra_cbd),2);');
    eval(sprintf('%s',temp_var));

    temp_var = strcat( 'detection_ratID',num2str(rat),'_HPCpyra_cbd(x2,:)=[];');
    eval(sprintf('%s',temp_var));

    % PFCshal
    temp_var = strcat( 'x3=any(isnan(detection_ratID',num2str(rat),'_PFCshal_cbd),2);');
    eval(sprintf('%s',temp_var));

    temp_var = strcat( 'detection_ratID',num2str(rat),'_PFCshal_cbd(x3,:)=[];');
    eval(sprintf('%s',temp_var));

    % PFCdeep
    temp_var = strcat( 'x4=any(isnan(detection_ratID',num2str(rat),'_PFCdeep_cbd),2);');
    eval(sprintf('%s',temp_var));

    temp_var = strcat( 'detection_ratID',num2str(rat),'_PFCdeep_cbd(x4,:)=[];');
    eval(sprintf('%s',temp_var));

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

    a=find(x1==1);
    b=find(x2==1);
    c=find(x3==1);
    d=find(x4==1);
    all=[a b c d];
    [all,m1,n1] = unique(all,'first');
    [c1,d1] =sort(m1);
    rmv = all(d1);
    grouped_oscil_table(rmv,:)=[];
    clearvars -except -regexp detection grouped rat

    temp_var = strcat('save detections',num2str(rat),'.mat;');
    eval(sprintf('%s',temp_var));
    
    rats=[2	3	4	5	9	10	11	201	203	204	205	206	207	209	210	211	212	213	214];
end

% cut and paste into /binned-data/detections_final




