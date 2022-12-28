clear variables
cd('F:\OSF\chronic\UMAP - All study days')
addpath('F:\OSF\ADRITOOLS-master\ADRITOOLS-master')
addpath(' F:\OSF\chronic')
% addpath(genpath('/Volumes/Samsung_T5/Milan_DA/RGS14_Ephys_data'))
% addpath '/Volumes/Samsung_T5/Milan_DA/RGS14_Ephys_da/Data_RGS14_Downsampled_First_Session'
%% Get the study day folders
rat_folder=getfolder;
prompt = {'Enter the rat index'};
dlgtitle = 'Rat Index';
k = str2double(inputdlg(prompt,dlgtitle));
cd(rat_folder{k}) 
SD_folders  = getfolder;
%  j = 12; 
%% Loading the timestamps and initiating variables
for j = 1:length(SD_folders)
    load(strcat('Long_Short_Ripple_',SD_folders{j},'.mat'))
    load(strcat('spindles_total_data_',SD_folders{j},'.mat'))
CO_ripples_long = {};
CO_spindles_long = {};
CO_ripples_short = {};
CO_spindles_short = {};

CO_count_hpc_short = [];
CO_count_pfc_short = [];
CO_count_hpc_long = [];
CO_count_pfc_long = [];

CO_ripples_short_TS = {};
CO_spindles_short_TS = {};
CO_ripples_long_TS = {};
CO_spindles_long_TS = {};
%% Extraction of indices and counts wrt Co-occurring events
    for i = 1:length(spindles_total_data)
        if ~isnan(spindles_total_data{1,i}) 
              if spindles_total_data{1,i}~= 0 
                  if ripple_timestamps_short{1,i}~= 0 & ~isnan(ripple_timestamps_short{1,i})
             s_start = spindles_total_data{1,i}(:,6);
             s_peak = spindles_total_data{1,i}(:,7);
             s_end = spindles_total_data{1,i}(:,8);

             r_start = ripple_timestamps_short{1,i}(:,5);
             r_peak = ripple_timestamps_short{1,i}(:,6);
             r_end = ripple_timestamps_short{1,i}(:,7);

     [co_vec1, co_vec2, count_co_vec1, count_co_vec2] = cooccurrence_vec(r_start,r_end, s_start, s_end); % HPC, Cortex

              co_vec1 = unique(co_vec1);  % Removing redundant indices
              co_vec2 = unique(co_vec2);

             CO_ripples_short_TS{i} = ripple_timestamps_short {1,i}(co_vec1,5:7); % Timestamps--Format- START PEAK END 
             CO_spindles_short_TS{i} = spindles_total_data{1,i}(co_vec2,6:8);

             CO_ripples_short{i} = co_vec1; % Indices 
             CO_spindles_short{i} = co_vec2;
             
             CO_count_hpc_short(i) = count_co_vec1; % Counts
             CO_count_pfc_short(i) = count_co_vec2;
            
                  else
             CO_ripples_short_TS{i} = NaN;
             CO_spindles_short_TS{i} = NaN;

             CO_ripples_short{i} = NaN;
             CO_spindles_short{i} = NaN;

             CO_count_hpc_short(i) = 0;
             CO_count_pfc_short(i) = 0;
                  end 
                  
                 if ripple_timestamps_long{1,i}~= 0 & ~isnan(ripple_timestamps_long{1,i})
             s_start = spindles_total_data{1,i}(:,6);
             s_peak = spindles_total_data{1,i}(:,7);
             s_end = spindles_total_data{1,i}(:,8);

             r_start = ripple_timestamps_long{1,i}(:,5);
             r_peak = ripple_timestamps_long{1,i}(:,6);
             r_end = ripple_timestamps_long{1,i}(:,7);

     [co_vec1, co_vec2, count_co_vec1, count_co_vec2] = cooccurrence_vec(r_start,r_end, s_start, s_end); % HPC, Cortex

              co_vec1 = unique(co_vec1);  % Removing redundant indices
              co_vec2 = unique(co_vec2);

             CO_ripples_long_TS{i} = ripple_timestamps_long{1,i}(co_vec1,5:7); % Timestamps--Format- START PEAK END 
             CO_spindles_long_TS{i} = spindles_total_data{1,i}(co_vec2,6:8);

             CO_ripples_long{i} = co_vec1; % Indices 
             CO_spindles_long{i} = co_vec2;
             
             CO_count_hpc_long(i) = count_co_vec1; % Counts
             CO_count_pfc_long(i) = count_co_vec2;
            
                  else
             CO_ripples_long_TS{i} = NaN;
             CO_spindles_long_TS{i} = NaN;

             CO_ripples_long{i} = NaN;
             CO_spindles_long{i} = NaN;

             CO_count_hpc_long(i) = 0;
             CO_count_pfc_long(i) = 0;
                  end  

        else
         CO_ripples_short_TS{i} = NaN;
         CO_spindles_short_TS{i} = NaN;

         CO_ripples_short{i} = NaN;
         CO_spindles_short{i} = NaN;

         CO_count_hpc_short(i) = 0;
         CO_count_pfc_short(i) = 0;
         
         CO_ripples_long_TS{i} = NaN;
         CO_spindles_long_TS{i} = NaN;

         CO_ripples_long{i} = NaN;
         CO_spindles_long{i} = NaN;

         CO_count_hpc_long(i) = 0;
         CO_count_pfc_long(i) = 0;
          end
  else
     CO_ripples_short_TS{i} = NaN;
     CO_spindles_short_TS{i} = NaN;

     CO_ripples_short{i} = NaN;
     CO_spindles_short{i} = NaN;

     CO_count_hpc_short(i) = 0;
     CO_count_pfc_short(i) = 0; 
     
     CO_ripples_long_TS{i} = NaN;
     CO_spindles_long_TS{i} = NaN;

     CO_ripples_long{i} = NaN;
     CO_spindles_long{i} = NaN;

     CO_count_hpc_long(i) = 0;
     CO_count_pfc_long(i) = 0;
     end
   end
    save (strcat('CO_Long_',SD_folders{j},'.mat'),'CO_ripples_long','CO_spindles_long','CO_count_hpc_long','CO_count_pfc_long','CO_ripples_long_TS','CO_spindles_long_TS')
    save (strcat('CO_Short_',SD_folders{j},'.mat'),'CO_ripples_short','CO_spindles_short','CO_count_hpc_short','CO_count_pfc_short','CO_ripples_short_TS','CO_spindles_short_TS')
end



