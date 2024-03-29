%% Extract
clear all
clc
load('forDelta.mat') % contains signals, signal_indexes, sleep_states, and number of bins (bins_num)

%% Creating time vector

fn = 600; % sampling frequency
time = (0:(size(signals,2)-1))/fn;
% bin boundaries
ratIDs = [2 3 4 5 9 10 11 201 203 204 205 206 207 209 210 211 212 213 214];  %Rat IDs
Veh = [0 1 1 0 1 0 0 1 1 0 0 1 0 0 1 1 0 1 0];  % Vector logical IDs

bin_sz = fn*(60*45); % sampling frequency*(bin duration in seconds)
i=1;t=0; % Initialisation

while i~=12
    binB{i,1} = t;
    t = t+bin_sz;
    binB{i,2} = t;
    i = i+1;
end
binBound = (cell2mat(binB))/fn; % boundary of each bin

%% Delta

load('delta3.mat')
load('delta3_d.mat')
%% Splitting the data into vehicle and CBD--delta

clear d_v d_c

% Intialisation
i_v = 1; % for vehicle
i_c = 1; % for CBD

% To get traces of Delta events
for i = 1:length(Veh)
    tmp = find(sleep_states(i,:)==2); % NREM periods
    
    % if-loop to segregate Vehicle/CBD rat data
    if Veh(i)==1
        for j = 1:length(delta3{1,i})
            t1 = delta3{1,i}(j,1); % Delta event's start time
            tp1=find(time(:)>=t1); % Index corresponding to start time of event
            t2 = delta3{1,i}(j,3); % Delta event's end time
            tp2=find(time(:)>=t2); % Index corresponding to end time of event
            d_v{i_v} = signals(i,tp1(1):tp2(1)); % Extracting event trace
            i_v = i_v+1; % Count increment
            clear tp1 tp2 t1 t2
        end
    elseif Veh(i)==0
        for j = 1:length(delta3{1,i})
            t1 = delta3{1,i}(j,1);
            tp1=find(time(:)>=t1);
            t2 = delta3{1,i}(j,3);
            tp2=find(time(:)>=t2);
            d_c{i_c} = signals(i,tp1(1):tp2(1));
            i_c = i_c+1;
            clear tp1 tp2 t1 t2
        end
    end
end


%% Plotting delta events trace charateristics

figure
[xd,yd,zd,~,~,qd,ld,pd,~,~,~,...
    xcd,ycd,zcd,~,~,qcd,lcd,pcd,~]...
    =specsHist(d_v,d_c,0,1);
%% Plotting a figure for each charateristics of traces of events
for k=0:5
    figure;
    for i=1:19
        i_c=1;jk={};
        for j = 1:length(delta3{1,i})
            t1 = delta3{1,i}(j,1);
            tp1=find(time(:)>=t1);
            t2 = delta3{1,i}(j,3);
            tp2=find(time(:)>=t2);
            jk{i_c} = signals(i,tp1(1):tp2(1));
            i_c = i_c+1;
            clear tp1 tp2
        end
        subplot(5,4,i)
        [xx,xy,xz,~,~,xq,xl,xp,~,~,~]= eachSpecs_hist(jk,0,k);
        legend(num2str(ratIDs(i)))
        ylabel('Fraction of count')
    end
end
%% Exporting data regarding delta event trace charateristics to excel
fxd={};
fxd{1} = xd';
fxd{2} = yd';
fxd{3} = zd';
fxd{4} = ld';
fxd{5} = qd';
fxd{6} = pd';
fxd{7} = xcd';
fxd{8} = ycd';
fxd{9} = zcd';
fxd{10} = lcd';
fxd{11} = qcd';
fxd{12} = pcd';

% To make a uniform data array
maximum = max(cellfun(@length, fxd));
for i=1:12
    fxd{i} = [fxd{i};zeros(maximum-length(fxd{i}),1)*nan];  % add nans at the end
end

TT=table(fxd{1},fxd{2},fxd{3},fxd{4},fxd{5},fxd{6},...
    fxd{7},fxd{8},fxd{9},fxd{10},fxd{11},fxd{12});
TT.Properties.VariableNames={'Instantaneous Frequencies (Veh)','Average Frequencies (Veh)',...
    'Amplitude (\muV) (Veh)','Area under the curve (Veh)','Duration(ms) (Veh)',...
    'Peak-to-peak amplitude (\muV) (Veh)',...
    'Instantaneous Frequencies (CBD)','Average Frequencies (CBD)',...
    'Amplitude(\muV) (CBD)','Area under the curve (CBD)','Duration(ms) (CBD)'...
    'Peak-to-peak amplitude(\muV) (CBD)'};
writetable(TT,'DeltaChara.xls','Sheet',1)

%% Spindles
load('forSpindles.mat') % contains signals, signal_indexes, sleep_states, and number of bins (bins_num)
load('spindle.mat')
load('s_S.mat')
% Splitting the data into vehicle and CBD--Spindles
clear s_c s_v

% Intialisation
i_v = 1;
i_c = 1;

% To get traces of spindle events
for i = 1:length(Veh)
    % if-loop to segregate Vehicle/CBD rat data
    if Veh(i)==1
        for j = 1:length(spindle{1,i})
            t1 = spindle{1,i}(j,1); % Spindle event's start time
            tp1=find(time(:)>=t1); % Index corresponding to start time of event
            t2 = spindle{1,i}(j,3); % Spindle event's end time
            tp2=find(time(:)>=t2); % Index corresponding to start time of event
            s_v{i_v} = signals(i,tp1(1):tp2(1)); % Extracting event trace
            i_v = i_v+1; % Count increment
            clear tp1 tp2 t1 t2
        end
    else
        for j = 1:length(spindle{1,i})
            t1 = spindle{1,i}(j,1);
            tp1=find(time(:)>=t1);
            t2 = spindle{1,i}(j,3);
            tp2=find(time(:)>=t2);
            s_c{i_c} = signals(i,tp1(1):tp2(1));
            i_c = i_c+1;
            clear tp1 tp2 t1 t2
        end
    end
end
%% Count of spindle events per bin

C_s = zeros(length(ratIDs),size(binBound,1)); % Intialisation
for i=1:length(ratIDs)
    for j=1:length(binBound)
        for k=1:length(s_S{i})
            if (s_S{i}(k,1)>binBound(j,1))&&(s_S{i}(k,3)<binBound(j,2))
                C_s(i,j)=1+C_s(i,j);
            elseif s_S{i}(k,3)>binBound(j,2)
                % To end the for-loop whe nthe event is at the
                % corresponding bin's boundary
                k=length(s_S{i});
            end
        end
        % To count spindle events in each time bin
        if ((binB{j,1}+bin_sz)<signals_indexes(i,1))||(binB{j,2}>signals_indexes(i,2))
            C_s(i,j)=nan;
        else
            sp_s = sleep_states(i,binB{j,1}+1:binB{j,2});
            tmp = (sp_s==2);
            if (sum(tmp)~=0)&&(C_s(i,j)==0)
                C_s(i,j)=0;
            end
            clear sp_s tmp
        end
    end
end


%% Exporting to excel the spindle event counts for each 45-min bin
TT=table(num2cell(ratIDs'),C_s(:,1),C_s(:,2),C_s(:,3),C_s(:,4),C_s(:,5),C_s(:,6),...
    C_s(:,7),C_s(:,8),C_s(:,9),C_s(:,10),C_s(:,11));
TT.Properties.VariableNames={'Rat ID','Bin 1','Bin 2','Bin 3',...
    'Bin 4','Bin 5','Bin 6','Bin 7','Bin 8',...
    'Bin 9','Bin 10','Bin 11'};
writetable(TT,'SpindleCount_split.xls','Sheet',1)


%% Plotting spindle events trace charateristics
figure
[x,y,z,~,~,q,l,p,~,~,~,...
    xc,yc,zc,~,~,qc,lc,pc,~]=specsHist(s_v,s_c,0,1);

%% Exporting data regarding spindle event trace charateristics to excel
fx{1} = x';
fx{2} = y';
fx{3} = z';
fx{4} = l';
fx{5} = q';
fx{6} = p';
fx{7} = xc';
fx{8} = yc';
fx{9} = zc';
fx{10} = lc';
fx{11} = qc';
fx{12} = pc';

% To make a uniform data array
maximum = max(cellfun(@length, fx));
for i=1:12
    fx{i} = [fx{i};zeros(maximum-length(fx{i}),1)*nan];  % add nans at the end
end
%
TT=table(fx{1},fx{2},fx{3},fx{4},fx{5},fx{6},...
    fx{7},fx{8},fx{9},fx{10},fx{11},fx{12});
TT.Properties.VariableNames={'Instantaneous Frequencies (Veh)','Average Frequencies (Veh)',...
    'Amplitude (\muV) (Veh)','Area under the curve (Veh)','Duration(ms) (Veh)',...
    'Peak-to-peak amplitude (\muV) (Veh)',...
    'Instantaneous Frequencies (CBD)','Average Frequencies (CBD)',...
    'Amplitude(\muV) (CBD)','Area under the curve (CBD)','Duration(ms) (CBD)'...
    'Peak-to-peak amplitude(\muV) (CBD)'};
writetable(TT,'SpindleChara.xls','Sheet',1)

%% Plot

% i=14;
% figure
% hold on
% plot(time,signals(i,:))
% s_t = ones(length(spindle{i}(:,2)),1)*(max(signals(i,:))*2);
% stem(spindle{i}(:,2),s_t)
% stem(spindle{i}(:,1),s_t)
% stem(spindle{i}(:,3),s_t)
% xlabel('time (in s)')
% ylabel('a.u.')
% legend('Filtered Signal', 'Spindle peak time','Start','Stop')
% title(['Spindles for Rat:',num2str(i),' (MaxPeak=',num2str(cfg.x),', MinPeak = ',num2str(cfg.n),', No. of spindles = ',num2str(length(spindle{i}(:,1))),')'])
% hold off
% x0=8;
% y0=15;
% width=5490;
% height=3900;
% set(gcf,'position',[x0,y0,width,height])
% clear val loc
% ylim([-300 500])
% xlim([11182 11188])
% xlim([4576 4582])
% xlim([11032 11046.5])
% xlim([11182 11188])
% xlim([16678 16681])
% xlim([3242 3263.5])
% xlim([3242 3246])


%% rat-wise chara data

% for k=0:5
% figure;
% for i=1:19
% i_r=1;jk={};
% for j = 1:length(spindle{1,i})
% t1 = spindle{1,i}(j,1);
% tp1=find(time(:)>=t1);
% t2 = spindle{1,i}(j,3);
% tp2=find(time(:)>=t2);
% jk{i_r} = signals(i,tp1(1):tp2(1));
% i_r = i_r+1;
% clear tp1 tp2
% end
% subplot(5,4,i)
% [xx,xy,xz,~,~,xq,xl,xp,~,~,~]= eachSpecs_hist(jk,0,k);
% legend(num2str(i))
% end
% end
