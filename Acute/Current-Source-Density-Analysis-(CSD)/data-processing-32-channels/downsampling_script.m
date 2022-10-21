%% Adrian Aleman Zapata & Pelin Ozsezer

%% Downsample the data from 30000 Hz to 600 Hz

clc
clear
format compact
addpath('/home/genzellab/Desktop/Pelin'); % to add functions used

%% RatIDs of Veh: 3, 4, 9, 201, 203, 206, 210, 211, 213
%% RatIDs of CBD: 2, 5, 10, 11, 204, 205, 207, 209, 212, 214

%% Set directories for each rat

%% VEHICLE
% Rat3 - RatID3
data_directory_ratID3='/media/genzellab/MD04_RAT_MECHOULAM/rat/cannabis/acutes/rat3/2019-05-01_11-53-38';
% Rat4 - RatID4
data_directory_ratID4='/media/genzellab/MD04_RAT_MECHOULAM/rat/cannabis/acutes/rat4/2019-05-02_11-55-59';
% Rat9 - RatID9
data_directory_ratID9='/media/genzellab/MD04_RAT_MECHOULAM/rat/cannabis/acutes/rat9/2019-05-20_16-19-45';
% Rat17 - RatID201
data_directory_ratID201='/media/genzellab/MD04_RAT_MECHOULAM/rat/cannabis/acutes-batch-2/201/2020-04-01_12-26-15';
% Rat19 - RatID203
data_directory_ratID203='/media/genzellab/MD04_RAT_MECHOULAM/rat/cannabis/acutes-batch-2/203/2020-04-02_12-21-50';
% Rat22 - RatID206
data_directory_ratID206='/media/genzellab/MD04_RAT_MECHOULAM/rat/cannabis/acutes-batch-2/206/2020-04-08_11-22-44';
% Rat26 - RatID210
data_directory_ratID210='/media/genzellab/MD04_RAT_MECHOULAM/rat/cannabis/acutes-batch-2/210/2020-04-17_11-25-39';
% Rat27 - RatID211
data_directory_ratID211='/media/genzellab/MD04_RAT_MECHOULAM/rat/cannabis/acutes-batch-2/211/2020-04-21_11-25-38';
% Rat29 - RatID213
data_directory_ratID213='/media/genzellab/MD04_RAT_MECHOULAM/rat/cannabis/acutes-batch-2/213/2020-04-23_11-20-57';

%% CBD
% Rat2 - RatID2
data_directory_ratID2='/media/genzellab/MD04_RAT_MECHOULAM/rat/cannabis/acutes/rat2/2019-04-25_12-03-17';
% Rat5 - RatID5
data_directory_ratID5='/media/genzellab/MD04_RAT_MECHOULAM/rat/cannabis/acutes/rat5/2019-05-03_11-53-36';
% Rat10 - RatID10
data_directory_ratID10='/media/genzellab/MD04_RAT_MECHOULAM/rat/cannabis/acutes/rat10/2019-05-21_15-20-51';
% Rat11 - RatID11
data_directory_ratID11='/media/genzellab/MD04_RAT_MECHOULAM/rat/cannabis/acutes/rat11/2019-05-23_15-45-04';
% Rat20 - RatID204
data_directory_ratID204='/media/genzellab/MD04_RAT_MECHOULAM/rat/cannabis/acutes-batch-2/204/2020-04-03_11-24-46';
% Rat21 - RatID205
data_directory_ratID205='/media/genzellab/MD04_RAT_MECHOULAM/rat/cannabis/acutes-batch-2/205/2020-04-07_11-29-26';
% Rat23 - RatID207
data_directory_ratID207='/media/genzellab/MD04_RAT_MECHOULAM/rat/cannabis/acutes-batch-2/207/2020-04-09_11-35-16';
% Rat25 - RatID209
data_directory_ratID209='/media/genzellab/MD04_RAT_MECHOULAM/rat/cannabis/acutes-batch-2/209/2020-04-16_11-29-09';
% Rat28 - RatID212
data_directory_ratID212='/media/genzellab/MD04_RAT_MECHOULAM/rat/cannabis/acutes-batch-2/212/2020-04-22_11-24-53';
% Rat30 - RatID214
data_directory_ratID214='/media/genzellab/MD04_RAT_MECHOULAM/rat/cannabis/acutes-batch-2/214/2020-04-24_11-24-38';


%% which channels belong to HPC
rats_1to32=[2 3 5];
rats_33to64=[9 10 11 201 203 204 205 206 207 209 210 211 212 213 214];

rats=[206 2 3 4 5 9 10 11 201 203 204 205 207 209 210 211 212 213 214];
for rat = rats
    % Rat directory
    ratid=rat;  
    sprintf(['ratID : ' num2str(rat)])

    temp_var = strcat( 'data_directory=data_directory_ratID',num2str(rat),';');
    eval(sprintf('%s',temp_var));

    % Folder where data will be saved
    cd /home/genzellab/Desktop/Pelin/HPC_32channels

    temp_var = strcat( 'mkdir ratID',num2str(rat));
    eval(sprintf('%s',temp_var));

    temp_var = strcat( 'cd ratID',num2str(rat),'');
    eval(sprintf('%s',temp_var));

    folder_HPC = pwd; % current folder 

    if ismember(rat,rats_1to32) == 1
        cd(data_directory) % rat's folder
        
        channels=[1:32]; 
        
        cfold=dir;
        cfold={cfold.name};
        
        cfold=cfold(cellfun(@(x) ~isempty(strfind(x,'CH')),cfold));
        
        % Design filter and sampling freqs.
        acq_fhz =30000;
        ds_fhz=600;
        
        % Design of low pass filter (we low pass to 300Hz)
        Wn = [ds_fhz/acq_fhz];     % Cutoff=fs_new/2 Hz.
        [b,a] = butter(3,Wn);      % Filter coefficients for LFP
        
        %% All channels
        for ch=channels(1:32)
            sprintf(['ratID : ' num2str(rat),' - channel : ' num2str(ch)])

            cf=[cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(channels(ch)) '.'])),cfold)) ...
                cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(channels(ch)) '_'])),cfold))]; 

            % Load data and downsample
            temp_var = strcat( 'HPC',num2str(ch),'=load_open_ephys_data(cf{1});'); % selecting first chunk 
            eval(sprintf('%s',temp_var));
        
            temp_var = strcat( 'Data = filtfilt(b,a,HPC',num2str(ch),');');
            eval(sprintf('%s',temp_var));
        
            temp_var = strcat( 'HPC',num2str(ch),'= downsample(Data,acq_fhz/ds_fhz);');
            eval(sprintf('%s',temp_var));
        
            clear Data
        
            cd(folder_HPC)
            temp_var = strcat( 'save ratID',num2str(rat),'_HPC_CH',num2str(ch),'.continuous.mat HPC',num2str(ch),' -v7.3');
            eval(sprintf('%s',temp_var));
        
            cd(data_directory)
            temp_var = strcat( 'clear HPC',num2str(ch));
            eval(sprintf('%s',temp_var));
        end

    elseif ismember(rat,rats_33to64) == 1
        cd(data_directory) % rat's folder
        
        channels=nan(1,64);
        channels(33:64)=[33:64]; 
        
        cfold=dir;
        cfold={cfold.name};
        
        cfold=cfold(cellfun(@(x) ~isempty(strfind(x,'CH')),cfold));
        
        % Design filter and sampling freqs.
        acq_fhz =30000;
        ds_fhz=600;
        
        % Design of low pass filter (we low pass to 300Hz)
        Wn = [ds_fhz/acq_fhz];     % Cutoff=fs_new/2 Hz.
        [b,a] = butter(3,Wn);      % Filter coefficients for LFP
        
        %% All channels
        for ch=channels(33:64)
            sprintf(['ratID : ' num2str(rat),' - channel : ' num2str(ch)])

            cf=[cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(channels(ch)) '.'])),cfold)) ...
                cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(channels(ch)) '_'])),cfold))];
        
            % Load data and downsample
            temp_var = strcat( 'HPC',num2str(ch),'=load_open_ephys_data(cf{1});'); % selecting first chunk
            eval(sprintf('%s',temp_var));
        
            temp_var = strcat( 'Data = filtfilt(b,a,HPC',num2str(ch),');');
            eval(sprintf('%s',temp_var));
        
            temp_var = strcat( 'HPC',num2str(ch),'= downsample(Data,acq_fhz/ds_fhz);');
            eval(sprintf('%s',temp_var));
        
            clear Data
        
            cd(folder_HPC)
            temp_var = strcat( 'save ratID',num2str(rat),'_HPC_CH',num2str(ch),'.continuous.mat HPC',num2str(ch),' -v7.3');
            eval(sprintf('%s',temp_var));
        
            cd(data_directory)
            temp_var = strcat( 'clear HPC',num2str(ch));
            eval(sprintf('%s',temp_var));
          
        end
    end
end


%% RatID4 (Manual)
% This rat is a bit problematic so needs to be done separately
rat=4;
ratid=rat;  
sprintf(['ratID : ' num2str(rat)])

temp_var = strcat( 'data_directory=data_directory_ratID',num2str(rat),';');
eval(sprintf('%s',temp_var));

% Folder where data will be saved
cd /home/genzellab/Desktop/Pelin/HPC_32channels

temp_var = strcat( 'mkdir ratID',num2str(rat));
eval(sprintf('%s',temp_var));

temp_var = strcat( 'cd ratID',num2str(rat),'');
eval(sprintf('%s',temp_var));

folder_HPC = pwd; % current folder 
cd(data_directory) % rat's folder
             
channels=[1:32]; 

cfold=dir;
cfold={cfold.name};

cfold=cfold(cellfun(@(x) ~isempty(strfind(x,'CH')),cfold));

% Design filter and sampling freqs.
acq_fhz =30000;
ds_fhz=600;

% Design of low pass filter (we low pass to 300Hz)
Wn = [ds_fhz/acq_fhz];     % Cutoff=fs_new/2 Hz.
[b,a] = butter(3,Wn);      % Filter coefficients for LFP

for ch=channels(1:32)
        sprintf(['ratID : ' num2str(rat),' - channel : ' num2str(ch)])
        
        if ch==6
        cf=[cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(channels(ch)) '.'])),cfold)) ...
            cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(channels(ch)) '_'])),cfold))...
            cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(channels(ch)) '_'])),cfold))];
        else
            cf=[cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(channels(ch)) '.'])),cfold)) ...
            cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(channels(ch)) '_'])),cfold))];
        end

        'Rat 4. Split recording.'
        if ~contains(cf(end),"mat")
            if ch==6 % channel 6 has 3 recordings. The 3rd channel is to be downsampled.
                % Load data and downsample
                temp_var = strcat( 'HPC',num2str(ch),'=load_open_ephys_data(cf{3});'); 
                eval(sprintf('%s',temp_var));
            
                temp_var = strcat( 'Data = filtfilt(b,a,HPC',num2str(ch),');');
                eval(sprintf('%s',temp_var));
            
                temp_var = strcat( 'HPC',num2str(ch),'= downsample(Data,acq_fhz/ds_fhz);');
                eval(sprintf('%s',temp_var));
            
                clear Data
            
                cd(folder_HPC)
                temp_var = strcat( 'save ratID',num2str(rat),'_HPC_CH',num2str(ch),'.continuous.mat HPC',num2str(ch),' -v7.3');
                eval(sprintf('%s',temp_var));
            
                cd(data_directory)
                temp_var = strcat( 'clear HPC',num2str(ch));
                eval(sprintf('%s',temp_var));

            else
                % Load data and downsample
                temp_var = strcat( 'HPC',num2str(ch),'=load_open_ephys_data(cf{2});'); 
                eval(sprintf('%s',temp_var));
            
                temp_var = strcat( 'Data = filtfilt(b,a,HPC',num2str(ch),');');
                eval(sprintf('%s',temp_var));
            
                temp_var = strcat( 'HPC',num2str(ch),'= downsample(Data,acq_fhz/ds_fhz);');
                eval(sprintf('%s',temp_var));
            
                clear Data
            
                cd(folder_HPC)
                temp_var = strcat( 'save ratID',num2str(rat),'_HPC_CH',num2str(ch),'.continuous.mat HPC',num2str(ch),' -v7.3');
                eval(sprintf('%s',temp_var));
            
                cd(data_directory)
                temp_var = strcat( 'clear HPC',num2str(ch));
                eval(sprintf('%s',temp_var));
            end
        end
end










