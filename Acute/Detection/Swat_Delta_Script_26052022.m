%% I. Load the data from all the rats, select the top channel
%Load the libraries
addpath(genpath('C:\Users\students\Documents\Swatantra\FMAToolbox-master'));  % FMAT Toolbox
source_path = "C:\Users\students\Documents\Swatantra";

%results_path = source_path + "results_sleep_oscil_tools\animal" + animal + "\";
%mkdir(results_path);

% Sleep Oscilations Tools (self)
% addpath(source_path + "sleep_oscil_tools");

%Fieldtrip
addpath('C:\Users\students\Documents\Tugdual\GitHub\fieldtrip');

%CorticoHippocampal
addpath('C:\Users\students\Documents\Tugdual\GitHub\CorticoHippocampal');
addpath('C:\Users\students\Documents\Tugdual\GitHub\CorticoHippocampal\Ripple_detection');
addpath('E:\Tugdual\GitHub\CorticoHippocampal\Ripple_detection');

%CBD
addpath('C:\Users\students\Documents\Tugdual\GitHub\CBD');

%ADRITOOLS
addpath('C:\Users\students\Documents\Tugdual\GitHub\ADRITOOLS');

% Additionnal package
addpath('C:\Users\students\Documents\Tugdual\GitHub\analysis-tools');

%Data path
data_path = "C:\Users\students\Documents\Swatantra\PFC_all_animals";
data_path_hpc="C:\Users\students\Documents\Swatantra\HPC_all_animals";
%Data saving location
save_path = 'C:\Users\students\Documents\Swatantra\Delta_Detections';


%Select the top channel
ratIDs = [2 3 4 5 9 10 11 201 203 204 205 206 207 209 210 211 212 213 214];  %Rat IDs
channel_ids = [ 37 37 37 37 8 8 8 7 7 7 7 7 7 7 7 7 7 7 7];%superficial channel ids
channel_ids_deep=[60 60 60 60 20 20 20 19 19 19 19 19 19 19 19 19 19 19 19]; % channels in the deep layer
ALIGNtot = [26 19 26 10 277 206 247 54 10 11 10 3 16 9 6 6 5 1 0]; % Time in minutes with respect to rat 214.
Veh = [0 1 1 0 1 0 0 1 1 0 0 1 0 0 1 1 0 1 0];  % Vector logical IDs
Cbd = [Veh == 0];   % Treatment logical IDs

artifact_thr=[3450 4000 5000 4500 4500 4500 4500 5000 5500 5000 5500 5000 6000 4500 4500 4500 4500 4500 4500 ];  % Artifact thresholds per rat provided by Victor

%Load data
% note: HPC data is loaded to look for artifact thresholds

PFC = {};
cd(data_path);  % move to the path where the data is
for i = 1:length(ratIDs)
    clear PFC_tmp
    clear HPC_tmp
    
    %Superficial PFC
    PFC_path = data_path + "\PFC_" + ratIDs(i) + "_CH"+ channel_ids(i) +".continuous.mat";    %channel 5 from end
    PFC_tmp{1} = importdata(PFC_path);

    %Deep PFC
    PFC_path = data_path + "\PFC_" + ratIDs(i) + "_CH"+ channel_ids_deep(i) +".continuous.mat";    %channel 5 from end
    PFC_tmp{2} = importdata(PFC_path);
    cd(data_path_hpc);
    
    %Above
    HPC_path = data_path_hpc + "\HPC_" + ratIDs(i) + "_CH"+ "ab.continuous.mat";    %channel 5 from end
    HPC_tmp{1} = importdata(HPC_path);

    %Pyr
    HPC_path = data_path_hpc + "\HPC_" + ratIDs(i) + "_CH"+ "pyr.continuous.mat";    %channel 5 from end
    HPC_tmp{2} = importdata(HPC_path);
    
    %Below
    HPC_path = data_path_hpc + "\HPC_" + ratIDs(i) + "_CH"+ "bel.continuous.mat";    %channel 5 from end
    HPC_tmp{3} = importdata(HPC_path);
    
  
   %Correct channels' length mismatch
    sz = min(cellfun(@length, [HPC_tmp PFC_tmp]));
    HPC_tmp{1} =HPC_tmp{1}(1:sz);
    HPC_tmp{2} =HPC_tmp{2}(1:sz);
    HPC_tmp{3} =HPC_tmp{3}(1:sz);
    PFC_tmp{1} =PFC_tmp{1}(1:sz);
    PFC_tmp{2} =PFC_tmp{2}(1:sz);
    
    
    TOT=abs(HPC_tmp{1})+abs(HPC_tmp{2})+abs(HPC_tmp{3})+abs(PFC_tmp{1})+abs(PFC_tmp{2});
    L = length(TOT);
    
    %Artifact removal
    tr = artifact_thr(i); %Visual threshold 
    outliers = false(L,1);
    index = 1;
    while index<L
        if TOT(index)>=tr
            if index-300 < 1; lo_lim = 1; else; lo_lim = index-300; end
            if index+1999 > L; hi_lim = L; else; hi_lim = index+1999; end
            sz = length(lo_lim:hi_lim);
            outliers(lo_lim:hi_lim) = ones(sz,1); %When we detect an artifact, remove 300 datapoints prior (build up of artifact) and 2000 datapoints after (3.5 sec)
            index = index+2000;
        else
            index = index +1;
        end
    end

    %Filter out artifacts & replace with the mean of the channels' medians
   PFC_tmp=cell2mat(PFC_tmp);
   PFC_tmp=PFC_tmp(:,1);
   PFC_tmp(outliers,:) = mean(PFC_tmp);    
    
  
  PFC{i} = PFC_tmp((600*60*15):end); % discard first 15 minutes of the data
    cd(data_path);
end
%% II.  Loop through each signal, detect delta and save in a temp variable
%initiate the return values
delta = {};
signal_filt = {};



for i = 1:length(ratIDs)
    
    % filter the signal
    fn=600; % signal frequency
    Wn1=[1/(fn/2) 6/(fn/2)]; % Cutoff=320 Hz
    [a,b] = butter(3,Wn1); %Filter coefficients
    signal_tmp = filtfilt(a,b,PFC{i}); %filtered signal
    signal_filt{i} = [zeros(ALIGNtot(i)*60*600,1)*nan; signal_tmp];  %allignment correction and saving the signal
    
    % Create the timestamp vector
    timevector = (0:length(signal_tmp)-1)/600;% timestamps
    timevector = timevector'; %seconds
    
    % signal for detection, with the timestamps
    signal = [timevector,signal_tmp];
    
     
    % Detect delta
    delta_tmp = FindDeltaWaves(signal,i);
    
    %Alignment correction
    delta_tmp(:,1:3)=delta_tmp(:,1:3)+ALIGNtot(i)*60; % This takes care of the alignment of delta tiestamps
    
    %save delta
    delta{i} = delta_tmp;
    
end

% align the signals wrt the longest signal
maximum = max(cellfun(@length, signal_filt))
for i=1:length(ratIDs)
    
    signal_filt{i} = [signal_filt{i};zeros(maximum-length(signal_filt{i}),1)*nan];  % add nans at the end

end

%% III. Save all the detection in a table
%cd(save_path)
%save("Delta_all_animals_final.mat",'delta')
%% IV. Plot the events to check the quality of detection.
close all
plot(signal(:,1),signal(:,2))
hold on
stem(delta_tmp(:,2),ones(size(delta_tmp(:,2)))*1000)
stem(delta_tmp(:,1),ones(size(delta_tmp(:,1)))*1000)
stem(delta_tmp(:,3),ones(size(delta_tmp(:,3)))*1000)

%% Plotting
% %ratIDs = [2 3 4 5 9 10 11 201 203 204 205 206 207 209 210 211 212 213 214]
% %rat    = [1 2 3 4 5  6  7  8   9   10  11  12  13  14  15  16  17  18  19]
close all
rat=5;

plot((0:length(signal_filt{rat})-1)/600,signal_filt{rat});
hold on

stem(delta{rat}(:,2),ones(size(delta{rat}(:,2)))*1000)
stem(delta{rat}(:,1),ones(size(delta{rat}(:,1)))*1000)
stem(delta{rat}(:,3),ones(size(delta{rat}(:,3)))*1000)
% 
% % xlim([delta{rat}(16,1) delta{rat}(16,3)])


%% Load PCA States Files
% Storing sleep stages from Batch 1

cd('C:\Users\students\Documents\Swatantra\PCA_Scorer_batch_1')
folders=getfolder;
[~,in]=sort(cell2mat(cellfun(@(x)  str2num(x(4:end)) ,folders ,'UniformOutput' ,false)));
folders=folders(in);

STATES = struct([]); %PCA scorer output
for rat=1:length(folders)
    cd(folders{rat})
STATES{rat} =load('states.mat');
STATES{rat} =STATES{rat}.clusters;

cd ..
end
%
% Storing sleep stages from Batch 2

cd('C:\Users\students\Documents\Swatantra\PCA_Scorer_batch_2')
folders=getfolder;
[~,in]=sort(cell2mat(cellfun(@(x)  str2num(x(4:end)) ,folders ,'UniformOutput' ,false)));
folders=folders(in);

for rat=1:length(folders)
    cd(folders{rat})
STATES{rat+7} =load('states.mat');
STATES{rat+7} =STATES{rat+7}.clusters;

cd ..
end


%%  fix the allignment in STATES
%discard first 15 mins and add zeros before
for i=1:length(ratIDs)
    
    STATES{i} = [zeros(1,ALIGNtot(i)*6)  STATES{i}(90:end)];%discard first 15 mins % Each data point in STATES represent 10 Seconds; discard first 15 mins
    
    
end
% add zeros after
maximum2 = max(cellfun(@length, STATES));
for i=1:length(ratIDs)
    
    STATES{i} = [STATES{i} zeros(1,maximum2-length(STATES{i}))];  % add zeros at the end

end


%% Scale States to resolution of seconds (seconds because delta timestamps are in  seconds)

STATES2 = {};
for i=1:length(ratIDs)
    states_10 = STATES{i};
    STATES_tmp = [];
    for j=1:length(states_10)
        
        STATES_tmp = [STATES_tmp (ones(1,10)*states_10(j))];
    end
    STATES2{i} = STATES_tmp;
end

%%  save states
cd(save_path)
save("STATES_sec_aligned.mat",'STATES2') %aligned states file at 600Hz sampling rate
        
%% Plotting

close all
rat=5;

% plot((1:length(signal_filt{rat}))/600,signal_filt{rat});
% hold on
% delta2 = delta{rat}(:,2) + ALIGNtot(rat)*60;
% close all
% rat=16;
% 
plot((1:length(signal_filt{rat}))/600,signal_filt{rat});
hold on
delta2 = delta{rat} + ALIGNtot(rat)*60;
stem(delta2(:,2),ones(size(delta2(:,2)))*1000)
stem(delta2(:,1),ones(size(delta2(:,1)))*1000)
stem(delta2(:,3),ones(size(delta2(:,3)))*1000)


% Bin for only NREM
%%%%% test | doesnt work
% bins_tot = zeros(19,12);
% for i=1:length(ratIDs)
%     bins = bins_tot(i,:);
%     state = STATES2{i};
%     delt = delta{i}(:,2)';
%     for j=1:45*60:45*60*12
%        
%         for k = j-45*60:
%             
%             if state(round(delt(k))) == 2
%             
%                 bins(j)= bins(j) 1;
%                 
%             end
%             
%         end
%         
%     end   
%     
% end
%%%%%%% test | doesnt work

%%
%% save a structrure with the peaks of the delta and the state
delta2 = {}
for i=1:length(ratIDs)
    delt = round(delta{i}(:,2)');
    state =  STATES2{i}(delt);
    delta2{i} = [delta{i}(:,2)'; state];
end
% get delta timestamps for only state 2
delta3 = {}
for i=1:length(ratIDs)
  delt = delta2{i}';
  delta3{i} = delt(delt(:,2)==2);
end
% count in bins
C=[];


for i=1:length(ratIDs)
    
    C(i,:)=histcounts(delta3{i}/60,[0:45:45*11]);
    
end

% BUG ALERT START
%create the matrix with nan for less than a full 45 mins of signal in a bin and
% discard all 
% X = [];
% for i=1:length(ratIDs)
%     x = [];
%     for j=1:45*60*600:45*60*600*11
%         k = j;
%         if sum(is_data{i}(k+1:k+45*60*600-1)) > 5; % 5 for tolerence of possible indexing error 
%              x = [x nan]; 
%         else
%              x = [x 1];
%         end
%       
%     end
%     X(i,:) = x;
% end

X(X==0) = NaN % make it NaN where there's no signal
FINAL = C.*X % get the final results

% BUG ALERT END


%%%%%%%%%%%%%%%%%% New fix of the code; creating the signal in minutes matrix %%%%%%%%%%
%% create the binned signal matrix (minutes)

% check if there is data or not
is_data = {};
for i=1:length(ratIDs)
    is_data{i} = not(isnan(signal_filt{i})); % signal filt is both ends aligned signals
end

% now start the binning process
Signal_binned = [];
for i=1:length(ratIDs)
    x = [];
    for j=1:45*60*600:45*60*600*11 %convert them to the signal frequency
        data_in_minutes = sum(is_data{i}(j:j+45*60*600))/(60*600)
        if round(data_in_minutes) == 45
            x = [x 45];     % replace 45 with 1 if want to create a logical vector
        elseif round(data_in_minutes) == 0
            x = [x nan];
        else
            x = [x round(data_in_minutes,3)]    %the amount of signal in partially filled bins
        end
    end
    Signal_binned(i,:) = x;
end

%% creation of the logical matrix to get the final counts
Signal_binned_logical = [];
your_tolerance = 40; % specify how long of signal you'll still consider for a bin
for i=1:length(ratIDs)
    x = [];
    for j=1:45*60*600:45*60*600*11 %convert them to the signal frequency
        data_in_minutes = sum(is_data{i}(j:j+45*60*600))/(60*600)
        if round(data_in_minutes) == 45
            x = [x 1];     % replace 45 with 1 if want to create a logical vector
        elseif round(data_in_minutes) == your_tolerance
            x = [x 1];
        else
            x = [x nan]    % nans for everything else
        end
    end
    Signal_binned_logical(i,:) = x;
end
%% getting the final counts
% get your matrix with all the counts(11 bins); this case C
% multiply with the logical matrix to get NaNs where you don't want to consider the counts
final_counts = C .* Signal_binned_logical
