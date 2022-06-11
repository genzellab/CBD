function [] = clean_dataset(regions, selected_region, results_dir, b, a, rats, thresholds)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    if ~exist('rats','var')
        rats = [2, 3, 4, 5, 9, 10, 11, 201, 203, 204, 205, 206, 207, 209, 210, 211, 212, 213, 214];
    end
    if ~exist('thresholds','var')
        thresholds = [3450, 4000, 5000, 4500, 4500, 4500, 4500, 5000, 5500, 5000, 5500, 5000, 6000, 4500, 4500, 4500, 4500, 4500, 4500];
    end

    % Get all subfolders of regions directory
    regions_dir = dir(regions);
    regions_subdirs = regions_dir([regions_dir(:).isdir]);
    regions_subdirs = regions_subdirs(~ismember({regions_subdirs(:).name},{'.','..'}));
    available_regions = {regions_subdirs.name};
    hpc_regions = contains(available_regions, 'hpc');
    pfc_regions = contains(available_regions, 'pfc');

    num_of_regions = length(available_regions);
    num_of_hpc = sum(hpc_regions == 1);
    num_of_pfc = sum(pfc_regions == 1);
    num_of_rats = length(rats);

    rat_regions = cell(1,num_of_regions);
    for i = 1:num_of_rats

        for j = 1:num_of_regions
            region_file = fullfile(regions, available_regions{j}, strcat(num2str(rats(i)), '.mat'));
            rat_regions{j} = importdata(region_file);
        end
        L = min(cellfun(@length, rat_regions));
        for j = 1:num_of_regions
            rat_region = rat_regions{j};
            rat_regions{j} = rat_region(1:L);
        end
        rat_regions_abs = cellfun(@abs, rat_regions, 'UniformOutput', false);
        TOT = sum(cat(2, rat_regions_abs{:}), 2);

        % Artifacts
        threshold = thresholds(i); %Visual threshold 
        outliers = false(L,1);
        index = 1;
        while index<L
            if TOT(index) >= threshold
                % When we detect an artifact, remove 300 datapoints prior 
                % (build up of artifact) and 2000 datapoints after (3.5 sec)
                if index-300 < 1; lo_lim = 1; else; lo_lim = index-300; end
                if index+1999 > L; hi_lim = L; else; hi_lim = index+1999; end
                sz = length(lo_lim:hi_lim);
                outliers(lo_lim:hi_lim) = ones(sz,1); 
                index = index+2000;
            else
                index = index +1;
            end
        end

        j = ismember(available_regions, selected_region);
        rat_region = rat_regions{j};
        rat_region = filtfilt(b, a, rat_region);

        if contains(selected_region, 'hpc')
            rat_region(outliers) = mean(cellfun(@median, rat_regions(hpc_regions)));
        elseif contains(selected_region, 'pfc')
            rat_region(outliers) = mean(cellfun(@median, rat_regions(pfc_regions)));
        else
            rat_region(outliers) = 0;
        end

        results_path = fullfile(results_dir, strcat(num2str(rats(i)), '.mat'));
        if ~exist(results_dir, 'dir')
            mkdir(results_dir);
        end
        save(results_path, 'rat_region')
    end

end

