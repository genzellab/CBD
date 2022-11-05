clear variables
clc
close all
addpath(genpath('F:\OSF\CorticoHippocampal-master\CorticoHippocampal-master'))
% addpath(genpath('/home/genzel/Documents/UMAP_Basic_OS/huseyin'))
addpath('F:\OSF\ADRITOOLS-master\ADRITOOLS-master')
addpath('F:\OSF\chronic')
cd('F:\OSF\chronic\UMAP - All study days')
rat_folder = getfolder;
fn = 2500;
% k = 4;
for k = 1:size(rat_folder,2)
    cd(rat_folder{k})
    addpath(strcat('F:\OSF\chronic\UMAP - All study days/',rat_folder{k},'/Long_Short_Ripple'))
    SD_folders = getfolder;
    SD_folders(contains('Long_Short_Ripple',SD_folders)) = [];
    for j = 1:size(SD_folders,2)
        phase_long_ripple = [];
        phase_short_ripple = [];
        load(strcat('Long_Short_Ripple_',SD_folders{j},'.mat'))
        cd(SD_folders{j})
%         load(strcat('Long_Short_Ripple_',SD_folders{j},'.mat'))
        trial_folders = getfolder;
        for i = 1:size(trial_folders,2)
            cd(trial_folders{i})
            current_trial = trial_folders{i};
            if ~contains(current_trial,'posttrial5')
                PFC=dir('*PFC_*.mat');
                PFC=PFC.name;
                PFC=load(PFC);
                PFC=PFC.PFC;
                PFC=PFC.*(0.195);
                
                states=dir('*states_*.mat');
                states=states.name;
                states=load(states);
                states=states.states;
            
            if length(PFC)<45*60*fn
                PFC = [PFC.' (nan(45*60*fn-length(PFC),1).')]; %Fill with NaNs.
            else
                PFC = PFC(1:45*60*fn).'; %Take only 45 min.
            end
            if length(states)<45*60
                states=[states nan(1,45*60-length(states))]; %Fill with NaNs.
            else
                states=states(1:45*60); %Take only 45 min.
            end
            ss = 3;
            vec_bin = ismember(states,ss);
           if sum(vec_bin)~=0
            v2 = ConsecutiveOnes(vec_bin);
            v_index = (find(v2~=0)*2500)-2500;
            if v_index(1)==0
               v_index(1) = 2500;
            end
            v_values = v2(v2~=0)*2500;
            v_end = [v_index+v_values];
            concatenated_NREM_pfc = [];
             for e = 1:size(v_index,2)
                 c =  PFC(v_index(e):v_end(e)-1);
                 concatenated_NREM_pfc = [concatenated_NREM_pfc,c];
             end 
             if sum(isnan(concatenated_NREM_pfc))~=0
                concatenated_NREM_pfc(isnan(concatenated_NREM_pfc)) = 0;
            end
            % Filtering the concatented NREM signal  
            Wn1 = [0.5/(fn/2) 4/(fn/2)]; % 0.5-4Hz
            [b3,a3] = butter(3,Wn1); %Filter coefficients
            concatenated_NREM_pfc = filtfilt(b3,a3,concatenated_NREM_pfc);
            
            % Computing the phase betweenn 0-360 degrees
            concatenated_NREM_phase = mod(rad2deg(angle(hilbert(concatenated_NREM_pfc))),360);
            
            % Computing phase cycle median per animal 
            phase_cycle = concatenated_NREM_phase;
            phase_cycle(phase_cycle<350) = 0;
            [~, p] = findpeaks(phase_cycle);
            d = (diff(p)/2500)*1000;
            d(d<10) = [];
            phase_cycle_duration{1,i} = d;
            phase_cycle_median(1,i) = median(d);

            if ~isnan(ripple_timestamps_long{1,i})
                if ~isempty(ripple_timestamps_long{1,i})
                    phase_long_ripple{1,i}(:,1) = concatenated_NREM_phase(int32(ripple_timestamps_long{1,i}(:,5)*2500));
                    phase_long_ripple{1,i}(:,2) = concatenated_NREM_phase(int32(ripple_timestamps_long{1,i}(:,6)*2500));
                    phase_long_ripple{1,i}(:,3) = concatenated_NREM_phase(int32(ripple_timestamps_long{1,i}(:,7)*2500));                
                else
                    phase_long_ripple{1,i} = [];
                end
            else 
                 phase_long_ripple{1,i} = NaN;
            end
            if ~isnan(ripple_timestamps_short{1,i})
                if ~isempty(ripple_timestamps_short{1,i})
                    phase_short_ripple{1,i}(:,1) = concatenated_NREM_phase(int32(ripple_timestamps_short{1,i}(:,5)*2500));
                    phase_short_ripple{1,i}(:,2) = concatenated_NREM_phase(int32(ripple_timestamps_short{1,i}(:,6)*2500));
                    phase_short_ripple{1,i}(:,3) = concatenated_NREM_phase(int32(ripple_timestamps_short{1,i}(:,7)*2500));
                else 
                    phase_short_ripple{1,i} = [];
                end
            else 
                 phase_short_ripple{1,i} = NaN;
            end
           else 
               phase_short_ripple{1,i} = NaN;
               phase_long_ripple{1,i} = NaN;
               phase_cycle_duration{1,i} = NaN;
               phase_cycle_median(1,i) = NaN;
           end
            else 
                %Post Trial 5 Case 
                PFC=dir('*PFC_*.mat');
                PFC=PFC.name;
                PFC=load(PFC);
                PFC=PFC.PFC;
                PFC=PFC.*(0.195);
                
                states=dir('*states_*.mat');
                states=states.name;
                states=load(states);
                states=states.states;
                
               if length(states)<45*60*4
                    states=[states nan(1,45*60*4-length(states))]; %Fill with NaNs.
                else
                    states=states(1:45*60*4); %Take only 45 min.
               end

                if length(PFC)<45*60*2500*4
                    PFC=[PFC.' (nan(45*60*2500*4-length(PFC),1).')]; %Fill with NaNs.
                else
                    PFC=PFC(1:45*60*2500*4).'; %Take only 45 min.
                end 
                for jj = 1:4
                    pfc_chunk = PFC((2700*2500*(jj-1))+1:2700*2500*jj); 
                    states_chunk= states(2700*(jj-1)+1:2700*jj);
                    ss = 3;
                    vec_bin = ismember(states_chunk,ss);
                    if sum(vec_bin)~=0
                        v2 = ConsecutiveOnes(vec_bin);
                        v_index = (find(v2~=0)*2500)-2500;
                        if v_index(1)==0
                            v_index(1) = 2500;
                        end
                        v_values = v2(v2~=0)*2500;
                        v_end = [v_index+v_values];
                        concatenated_NREM_pfc = [];
                         for e = 1:size(v_index,2)
                             c =  pfc_chunk(v_index(e):v_end(e));
                             concatenated_NREM_pfc = [concatenated_NREM_pfc,c];
                         end 
                        if sum(isnan(concatenated_NREM_pfc))~=0
                            concatenated_NREM_pfc(isnan(concatenated_NREM_pfc)) = 0;
                        end
                        % Filtering the concatented NREM signal  
                        Wn1 = [0.5/(fn/2) 4/(fn/2)]; % 0.5-4Hz
                        [b3,a3] = butter(3,Wn1); %Filter coefficients
                        concatenated_NREM_pfc = filtfilt(b3,a3,concatenated_NREM_pfc);
                        % Computing the phase betweenn 0-360 degrees
                        concatenated_NREM_phase = mod(rad2deg(angle(hilbert(concatenated_NREM_pfc))),360);
                        % Computing phase cycle median per animal                         
                        phase_cycle = concatenated_NREM_phase;
                        phase_cycle(phase_cycle<350) = 0;
                        [~, p] = findpeaks(phase_cycle);
                        d = (diff(p)/2500)*1000;
                        d(d<10) = [];
                        phase_cycle_duration{1,i+jj-1} = d;
                        phase_cycle_median(1,i+jj-1) = median(d);

                        if ~isnan(ripple_timestamps_long{1,i+jj-1})
                            if ~isempty(ripple_timestamps_long{1,i+jj-1})
                                phase_long_ripple{1,i+jj-1}(:,1) = concatenated_NREM_phase(int32(ripple_timestamps_long{1,i+jj-1}(:,5)*2500));
                                phase_long_ripple{1,i+jj-1}(:,2) = concatenated_NREM_phase(int32(ripple_timestamps_long{1,i+jj-1}(:,6)*2500));
                                phase_long_ripple{1,i+jj-1}(:,3) = concatenated_NREM_phase(int32(ripple_timestamps_long{1,i+jj-1}(:,7)*2500));
                            else 
                                phase_long_ripple{1,i+jj-1} = [];
                            end
                        else 
                             phase_long_ripple{1,i+jj-1} = NaN;
                        end
                        if ~isnan(ripple_timestamps_short{1,i+jj-1})
                            if ~isempty(ripple_timestamps_short{1,i+jj-1})
                                phase_short_ripple{1,i+jj-1}(:,1) = concatenated_NREM_phase(int32(ripple_timestamps_short{1,i+jj-1}(:,5)*2500));
                                phase_short_ripple{1,i+jj-1}(:,2) = concatenated_NREM_phase(int32(ripple_timestamps_short{1,i+jj-1}(:,6)*2500));
                                phase_short_ripple{1,i+jj-1}(:,3) = concatenated_NREM_phase(int32(ripple_timestamps_short{1,i+jj-1}(:,7)*2500));                           
                            else
                                phase_short_ripple{1,i+jj-1} = [];
                            end
                        else 
                             phase_short_ripple{1,i+jj-1} = NaN;
                        end
                    else 
                       phase_short_ripple{1,i+jj-1} = NaN;
                       phase_long_ripple{1,i+jj-1} = NaN; 
                       phase_cycle_duration{1,i+jj-1} = NaN;
                       phase_cycle_median(1,i+jj-1) = NaN;
                    end 
                end
            end
            clear concatenated_NREM_pfc concatenated_NREM_phase a3 b3 vec_bin v_values v_index v_end states PFC 
            cd ..
        end 
        cd ..
        save(strcat('Phase_Long&Short_Ripple_',SD_folders{j},'.mat'),'phase_long_ripple','phase_short_ripple')
        save(strcat('Phase_Cycle_Duration_median_',SD_folders{j},'.mat'),'phase_cycle_duration','phase_cycle_median')
    end
    cd ..
end 
