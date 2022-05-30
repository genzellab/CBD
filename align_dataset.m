function [signals, states, bins_indexes, signals_indexes] = align_dataset(signals_dir, states_dir)
% Align Dataset to get aligned data matrix and bin indexes
%   Detailed explanation goes here

%signals_dir = "D:\Dev\MATLAB\GenzelLab\data\hpcbel";
%states_dir = "D:\Dev\MATLAB\GenzelLab\data\sleepstates";

fn = 600;

ALIGNtot = [26 19 26 10 277 206 247 54 10 11 10 3 16 9 6 6 5 1 0];
              
remove_at_start = 15 * 60 * fn;

bin_size = 45*60*fn;

files_path_contents = dir(signals_dir);
are_files = ~cell2mat({files_path_contents.isdir});
dir_files = {files_path_contents(are_files).name};
files_order = zeros(1,length(dir_files));
for i = 1:length(dir_files)
    file_i = dir_files{i};
    [~, name, ~] = fileparts(file_i);
    files_order(i) = str2double(name);
end
files_order = sort(files_order);

sigs = cell(1, length(files_order));
states = cell(1, length(files_order));
for i = 1:length(files_order)
    name = [num2str(files_order(i)) '.mat'];
    sig_path = fullfile(signals_dir, name);
    % Sleep states across the signal
    sleep_states_path = fullfile(states_dir, name);
    clusters = importdata(sleep_states_path);
    sleep_states = zeros(1, length(clusters)*fn*10);
    for j = 1:length(clusters)
        state = repmat(clusters(j),1,fn*10);
        pos = fn*10*j-5999;
        sleep_states(pos:pos+5999) = state;
    end
    sleep_states = sleep_states(remove_at_start:end);
    states{i} = sleep_states;
    L = length(sleep_states);
    align_size = ALIGNtot(i) * 60 * fn;
    alignment = NaN(align_size, 1);
    sig = importdata(sig_path);
    cutted_sig = sig(remove_at_start:end);
    cutted_sig = cutted_sig(1:L);
    aligned_sig = [alignment; cutted_sig];
    sigs{i} = aligned_sig;
end

max_len = max(cellfun(@length, sigs));
signals = NaN(length(sigs), max_len);
for i = 1:length(sigs)
    signals(i, 1:length(sigs{i})) = sigs{i};
end 

bins_num = floor(length(signals)/bin_size);

signals = signals(:, 1:bins_num*bin_size);

end

