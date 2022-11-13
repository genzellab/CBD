clear variables
clc
close all
addpath(genpath('F:\OSF\CorticoHippocampal-master\CorticoHippocampal-master'))
addpath('F:\OSF\ADRITOOLS-master\ADRITOOLS-master')
% addpath(genpath('/Volumes/Samsung_T5/Milan_DA/OS_ephys_da/CorticoHippocampal'))
% addpath ('/Volumes/Samsung_T5/Milan_DA/OS_ephys_da/ADRITOOLS')
addpath('F:\OSF\chronic')
cd('F:\OSF\chronic\UMAP - All study days') % Animal folders
% cd('/Volumes/Samsung_T5/CBD/Chronics')
rat_folder = getfolder;
% prompt = {'Enter the rat index'};
% dlgtitle = 'Rat Index';
% k = str2double(inputdlg(prompt,dlgtitle));
% for k = 1:length(rat_folder) % Iterates across animals
for k = 4
cd(rat_folder{k}) 
addpath(strcat('F:\OSF\chronic\UMAP - All study days/',rat_folder{k},'/Long_Short_Ripple'))
% addpath(strcat('/Volumes/Samsung_T5/CBD/Chronics/',rat_folder{k},'/Long_Short'))
SD_folders = getfolder; % List of SD folders
SD_folders(1) = [];
for j = 1:length(SD_folders) % Iterates across SDs
        rates_long = [];
        rates_short = [];
        load(strcat('Long_Short_Ripple_',SD_folders{j},'.mat'))
        cd(SD_folders{j}) 
        trial_folders = getfolder;
    for i  = 1:size(trial_folders,2) % Iterates across trials  
        cd(trial_folders{i})
        current_trial = trial_folders{i};
        if ~contains(current_trial,'posttrial5')
                states = dir('*states_*.mat');
                states = states.name;
                states = load(states);
                states = states.states;
                
            if length(states)<45*60
                states = [states nan(1,45*60-length(states))]; %Fill with NaNs.
            else
                states = states(1:45*60); %Take only 45 min.
            end
            ss = 3;
            vec_bin = ismember(states,ss);
            id_start = [];
            id_end = [];
           if sum(vec_bin)~=0
            v2 = ConsecutiveOnes(vec_bin);
            v_index = find(v2~=0); % start of the NREM bouts
            v_values = v2(v2~=0); % durations
            t_limit = 5;
            t_sec = t_limit*60;
            v_index(v_values<t_sec) = [];
            v_values(v_values<t_sec) = [];
            v_indexend = v_index+v_values-1; % end of the NREM bouts
            p = 0.1;
            p_sec = floor(v_values*p); 
            id_start(:,1) = v_index;
            id_start(:,2) = v_index+p_sec;
            id_end(:,1) = v_indexend-p_sec;
            id_end(:,2) = v_indexend;
            p_min = p_sec./60; % in minutes not seconds
           if ~isempty(id_start)
            for s = 1:size(id_start,1)
            if ~isnan(ripple_timestamps_long{1,i})
                if ~isempty(ripple_timestamps_long{1,i})
                    start_long = ripple_timestamps_long{1,i}(:,1);
                    end_long = ripple_timestamps_long{1,i}(:,3);
                    f_s = find(start_long>=id_start(s,1) & start_long<=id_start(s,2)); 
                    f_e = find(end_long>=id_start(s,1)& end_long<=id_start(s,2));
                    long_start = unique([f_s;f_e]); % Start of the bout
                    f_s = find(start_long>=id_end(s,1) & start_long<=id_end(s,2)); 
                    f_e = find(end_long>=id_end(s,1)& end_long<=id_end(s,2));
                    long_end = unique([f_s;f_e]); % End of the bout
                    rates_long{1,i}(s,1) = size(long_start,1)/p_min(1,s);
                    rates_long{1,i}(s,2) = size(long_end,1)/p_min(1,s);
                else
                    rates_long{1,i} = [];
                end
            else 
                 rates_long{1,i} = NaN;
            end
            if ~isnan(ripple_timestamps_short{1,i})
                if ~isempty(ripple_timestamps_short{1,i})
                    start_short = ripple_timestamps_short{1,i}(:,1);
                    end_short = ripple_timestamps_short{1,i}(:,3);
                    f_s = find(start_short>=id_start(s,1) & start_short<=id_start(s,2)); 
                    f_e = find(end_short>=id_start(s,1)& end_short<=id_start(s,2));
                    short_start = unique([f_s ; f_e]); % Start of the bout
                    f_s = find(start_short>=id_end(s,1) & start_short<=id_end(s,2)); 
                    f_e = find(end_short>=id_end(s,1)& end_short<=id_end(s,2));
                    short_end = unique([f_s;f_e]); % End of the bout
                    rates_short{1,i}(s,1) = size(short_start,1)/p_min(1,s);
                    rates_short{1,i}(s,2) = size(short_end,1)/p_min(1,s);
                else 
                    rates_short{1,i} = [];
                end
            else 
                 rates_short{1,i} = NaN;
            end
            end
           else 
               rates_long{1,i} = NaN;
               rates_short{1,i} = NaN;
           end
           else
               rates_long{1,i} = NaN;
               rates_short{1,i} = NaN;
           end
            else 
                %Post Trial 5 Case 
                
                states=dir('*states_*.mat');
                states=states.name;
                states=load(states);
                states=states.states;
                
               if length(states)<45*60*4
                    states=[states nan(1,45*60*4-length(states))]; %Fill with NaNs.
                else
                    states=states(1:45*60*4); %Take only 45 min.
               end
            for jj = 1:4
                states_chunk= states(2700*(jj-1)+1:2700*jj);
                ss = 3;
                vec_bin = ismember(states_chunk,ss);
                id_start = [];
                id_end = [];
                if sum(vec_bin)~=0
                    v2 = ConsecutiveOnes(vec_bin);
                    v_index = find(v2~=0); % start of the NREM bouts
                    v_values = v2(v2~=0); % durations
                    t_limit = 5;
                    t_sec = t_limit*60;
                    v_index(v_values<t_sec) = [];
                    v_values(v_values<t_sec) = [];
                    v_indexend = v_index+v_values-1; % end of the NREM bouts
                    p = 0.1;
                    p_sec = floor(v_values*p); 
                    id_start(:,1) = v_index;
                    id_start(:,2) = v_index+p_sec;
                    id_end(:,1) = v_indexend-p_sec;
                    id_end(:,2) = v_indexend;
                    p_min = p_sec./60; % in minutes not seconds
                  if ~isempty(id_start)
                    for s = 1: size(id_start,1)
                    if ~isnan(ripple_timestamps_long{1,i+jj-1})
                        if ~isempty(ripple_timestamps_long{1,i+jj-1})
                            start_long = ripple_timestamps_long{1,i+jj-1}(:,1);
                            end_long = ripple_timestamps_long{1,i+jj-1}(:,3);
                            f_s = find(start_long>=id_start(s,1) & start_long<=id_start(s,2)); 
                            f_e = find(end_long>=id_start(s,1) & end_long<=id_start(s,2));
                            long_start = unique([f_s;f_e]); % Start of the bout
                            f_s = find(start_long>=id_end(s,1) & start_long<=id_end(s,2)); 
                            f_e = find(end_long>=id_end(s,1) & end_long<=id_end(s,2));
                            long_end = unique([f_s;f_e]); % End of the bout
                            rates_long{1,i+jj-1}(s,1) = size(long_start,1)/p_min(1,s);
                            rates_long{1,i+jj-1}(s,2) = size(long_end,1)/p_min(1,s);
                        else
                            rates_long{1,i+jj-1} = [];
                        end
                    else 
                         rates_long{1,i+jj-1} = NaN;
                    end
                    if ~isnan(ripple_timestamps_short{1,i+jj-1})
                        if ~isempty(ripple_timestamps_short{1,i+jj-1})
                            start_short = ripple_timestamps_short{1,i+jj-1}(:,1);
                            end_short = ripple_timestamps_short{1,i+jj-1}(:,3);
                            f_s = find(start_short>=id_start(s,1) & start_short<=id_start(s,2)); 
                            f_e = find(end_short>=id_start(s,1) & end_short<=id_start(s,2));
                            short_start = unique([f_s;f_e]); % Start of the bout
                            f_s = find(start_short>=id_end(s,1) & start_short<=id_end(s,2)); 
                            f_e = find(end_short>=id_end(s,1) & end_short<=id_end(s,2));
                            short_end = unique([f_s;f_e]); % End of the bout
                            rates_short{1,i+jj-1}(s,1) = size(short_start,1)/p_min(1,s);
                            rates_short{1,i+jj-1}(s,2) = size(short_end,1)/p_min(1,s);
                        else 
                            rates_short{1,i+jj-1} = [];
                        end
                    else 
                         rates_short{1,i+jj-1} = NaN;
                    end
                    end
                  else
                     rates_long{1,i+jj-1} = NaN;
                     rates_short{1,i+jj-1} = NaN;
                  end
                else
                   rates_long{1,i+jj-1} = NaN;
                   rates_short{1,i+jj-1} = NaN;
                end 
            end
        end
    cd ..    
    end
    cd ..
    save(strcat('Rates_TuksAnalysis_',SD_folders{j},'.mat'),'rates_long','rates_short')
end
cd .. 
end