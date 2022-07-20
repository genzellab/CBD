%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CREATE BASELINE                                          %%
%% Baseline vs Event Type (Ripple, SW, SWR, & Complex SWR)  %%
%% For PFCshal & PFCdeep                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD_project/processed_data');

% RatIDs of Veh: 3, 4, 9, 201, 203, 206, 210, 211, 213
% RatIDs of CBD: 2, 5, 10, 11, 204, 205, 207, 209, 212, 214
rats_veh=[2,3,5,8,9,12,15,16,18];
rats_cbd=[1,4,6,7,10,11,13,14,17,19];

%%%%%%%%%%%%%%%%%%%%%%%%
%% EXTRACT NREM SLEEP %%
%%%%%%%%%%%%%%%%%%%%%%%%

% NREM = 2

%% PFCshal
load('processed_PFCshal.mat');
NREM_PFCshal=[];
for rat=1:size(signals,1)
    for i=1:size(signals,2)
        if sleep_states(rat,i) == 2
            NREM_PFCshal(rat,i)=signals(rat,i);
        else 
            NREM_PFCshal(rat,i)=nan;
        end
    end
end

NREM_PFCshal_veh=NREM_PFCshal(rats_veh,:);
NREM_PFCshal_cbd=NREM_PFCshal(rats_cbd,:);

%% PFCdeep
load('processed_PFCdeep.mat');
NREM_PFCdeep=[];
for rat=1:size(signals,1)
    for i=1:size(signals,2)
        if sleep_states(rat,i) == 2
            NREM_PFCdeep(rat,i)=signals(rat,i);
        else
            NREM_PFCdeep(rat,i)=nan;
        end
    end
end

NREM_PFCdeep_veh=NREM_PFCdeep(rats_veh,:);
NREM_PFCdeep_cbd=NREM_PFCdeep(rats_cbd,:);

clearvars -except NREM_PFCshal_veh NREM_PFCshal_cbd...
    NREM_PFCdeep_veh NREM_PFCdeep_cbd...
    rats_veh rats_cbd


%%%%%%%%%%%%%
%% ARRANGE %%
%%%%%%%%%%%%%

%% PFCshal %%

% Veh
NREM_PFCshal_rat1_veh=[];
NREM_PFCshal_rat2_veh=[];
NREM_PFCshal_rat3_veh=[];
NREM_PFCshal_rat4_veh=[];
NREM_PFCshal_rat5_veh=[];
NREM_PFCshal_rat6_veh=[];
NREM_PFCshal_rat7_veh=[];
NREM_PFCshal_rat8_veh=[];
NREM_PFCshal_rat9_veh=[];
for i =1:size(NREM_PFCshal_veh,1)
    if i==1
        NREM_PFCshal_rat1_veh=NREM_PFCshal_veh(i,:);
    elseif i==2
         NREM_PFCshal_rat2_veh=NREM_PFCshal_veh(i,:);
    elseif i==3
        NREM_PFCshal_rat3_veh=NREM_PFCshal_veh(i,:);
    elseif i==4
        NREM_PFCshal_rat4_veh=NREM_PFCshal_veh(i,:);
    elseif i==5
        NREM_PFCshal_rat5_veh=NREM_PFCshal_veh(i,:);
    elseif i==6
        NREM_PFCshal_rat6_veh=NREM_PFCshal_veh(i,:);
    elseif i==7
        NREM_PFCshal_rat7_veh=NREM_PFCshal_veh(i,:);
    elseif i==8
        NREM_PFCshal_rat8_veh=NREM_PFCshal_veh(i,:);
    elseif i==9
        NREM_PFCshal_rat9_veh=NREM_PFCshal_veh(i,:);                       
    end
end

% remove NaN
NREM_PFCshal_rat1_veh=rmmissing(NREM_PFCshal_rat1_veh);
NREM_PFCshal_rat2_veh=rmmissing(NREM_PFCshal_rat2_veh);
NREM_PFCshal_rat3_veh=rmmissing(NREM_PFCshal_rat3_veh);
NREM_PFCshal_rat4_veh=rmmissing(NREM_PFCshal_rat4_veh);
NREM_PFCshal_rat5_veh=rmmissing(NREM_PFCshal_rat5_veh);
NREM_PFCshal_rat6_veh=rmmissing(NREM_PFCshal_rat6_veh);
NREM_PFCshal_rat7_veh=rmmissing(NREM_PFCshal_rat7_veh);
NREM_PFCshal_rat8_veh=rmmissing(NREM_PFCshal_rat8_veh);
NREM_PFCshal_rat9_veh=rmmissing(NREM_PFCshal_rat9_veh);

% CBD
NREM_PFCshal_rat1_cbd=[];
NREM_PFCshal_rat2_cbd=[];
NREM_PFCshal_rat3_cbd=[];
NREM_PFCshal_rat4_cbd=[];
NREM_PFCshal_rat5_cbd=[];
NREM_PFCshal_rat6_cbd=[];
NREM_PFCshal_rat7_cbd=[];
NREM_PFCshal_rat8_cbd=[];
NREM_PFCshal_rat9_cbd=[];
NREM_PFCshal_rat10_cbd=[];
for i =1:size(NREM_PFCshal_cbd,1)
    if i==1
        NREM_PFCshal_rat1_cbd=NREM_PFCshal_cbd(i,:);
    elseif i==2
         NREM_PFCshal_rat2_cbd=NREM_PFCshal_cbd(i,:);
    elseif i==3
        NREM_PFCshal_rat3_cbd=NREM_PFCshal_cbd(i,:);
    elseif i==4
        NREM_PFCshal_rat4_cbd=NREM_PFCshal_cbd(i,:);
    elseif i==5
        NREM_PFCshal_rat5_cbd=NREM_PFCshal_cbd(i,:);
    elseif i==6
        NREM_PFCshal_rat6_cbd=NREM_PFCshal_cbd(i,:);
    elseif i==7
        NREM_PFCshal_rat7_cbd=NREM_PFCshal_cbd(i,:);
    elseif i==8
        NREM_PFCshal_rat8_cbd=NREM_PFCshal_cbd(i,:);
    elseif i==9
        NREM_PFCshal_rat9_cbd=NREM_PFCshal_cbd(i,:);       
    elseif i==10
        NREM_PFCshal_rat10_cbd=NREM_PFCshal_cbd(i,:); 
    end
end

% remove NaN
NREM_PFCshal_rat1_cbd=rmmissing(NREM_PFCshal_rat1_cbd);
NREM_PFCshal_rat2_cbd=rmmissing(NREM_PFCshal_rat2_cbd);
NREM_PFCshal_rat3_cbd=rmmissing(NREM_PFCshal_rat3_cbd);
NREM_PFCshal_rat4_cbd=rmmissing(NREM_PFCshal_rat4_cbd);
NREM_PFCshal_rat5_cbd=rmmissing(NREM_PFCshal_rat5_cbd);
NREM_PFCshal_rat6_cbd=rmmissing(NREM_PFCshal_rat6_cbd);
NREM_PFCshal_rat7_cbd=rmmissing(NREM_PFCshal_rat7_cbd);
NREM_PFCshal_rat8_cbd=rmmissing(NREM_PFCshal_rat8_cbd);
NREM_PFCshal_rat9_cbd=rmmissing(NREM_PFCshal_rat9_cbd);
NREM_PFCshal_rat10_cbd=rmmissing(NREM_PFCshal_rat10_cbd);


%% PFCdeep %%

% Veh
NREM_PFCdeep_rat1_veh=[];
NREM_PFCdeep_rat2_veh=[];
NREM_PFCdeep_rat3_veh=[];
NREM_PFCdeep_rat4_veh=[];
NREM_PFCdeep_rat5_veh=[];
NREM_PFCdeep_rat6_veh=[];
NREM_PFCdeep_rat7_veh=[];
NREM_PFCdeep_rat8_veh=[];
NREM_PFCdeep_rat9_veh=[];
for i =1:size(NREM_PFCdeep_veh,1)
    if i==1
        NREM_PFCdeep_rat1_veh=NREM_PFCdeep_veh(i,:);
    elseif i==2
         NREM_PFCdeep_rat2_veh=NREM_PFCdeep_veh(i,:);
    elseif i==3
        NREM_PFCdeep_rat3_veh=NREM_PFCdeep_veh(i,:);
    elseif i==4
        NREM_PFCdeep_rat4_veh=NREM_PFCdeep_veh(i,:);
    elseif i==5
        NREM_PFCdeep_rat5_veh=NREM_PFCdeep_veh(i,:);
    elseif i==6
        NREM_PFCdeep_rat6_veh=NREM_PFCdeep_veh(i,:);
    elseif i==7
        NREM_PFCdeep_rat7_veh=NREM_PFCdeep_veh(i,:);
    elseif i==8
        NREM_PFCdeep_rat8_veh=NREM_PFCdeep_veh(i,:);
    elseif i==9
        NREM_PFCdeep_rat9_veh=NREM_PFCdeep_veh(i,:);                       
    end
end

% remove NaN
NREM_PFCdeep_rat1_veh=rmmissing(NREM_PFCdeep_rat1_veh);
NREM_PFCdeep_rat2_veh=rmmissing(NREM_PFCdeep_rat2_veh);
NREM_PFCdeep_rat3_veh=rmmissing(NREM_PFCdeep_rat3_veh);
NREM_PFCdeep_rat4_veh=rmmissing(NREM_PFCdeep_rat4_veh);
NREM_PFCdeep_rat5_veh=rmmissing(NREM_PFCdeep_rat5_veh);
NREM_PFCdeep_rat6_veh=rmmissing(NREM_PFCdeep_rat6_veh);
NREM_PFCdeep_rat7_veh=rmmissing(NREM_PFCdeep_rat7_veh);
NREM_PFCdeep_rat8_veh=rmmissing(NREM_PFCdeep_rat8_veh);
NREM_PFCdeep_rat9_veh=rmmissing(NREM_PFCdeep_rat9_veh);

% CBD
NREM_PFCdeep_rat1_cbd=[];
NREM_PFCdeep_rat2_cbd=[];
NREM_PFCdeep_rat3_cbd=[];
NREM_PFCdeep_rat4_cbd=[];
NREM_PFCdeep_rat5_cbd=[];
NREM_PFCdeep_rat6_cbd=[];
NREM_PFCdeep_rat7_cbd=[];
NREM_PFCdeep_rat8_cbd=[];
NREM_PFCdeep_rat9_cbd=[];
NREM_PFCdeep_rat10_cbd=[];
for i =1:size(NREM_PFCdeep_cbd,1)
    if i==1
        NREM_PFCdeep_rat1_cbd=NREM_PFCdeep_cbd(i,:);
    elseif i==2
         NREM_PFCdeep_rat2_cbd=NREM_PFCdeep_cbd(i,:);
    elseif i==3
        NREM_PFCdeep_rat3_cbd=NREM_PFCdeep_cbd(i,:);
    elseif i==4
        NREM_PFCdeep_rat4_cbd=NREM_PFCdeep_cbd(i,:);
    elseif i==5
        NREM_PFCdeep_rat5_cbd=NREM_PFCdeep_cbd(i,:);
    elseif i==6
        NREM_PFCdeep_rat6_cbd=NREM_PFCdeep_cbd(i,:);
    elseif i==7
        NREM_PFCdeep_rat7_cbd=NREM_PFCdeep_cbd(i,:);
    elseif i==8
        NREM_PFCdeep_rat8_cbd=NREM_PFCdeep_cbd(i,:);
    elseif i==9
        NREM_PFCdeep_rat9_cbd=NREM_PFCdeep_cbd(i,:);       
    elseif i==10
        NREM_PFCdeep_rat10_cbd=NREM_PFCdeep_cbd(i,:); 
    end
end

% remove NaN
NREM_PFCshal_rat1_cbd=rmmissing(NREM_PFCshal_rat1_cbd);
NREM_PFCshal_rat2_cbd=rmmissing(NREM_PFCshal_rat2_cbd);
NREM_PFCshal_rat3_cbd=rmmissing(NREM_PFCshal_rat3_cbd);
NREM_PFCshal_rat4_cbd=rmmissing(NREM_PFCshal_rat4_cbd);
NREM_PFCshal_rat5_cbd=rmmissing(NREM_PFCshal_rat5_cbd);
NREM_PFCshal_rat6_cbd=rmmissing(NREM_PFCshal_rat6_cbd);
NREM_PFCshal_rat7_cbd=rmmissing(NREM_PFCshal_rat7_cbd);
NREM_PFCshal_rat8_cbd=rmmissing(NREM_PFCshal_rat8_cbd);
NREM_PFCshal_rat9_cbd=rmmissing(NREM_PFCshal_rat9_cbd);
NREM_PFCshal_rat10_cbd=rmmissing(NREM_PFCshal_rat10_cbd);


%%%%%%%%%%%%%%%
%% RANDOMIZE %%
%%%%%%%%%%%%%%%

% randomize 2000 (for complex SWR -> 1810 - Veh & 1300 - CBD) time windows of 2.2 seconds

rng(0);
fs=600; % sampling rate is 600 Hz

%%%%%%%%%
%% Veh %%
%%%%%%%%%
   
waveforms_PFCshal_baseline_veh=[];
waveforms_PFCdeep_baseline_veh=[];
tw_stored_veh=[];
for i=1:2000
    i
    rat = randperm(length(rats_veh));
    rat = rat(1);
    if rat == 1
        signal = NREM_PFCshal_rat1_veh; % tw=time window
        x = 1:length(signal);
        x = x(1+fs:end-fs);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_veh=[tw_stored_veh; tw];
        tw = NREM_PFCshal_rat1_veh(tw-fs*1.1:tw+fs*1.1);
        waveforms_PFCshal_baseline_veh=[waveforms_PFCshal_baseline_veh; tw];
        waveforms_PFCdeep_baseline_veh=[waveforms_PFCdeep_baseline_veh; tw];
    elseif rat == 2
        signal = NREM_PFCshal_rat2_veh; % tw=time window
        x = 1:length(signal);
        x = x(1+fs:end-fs);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_veh=[tw_stored_veh; tw];
        tw = NREM_PFCshal_rat2_veh(tw-fs*1.1:tw+fs*1.1);
        waveforms_PFCshal_baseline_veh=[waveforms_PFCshal_baseline_veh; tw];
        waveforms_PFCdeep_baseline_veh=[waveforms_PFCdeep_baseline_veh; tw];
    elseif rat == 3
        signal = NREM_PFCshal_rat3_veh; % tw=time window
        x = 1:length(signal);
        x = x(1+fs:end-fs);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_veh=[tw_stored_veh; tw];
        tw = NREM_PFCshal_rat3_veh(tw-fs*1.1:tw+fs*1.1);
        waveforms_PFCshal_baseline_veh=[waveforms_PFCshal_baseline_veh; tw];
        waveforms_PFCdeep_baseline_veh=[waveforms_PFCdeep_baseline_veh; tw];
    elseif rat == 4
        signal = NREM_PFCshal_rat4_veh; % tw=time window
        x = 1:length(signal);
        x = x(1+fs:end-fs);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_veh=[tw_stored_veh; tw];
        tw = NREM_PFCshal_rat4_veh(tw-fs*1.1:tw+fs*1.1);
        waveforms_PFCshal_baseline_veh=[waveforms_PFCshal_baseline_veh; tw];
        waveforms_PFCdeep_baseline_veh=[waveforms_PFCdeep_baseline_veh; tw];
    elseif rat == 5
        signal = NREM_PFCshal_rat5_veh; % tw=time window
        x = 1:length(signal);
        x = x(1+fs:end-fs);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_veh=[tw_stored_veh; tw];
        tw = NREM_PFCshal_rat5_veh(tw-fs*1.1:tw+fs*1.1);
        waveforms_PFCshal_baseline_veh=[waveforms_PFCshal_baseline_veh; tw];
        waveforms_PFCdeep_baseline_veh=[waveforms_PFCdeep_baseline_veh; tw];
    elseif rat == 6
        signal = NREM_PFCshal_rat6_veh; % tw=time window
        x = 1:length(signal);
        x = x(1+fs:end-fs);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_veh=[tw_stored_veh; tw];
        tw = NREM_PFCshal_rat6_veh(tw-fs*1.1:tw+fs*1.1);
        waveforms_PFCshal_baseline_veh=[waveforms_PFCshal_baseline_veh; tw];
        waveforms_PFCdeep_baseline_veh=[waveforms_PFCdeep_baseline_veh; tw];
    elseif rat == 7
        signal = NREM_PFCshal_rat7_veh; % tw=time window
        x = 1:length(signal);
        x = x(1+fs:end-fs);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_veh=[tw_stored_veh; tw];
        tw = NREM_PFCshal_rat7_veh(tw-fs*1.1:tw+fs*1.1);
        waveforms_PFCshal_baseline_veh=[waveforms_PFCshal_baseline_veh; tw];
        waveforms_PFCdeep_baseline_veh=[waveforms_PFCdeep_baseline_veh; tw];
    elseif rat == 8
        signal = NREM_PFCshal_rat8_veh; % tw=time window
        x = 1:length(signal);
        x = x(1+fs:end-fs);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_veh=[tw_stored_veh; tw];
        tw = NREM_PFCshal_rat8_veh(tw-fs*1.1:tw+fs*1.1);
        waveforms_PFCshal_baseline_veh=[waveforms_PFCshal_baseline_veh; tw];
        waveforms_PFCdeep_baseline_veh=[waveforms_PFCdeep_baseline_veh; tw];
    elseif rat == 9
        signal = NREM_PFCshal_rat9_veh; % tw=time window
        x = 1:length(signal);
        x = x(1+fs:end-fs);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_veh=[tw_stored_veh; tw];
        tw = NREM_PFCshal_rat9_veh(tw-fs*1.1:tw+fs*1.1);
        waveforms_PFCshal_baseline_veh=[waveforms_PFCshal_baseline_veh; tw];
        waveforms_PFCdeep_baseline_veh=[waveforms_PFCdeep_baseline_veh; tw];
    end
end

%
GC_baseline_PFCshal_veh=cell(size(waveforms_PFCshal_baseline_veh,1),1);
for i=1:size(waveforms_PFCshal_baseline_veh,1)
    i
    GC_baseline_PFCshal_veh{i}=waveforms_PFCshal_baseline_veh(i,:);
end

%
GC_baseline_PFCdeep_veh=cell(size(waveforms_PFCdeep_baseline_veh,1),1);
for i=1:size(waveforms_PFCdeep_baseline_veh,1)
    i
    GC_baseline_PFCdeep_veh{i}=waveforms_PFCdeep_baseline_veh(i,:);
end


%%%%%%%%%
%% CBD %%
%%%%%%%%%

waveforms_PFCshal_baseline_cbd=[];
waveforms_PFCdeep_baseline_cbd=[];
tw_stored_cbd=[];
for i=1:2000
    i
    rat = randperm(length(rats_cbd));
    rat = rat(1);
    if rat == 1
        signal = NREM_PFCshal_rat1_cbd; % tw=time window
        x = 1:length(signal);
        x = x(1+fs:end-fs);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_cbd=[tw_stored_cbd; tw];
        tw = NREM_PFCshal_rat1_cbd(tw-fs*1.1:tw+fs*1.1);
        waveforms_PFCshal_baseline_cbd=[waveforms_PFCshal_baseline_cbd; tw];
        waveforms_PFCdeep_baseline_cbd=[waveforms_PFCdeep_baseline_cbd; tw];
    elseif rat == 2
        signal = NREM_PFCshal_rat2_cbd; % tw=time window
        x = 1:length(signal);
        x = x(1+fs:end-fs);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_cbd=[tw_stored_cbd; tw];
        tw = NREM_PFCshal_rat2_cbd(tw-fs*1.1:tw+fs*1.1);
        waveforms_PFCshal_baseline_cbd=[waveforms_PFCshal_baseline_cbd; tw];
        waveforms_PFCdeep_baseline_cbd=[waveforms_PFCdeep_baseline_cbd; tw];
    elseif rat == 3
        signal = NREM_PFCshal_rat3_cbd; % tw=time window
        x = 1:length(signal);
        x = x(1+fs:end-fs);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_cbd=[tw_stored_cbd; tw];
        tw = NREM_PFCshal_rat3_cbd(tw-fs*1.1:tw+fs*1.1);
        waveforms_PFCshal_baseline_cbd=[waveforms_PFCshal_baseline_cbd; tw];
        waveforms_PFCdeep_baseline_cbd=[waveforms_PFCdeep_baseline_cbd; tw];
    elseif rat == 4
        signal = NREM_PFCshal_rat4_cbd; % tw=time window
        x = 1:length(signal);
        x = x(1+fs:end-fs);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_cbd=[tw_stored_cbd; tw];
        tw = NREM_PFCshal_rat4_cbd(tw-fs*1.1:tw+fs*1.1);
        waveforms_PFCshal_baseline_cbd=[waveforms_PFCshal_baseline_cbd; tw];
        waveforms_PFCdeep_baseline_cbd=[waveforms_PFCdeep_baseline_cbd; tw];
    elseif rat == 5
        signal = NREM_PFCshal_rat5_cbd; % tw=time window
        x = 1:length(signal);
        x = x(1+fs:end-fs);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_cbd=[tw_stored_cbd; tw];
        tw = NREM_PFCshal_rat5_cbd(tw-fs*1.1:tw+fs*1.1);
        waveforms_PFCshal_baseline_cbd=[waveforms_PFCshal_baseline_cbd; tw];
        waveforms_PFCdeep_baseline_cbd=[waveforms_PFCdeep_baseline_cbd; tw];
    elseif rat == 6
        signal = NREM_PFCshal_rat6_cbd; % tw=time window
        x = 1:length(signal);
        x = x(1+fs:end-fs);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_cbd=[tw_stored_cbd; tw];
        tw = NREM_PFCshal_rat6_cbd(tw-fs*1.1:tw+fs*1.1);
        waveforms_PFCshal_baseline_cbd=[waveforms_PFCshal_baseline_cbd; tw];
        waveforms_PFCdeep_baseline_cbd=[waveforms_PFCdeep_baseline_cbd; tw];
    elseif rat == 7
        signal = NREM_PFCshal_rat7_cbd; % tw=time window
        x = 1:length(signal);
        x = x(1+fs:end-fs);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_cbd=[tw_stored_cbd; tw];
        tw = NREM_PFCshal_rat7_cbd(tw-fs*1.1:tw+fs*1.1);
        waveforms_PFCshal_baseline_cbd=[waveforms_PFCshal_baseline_cbd; tw];
        waveforms_PFCdeep_baseline_cbd=[waveforms_PFCdeep_baseline_cbd; tw];
    elseif rat == 8
        signal = NREM_PFCshal_rat8_cbd; % tw=time window
        x = 1:length(signal);
        x = x(1+fs:end-fs);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_cbd=[tw_stored_cbd; tw];
        tw = NREM_PFCshal_rat8_cbd(tw-fs*1.1:tw+fs*1.1);
        waveforms_PFCshal_baseline_cbd=[waveforms_PFCshal_baseline_cbd; tw];
        waveforms_PFCdeep_baseline_cbd=[waveforms_PFCdeep_baseline_cbd; tw];
    elseif rat == 9
        signal = NREM_PFCshal_rat9_cbd; % tw=time window
        x = 1:length(signal);
        x = x(1+fs:end-fs);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_cbd=[tw_stored_cbd; tw];
        tw = NREM_PFCshal_rat9_cbd(tw-fs*1.1:tw+fs*1.1);
        waveforms_PFCshal_baseline_cbd=[waveforms_PFCshal_baseline_cbd; tw];
        waveforms_PFCdeep_baseline_cbd=[waveforms_PFCdeep_baseline_cbd; tw];
    elseif rat == 10
        signal = NREM_PFCshal_rat10_cbd; % tw=time window
        x = 1:length(signal);
        x = x(1+fs:end-fs);
        tw = x(randperm(length(x)));
        tw = tw(1);
        tw_stored_cbd=[tw_stored_cbd; tw];
        tw = NREM_PFCshal_rat10_cbd(tw-fs*1.1:tw+fs*1.1);
        waveforms_PFCshal_baseline_cbd=[waveforms_PFCshal_baseline_cbd; tw];
        waveforms_PFCdeep_baseline_cbd=[waveforms_PFCdeep_baseline_cbd; tw];
    end
end

%
GC_baseline_PFCshal_cbd=cell(size(waveforms_PFCshal_baseline_cbd,1),1);
for i=1:size(waveforms_PFCshal_baseline_cbd,1)
    i
    GC_baseline_PFCshal_cbd{i}=waveforms_PFCshal_baseline_cbd(i,:);
end

%
GC_baseline_PFCdeep_cbd=cell(size(waveforms_PFCdeep_baseline_cbd,1),1);
for i=1:size(waveforms_PFCdeep_baseline_cbd,1)
    i
    GC_baseline_PFCdeep_cbd{i}=waveforms_PFCdeep_baseline_cbd(i,:);
end


%% SAVE VARIABLES %%

    clearvars -except GC_baseline_PFCshal_veh GC_baseline_PFCshal_cbd...
        GC_baseline_PFCdeep_veh  GC_baseline_PFCdeep_cbd...
        tw_stored_veh tw_stored_cbd

    save baseline_2000.mat




