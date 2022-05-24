addpath('C:\Users\students\Documents\Tugdual\GitHub\analysis-tools');
%Folder where data will be saved
folder_HPC = 'E:\rat\cannabis\HPC_all_animals';
folder_PFC = 'E:\rat\cannabis\PFC_all_animals';


% Acquisition parameters
acq_fhz = 30e3; %acquisition freq
ds_fhz = 600;   %downsampling freq

% Design of low pass filter (we low pass to 300Hz)
Wn = [ds_fhz/acq_fhz ]; % Cutoff=fs_new/2 Hz. 
[b,a] = butter(3,Wn); %Filter coefficients for LPF.

%PFC superficial
[Data, ~, ~] = load_open_ephys_data('102_CH7.continuous');
Data = filtfilt(b,a,Data);
PFC1 = downsample(Data,acq_fhz/ds_fhz);

%PFC deep
[Data, ~, ~] = load_open_ephys_data('102_CH19.continuous');
Data = filtfilt(b,a,Data);
PFC2 = downsample(Data,acq_fhz/ds_fhz);

save([folder_PFC 'output_data_pfc_rat' num2str(P)],'output_data_pfc')
save([folder_PFC 'output_data_pfc_rat' num2str(P)],'output_data_pfc')


clear PFC1 PFC2 Data
%%
%HPC pyramidal
[Data, ~, ~] = load_open_ephys_data('102_CH7.continuous');
Data = filtfilt(b,a,Data);
HPC1 = downsample(Data,acq_fhz/ds_fhz);

%HPC above
[Data, ~, ~] = load_open_ephys_data('102_CH19.continuous');
Data = filtfilt(b,a,Data);
HPC2 = downsample(Data,acq_fhz/ds_fhz);

%HPC below
[Data, ~, ~] = load_open_ephys_data('102_CH19.continuous');
Data = filtfilt(b,a,Data);
HPC3 = downsample(Data,acq_fhz/ds_fhz);
