%% Pelin Ozsezer

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CREATE BASELINE                                          %%
%% Baseline vs Event Type (Ripple, SW, SWR, & Complex SWR)  %%
%% For HPCpyra                                              %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear

% RatIDs of Veh: 3, 4, 9, 201, 203, 206, 210, 211, 213
% RatIDs of CBD: 2, 5, 10, 11, 204, 205, 207, 209, 212, 214
rats_veh=[2,3,5,8,9,12,15,16,18];
rats_cbd=[1,4,6,7,10,11,13,14,17,19];

%%%%%%%%%%%%%%%%%%%%%%%%
%% EXTRACT NREM SLEEP %%
%%%%%%%%%%%%%%%%%%%%%%%%

% NREM = 2

cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/processed_data_unfiltered
%% HPCpyra
load('processed_HPCpyra.mat');
NREM_HPCpyra=[];
for rat=1:size(signals,1)
    for i=1:size(signals,2)
        if sleep_states(rat,i) == 2
            NREM_HPCpyra(rat,i)=signals(rat,i);
        else 
            NREM_HPCpyra(rat,i)=nan;
        end
    end
end

NREM_HPCpyra_veh=NREM_HPCpyra(rats_veh,:);
NREM_HPCpyra_cbd=NREM_HPCpyra(rats_cbd,:);

cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project

%%%%%%%%%%%%%
%% ARRANGE %%
%%%%%%%%%%%%%

%% HPCpyra %%

%% Veh
NREM_HPCpyra_rat1_veh=[];
NREM_HPCpyra_rat2_veh=[];
NREM_HPCpyra_rat3_veh=[];
NREM_HPCpyra_rat4_veh=[];
NREM_HPCpyra_rat5_veh=[];
NREM_HPCpyra_rat6_veh=[];
NREM_HPCpyra_rat7_veh=[];
NREM_HPCpyra_rat8_veh=[];
NREM_HPCpyra_rat9_veh=[];
for i =1:size(NREM_HPCpyra_veh,1)
    if i==1
        NREM_HPCpyra_rat1_veh=NREM_HPCpyra_veh(i,:);
    elseif i==2
         NREM_HPCpyra_rat2_veh=NREM_HPCpyra_veh(i,:);
    elseif i==3
        NREM_HPCpyra_rat3_veh=NREM_HPCpyra_veh(i,:);
    elseif i==4
        NREM_HPCpyra_rat4_veh=NREM_HPCpyra_veh(i,:);
    elseif i==5
        NREM_HPCpyra_rat5_veh=NREM_HPCpyra_veh(i,:);
    elseif i==6
        NREM_HPCpyra_rat6_veh=NREM_HPCpyra_veh(i,:);
    elseif i==7
        NREM_HPCpyra_rat7_veh=NREM_HPCpyra_veh(i,:);
    elseif i==8
        NREM_HPCpyra_rat8_veh=NREM_HPCpyra_veh(i,:);
    elseif i==9
        NREM_HPCpyra_rat9_veh=NREM_HPCpyra_veh(i,:);                       
    end
end

% remove NaN
NREM_HPCpyra_rat1_veh=rmmissing(NREM_HPCpyra_rat1_veh);
NREM_HPCpyra_rat2_veh=rmmissing(NREM_HPCpyra_rat2_veh);
NREM_HPCpyra_rat3_veh=rmmissing(NREM_HPCpyra_rat3_veh);
NREM_HPCpyra_rat4_veh=rmmissing(NREM_HPCpyra_rat4_veh);
NREM_HPCpyra_rat5_veh=rmmissing(NREM_HPCpyra_rat5_veh);
NREM_HPCpyra_rat6_veh=rmmissing(NREM_HPCpyra_rat6_veh);
NREM_HPCpyra_rat7_veh=rmmissing(NREM_HPCpyra_rat7_veh);
NREM_HPCpyra_rat8_veh=rmmissing(NREM_HPCpyra_rat8_veh);
NREM_HPCpyra_rat9_veh=rmmissing(NREM_HPCpyra_rat9_veh);

%% CBD
NREM_HPCpyra_rat1_cbd=[];
NREM_HPCpyra_rat2_cbd=[];
NREM_HPCpyra_rat3_cbd=[];
NREM_HPCpyra_rat4_cbd=[];
NREM_HPCpyra_rat5_cbd=[];
NREM_HPCpyra_rat6_cbd=[];
NREM_HPCpyra_rat7_cbd=[];
NREM_HPCpyra_rat8_cbd=[];
NREM_HPCpyra_rat9_cbd=[];
NREM_HPCpyra_rat10_cbd=[];
for i =1:size(NREM_HPCpyra_cbd,1)
    if i==1
        NREM_HPCpyra_rat1_cbd=NREM_HPCpyra_cbd(i,:);
    elseif i==2
         NREM_HPCpyra_rat2_cbd=NREM_HPCpyra_cbd(i,:);
    elseif i==3
        NREM_HPCpyra_rat3_cbd=NREM_HPCpyra_cbd(i,:);
    elseif i==4
        NREM_HPCpyra_rat4_cbd=NREM_HPCpyra_cbd(i,:);
    elseif i==5
        NREM_HPCpyra_rat5_cbd=NREM_HPCpyra_cbd(i,:);
    elseif i==6
        NREM_HPCpyra_rat6_cbd=NREM_HPCpyra_cbd(i,:);
    elseif i==7
        NREM_HPCpyra_rat7_cbd=NREM_HPCpyra_cbd(i,:);
    elseif i==8
        NREM_HPCpyra_rat8_cbd=NREM_HPCpyra_cbd(i,:);
    elseif i==9
        NREM_HPCpyra_rat9_cbd=NREM_HPCpyra_cbd(i,:);       
    elseif i==10
        NREM_HPCpyra_rat10_cbd=NREM_HPCpyra_cbd(i,:); 
    end
end

% remove NaN
NREM_HPCpyra_rat1_cbd=rmmissing(NREM_HPCpyra_rat1_cbd);
NREM_HPCpyra_rat2_cbd=rmmissing(NREM_HPCpyra_rat2_cbd);
NREM_HPCpyra_rat3_cbd=rmmissing(NREM_HPCpyra_rat3_cbd);
NREM_HPCpyra_rat4_cbd=rmmissing(NREM_HPCpyra_rat4_cbd);
NREM_HPCpyra_rat5_cbd=rmmissing(NREM_HPCpyra_rat5_cbd);
NREM_HPCpyra_rat6_cbd=rmmissing(NREM_HPCpyra_rat6_cbd);
NREM_HPCpyra_rat7_cbd=rmmissing(NREM_HPCpyra_rat7_cbd);
NREM_HPCpyra_rat8_cbd=rmmissing(NREM_HPCpyra_rat8_cbd);
NREM_HPCpyra_rat9_cbd=rmmissing(NREM_HPCpyra_rat9_cbd);
NREM_HPCpyra_rat10_cbd=rmmissing(NREM_HPCpyra_rat10_cbd);


%%%%%%%%%%%%%%%
%% RANDOMIZE %%
%%%%%%%%%%%%%%%

% randomize 2000 (for complex SWR -> 1810 - Veh & 1300 - CBD) time windows of 2.2 seconds
rng(13);
fs=600; % sampling rate is 600 Hz

%%%%%%%%%
%% Veh %%
%%%%%%%%%
waveforms_HPCpyra_baseline_veh=[];
tw_stored_veh=[];
for i=1:2000
    i
    rat = randperm(length(rats_veh));
    rat = rat(1);
    if rat == 1
        signal = NREM_HPCpyra_rat1_veh; % tw=time window
        x = 1:length(signal);
        x = x(1+fs*3:end-fs*3);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_veh=[tw_stored_veh; tw];
        tw1 = NREM_HPCpyra_rat1_veh(tw-fs*3:tw+fs*3);
        waveforms_HPCpyra_baseline_veh=[waveforms_HPCpyra_baseline_veh; tw1];
    elseif rat == 2
        signal = NREM_HPCpyra_rat2_veh; % tw=time window
        x = 1:length(signal);
        x = x(1+fs*3:end-fs*3);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_veh=[tw_stored_veh; tw];
        tw1 = NREM_HPCpyra_rat2_veh(tw-fs*3:tw+fs*3);
        waveforms_HPCpyra_baseline_veh=[waveforms_HPCpyra_baseline_veh; tw1];
    elseif rat == 3
        signal = NREM_HPCpyra_rat3_veh; % tw=time window
        x = 1:length(signal);
        x = x(1+fs*3:end-fs*3);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_veh=[tw_stored_veh; tw];
        tw1 = NREM_HPCpyra_rat3_veh(tw-fs*3:tw+fs*3);
        waveforms_HPCpyra_baseline_veh=[waveforms_HPCpyra_baseline_veh; tw1];
    elseif rat == 4
        signal = NREM_HPCpyra_rat4_veh; % tw=time window
        x = 1:length(signal);
        x = x(1+fs*3:end-fs*3);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_veh=[tw_stored_veh; tw];
        tw1 = NREM_HPCpyra_rat4_veh(tw-fs*3:tw+fs*3);
        waveforms_HPCpyra_baseline_veh=[waveforms_HPCpyra_baseline_veh; tw1];
    elseif rat == 5
        signal = NREM_HPCpyra_rat5_veh; % tw=time window
        x = 1:length(signal);
        x = x(1+fs*3:end-fs*3);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_veh=[tw_stored_veh; tw];
        tw1 = NREM_HPCpyra_rat5_veh(tw-fs*3:tw+fs*3);
        waveforms_HPCpyra_baseline_veh=[waveforms_HPCpyra_baseline_veh; tw1];
    elseif rat == 6
        signal = NREM_HPCpyra_rat6_veh; % tw=time window
        x = 1:length(signal);
        x = x(1+fs*3:end-fs*3);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_veh=[tw_stored_veh; tw];
        tw1 = NREM_HPCpyra_rat6_veh(tw-fs*3:tw+fs*3);
        waveforms_HPCpyra_baseline_veh=[waveforms_HPCpyra_baseline_veh; tw1];
    elseif rat == 7
        signal = NREM_HPCpyra_rat7_veh; % tw=time window
        x = 1:length(signal);
        x = x(1+fs*3:end-fs*3);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_veh=[tw_stored_veh; tw];
        tw1 = NREM_HPCpyra_rat7_veh(tw-fs*3:tw+fs*3);
        waveforms_HPCpyra_baseline_veh=[waveforms_HPCpyra_baseline_veh; tw1];
    elseif rat == 8
        signal = NREM_HPCpyra_rat8_veh; % tw=time window
        x = 1:length(signal);
        x = x(1+fs*3:end-fs*3);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_veh=[tw_stored_veh; tw];
        tw1 = NREM_HPCpyra_rat8_veh(tw-fs*3:tw+fs*3);
        waveforms_HPCpyra_baseline_veh=[waveforms_HPCpyra_baseline_veh; tw1];
    elseif rat == 9
        signal = NREM_HPCpyra_rat9_veh; % tw=time window
        x = 1:length(signal);
        x = x(1+fs*3:end-fs*3);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_veh=[tw_stored_veh; tw];
        tw1 = NREM_HPCpyra_rat9_veh(tw-fs*3:tw+fs*3);
        waveforms_HPCpyra_baseline_veh=[waveforms_HPCpyra_baseline_veh; tw1];
    end
end

%
GC_baseline_HPCpyra_veh=cell(size(waveforms_HPCpyra_baseline_veh,1),1);
for i=1:size(waveforms_HPCpyra_baseline_veh,1)
    i
    GC_baseline_HPCpyra_veh{i}=waveforms_HPCpyra_baseline_veh(i,:);
end


%%%%%%%%%
%% CBD %%
%%%%%%%%%
waveforms_HPCpyra_baseline_cbd=[];
tw_stored_cbd=[];
for i=1:2000
    i
    rat = randperm(length(rats_cbd));
    rat = rat(1);
    if rat == 1
        signal = NREM_HPCpyra_rat1_cbd; % tw=time window
        x = 1:length(signal);
        x = x(1+fs*3:end-fs*3);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_cbd=[tw_stored_cbd; tw];
        tw1 = NREM_HPCpyra_rat1_cbd(tw-fs*3:tw+fs*3);
        waveforms_HPCpyra_baseline_cbd=[waveforms_HPCpyra_baseline_cbd; tw1];
    elseif rat == 2
        signal = NREM_HPCpyra_rat2_cbd; % tw=time window
        x = 1:length(signal);
        x = x(1+fs*3:end-fs*3);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_cbd=[tw_stored_cbd; tw];
        tw1 = NREM_HPCpyra_rat2_cbd(tw-fs*3:tw+fs*3);
        waveforms_HPCpyra_baseline_cbd=[waveforms_HPCpyra_baseline_cbd; tw1];
    elseif rat == 3
        signal = NREM_HPCpyra_rat3_cbd; % tw=time window
        x = 1:length(signal);
        x = x(1+fs*3:end-fs*3);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_cbd=[tw_stored_cbd; tw];
        tw1 = NREM_HPCpyra_rat3_cbd(tw-fs*3:tw+fs*3);
        waveforms_HPCpyra_baseline_cbd=[waveforms_HPCpyra_baseline_cbd; tw1];
    elseif rat == 4
        signal = NREM_HPCpyra_rat4_cbd; % tw=time window
        x = 1:length(signal);
        x = x(1+fs*3:end-fs*3);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_cbd=[tw_stored_cbd; tw];
        tw1 = NREM_HPCpyra_rat4_cbd(tw-fs*3:tw+fs*3);
        waveforms_HPCpyra_baseline_cbd=[waveforms_HPCpyra_baseline_cbd; tw1];
    elseif rat == 5
        signal = NREM_HPCpyra_rat5_cbd; % tw=time window
        x = 1:length(signal);
        x = x(1+fs*3:end-fs*3);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_cbd=[tw_stored_cbd; tw];
        tw1 = NREM_HPCpyra_rat5_cbd(tw-fs*3:tw+fs*3);
        waveforms_HPCpyra_baseline_cbd=[waveforms_HPCpyra_baseline_cbd; tw1];
    elseif rat == 6
        signal = NREM_HPCpyra_rat6_cbd; % tw=time window
        x = 1:length(signal);
        x = x(1+fs*3:end-fs*3);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_cbd=[tw_stored_cbd; tw];
        tw1 = NREM_HPCpyra_rat6_cbd(tw-fs*3:tw+fs*3);
        waveforms_HPCpyra_baseline_cbd=[waveforms_HPCpyra_baseline_cbd; tw1];
    elseif rat == 7
        signal = NREM_HPCpyra_rat7_cbd; % tw=time window
        x = 1:length(signal);
        x = x(1+fs*3:end-fs*3);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_cbd=[tw_stored_cbd; tw];
        tw1 = NREM_HPCpyra_rat7_cbd(tw-fs*3:tw+fs*3);
        waveforms_HPCpyra_baseline_cbd=[waveforms_HPCpyra_baseline_cbd; tw1];
    elseif rat == 8
        signal = NREM_HPCpyra_rat8_cbd; % tw=time window
        x = 1:length(signal);
        x = x(1+fs*3:end-fs*3);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_cbd=[tw_stored_cbd; tw];
        tw1 = NREM_HPCpyra_rat8_cbd(tw-fs*3:tw+fs*3);
        waveforms_HPCpyra_baseline_cbd=[waveforms_HPCpyra_baseline_cbd; tw1];
    elseif rat == 9
        signal = NREM_HPCpyra_rat9_cbd; % tw=time window
        x = 1:length(signal);
        x = x(1+fs*3:end-fs*3);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_cbd=[tw_stored_cbd; tw];
        tw1 = NREM_HPCpyra_rat9_cbd(tw-fs*3:tw+fs*3);
        waveforms_HPCpyra_baseline_cbd=[waveforms_HPCpyra_baseline_cbd; tw1];
    elseif rat == 10
        signal = NREM_HPCpyra_rat10_cbd; % tw=time window
        x = 1:length(signal);
        x = x(1+fs*3:end-fs*3);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_cbd=[tw_stored_cbd; tw];
        tw1 = NREM_HPCpyra_rat10_cbd(tw-fs*3:tw+fs*3);
        waveforms_HPCpyra_baseline_cbd=[waveforms_HPCpyra_baseline_cbd; tw1];
    end
end

%
GC_baseline_HPCpyra_cbd=cell(size(waveforms_HPCpyra_baseline_cbd,1),1);
for i=1:size(waveforms_HPCpyra_baseline_cbd,1)
    i
    GC_baseline_HPCpyra_cbd{i}=waveforms_HPCpyra_baseline_cbd(i,:);
end


%% SAVE VARIABLES %%

    clearvars -except GC_baseline_HPCpyra_veh GC_baseline_HPCpyra_cbd...
        tw_stored_veh tw_stored_cbd

    save baseline_2000_HPCpyra.mat

