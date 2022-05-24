clear;
%Rat directory
ratid=204;  
data_directory='E:\rat\cannabis\acutes-batch-2\204\2020-04-03_11-24-46';
%Folder where data will be saved
folder_HPC = 'E:\rat\cannabis\HPC_all_animals';
folder_PFC = 'E:\rat\cannabis\PFC_all_animals';

cd(data_directory)


% 2 - HPC pyr ch11, below pyr ch17, above pyr ch7; PFC ch37 and ch60
%CHANNELS: 1)HPC PYR, 2) HPC AB,3) HPC BELOW, 4)PFC shal, 5)PFC deep.
%channels=[50,47,54,8,20]; 
% channels=[6,3,17,37,60]; 
channels=[43,52,56,7,19]; 


cfold=dir;
cfold={cfold.name};

cfold=cfold(cellfun(@(x) ~isempty(strfind(x,'CH')),cfold));

%Design filter and sampling freqs.
acq_fhz =30000;
ds_fhz=600;

% Design of low pass filter (we low pass to 300Hz)
Wn = [ds_fhz/acq_fhz ];     % Cutoff=fs_new/2 Hz.
[b,a] = butter(3,Wn);       %Filter coefficients for LPF.





cf1=[cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(channels(1)) '.'])),cfold)) cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(channels(1)) '_'])),cfold))];

if size(cf1,2)>1
    'Split recording. Selecting 2nd chunk.'
    cf1=cf1(end);
end

%Load data and downsample
HPC1=load_open_ephys_data(cf1{1});
Data = filtfilt(b,a,HPC1);
HPC1 = downsample(Data,acq_fhz/ds_fhz);
clear Data

cd(folder_HPC)
save(['HPC_' num2str(ratid)  '_CHpyr.continuous.mat'],'HPC1','-v7.3')
clear HPC1
cd(data_directory)

% %Load data and downsample
% PFC=load_open_ephys_data(cf1{1});
% Data = filtfilt(b,a,PFC);
% PFC = downsample(Data,acq_fhz/ds_fhz);
% 
% % save('PFC_downsampled.mat','PFC','-v7.3')
%  save(['PFC_' cf1{1} '.mat'],'PFC','-v7.3')
% % save('HPC_SharpRipples_downsampled.mat')


cf2=[cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(channels(2)) '.'])),cfold)) cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(channels(2)) '_'])),cfold))];

if size(cf2,2)>1
    'Split recording. Selecting 2nd chunk.'
    cf2=cf2(end);
end

%Load data and downsample
HPC2=load_open_ephys_data(cf2{1});
Data = filtfilt(b,a,HPC2);
HPC2 = downsample(Data,acq_fhz/ds_fhz);
clear Data

cd(folder_HPC)
save(['HPC_' num2str(ratid)  '_CHab.continuous.mat'],'HPC2','-v7.3')
clear HPC2
cd(data_directory) 
%
 cf3=[cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(channels(3)) '.'])),cfold)) cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(channels(3)) '_'])),cfold))];
if size(cf3,2)>1
    'Split recording. Selecting 2nd chunk.'
    cf3=cf3(end);
end

%Load data and downsample
HPC3=load_open_ephys_data(cf3{1});
Data = filtfilt(b,a,HPC3);
HPC3 = downsample(Data,acq_fhz/ds_fhz);
clear Data

cd(folder_HPC)
save(['HPC_' num2str(ratid)  '_CHbel.continuous.mat'],'HPC3','-v7.3')
clear HPC3
cd(data_directory)
%% PFC

 cf4=[cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(channels(4)) '.'])),cfold)) cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(channels(4)) '_'])),cfold))];
if size(cf4,2)>1
    'Split recording. Selecting 2nd chunk.'
    cf4=cf4(end);
end

%Load data and downsample
PFC1=load_open_ephys_data(cf4{1});
Data = filtfilt(b,a,PFC1);
PFC1 = downsample(Data,acq_fhz/ds_fhz);
clear Data

cd(folder_PFC)
save(['PFC_' num2str(ratid)  '_CH' num2str(channels(4)) '.continuous.mat'],'PFC1','-v7.3')
clear PFC1
cd(data_directory)


 cf5=[cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(channels(5)) '.'])),cfold)) cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(channels(5)) '_'])),cfold))];
if size(cf5,2)>1
    'Split recording. Selecting 2nd chunk.'
    cf5=cf5(end);
end

%Load data and downsample
PFC2=load_open_ephys_data(cf5{1});
Data = filtfilt(b,a,PFC2);
PFC2 = downsample(Data,acq_fhz/ds_fhz);
clear Data

cd(folder_PFC)
save(['PFC_' num2str(ratid)  '_CH' num2str(channels(5)) '.continuous.mat'],'PFC2','-v7.3')
clear PFC2
cd(data_directory)