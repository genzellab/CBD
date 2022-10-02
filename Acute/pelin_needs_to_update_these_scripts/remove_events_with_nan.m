%
%% REMOVE EVENTS THAT DID NOT STARTED AFTER 3 SECS OF RECORDING
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

    %% check if there is NaN in the first 3 seconds
    % HPC belo
    temp_var = strcat( 'x1=find(isnan(detection_ratID',num2str(rat),'_HPCbelo_veh(:,1))==1);');
    eval(sprintf('%s',temp_var));

    if not(isempty(x1))
        temp_var = strcat( 'detection_ratID',num2str(rat),'_HPCbelo_veh(x1,:)=[];');
        eval(sprintf('%s',temp_var));
    end

    % HPCpyra
    temp_var = strcat( 'x2=find(isnan(detection_ratID',num2str(rat),'_HPCpyra_veh(:,1))==1);');
    eval(sprintf('%s',temp_var));

    if not(isempty(x2))
        temp_var = strcat( 'detection_ratID',num2str(rat),'_HPCpyra_veh(x2,:)=[];');
        eval(sprintf('%s',temp_var));
    end
    % PFCshal
    temp_var = strcat( 'x3=find(isnan(detection_ratID',num2str(rat),'_PFCshal_veh(:,1))==1);');
    eval(sprintf('%s',temp_var));

    if not(isempty(x3))
        temp_var = strcat( 'detection_ratID',num2str(rat),'_PFCshal_veh(x3,:)=[];');
        eval(sprintf('%s',temp_var));
    end

    % PFCdeep
    temp_var = strcat( 'x4=find(isnan(detection_ratID',num2str(rat),'_PFCdeep_veh(:,1))==1);');
    eval(sprintf('%s',temp_var));

    if not(isempty(x4))
        temp_var = strcat( 'detection_ratID',num2str(rat),'_PFCdeep_veh(x4,:)=[];');
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
rats_cbd=[2 5 10 11 204 205 207 209 212 214];
for rat_no=1:length(rats_cbd)
    rat=rats_cbd(rat_no);
    %% load the data
    cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/detections_only
    temp_var = strcat( 'load detection',num2str(rat),'.mat;');
    eval(sprintf('%s',temp_var));

    %% check if there is NaN in the first 3 seconds
    % HPC belo
    temp_var = strcat( 'x1=find(isnan(detection_ratID',num2str(rat),'_HPCbelo_cbd(:,1))==1);');
    eval(sprintf('%s',temp_var));

    if not(isempty(x1))
        temp_var = strcat( 'detection_ratID',num2str(rat),'_HPCbelo_cbd(x1,:)=[];');
        eval(sprintf('%s',temp_var));
    end

    % HPCpyra
    temp_var = strcat( 'x2=find(isnan(detection_ratID',num2str(rat),'_HPCpyra_cbd(:,1))==1);');
    eval(sprintf('%s',temp_var));

    if not(isempty(x2))
        temp_var = strcat( 'detection_ratID',num2str(rat),'_HPCpyra_cbd(x2,:)=[];');
        eval(sprintf('%s',temp_var));
    end
    % PFCshal
    temp_var = strcat( 'x3=find(isnan(detection_ratID',num2str(rat),'_PFCshal_cbd(:,1))==1);');
    eval(sprintf('%s',temp_var));

    if not(isempty(x3))
        temp_var = strcat( 'detection_ratID',num2str(rat),'_PFCshal_cbd(x3,:)=[];');
        eval(sprintf('%s',temp_var));
    end

    % PFCdeep
    temp_var = strcat( 'x4=find(isnan(detection_ratID',num2str(rat),'_PFCdeep_cbd(:,1))==1);');
    eval(sprintf('%s',temp_var));

    if not(isempty(x4))
        temp_var = strcat( 'detection_ratID',num2str(rat),'_PFCdeep_cbd(x4,:)=[];');
        eval(sprintf('%s',temp_var));
    end

    %% save
    clearvars -except -regexp detection grouped rat x

    temp_var = strcat( 'save detections',num2str(rat),'.mat;');
    eval(sprintf('%s',temp_var));

    clear
    rats_cbd=[2 5 10 11 204 205 207 209 212 214];
end
% cut and paste into /binned-data/detections_final


%% remove nans in groupep_oscil_table %%

% rat 2
clear
load('detections2.mat');
grouped_oscil_table(1,:)=[];
clear rat_no rats_veh rats_cbd temp_var x1 x2 x3 x4 ans
save detections2.mat
% rat 3
clear
load('detections3.mat');
clear rat_no rats_veh rats_cbd temp_var x1 x2 x3 x4 ans
save detections3.mat
% rat 4
clear
load('detections4.mat');
clear rat_no rats_veh rats_cbd temp_var x1 x2 x3 x4 ans
save detections4.mat
% rat 5
clear
load('detections5.mat');
clear rat_no rats_veh rats_cbd temp_var x1 x2 x3 x4 ans
save detections5.mat
% rat 9
clear
load('detections9.mat');
clear rat_no rats_veh rats_cbd temp_var x1 x2 x3 x4 ans
save detections9.mat
% rat 10
clear
load('detections10.mat');
grouped_oscil_table(1:2,:)=[];
clear rat_no rats_veh rats_cbd temp_var x1 x2 x3 x4 ans
save detections10.mat
% rat 11
clear
load('detections11.mat');
clear rat_no rats_veh rats_cbd temp_var x1 x2 x3 x4 ans
save detections11.mat
% rat 201
clear
load('detections201.mat');
clear rat_no rats_veh rats_cbd temp_var x1 x2 x3 x4 ans
save detections201.mat
% rat 203
clear
load('detections203.mat');
clear rat_no rats_veh rats_cbd temp_var x1 x2 x3 x4 ans
save detections203.mat
% rat 204
clear
load('detections204.mat');
clear rat_no rats_veh rats_cbd temp_var x1 x2 x3 x4 ans
save detections204.mat
% rat 205
clear
load('detections205.mat');
clear rat_no rats_veh rats_cbd temp_var x1 x2 x3 x4 ans
save detections205.mat
% rat 206
clear
load('detections206.mat');
clear rat_no rats_veh rats_cbd temp_var x1 x2 x3 x4 ans
save detections206.mat
% rat 207
clear
load('detections207.mat');
clear rat_no rats_veh rats_cbd temp_var x1 x2 x3 x4 ans
save detections207.mat
% rat 209
clear
load('detections209.mat');
clear rat_no rats_veh rats_cbd temp_var x1 x2 x3 x4 ans
save detections209.mat
% rat 210
clear
load('detections210.mat');
clear rat_no rats_veh rats_cbd temp_var x1 x2 x3 x4 ans
save detections210.mat
% rat 211
clear
load('detections211.mat');
clear rat_no rats_veh rats_cbd temp_var x1 x2 x3 x4 ans
save detections211.mat
% rat 212
clear
load('detections212.mat');
clear rat_no rats_veh rats_cbd temp_var x1 x2 x3 x4 ans
save detections212.mat
% rat 213
clear
load('detections213.mat');
clear rat_no rats_veh rats_cbd temp_var x1 x2 x3 x4 ans
save detections213.mat
% rat 214
clear
load('detections214.mat');
clear rat_no rats_veh rats_cbd temp_var x1 x2 x3 x4 ans
save detections214.mat





