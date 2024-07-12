clearvars
addpath('F:\OSF_CBD_DONT_DELETE\ADRITOOLS-master\ADRITOOLS-master')
addpath('F:\OSF_CBD_DONT_DELETE\swr_analysys\CBD\')
addpath(genpath('C:\Users\students\Documents\CBD_acutes_DONT_DELETE\Swatantra\FMAToolbox-master'))
load ('processed_pfc_shal.mat')
cd('F:\OSF_CBD_DONT_DELETE\swr_analysys\detections')

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

peak = timestamps_table{:,4};
peaks_nrem = peak(ripple_sleepstate_binary);
peaks_f1 = peaks_nrem(event_form_nrem==1);
peaks_f2 = peaks_nrem(event_form_nrem==2);
peaks_f4 = peaks_nrem(event_form_nrem==4);
peaks_f6 = peaks_nrem(event_form_nrem==6);

pfc_signal = signals(Ratindex,:); %Includes NAN values
states = sleep_states(Ratindex,:);

%Removed nans
pfc_signal_withoutnans = (signals(Ratindex,signals_indexes(Ratindex,1):signals_indexes(Ratindex,2)));
states_withoutnans = (sleep_states(Ratindex,signals_indexes(Ratindex,1):signals_indexes(Ratindex,2)));
states_binary = states_withoutnans==2;%NREM samples
pfc_signal_500 = ones(size(pfc_signal_withoutnans))*500; %USE value of 500 to identify REM.

%Filter in SO range
fn = 600;
Wn1 = [0.5/(fn/2) 4/(fn/2)]; % 0.5-4Hz
[b3,a3] = butter(3,Wn1); %Filter coefficients
pfc_signal_filter = filtfilt(b3,a3,pfc_signal_withoutnans);

% t_pfc=[0:length(pfc_signal_filter)-1]/fn;
% filtered=[ t_pfc' pfc_signal_filter'];
% 
% delta=FindDeltaWaves(filtered,ratIDs(Ratindex))
%% Checking delta detections
% plot(t_pfc, pfc_signal_filter)
% hold on
% stem(delta(:,2),ones(size(delta(:,2)))*500)
%%
pfc_signal_nrem = pfc_signal_filter(states_binary); %removed rem
%%
t_pfc=[0:length(pfc_signal_nrem)-1]/fn;
%t_pfc=[1:length(pfc_signal_nrem)];
filtered=[ t_pfc' pfc_signal_nrem'];
% 
delta=FindDeltaWaves(filtered,(Ratindex));
dpeak=delta(:,2);
dpeak_ind=find(ismember(t_pfc,dpeak));

%%
%Compute the phase from 0 to 360 degrees
pfc_signal_phase = mod(rad2deg(angle(hilbert(pfc_signal_nrem))),360);

dpeak_phase{Ratindex,1}=pfc_signal_phase(dpeak_ind);

% Computing phase cycle median per animal

phase_cycle = pfc_signal_phase;
phase_cycle(phase_cycle<350) = 0;
[~, p] = findpeaks(phase_cycle);
d = (diff(p)/600)*1000;
d(d<10) = [];
phase_cycle_duration{Ratindex,1} = d;
phase_cycle_median(Ratindex,1) = median(d);

v2=ConsecutiveOnes(states_binary);
v_index = find(v2~=0); % With respect to without nans signal
v_values = v2(v2~=0); %durations
v_values_cumulative = cumsum(v_values);
v_indexend = v_index+v_values-1;

    for j = 1:length(v_index)
        if j==1
            pfc_signal_500(v_index(j):v_indexend(j)) = pfc_signal_phase(1:v_values(j));
        else
            pfc_signal_500(v_index(j):v_indexend(j)) = pfc_signal_phase(v_values_cumulative(j-1)+1:v_values_cumulative(j));
        end
    end
    
alinged_pfc_phase = nan(size(pfc_signal));
alinged_pfc_phase(signals_indexes(Ratindex,1):signals_indexes(Ratindex,2)) = pfc_signal_500;

SO_phase  = alinged_pfc_phase(round(peak)).';

SO_phase_f1_total{Ratindex,1} = alinged_pfc_phase(round(peaks_f1));
SO_phase_f2_total{Ratindex,1} = alinged_pfc_phase(round(peaks_f2));
SO_phase_f4_total{Ratindex,1} = alinged_pfc_phase(round(peaks_f4));
SO_phase_f6_total{Ratindex,1} = alinged_pfc_phase(round(peaks_f6));

SO_phase(SO_phase==500)= NaN;
phase_table = addvars(timestamps_table,SO_phase,'After',"Bin");
%save(strcat('Phase_Table_Rat_',ratno,'.mat'),'phase_table')

clear phase_table SO_phase v_values v_index peaks_f1 peaks_f2 peaks_f4 peaks_f6 peaks event_form_nrem ripple_sleepstate ripple_sleepstate_binary event_form alinged_pfc_phase timestamps_table pfc_signal_withoutnans pfc_signal_nrem pfc_signal_filter pfc_signal
end 
% save('Phase_AllRats_form_1.mat','SO_phase_f1_total')
% save('Phase_AllRats_form_2.mat','SO_phase_f2_total')
% save('Phase_AllRats_form_4.mat','SO_phase_f4_total')
% save('Phase_AllRats_form_6.mat','SO_phase_f6_total')
% save('Phase_Cycle_Duration_median_AllRats.mat','phase_cycle_duration','phase_cycle_median')
polarhistogram(deg2rad([dpeak_phase{:}]),180,'Normalization','probability')
title('Delta peak slow wave phase')
printing('Delta peak slow wave phase')



