%% Victor A. Camales Lama & Pelin Ozsezer

%% ||| Pyramidal and Below-Pyramidal Data Preprocessing ||| %%
clc
clear
addpath('/home/genzellab/Desktop/Pelin');
cd /home/genzellab/Desktop/Pelin

% rat IDs
rats = [2, 3, 4, 5, 9, 10, 11, ...
    201, 203, 204, 205, 206, 207, 209, 210, 211, 212, 213, 214];

% Visually found artifact thresholds per rat
thresholds=[30500 18700 115000 34400 95000 76300  80500 38700 50000 40000  ...
    59500 121000 46000 31000 58900 55700 55490 60000 70900];

bin_size = 11;

states_dirpath = uigetdir('..', 'Folder with sleep states');

% path to brain regions of all rats
regions = uigetdir('..', 'Folder with all brain regions data');

%% Preprocessing: Cleaning %%

cd /home/genzellab/Desktop/Pelin/cleaned_data
for ch=1:32
    ch

    % path to directory where cleaned data will be saved
    temp_var = strcat( "mkdir cleaned_HPC",num2str(ch));
    eval(sprintf('%s',temp_var));

    temp_var = strcat( "results_dir = 'cleaned_HPC",num2str(ch),"';");
    eval(sprintf('%s',temp_var));
    
    temp_var = strcat( "answer={'HPC",num2str(ch),"'};");
    eval(sprintf('%s',temp_var));
    selected_region = answer{1};
    
    clean_dataset_spec_HPC(regions, selected_region, results_dir, rats, thresholds);
end

%% Preprocessing: Alignment %%

results_dir = uigetdir('..','Folder to save processed data');

for ch=1:32
    ch
    temp_var = strcat( "selected_region='HPC",num2str(ch),"';");
    eval(sprintf('%s',temp_var));
    
    temp_var = strcat( "region_dirpath = '/home/genzellab/Desktop/Pelin/cleaned_data/cleaned_HPC",num2str(ch),"';");
    eval(sprintf('%s',temp_var));

    [signals, sleep_states, signals_indexes, bins_num] = align_dataset_spec(region_dirpath, states_dirpath, bin_size);
    save(fullfile(results_dir, ['processed_' selected_region '.mat']), 'signals', 'sleep_states', 'signals_indexes', 'bins_num', '-v7.3');
end

%% End
clear














