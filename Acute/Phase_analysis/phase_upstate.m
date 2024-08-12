%Load CSD data to extract table data. 
cd /media/adrian/6aa1794c-0320-4096-a7df-00ab0ba946dc
%ratID = '11_cbd'; % Adjust the ratID if needed
%ratID = '212_cbd'; % Adjust the ratID if needed
%ratID = '210_veh'; % Adjust the ratID if needed
%ratID = '213_veh'; % Adjust the ratID if needed
ratID = '10_cbd'; % Adjust the ratID if needed
% load GC_ratID11_cbd.mat
% 
% sw_grouped=GC_sw_ratID11_cbd.grouped_oscil_table;
% ripple_grouped=GC_ripple_ratID11_cbd.grouped_oscil_table;
% swr_grouped=GC_swr_ratID11_cbd.grouped_oscil_table;
% cswr_grouped=GC_complex_swr_ratID11_cbd.grouped_oscil_table;
% 
% %clearvars -except sw_grouped ripple_grouped swr_grouped cswr_grouped
% %% Load PFC data
% 
% cd /media/adrian/6aa1794c-0320-4096-a7df-00ab0ba946dc/cbd_revision/renamed
% 
% %Filter in SO range
% fn = 600;
% Wn1 = [0.5/(fn/2) 4/(fn/2)]; % 0.5-4Hz
% [b3,a3] = butter(3,Wn1); %Filter coefficients
% 
% load('FTx_ratID11_cbd.mat')

% Load the GC data file dynamically
gc_file = ['GC_ratID' ratID '.mat'];
load(gc_file);

% Dynamically construct the grouped oscil table variable names
sw_grouped = eval(['GC_sw_ratID' ratID '.grouped_oscil_table']);
ripple_grouped = eval(['GC_ripple_ratID' ratID '.grouped_oscil_table']);
swr_grouped = eval(['GC_swr_ratID' ratID '.grouped_oscil_table']);
cswr_grouped = eval(['GC_complex_swr_ratID' ratID '.grouped_oscil_table']);

% Uncomment the next line to clear variables except the loaded tables
% clearvars -except sw_grouped ripple_grouped swr_grouped cswr_grouped

% Load PFC data
cd('/media/adrian/6aa1794c-0320-4096-a7df-00ab0ba946dc/cbd_revision/renamed');

% Filter in SO range
fn = 600;
Wn1 = [0.5/(fn/2) 4/(fn/2)]; % 0.5-4Hz
[b3,a3] = butter(3, Wn1); % Filter coefficients

% Load the FTx data file dynamically
ftx_file = ['FTx_ratID' ratID '.mat'];
load(ftx_file);

%%

% Define the variables to iterate over
signal_vars = {'GC_complex_swr', 'GC_ripple', 'GC_sw', 'GC_swr'};

for var_idx = 1:length(signal_vars)
    signal_var = signal_vars{var_idx};
    
    % Dynamically construct the table and waveforms variable names
    table_var_name = [signal_var '_ratID' ratID '.grouped_oscil_table'];
    waveforms_var_name = [signal_var '_ratID' ratID '.waveforms'];
    
    % Load the data from the dynamically constructed variable names
    pfc_table = eval(table_var_name);
    pfc = eval(waveforms_var_name);
    
       % Extract the Six_Start values from both tables using switch-case
    switch signal_var
        case 'GC_ripple'
            tableCSD_start = ripple_grouped.Start;
            grouped=ripple_grouped;
        case 'GC_complex_swr'
            tableCSD_start = cswr_grouped.Start;
            grouped=cswr_grouped;
        case 'GC_sw'
            tableCSD_start = sw_grouped.Start;
            grouped=sw_grouped;
        case 'GC_swr'
            tableCSD_start = swr_grouped.Start;
            grouped=swr_grouped;
        otherwise
            error('Unknown signal variable: %s', signal_var);
    end

            
        
%     cswr_six_start = cswr_grouped.Six_Start;
    pfc_start = pfc_table.Start;

    % Find the common Six_Start values
    common_start = intersect(tableCSD_start, pfc_start);

    common_ind = ismember(tableCSD_start, common_start);

    % Filter cswr_grouped to keep only rows with common Six_Start values
    grouped_filtered = grouped(ismember(tableCSD_start, common_start), :);

    common_ind2 = ismember(pfc_table.Start, common_start);

    % Filter pfc_table to keep only rows with common Six_Start values
    pfc_filtered = pfc_table(ismember(pfc_table.Start, common_start), :);

    if sum(common_ind) ~= sum(common_ind2)
        error('something is wrong')
    end

    % Initialize the array to store indices
    IND180 = [];

    for i = 1:length(pfc)
        signal = pfc{i}(1, :);
        filtered = filtfilt(b3, a3, signal);
        pfc_signal_phase = mod(rad2deg(angle(hilbert(filtered))), 360);

        % Find indices where phase is around 180 degrees
        ind180 = find(pfc_signal_phase <= 185 & pfc_signal_phase >= 175);

        % Ensure indices are within a valid range
        ind180 = ind180(ind180 < length(pfc_signal_phase) - 1);

        % Filter to only include ascending phase
        ascending_phase_indices = [];
        for j = 1:length(ind180)
            if pfc_signal_phase(ind180(j)) < pfc_signal_phase(ind180(j) + 1)
                ascending_phase_indices = [ascending_phase_indices, ind180(j)];
            end
        end
        ascending_phase_indices = ascending_phase_indices(ascending_phase_indices < 1801);
        closest_ind = max(ascending_phase_indices);
        IND180 = [IND180, closest_ind];
    end
    
    % Optionally, save or process the results for each signal variable
    %e.g., 
    cd /media/adrian/6aa1794c-0320-4096-a7df-00ab0ba946dc/cbd_revision

    save(['IND180_' signal_var '_ratID' ratID], 'IND180');
    save(['CommonInd_' signal_var '_ratID' ratID], 'common_ind','common_ind2');


end
