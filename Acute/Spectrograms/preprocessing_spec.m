%% ||| Pyramidal and Below-Pyramidal Data Preprocessing ||| %%
clear
clc

% rat ids
rats = [2, 3, 4, 5, 9, 10, 11, 201, 203, 204, 205, 206, 207, 209, 210, 211, 212, 213, 214];

% Visually found artifact thresholds per rat
thresholds = [3450, 4000, 5000, 4500, 4500, 4500, 4500, 5000, 5500, 5000, 5500, 5000, 6000, 4500, 4500, 4500, 4500, 4500, 4500];

bin_size = 11;

states_dirpath = uigetdir('..', 'Folder with sleep states');

%% Ripples - Preprocessing: Cleaning %%

% path to directory where cleaned data will be saved
% for cleaned data, manually create a folder called 'cleaned_X' where X is the brain region. !!!!!!!!!!!
results_dir = uigetdir('..', 'Folder to save cleaned data');
% path to brain regions of all rats
regions = uigetdir('..', 'Folder with all brain regions data');
% hippocampal pyramidal layer 
% for ripple detection
answer = inputdlg('Brain region','Select brain region to process', [1 55], {'pfc_shal'});
selected_region = answer{1};


% Cleaning of hippocampal pyramidal layer signals of all rats
clean_dataset_spec(regions, selected_region, results_dir, rats, thresholds);

%% Ripples - Preprocessing: Alignment %%
region_dirpath = results_dir;

[signals, sleep_states, signals_indexes, bins_num] = align_dataset_spec(region_dirpath, states_dirpath, bin_size);

results_dir = uigetdir('..','Folder to save processed data');
save(fullfile(results_dir, ['processed_' selected_region '.mat']), 'signals', 'sleep_states', 'signals_indexes', 'bins_num', '-v7.3');

%% End
clear












