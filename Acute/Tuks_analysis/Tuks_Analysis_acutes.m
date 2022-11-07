clearvars
addpath('F:\OSF\ADRITOOLS-master\ADRITOOLS-master')
load ('processed_pfc_shal.mat')
cd('F:\OSF\swr_analysys\detections')

for Ratindex = 1:size(signals,1)

ratIDs = [2 3 4 5 9 10 11 201 203 204 205 206 207 209 210 211 212 213 214]; %Rat IDs
ratno = num2str(ratIDs(Ratindex));
load(strcat(ratno,'.mat'))
timestamps_table = grouped_oscil_table; %%

ripple_sleepstate = timestamps_table{:,8};
ripple_sleepstate_binary = ripple_sleepstate==2;

event_form = timestamps_table{:,2};
event_form_len = cellfun('length',event_form);
event_form(event_form_len==2) = {4}; event_form(event_form_len>=3) = {6};
event_form = cell2mat(event_form);
event_form_nrem = event_form(ripple_sleepstate_binary);

% peak = timestamps_table{:,4};
% peaks_nrem = peak(ripple_sleepstate_binary);
% peaks_f1 = peaks_nrem(event_form_nrem==1);
% peaks_f2 = peaks_nrem(event_form_nrem==2);
% peaks_f4 = peaks_nrem(event_form_nrem==4);
% peaks_f6 = peaks_nrem(event_form_nrem==6);

start = timestamps_table{:,3};
start_nrem = start(ripple_sleepstate_binary);
start_f1 = start_nrem(event_form_nrem==1);
start_f2 = start_nrem(event_form_nrem==2);
start_f4 = start_nrem(event_form_nrem==4);
start_f6 = start_nrem(event_form_nrem==6);

ends = timestamps_table{:,5};
ends_nrem = ends(ripple_sleepstate_binary);
ends_f1 = ends_nrem(event_form_nrem==1);
ends_f2 = ends_nrem(event_form_nrem==2);
ends_f4 = ends_nrem(event_form_nrem==4);
ends_f6 = ends_nrem(event_form_nrem==6);

t_limit = 15;
t_sample = t_limit*60*600;
p = 0.1;
states = sleep_states(Ratindex,:); % Included NaN 
states_binary = states==2;
v2 = ConsecutiveOnes(states_binary);
v_index = find(v2~=0); %start of the NREM bouts
v_values = v2(v2~=0); %durations
v_index(v_values<t_sample) = [];
v_values(v_values<t_sample) = [];
v_indexend = v_index+v_values-1; %end of the NREM bouts
p_sample = floor(v_values*p); %
id_start(:,1) = v_index;
id_start(:,2) = v_index+p_sample;
id_end(:,1) = v_indexend-p_sample;
id_end(:,2) = v_indexend;
p_sec = p_sample./600*60; % in minutes not seconds
    for i = 1:size(id_start,1)
        % Sharp wave
        f_s = find(start_f1>=id_start(i,1) & start_f1<=id_start(i,2)); 
        f_e = find(ends_f1>=id_start(i,1)& ends_f1<=id_start(i,2));
        f1_start = unique([f_s,f_e]); % Start of the bout
        f_s = find(start_f1>=id_end(i,1) & start_f1<=id_end(i,2));
        f_e = find(ends_f1>=id_end(i,1)& ends_f1<=id_end(i,2));
        f1_end = unique([f_s,f_e]); % End of the bout
        rates_sharpwave{Ratindex,1}(i,1) = size(f1_start,1)/p_sec(1,i);
        rates_sharpwave{Ratindex,1}(i,2) = size(f1_end,1)/p_sec(1,i);
        
        % Ripple
        f_s = find(start_f2>=id_start(i,1) & start_f2<=id_start(i,2));
        f_e = find(ends_f2>=id_start(i,1)& ends_f2<=id_start(i,2));
        f2_start = unique([f_s,f_e]);
        f_s = find(start_f2>=id_end(i,1) & start_f2<=id_end(i,2));
        f_e = find(ends_f2>=id_end(i,1)& ends_f2<=id_end(i,2));
        f2_end = unique([f_s,f_e]); 
        rates_ripple{Ratindex,1}(i,1) = size(f2_start,1)/p_sec(1,i);
        rates_ripple{Ratindex,1}(i,2) = size(f2_end,1)/p_sec(1,i);
        
        % SWR
        f_s = find(start_f4>=id_start(i,1) & start_f4<=id_start(i,2));
        f_e = find(ends_f4>=id_start(i,1)& ends_f4<=id_start(i,2));
        f4_start = unique([f_s,f_e]);
        f_s = find(start_f4>=id_end(i,1) & start_f4<=id_end(i,2));
        f_e = find(ends_f4>=id_end(i,1)& ends_f4<=id_end(i,2));
        f4_end = unique([f_s,f_e]); 
        rates_SWR{Ratindex,1}(i,1) = size(f4_start,1)/p_sec(1,i);
        rates_SWR{Ratindex,1}(i,2) = size(f4_end,1)/p_sec(1,i);
        
        % cSWR
        f_s = find(start_f6>=id_start(i,1) & start_f6<=id_start(i,2));
        f_e = find(ends_f6>=id_start(i,1)& ends_f6<=id_start(i,2));
        f6_start = unique([f_s,f_e]);
        f_s = find(start_f6>=id_end(i,1) & start_f6<=id_end(i,2));
        f_e = find(ends_f6>=id_end(i,1)& ends_f6<=id_end(i,2));
        f6_end = unique([f_s,f_e]); 
        rates_cSWR{Ratindex,1}(i,1) = size(f6_start,1)/p_sec(1,i);
        rates_cSWR{Ratindex,1}(i,2) = size(f6_end,1)/p_sec(1,i);
    end
    clear id_start id_end p_sample 
end 
 save('Rates_Tuks_Analysis','rates_cSWR','rates_SWR','rates_ripple','rates_sharpwave')
