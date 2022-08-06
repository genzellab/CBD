%% Delta

load('forDelta.mat') % contains signals, signal_indexes, sleep_states, and number of bins (bins_num)
time = (0:(size(signals,2)-1))/fn;
ratIDs = [2 3 4 5 9 10 11 201 203 204 205 206 207 209 210 211 212 213 214];  %Rat IDs

% Defining bins
bin_sz = fn*(60*45); % sampling frequency*(bin duration in seconds)
i=1;t=0; % Initialisation

while i~=12
    binB{i,1} = t;
    t = t+bin_sz;
    binB{i,2} = t;
    i = i+1;
end

% Detecting delta events during 5th to 9th time-bin
for i = 1:size(signals,1)
    % Identifying the earliest non-nan time stamp for recorded data in
    % corresponding time-bin
    if ((binB{5,1}+1)<=signals_indexes(i,1))
        begin = signals_indexes(i,1);
    else
        begin = (binB{5,1}+1);
    end
    
    % Identifying the last non-nan time stamp for recorded data in
    % corresponding time-bin
    % (here, the data until the 9th bin was only considered)
    if (binB{9,2}>=signals_indexes(i,2))
        close = signals_indexes(i,2);
    else
        close = binB{9,2};
    end
    
    
    signal = signals(i,begin:close);% Extracting the signal from which
    % delta event detections are to be made
    
    tmpTime = time(begin:close);    % Extracting corresponding time-stamps
    
    signal = [tmpTime', signal'];   % Preparing input for detection
    
    delta{i} = FindDeltaWaves(signal,i);
    
    clear signal tmpTime
end

% Identifying all Delta events
for i = 1:size(signals,1)
    begin = signals_indexes(i,1);
    close = signals_indexes(i,2);
    signal = signals(i,begin:close);%
    tmpTime = time(begin:close);%
    signal = [tmpTime', signal'];
    delta_d{i} = FindDeltaWaves(signal,i);
    clear signal tmpTime
end

%% Plot for comparing number of delta events in time-bins 5 to 9 to
% total number of delta event detections

sz_d = cellfun(@(x) size(x,1),delta,'UniformOutput',false);
sz_dd = cellfun(@(x) size(x,1),delta_d,'UniformOutput',false);
figure;
hold on;
plot(cell2mat(sz_d))
plot(cell2mat(sz_dd))
hold off
legend('Bin 5 to 9','All')
%% Identifying delta events that occur during NREM states

% For delta event detection during time bins 5 to 9

delta2 = {};
for i=1:length(ratIDs)
    delt = round(delta{i}(:,2)');
    sleep_state = sleep_states(i,:);
    state =  sleep_state(delt*fn)';
    delta2{i} = [delta{i}, state];
end

% To get delta timestamps for only state 2 (corresponding to NREM)
delta3 = {};
for i= 1:length(ratIDs)
    delt = delta2{i};
    delta3{i} = delt(delt(:,7)==2,1:6);
end

% For delta event detections for all time bins
delta2_d = {};
for i=1:length(ratIDs)
    delt_d = round(delta_d{i}(:,2)');
    sleep_state = sleep_states(i,:);
    state =  sleep_state(delt_d*fn)';
    delta2_d{i} = [delta_d{i}, state];
end

% To get delta timestamps for only state 2 (NREM)
delta3_d = {};
for i= 1:length(ratIDs)
    delt_d = delta2_d{i};
    delta3_d{i} = delt_d(delt_d(:,7)==2,1:6);
end

save('delta3.mat','delta3')
save('delta3_d.mat','delta3_d')

%% Count of delta events per bin

C = zeros(length(ratIDs),size(binBound,1)); % Intialisation
for i=1:length(ratIDs)
    for j=1:length(binBound)
        for k=1:length(delta3_d{i})
            % delta count
            if (delta3_d{i}(k,1)>binBound(j,1))&&(delta3_d{i}(k,3)<binBound(j,2))
                C(i,j)=1+C(i,j);
            elseif delta3_d{i}(k,3)>binBound(j,2)
                % To end the for-loop whe nthe event is at the
                % corresponding bin's boundary
                k=length(delta3_d{i});
            end
        end
        
        % To count delta events in each time bin
        if ((binB{j,1}+bin_sz)<signals_indexes(i,1))||(binB{j,2}>signals_indexes(i,2))
            C(i,j)=nan;
        else
            sp_s = sleep_states(i,binB{j,1}+1:binB{j,2});
            tmp = (sp_s==2);
            if (sum(tmp)~=0)&&(C(i,j)==0)
                C(i,j)=0;
            end
            clear sp_s tmp
        end
    end
end
%% Exporting to excel the delta event counts for each 45-min bin
TT=table(num2cell(ratIDs'),C(:,1),C(:,2),C(:,3),C(:,4),C(:,5),C(:,6),...
    C(:,7),C(:,8),C(:,9),C(:,10),C(:,11));
TT.Properties.VariableNames={'Rat ID','Bin 1','Bin 2','Bin 3',...
    'Bin 4','Bin 5','Bin 6','Bin 7','Bin 8',...
    'Bin 9','Bin 10','Bin 11'};
writetable(TT,'DeltaCount_split.xls','Sheet',1)



%% Spindles
load('forSpindles.mat') % contains signals, signal_indexes, sleep_states, and number of bins (bins_num)

cfg.x=8; % max peak
cfg.n= 3; % min peak
spindle={};

% Detecting spindle events during 5th to 9th time-bin
for i = 1:size(signals,1)
    % Identifying the earliest non-nan time stamp for recorded data in
    % corresponding time-bin
    if ((binB{5,1}+1)<=signals_indexes(i,1))
        begin = signals_indexes(i,1);
    else
        begin = (binB{5,1}+1);
    end
    
    % Identifying the last non-nan time stamp for recorded data in
    % corresponding time-bin
    % (here, the data until the 9th bin was only considered)
    if (binB{9,2}>=signals_indexes(i,2))
        close = signals_indexes(i,2);
    else
        close = binB{9,2};
    end
    
    % Detecting spindle events during NREM
    ss = sleep_states(i,begin:close);
    tmp = (ss==2);
    signal = signals(i,begin:close);
    signal = signal(tmp);
    tmpT = time(begin:close);
    tmpTime = tmpT(tmp);
    signal = [tmpTime', signal'];
    spindle{i} = FindSpindles(cfg,signal);
    clear signal tmpTime
end

% Identifying all spindle events
s_S={};
for i = 1:size(signals,1)
    begin = signals_indexes(i,1);
    close = signals_indexes(i,2);
    ss = sleep_states(i,begin:close);
    tmp = (ss==2);
    signal = signals(i,begin:close);
    signal = signal(tmp);
    tmpT = time(begin:close);
    tmpTime = tmpT(tmp);
    signal = [tmpTime', signal'];
    s_S{i} = FindSpindles(cfg,signal);
    clear signal tmpTime
end

save('spindle.mat','spindle')
save('s_S.mat','s_S')
%% Plot for comparing number of spindle events in time-bins 5 to 9 to
% total number of spindle event detections

sz_s = cellfun(@(x) size(x,1),spindle,'UniformOutput',false);
sz_ss = cellfun(@(x) size(x,1),s_S,'UniformOutput',false);
figure;
hold on;
plot(cell2mat(sz_s))
plot(cell2mat(sz_ss))
hold off
legend('Bin 5 to 9','All')

%% NREM duration computation

% Intialisation
nrem=zeros(19,size(binB,1));
rec=zeros(19,size(binB,1));
p_rec=zeros(19,size(binB,1));

for i=1:length(ratIDs)
    for j = 1:length(binBound)
        sp_s = sleep_states(i,binB{j,1}+1:binB{j,2}); % sleep states during
        % each time-bin
        
        nrem(i,j) = sum(sp_s==2)/fn;                  % amount of NREM
        
        rec(i,j) = sum(not(isnan(sp_s)))/fn;          % recording duration
        
        p_rec(i,j) = sum(not(isnan(sp_s)))/(bin_sz);  % recording duration
        % in each time-bin
    end
end

%% Plotting amount of NREM in each time-bin
figure
hold on
for i=1:length(ratIDs)
    subplot(5,4,i)
    bar(1:1:length(binBound),nrem(i,:))
    title(['Rat ID:',num2str(ratIDs(i))])
    if i>=16
        xlabel('Bin Number')
    end
    if rem(i+3,4)==0
        ylabel('Time in seconds')
    end
    ylim([0 max(max(nrem))])
end
hold off
%% Plotting fraction of recording duration in each time-bin
figure
hold on
for i=1:length(ratIDs)
    subplot(5,4,i)
    bar(1:1:length(binBound),p_rec(i,:))
    title(['Rat ID:',num2str(ratIDs(i))])
    if i>=16
        xlabel('Bin Number')
    end
    if i==9
        ylabel('Fraction of bin-time with recording')
    end
    ylim([0 max(max(p_rec))])
end
hold off

%% Exporting to excel data regarding time-bins & NREM bouts duration
TT=table(num2cell(ratIDs'),nrem(:,1),nrem(:,2),nrem(:,3),nrem(:,4),nrem(:,5),nrem(:,6),...
    nrem(:,7),nrem(:,8),nrem(:,9),nrem(:,10),nrem(:,11));
TT.Properties.VariableNames={'Rat ID','Bin 1','Bin 2','Bin 3',...
    'Bin 4','Bin 5','Bin 6','Bin 7','Bin 8',...
    'Bin 9','Bin 10','Bin 11'};
writetable(TT,'NREM_split.xls','Sheet',1)
%% Excel with tine bins recording duration
TT=table(num2cell(ratIDs'),rec(:,1),rec(:,2),rec(:,3),rec(:,4),rec(:,5),rec(:,6),...
    rec(:,7),rec(:,8),rec(:,9),rec(:,10),rec(:,11));
TT.Properties.VariableNames={'Rat ID','Bin 1','Bin 2','Bin 3',...
    'Bin 4','Bin 5','Bin 6','Bin 7','Bin 8',...
    'Bin 9','Bin 10','Bin 11'};
writetable(TT,'Recording_duration.xls','Sheet',1)
