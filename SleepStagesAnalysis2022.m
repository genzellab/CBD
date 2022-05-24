% Script for the analysis of the sleep stages for the CBD project
clear
clc
%Fieldtrip
addpath('C:\Users\students\Documents\Tugdual\GitHub\fieldtrip');

%CorticoHippocampal
addpath('C:\Users\students\Documents\Tugdual\GitHub\CorticoHippocampal');
addpath('C:\Users\students\Documents\Tugdual\GitHub\CorticoHippocampal\Ripple_detection');
addpath('E:\Tugdual\GitHub\CorticoHippocampal\Ripple_detection')

%CBD
addpath('C:\Users\students\Documents\Tugdual\GitHub\CBD');

%ADRITOOLS
addpath('C:\Users\students\Documents\Tugdual\GitHub\ADRITOOLS');

 
% Additionnal package
addpath('C:\Users\students\Documents\Tugdual\GitHub\bluewhitered'); %Actually I'm not using this one here, it's for a blue/red colormap
addpath('C:\Users\students\Documents\Tugdual\GitHub\analysis-tools');


%% LOAD
%Loading all the data for the CBD project and preprocessing it (low pass and downsampling). 
%For each animal, loading the selected channels (HPC-pyramidal layer, HPC-below pyramidal layer, PFC)
%and the output from the PCA scorer, which is a vector of 1 (REM) and 2
%(NREM). 

%Parameters
ds_fhz = 600;

%% Storing sleep stages from Batch 1

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
%%
%% Storing sleep stages from Batch 2

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


%% Storing data HPC
cd('E:\rat\cannabis\HPC_all_animals')
ratID=[2 3 4 5 9 10 11 201 203 204 205 206 207 209 210 211 212 213 214];

for rat=1:length(ratID)
HPC{rat} = load(['HPC_' num2str(ratID(rat)) '_CHpyr.continuous.mat']);
HPC{rat} =HPC{rat}.HPC1 ;

BPL{rat} = load(['HPC_' num2str(ratID(rat)) '_CHbel.continuous.mat']);
BPL{rat} =BPL{rat}.HPC3 ;

APL{rat} = load(['HPC_' num2str(ratID(rat)) '_CHab.continuous.mat']);
APL{rat} =APL{rat}.HPC2 ;

end

%%
%% Storing data PFC
cd('E:\rat\cannabis\PFC_all_animals')
PFC_shallow_channels=[ones(1,4)*37 ones(1,3)*8 ones(1,12)*7 ];

for rat=1:length(ratID)
% HPC{rat} = load(['HPC_' num2str(ratID(rat)) '_CHpyr.continuous.mat']);
% BPL{rat} = load(['HPC_' num2str(ratID(rat)) '_CHbel.continuous.mat']);
PFC{rat} = load(['PFC_' num2str(ratID(rat)) '_CH' num2str(PFC_shallow_channels(rat)) '.continuous.mat']);
PFC{rat} =PFC{rat}.PFC1;    
end




% type, ie vehicle (0) or cbd (1)
type = [1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1]; 
nrats = length(type); %number of animals
ncbd = sum(type==1); %number of cbd animals
nveh = sum(type==0); %number of veh animals

% Correct rat 3 and 213, PCA gave a 3rd cluster, which we set to REM or
% NREM

% sta3 = STATES{2};
% sta213 = STATES{18};
% sta3(sta3==3) = 1;
% sta213(sta213==3) = 2;
% STATES{2} = sta3;
% STATES{18} = sta213;
%% Remove first 15min and alignment
%We remove the first 15 minutes of the recording because of tissue
%relaxation following probe insertion
%we know that 600 datapoints = 1 second for the HPC/PFC/BPL, and for the hypnogram,
%1 datapoint = 10sec

for ii=1:length(HPC)
    tmphpc = HPC{ii};
    tmppfc = PFC{ii};
    tmpbpl = BPL{ii};
    HPC{ii} = tmphpc((600*60*15):end);
    PFC{ii} = tmppfc((600*60*15):end);
    BPL{ii} = tmpbpl((600*60*15):end);
    tmpstates = STATES{ii};
    STATES{ii} = tmpstates((6*15):end);
end



% ALIGNMENT ON FEEDING TIME

%We want to align the data not on the beginning of the recording, but on
%the time since the CBD/VEH was administered. The rat 214 from Batch 2 is
%the one for which the recording started the sooner after injection of
%CBD/VEH. For each rat we store the relative difference in time (minutes)
%injection-recording with rat 214

ALIGNtot = [26 19 26 10 277 206 247 54 10 11 10 3 16 9 6 6 5 1 0];
%So for example, for the first animal, rat 2 batch 1, it took 26 more
%minutes for the surgery than it did for rat 214 (last animal)

VEH = struct([]);
CBD = struct([]);
%index_cbd = [1 4 6 7 10 11 13 14 17 19]; % B1 rats 2 5 10 11, B2 rats 204 205 207 209 212 214
index_cbd=find(type==1);
%index_veh = [2 3 5 8 9 12 15 16 18]; % B1 rats 3 4 9, B2 rats 201 203 206 210 211 213
index_veh=find(type==0);
% Here we just split states between CBD and VEH
for ii = 1:length(index_cbd)
    CBD{ii} = STATES{index_cbd(ii)};
end
for ii = 1:length(index_veh)
    VEH{ii} = STATES{index_veh(ii)};
end

%We are going to align by adding NaNs to our states so as to get the same
%amount of data in each recording. 
%We already know how much to add at the beginning to align on the feeding
%Now we search for the longest recording, i.e. the animal whose recording
%ended the latest after feeding
max_rec = 0; 
for ii = 1:length(STATES)
    tmp = max_rec;
    max_rec = max(max_rec, ALIGNtot(ii)*6 + length(STATES{ii}));   %STATES in 10s epochs, ALIGNtot in minutes, hence the *6
    if tmp ~= max_rec
        index_rec = ii;
    end
end
% Now we have the "longest recording" (in 10s epoch) and the index of this
% recording

%Now we can store our aligned data in matrices
cbd_align = [];
veh_align = [];
for ii = 1:length(CBD)
    beforecbd = ALIGNtot(index_cbd(ii))*6; %*6 because in the ALIGN vector, the time is in minutes, and in the state vector, each data is 10 sec of recording
    aftercbd = max_rec - (length(CBD{ii}) + beforecbd);
    cbd_align = [cbd_align ; NaN(1,beforecbd) CBD{ii} NaN(1,aftercbd)];
end
for ii = 1:length(VEH)
    beforeveh = ALIGNtot(index_veh(ii))*6;
    afterveh = max_rec - (length(VEH{ii}) + beforeveh);
    veh_align = [veh_align ; NaN(1,beforeveh) VEH{ii} NaN(1,afterveh)];
end

% A few notable durations that will be usefull afterward
time_start = duration(1,34,0,0, 'Format', 'hh:mm:ss.SSS'); %Time after feeding, correspond to the start of the alignment, so time after feeding for rat 214
time_end = time_start + duration(0,0,max_rec*6000/600,0, 'Format', 'hh:mm:ss.SSS');
%% LOAD ALL DATA
cd('C:\Users\students\Documents\Swatantra')
load('SleepStagesAnalysis_data.mat')

%% Plot stages
% Plot all the scored stages from the scorer. No alignment here, so each
% recording has a different duration
titles = {'Rat 2 CBD', 'Rat 3 VEH', 'Rat 4 VEH', 'Rat 5 CBD', 'Rat 9 VEH', 'Rat 10 CBD', 'Rat 11 CBD', 'Rat 201 VEH', 'Rat 203 VEH', 'Rat 204 CBD', 'Rat 205 CBD', 'Rat 206 VEH', 'Rat 207 CBD', 'Rat 209 CBD', 'Rat 210 VEH', 'Rat 211 VEH', 'Rat 212 CBD', 'Rat 213 VEH', 'Rat 214 CBD'};
reorder = [1 2 4 3 6 5 7 8 10 9 11 12 13 15 14 16 17 18 19]; % Reorder to have CBD on one side, VEH on the other side

figure
t = tiledlayout(10,2);
for ii = 1:nrats
    t1 = nexttile;
    clusters = STATES{reorder(ii)};
     plot(linspace(duration([0 0 0]), duration([0 0 length(HPC{ii})/600]),length(clusters)), mean(clusters)) %This is a trick: because we plot the stages as an image, using imagesc, we cannot have a time axis, so we plot a random recording of the right duration, and plot the image on top of it
     hold on
     statesmat = zeros(5, length(clusters));
     statesmat(4,:) = clusters .* (clusters == 1); %REM
     statesmat(2,:) = clusters .* (clusters == 2); %NREM
     timerange = [duration([0 0 0]) duration([0 0 length(HPC{ii})/600])];
     imagesc(datenum(timerange), [1 5], statesmat);
     set(gca, 'YTick', [2 4], 'YTickLabel', [{'NREM'}, {'REM'}])
     if length(unique(clusters)) == 3
        colormap(t1, [1.0000    0.99    0.95; 0 0.5 1; 0.3 1 0.2; 1 0.2 0.2]);
     else
         colormap(t1, [1.0000    0.99    0.95; 0 0.5 1; 0.3 1 0.2]);
     end
     title(titles(reorder(ii)))
    

end
title(t, 'PCA scored stages')

%% Stages proportion
%Proportion of REM/NREM in each animal
proportions = [];
for ii = 1:length(STATES)
    rems = sum(STATES{ii} == 1);
    nrems = sum(STATES{ii} == 2);
    proportions = [proportions ; [rems nrems]/length(STATES{ii})];
end

figure

X = categorical({'Rat 2 CBD', 'Rat 3 VEH', 'Rat 4 VEH', 'Rat 5 CBD', 'Rat 9 VEH', 'Rat 10 CBD', 'Rat 11 CBD', 'Rat 201 VEH', 'Rat 203 VEH', 'Rat 204 CBD', 'Rat 205 CBD', 'Rat 206 VEH', 'Rat 207 CBD', 'Rat 209 CBD', 'Rat 210 VEH', 'Rat 211 VEH', 'Rat 212 CBD', 'Rat 213 VEH', 'Rat 214 CBD'});
X = reordercats(X, {'Rat 2 CBD',  'Rat 5 CBD',  'Rat 10 CBD', 'Rat 11 CBD', 'Rat 204 CBD','Rat 205 CBD','Rat 207 CBD', 'Rat 209 CBD', 'Rat 212 CBD','Rat 214 CBD', 'Rat 3 VEH', 'Rat 4 VEH','Rat 9 VEH', 'Rat 201 VEH', 'Rat 203 VEH',  'Rat 206 VEH', 'Rat 210 VEH', 'Rat 211 VEH', 'Rat 213 VEH'});
b = bar(X, proportions, 'stacked', 'FaceColor','flat')
title('Proportion of the different stages')
%Change color to match hypnograms
b(1).CData = [0 0.5 1];
b(2).CData = [0.3 1 0.2];
legend('REM', 'NREM')

% Few stats, mean proportion of REM/NREM in both groups, with STD
prop_rem_cbd = mean(proportions(index_cbd,1))*100;
std_rem_cbd = std(proportions(index_cbd,1))*100;
prop_nrem_cbd = mean(proportions(index_cbd,2))*100;
std_nrem_cbd = std(proportions(index_cbd,2))*100;
prop_rem_veh = mean(proportions(index_veh,1))*100;
std_rem_veh = std(proportions(index_veh,1))*100;
prop_nrem_veh = mean(proportions(index_veh,2))*100;
std_nrem_veh = std(proportions(index_veh,2))*100;

%% Stages proportions in bins
timesize = 45; %minutes
binsize = 6*timesize; 
%% REM amount

% So basically what we do, and we will do this for every feature almost
% We split the time in bins of 45 minutes: we have a given number of bins
% For each bin, we look at the portion of the aligned data, and compute the mean and sem of the studied parameter (here amount of REM)
% The only thing to keep in mind is that, because of alignment, some
% animals don't have any data in the first few bins (or in the last ones),
% so we have to adapt the MEAN and SEM to the number of rats THAT HAVE DATA
% IN THE CURRENT BIN

% Average + SEM for both groups

anova_mat_rem = [];
N_bins = floor(size(cbd_align,2)/binsize);
average_cbd = [];
average_veh = [];
sem_cbd = [];
sem_veh = [];
N = []; 
N1=[];
N2=[];
SUM1=[];
SUM2=[];
C=[];
for kk = 1:(N_bins-1) % We remove the last bin, because too few animals have data is this one
    %first we take only the data corresponding the the current bin
    tmpcbd = cbd_align(:,(binsize*(kk-1)+1):kk*binsize);
    tmpveh = veh_align(:,(binsize*(kk-1)+1):kk*binsize);
    % Now we look at which animals have data in this bin (basically, if an
    % animal has no data, he'll only have NaNs)
    n1 = sum(~isnan(tmpcbd),2);
    n1 = n1~=0;
    n2 = sum(~isnan(tmpveh),2);
    n2 = n2~=0;
    N1(:,kk)=n1;
    N2(:,kk)=n2;
    
    % We sum the duration of REM for cbd and veh animals
    sum1 = sum((tmpcbd==1),2)*10; %*10 to make it in seconds
    sum2 = sum((tmpveh==1),2)*10;
    
    SUM1(:,kk)=sum1;
    SUM2(:,kk)=sum2;

    C(:,2*kk-1:kk*2) = [sum1 n1];
    % We compute mean and sem over the rats that have data in the bin
    average_cbd(kk) = mean(sum1(n1,:));
    average_veh(kk) = mean(sum2(n2,:));
    sem_cbd(kk) = std(sum1(n1,:))/sqrt(sum(n1));
    sem_veh(kk) = std(sum2(n2,:))/sqrt(sum(n2));
    
    SUM = [sum1 ; sum2];
    anova_mat_rem = [anova_mat_rem SUM]; % Matrix we use to run the RANOVA
    N = [N [n1;n2]];
end
N = N==1; % Turn into a logical array. This matrix has as a row per animal, and a column per bin. N(i,j) = 1 if the i-th rat has data in the j-th bin, 0 else

    

%t-test with averaged over whole time
% First normalize
anova_mat_rem2 = normalize_matrix(anova_mat_rem,N);
for ii = 1:size(anova_mat_rem,1)
    tmp = anova_mat_rem2(ii,:);
    n = N(ii,:);
    ttest_rem(ii) = mean(tmp(n));
end
[H_rem,P_rem,CI_rem,STATS_rem] = ttest2(ttest_rem(1:10), ttest_rem(11:19));


% ANOVA
drug = {'CBD','CBD','CBD','CBD','CBD','CBD','CBD','CBD','CBD','CBD','VEH','VEH','VEH','VEH','VEH','VEH','VEH','VEH','VEH'}';

% Test 1 is: we keep all bins, and replace NaNs by the bin's average
test1 = anova_mat_rem;
test1(~N) = NaN;
for ii = 1:size(test1,2)
    tmp = test1(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test1(:,ii) = tmp;
end
t_rem = table(drug, test1(:,1), test1(:,2), test1(:,3), test1(:,4), test1(:,5), test1(:,6), test1(:,7), test1(:,8), test1(:,9), test1(:,10),...
    'VariableNames', {'drug', 'bin1','bin2','bin3', 'bin4', 'bin5', 'bin6', 'bin7', 'bin8', 'bin9', 'bin10'});
Bins = table([1:10]', 'VariableNames', {'Time'});

rm_rem = fitrm(t_rem, 'bin1-bin10~drug', 'WithinDesign', Bins); % Fit a repeated measures model
tbl_rem = mauchly(rm_rem);  % Sphericity test, which is assumption of RANOVA
ranovatbl_rem = ranova(rm_rem);  %RANOVA for effect of time and drug x Time
anovatbl_rem = anova(rm_rem);  % ANOVA for effect of drug alone

% Test 2 is: we only keep bins that are full (or let's say almost full = 1 NaN per bin max)
test2 = anova_mat_rem;
test2(~N) = NaN;
test2 = test2(:,6:9);
for ii = 1:size(test2,2)
    tmp = test2(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test2(:,ii) = tmp;
end

t_rem2 = table(drug, test2(:,1), test2(:,2), test2(:,3), test2(:,4),...
    'VariableNames', {'drug','bin6', 'bin7', 'bin8', 'bin9'});
Bins2 = table([1:4]', 'VariableNames', {'Time'});

rm_rem2 = fitrm(t_rem2, 'bin6-bin9~drug', 'WithinDesign', Bins2);
tbl_rem2 = mauchly(rm_rem2);
ranovatbl_rem2 = ranova(rm_rem2);
anovatbl_rem2 = anova(rm_rem2);


% PLOT
figure
tiledlayout(1,5)
t1 = nexttile([1 4]);
curve1 = average_cbd + sem_cbd;
curve2 = average_cbd - sem_cbd;
curve3 = average_veh + sem_veh;
curve4 = average_veh - sem_veh;
plot(linspace(time_start, time_end - duration([0 45 0]),(N_bins-1)), average_cbd, '-', 'color',[0.4667    0.7804    0.3529], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),(N_bins-1)), curve1, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),(N_bins-1)), curve2, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),(N_bins-1)), average_veh, '-', 'color', [0.5020    0.5020    0.5020], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),(N_bins-1)), curve3, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),(N_bins-1)), curve4, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
legend('CBD', 'Vehicle')
title(strcat('Averaged REM amount per',{' '}, num2str(timesize), ' minutes bins'))
xlabel('Time since feeding')
ylabel('Amount(s)')

t2 = nexttile([1 1]);
%Barplots showing whole time average + individual distribution
b1 = bar(0.5, mean(average_cbd));
hold on
ylim(t1.YLim)
hold on 
b2 = bar(1.5, mean(average_veh));
set(b1,'FaceColor',[0.4667    0.78  0.3529]);
set(b2,'FaceColor',[0.5020    0.5020    0.5020]);
hold on
% Individual dots
scatter(ones(1,10)*0.5,ttest_rem(1:10),[],'black', 'markerfacecolor', [0.4667    0.7804    0.3529], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
hold on
scatter(ones(1,9)*1.5,ttest_rem(11:19),[],'black', 'markerfacecolor', [0.5020    0.5020    0.5020], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
% Error bars
SEM = [std(average_cbd)/sqrt(10) std(average_veh)/sqrt(9)];
er = errorbar([0.5 1.5],[mean(average_cbd) mean(average_veh)],SEM,SEM);      
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
set(gca, 'XTick', [0.5 1.5], 'XTickLabel', {'CBD','Vehicle'})
xtickangle(-30)
% If significance with t-test, significance star
if P_rem <= 0.05
    hold on
    plot([0.1 1.9], [1.06*max(mean(average_cbd)+SEM(1), mean(average_veh)+ SEM(2)) 1.06*max(mean(average_cbd)+SEM(1), mean(average_veh) + SEM(2))], 'black', 'LineWidth', 1)
    hold on
    scatter(1,1.1*max(mean(average_cbd)+SEM(1), mean(average_veh) + SEM(2)), '*k', 'LineWidth', 0.90)
    hold off
end
title('Average per group')

%% REM bouts counts + duration
%We're going here to look at the number of REM bouts and their durations

%nb of bouts
mat_rem_boutsnb = [];
avg_rem_nb_bouts_cbd = [];
avg_rem_nb_bouts_veh = [];
sem_rem_nb_bouts_cbd = [];
sem_rem_nb_bouts_veh = [];
%durations
mat_rem_boutsdur = [];
avg_rem_dur_bouts_cbd = [];
avg_rem_dur_bouts_veh = [];
sem_rem_dur_bouts_cbd = [];
sem_rem_dur_bouts_veh = [];
%CBD_BIN_COUNT=[];
C=[];
D=[];
E=[];
F=[];
%Same principle, mean and SEM
for kk = 1:(N_bins-1)
    tmpcbd = cbd_align(:,(binsize*(kk-1)+1):kk*binsize);
    tmpveh = veh_align(:,(binsize*(kk-1)+1):kk*binsize);
    n1 = N(1:10,kk);
    n2 = N(11:19,kk);
    tmpcbd(isnan(tmpcbd)) = 0; %replace NaNs with 0
    tmpveh(isnan(tmpveh)) = 0;
    
    CBD_bin_count = [];
    CBD_bin_dur = [];
    % We retrieve every bout. Quite easy principle, go through every point,
    % every time you find a 1, that's the beginning of a REM bout, then as
    % long as you still have 1, that's the same bout, when you encounter
    % something else, it means the bout is finished, and you have its
    % length
    for ii = 1:size(tmpcbd,1)
        tmp = tmpcbd(ii,:);
        index = 1;
        count = 0; % count is the number of REM bouts
        durations = []; % vector with duration of each REM bout
        while index < length(tmp) % Precaution in case the recording ends with a REM bout
            if tmp(index) == 1 
                count = count + 1;
                index2 = index + 1;
                while tmp(index2) == 1 & index2 < length(tmp)
                    index2 = index2 + 1;
                end
                durations = [durations (index2-index)];
                index = index2;
            else
                index = index + 1;
            end
        end 
        CBD_bin_count = [CBD_bin_count count];
        CBD_bin_dur = [CBD_bin_dur mean(durations)];
    end
    CBD_bin_dur(isnan(CBD_bin_dur)) = 0; 
 %   CBD_BIN_COUNT(:,kk)=CBD_bin_count;
    C(:,2*kk-1:kk*2) = [CBD_bin_count.' n1];
    E(:,2*kk-1:kk*2) = [CBD_bin_dur.' n1];

    avg_rem_nb_bouts_cbd(kk) = mean(CBD_bin_count(n1));
    avg_rem_dur_bouts_cbd(kk) = mean(CBD_bin_dur(n1)*10);
    sem_rem_nb_bouts_cbd(kk) = std(CBD_bin_count(n1))/sqrt(sum(n1));
    sem_rem_dur_bouts_cbd(kk) = std(CBD_bin_dur(n1)*10)/sqrt(sum(n1));
    
    %Same here for vehicles
    VEH_bin_count = [];
    VEH_bin_dur = [];
    for ii = 1:size(tmpveh,1)
        tmp = tmpveh(ii,:);
        index = 1;
        count = 0;
        durations = [];
        while index < length(tmp)
            if tmp(index) == 1 
                count = count + 1;
                index2 = index + 1;
                while tmp(index2) == 1 & index2 < length(tmp)
                    index2 = index2 + 1;
                end
                durations = [durations (index2-index)];
                index = index2;
            else
                index = index + 1;
            end
        end 
        VEH_bin_count = [VEH_bin_count count];
        VEH_bin_dur = [VEH_bin_dur mean(durations)];
    end
    VEH_bin_dur(isnan(VEH_bin_dur)) = 0;
    D(:,2*kk-1:kk*2) = [VEH_bin_count.' n2];
    F(:,2*kk-1:kk*2) = [VEH_bin_dur.' n2];
   
    avg_rem_nb_bouts_veh(kk) = mean(VEH_bin_count(n2));
    avg_rem_dur_bouts_veh(kk) = mean(VEH_bin_dur(n2)*10);
    sem_rem_nb_bouts_veh(kk) = std(VEH_bin_count(n2))/sqrt(sum(n2));
    sem_rem_dur_bouts_veh(kk) = std(VEH_bin_dur(n2)*10)/sqrt(sum(n2));
    
    mat_rem_boutsnb = [mat_rem_boutsnb [CBD_bin_count'; VEH_bin_count']];
    mat_rem_boutsdur = [mat_rem_boutsdur [10*CBD_bin_dur' ; 10*VEH_bin_dur']];
end

data_table=[[ratID((logical(type))).' ; ratID(not(logical(type))).'] [ones(ncbd,1); zeros(nveh,1) ] [C;D]]

T=table;
T.Variables=data_table;
T.Properties.VariableNames={'Rat' ,'Treatment', 'Bin1' ,'Bin1_binary' ,'Bin2', 'Bin2_binary', 'Bin3' ,'Bin3_binary', 'Bin4' ,'Bin4_binary','Bin5' ,'Bin5_binary' ,'Bin6', 'Bin6_binary', 'Bin7' ,'Bin7_binary', 'Bin8', 'Bin8_binary' ,'Bin9' ,'Bin9_binary', 'Bin10' ,'Bin10_binary' }
filename = 'REM_bout_count.xlsx';
writetable(T,filename,'Sheet',1,'Range','A1:Z50')


data_table=[[ratID((logical(type))).' ; ratID(not(logical(type))).'] [ones(ncbd,1); zeros(nveh,1) ] [E;F]];
T=table;
T.Variables=data_table;
T.Properties.VariableNames={'Rat' ,'Treatment', 'Bin1' ,'Bin1_binary' ,'Bin2', 'Bin2_binary', 'Bin3' ,'Bin3_binary', 'Bin4' ,'Bin4_binary','Bin5' ,'Bin5_binary' ,'Bin6', 'Bin6_binary', 'Bin7' ,'Bin7_binary', 'Bin8', 'Bin8_binary' ,'Bin9' ,'Bin9_binary', 'Bin10' ,'Bin10_binary' }
filename = 'REM_bout_duration.xlsx';
writetable(T,filename,'Sheet',1,'Range','A1:Z50')

mat_rem_boutsnb2 = normalize_matrix(mat_rem_boutsnb,N);
mat_rem_boutsdur2 = normalize_matrix(mat_rem_boutsdur,N);
%t-test with averaged over whole time
for ii = 1:size(mat_rem_boutsnb,1)
    tmp1 = mat_rem_boutsnb2(ii,:);
    tmp2 = mat_rem_boutsdur2(ii,:);
    n = N(ii,:)
    mat_rem_boutsnb3(ii) = mean(tmp1(n));
    mat_rem_boutsdur3(ii) = mean(tmp2(n));
end
[H_rem_boutsnb,P_rem_boutsnb,CI_rem_boutsnb,STATS_rem_boutsnb] = ttest2(mat_rem_boutsnb3(1:10), mat_rem_boutsnb3(11:19));
[H_rem_boutsdur,P_rem_boutsdur,CI_rem_boutsdur,STATS_rem_boutsdur] = ttest2(mat_rem_boutsdur3(1:10), mat_rem_boutsdur3(11:19));

% ANOVA

%Bouts count

% Test 1 is: we keep all bins, and replace NaNs by the bin's average
test1 = mat_rem_boutsnb;
test1(~N) = NaN;
for ii = 1:size(test1,2)
    tmp = test1(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test1(:,ii) = tmp;
end
t_rem_boutsnb = table(drug, test1(:,1), test1(:,2), test1(:,3), test1(:,4), test1(:,5), test1(:,6), test1(:,7), test1(:,8), test1(:,9), test1(:,10),...
    'VariableNames', {'drug', 'bin1','bin2','bin3', 'bin4', 'bin5', 'bin6', 'bin7', 'bin8', 'bin9', 'bin10'});
Bins = table([1:10]', 'VariableNames', {'Time'});

rm_rem_boutsnb = fitrm(t_rem_boutsnb, 'bin1-bin10~drug', 'WithinDesign', Bins);
tbl_rem_boutsnb = mauchly(rm_rem_boutsnb);
ranovatbl_rem_boutsnb = ranova(rm_rem_boutsnb);
anovatbl_rem_boutsnb = anova(rm_rem_boutsnb);

% Test 2 is: we only keep bins that are full (or let's say almost full = 1 NaN per bin max)
test2 = mat_rem_boutsnb;
test2(~N) = NaN;
test2 = test2(:,6:9);
for ii = 1:size(test2,2)
    tmp = test2(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test2(:,ii) = tmp;
end

t_rem_boutsnb2 = table(drug, test2(:,1), test2(:,2), test2(:,3), test2(:,4),...
    'VariableNames', {'drug','bin6', 'bin7', 'bin8', 'bin9'});
Bins2 = table([1:4]', 'VariableNames', {'Time'});

rm_rem_boutsnb2 = fitrm(t_rem_boutsnb2, 'bin6-bin9~drug', 'WithinDesign', Bins2);
tbl_rem_boutsnb2 = mauchly(rm_rem_boutsnb2);
ranovatbl_rem_boutsnb2 = ranova(rm_rem_boutsnb2);
anovatbl_rem_boutsnb2 = anova(rm_rem_boutsnb2);

%Bouts duration

% Test 1 is: we keep all bins, and replace NaNs by the bin's average
test1 = mat_rem_boutsdur;
test1(~N) = NaN;
for ii = 1:size(test1,2)
    tmp = test1(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test1(:,ii) = tmp;
end
t_rem_boutsdur = table(drug, test1(:,1), test1(:,2), test1(:,3), test1(:,4), test1(:,5), test1(:,6), test1(:,7), test1(:,8), test1(:,9), test1(:,10),...
    'VariableNames', {'drug', 'bin1','bin2','bin3', 'bin4', 'bin5', 'bin6', 'bin7', 'bin8', 'bin9', 'bin10'});
Bins = table([1:10]', 'VariableNames', {'Time'});

rm_rem_boutsdur = fitrm(t_rem_boutsdur, 'bin1-bin10~drug', 'WithinDesign', Bins);
tbl_rem_boutsdur = mauchly(rm_rem_boutsdur);
ranovatbl_rem_boutsdur = ranova(rm_rem_boutsdur);
anovatbl_rem_boutsdur = anova(rm_rem_boutsdur);

% Test 2 is: we only keep bins that are full (or let's say almost full = 1 NaN per bin max)
test2 = mat_rem_boutsdur;
test2(~N) = NaN;
test2 = test2(:,6:9);
for ii = 1:size(test2,2)
    tmp = test2(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test2(:,ii) = tmp;
end

t_rem_boutsdur2 = table(drug, test2(:,1), test2(:,2), test2(:,3), test2(:,4),...
    'VariableNames', {'drug','bin6', 'bin7', 'bin8', 'bin9'});
Bins2 = table([1:4]', 'VariableNames', {'Time'});

rm_rem_boutsdur2 = fitrm(t_rem_boutsdur2, 'bin6-bin9~drug', 'WithinDesign', Bins2);
tbl_rem_boutsdur2 = mauchly(rm_rem_boutsdur2);
ranovatbl_rem_boutsdur2 = ranova(rm_rem_boutsdur2);
anovatbl_rem_boutsdur2 = anova(rm_rem_boutsdur2);

%PLOTS
% Number of bouts
figure
tiledlayout(1,5)
t1 = nexttile([1 4]);
curve1 = avg_rem_nb_bouts_cbd + sem_rem_nb_bouts_cbd;
curve2 = avg_rem_nb_bouts_cbd - sem_rem_nb_bouts_cbd;
curve3 = avg_rem_nb_bouts_veh + sem_rem_nb_bouts_veh;
curve4 = avg_rem_nb_bouts_veh - sem_rem_nb_bouts_veh;

plot(linspace(time_start, time_end - duration([0 45 0]),(N_bins-1)), avg_rem_nb_bouts_cbd, '-', 'color',[0.4667    0.7804    0.3529], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),(N_bins-1)), curve1, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),(N_bins-1)), curve2, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),(N_bins-1)), avg_rem_nb_bouts_veh, '-', 'color', [0.5020    0.5020    0.5020], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),(N_bins-1)), curve3, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),(N_bins-1)), curve4, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
legend('CBD', 'Vehicle')
title(strcat('Averaged REM bouts count per',{' '}, num2str(timesize), ' minutes bins'))
xlabel('Time')
ylabel('Number of bouts')
nexttile([1 1])

b1 = bar(0.5, mean(avg_rem_nb_bouts_cbd));
hold on
ylim(t1.YLim)
hold on 
b2 = bar(1.5, mean(avg_rem_nb_bouts_veh));
set(b1,'FaceColor',[0.4667    0.78  0.3529]);
set(b2,'FaceColor',[0.5020    0.5020    0.5020]);
hold on
scatter(ones(1,10)*0.5,mat_rem_boutsnb2(1:10),[],'black', 'markerfacecolor', [0.4667    0.7804    0.3529], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
hold on
scatter(ones(1,9)*1.5,mat_rem_boutsnb2(11:19),[],'black', 'markerfacecolor', [0.5020    0.5020    0.5020], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
SEM = [std(avg_rem_nb_bouts_cbd)/sqrt(10) std(avg_rem_nb_bouts_veh)/sqrt(9)];
er = errorbar([0.5 1.5],[mean(avg_rem_nb_bouts_cbd) mean(avg_rem_nb_bouts_veh)],SEM,SEM);      
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
set(gca, 'XTick', [0.5 1.5], 'XTickLabel', {'CBD','Vehicle'})
xtickangle(-30)
if P_rem_boutsnb <= 0.05
    hold on
    plot([0.1 1.9], [1.06*max(mean(avg_rem_nb_bouts_cbd)+SEM(1), mean(avg_rem_nb_bouts_veh)+ SEM(2)) 1.06*max(mean(avg_rem_nb_bouts_cbd)+SEM(1), mean(avg_rem_nb_bouts_veh) + SEM(2))], 'black', 'LineWidth', 1)
    hold on
    scatter(1,1.1*max(mean(avg_rem_nb_bouts_cbd)+SEM(1), mean(avg_rem_nb_bouts_veh) + SEM(2)), '*k', 'LineWidth', 0.90)
    hold off
end

title('Average per group')

% Bout duration
figure
tiledlayout(1,5)
t1 = nexttile([1 4]);
curve1 = avg_rem_dur_bouts_cbd + sem_rem_dur_bouts_cbd;
curve2 = avg_rem_dur_bouts_cbd - sem_rem_dur_bouts_cbd;
curve3 = avg_rem_dur_bouts_veh + sem_rem_dur_bouts_veh;
curve4 = avg_rem_dur_bouts_veh - sem_rem_dur_bouts_veh;
plot(linspace(time_start, time_end - duration([0 45 0]),(N_bins-1)), avg_rem_dur_bouts_cbd, '-', 'color',[0.4667    0.7804    0.3529], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),(N_bins-1)), curve1, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),(N_bins-1)), curve2, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),(N_bins-1)), avg_rem_dur_bouts_veh, '-', 'color', [0.5020    0.5020    0.5020], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),(N_bins-1)), curve3, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),(N_bins-1)), curve4, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
legend('CBD', 'Vehicle')
title(strcat('Averaged REM bouts duration per',{' '}, num2str(timesize), ' minutes bins'))
xlabel('Time')
ylabel('Duration (s)')

nexttile([1 1])

b1 = bar(0.5, mean(avg_rem_dur_bouts_cbd));
hold on
ylim(t1.YLim)
hold on 
b2 = bar(1.5, mean(avg_rem_dur_bouts_veh));
set(b1,'FaceColor',[0.4667    0.78  0.3529]);
set(b2,'FaceColor',[0.5020    0.5020    0.5020]);
hold on
scatter(ones(1,10)*0.5,mat_rem_boutsdur2(1:10),[],'black', 'markerfacecolor', [0.4667    0.7804    0.3529], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
hold on
scatter(ones(1,9)*1.5,mat_rem_boutsdur2(11:19),[],'black', 'markerfacecolor', [0.5020    0.5020    0.5020], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
SEM = [std(avg_rem_dur_bouts_cbd)/sqrt(10) std(avg_rem_dur_bouts_veh)/sqrt(9)];
er = errorbar([0.5 1.5],[mean(avg_rem_dur_bouts_cbd) mean(avg_rem_dur_bouts_veh)],SEM,SEM);      
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
set(gca, 'XTick', [0.5 1.5], 'XTickLabel', {'CBD','Vehicle'})
xtickangle(-30)
if P_rem_boutsdur <= 0.05
    hold on
    plot([0.1 1.9], [1.06*max(mean(avg_rem_dur_bouts_cbd)+SEM(1), mean(avg_rem_dur_bouts_veh)+ SEM(2)) 1.06*max(mean(avg_rem_dur_bouts_cbd)+SEM(1), mean(avg_rem_dur_bouts_veh) + SEM(2))], 'black', 'LineWidth', 1)
    hold on
    scatter(1,1.1*max(mean(avg_rem_dur_bouts_cbd)+SEM(1), mean(avg_rem_dur_bouts_veh) + SEM(2)), '*k', 'LineWidth', 0.90)
    hold off
end

title('Average per group')
%% NREM 
%Same but for NREM

% Average + SEM for both groups

ttest_mat_nrem = [];
N_bins = floor(size(cbd_align,2)/binsize);
average_cbd_nrem = [];
average_veh_nrem = [];
sem_cbd_nrem = [];
sem_veh_nrem = [];

% %Remove rats absent from a lot of bins
% cbd_align = cbd_align([1:2 5:10], :);
% veh_align = veh_align([1:2 4:9], :);

for kk = 1:(N_bins-1)
    tmpcbd = cbd_align(:,(binsize*(kk-1)+1):kk*binsize);
    tmpveh = veh_align(:,(binsize*(kk-1)+1):kk*binsize);
    n1 = N(1:10,kk);
    n2 = N(11:19,kk);
    sum1 = sum((tmpcbd==2|tmpcbd==3),2)*10; %*10 to make it in seconds
    sum2 = sum((tmpveh==2|tmpveh==3),2)*10;
    average_cbd_nrem(kk) = mean(sum1(n1,:));
    average_veh_nrem(kk) = mean(sum2(n2,:));
    sem_cbd_nrem(kk) = std(sum1(n1,:))/sqrt(size(sum1(n1,:),1));
    sem_veh_nrem(kk) = std(sum2(n2,:))/sqrt(size(sum2(n2,:),1));

    SUM = [sum1 ; sum2];
    ttest_mat_nrem = [ttest_mat_nrem SUM];
end

ttest_mat_nrem2 = normalize_matrix(ttest_mat_nrem,N);
%t-test with averaged over whole time
for ii = 1:size(ttest_mat_nrem,1)
    tmp = ttest_mat_nrem2(ii,:);
    n = N(ii,:)
    ttest_mat_nrem3(ii) = mean(tmp(n));
end
[H_nrem,P_nrem,CI_nrem,STATS_nrem] = ttest2(ttest_mat_nrem3(1:10), ttest_mat_nrem3(11:19))


% ANOVA
drug = {'CBD','CBD','CBD','CBD','CBD','CBD','CBD','CBD','CBD','CBD','VEH','VEH','VEH','VEH','VEH','VEH','VEH','VEH','VEH'}';

% Test 1 is: we keep all bins, and replace NaNs by the bin's average
test1 = ttest_mat_nrem;
test1(~N) = NaN;
for ii = 1:size(test1,2)
    tmp = test1(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test1(:,ii) = tmp;
end
t_nrem = table(drug, test1(:,1), test1(:,2), test1(:,3), test1(:,4), test1(:,5), test1(:,6), test1(:,7), test1(:,8), test1(:,9), test1(:,10),...
    'VariableNames', {'drug', 'bin1','bin2','bin3', 'bin4', 'bin5', 'bin6', 'bin7', 'bin8', 'bin9', 'bin10'});
Bins = table([1:10]', 'VariableNames', {'Time'});

rm_nrem = fitrm(t_nrem, 'bin1-bin10~drug', 'WithinDesign', Bins);
tbl_nrem = mauchly(rm_nrem);
ranovatbl_nrem = ranova(rm_nrem);
anovatbl_nrem = anova(rm_nrem);

% Test 2 is: we only keep bins that are full (or let's say almost full = 1 NaN per bin max)
test2 = ttest_mat_nrem;
test2(~N) = NaN;
test2 = test2(:,6:9);
for ii = 1:size(test2,2)
    tmp = test2(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test2(:,ii) = tmp;
end

t_nrem2 = table(drug, test2(:,1), test2(:,2), test2(:,3), test2(:,4),...
    'VariableNames', {'drug','bin6', 'bin7', 'bin8', 'bin9'});
Bins2 = table([1:4]', 'VariableNames', {'Time'});

rm_nrem2 = fitrm(t_nrem2, 'bin6-bin9~drug', 'WithinDesign', Bins2);
tbl_nrem2 = mauchly(rm_nrem2);
ranovatbl_nrem2 = ranova(rm_nrem2);
anovatbl_nrem2 = anova(rm_nrem2);

% PLOTS

figure
tiledlayout(1,5)
t1 = nexttile([1 4]);
curve1 = average_cbd_nrem + sem_cbd_nrem;
curve2 = average_cbd_nrem - sem_cbd_nrem;
curve3 = average_veh_nrem + sem_veh_nrem;
curve4 = average_veh_nrem - sem_veh_nrem;
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_cbd_nrem,2)), average_cbd_nrem, '-', 'color', [0.4667    0.7804    0.3529], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_cbd_nrem,2)), curve1, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_cbd_nrem,2)), curve2, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_veh_nrem,2)), average_veh_nrem, '-', 'color', [0.5020    0.5020    0.5020], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_veh_nrem,2)), curve3, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_veh_nrem,2)), curve4, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
legend('CBD','Vehicle')
title(strcat('Averaged NREM amount per',{' '}, num2str(timesize), ' minutes bins'))
xlabel('Time')
ylabel('Amount(s)')
nexttile([1 1])

b1 = bar(0.5, mean(average_cbd_nrem));
hold on
ylim(t1.YLim)
hold on 
b2 = bar(1.5, mean(average_veh_nrem));
set(b1,'FaceColor',[0.4667    0.78  0.3529]);
set(b2,'FaceColor',[0.5020    0.5020    0.5020]);
hold on
scatter(ones(1,10)*0.5,ttest_mat_nrem2(1:10),[],'black', 'markerfacecolor', [0.4667    0.7804    0.3529], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
hold on
scatter(ones(1,9)*1.5,ttest_mat_nrem2(11:19),[],'black', 'markerfacecolor', [0.5020    0.5020    0.5020], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
SEM = [std(average_cbd_nrem)/sqrt(10) std(average_veh_nrem)/sqrt(9)];
er = errorbar([0.5 1.5],[mean(average_cbd_nrem) mean(average_veh_nrem)],SEM,SEM);      
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
set(gca, 'XTick', [0.5 1.5], 'XTickLabel', {'CBD','Vehicle'})
xtickangle(-30)
if P_nrem <= 0.05
    hold on
    plot([0.1 1.9], [1.06*max(mean(average_cbd_nrem)+SEM(1), mean(average_veh_nrem)+ SEM(2)) 1.06*max(mean(average_cbd_nrem)+SEM(1), mean(average_veh_nrem) + SEM(2))], 'black', 'LineWidth', 1)
    hold on
    scatter(1,1.1*max(mean(average_cbd_nrem)+SEM(1), mean(average_veh_nrem) + SEM(2)), '*k', 'LineWidth', 0.90)
    hold off
end

title('Average per group')

%% NREM bouts + duration

mat_nrem_boutsnb = [];
avg_nrem_nb_bouts_cbd = [];
avg_nrem_nb_bouts_veh = [];
sem_nrem_nb_bouts_cbd = [];
sem_nrem_nb_bouts_veh = [];

mat_nrem_boutsdur = [];
avg_nrem_dur_bouts_cbd = [];
avg_nrem_dur_bouts_veh = [];
sem_nrem_dur_bouts_cbd = [];
sem_nrem_dur_bouts_veh = [];

C=[];
D=[];
E=[];
F=[];

for kk = 1:(N_bins-1)
    tmpcbd = cbd_align(:,(binsize*(kk-1)+1):kk*binsize);
    tmpveh = veh_align(:,(binsize*(kk-1)+1):kk*binsize);
    n1 = N(1:10,kk);
    n2 = N(11:19,kk);
    tmpcbd(isnan(tmpcbd)) = 0;
    tmpveh(isnan(tmpveh)) = 0;
    
    CBD_bin_count = [];
    CBD_bin_dur = [];
    for ii = 1:size(tmpcbd,1)
        tmp = tmpcbd(ii,:);
        index = 1;
        count = 0;
        durations = [];
        while index < length(tmp)
            if tmp(index) == 2 |  tmp(index) == 3
                count = count + 1;
                index2 = index ;
                while (tmp(index2) == 2 |  tmp(index2) == 3) & index2 < length(tmp)
                    index2 = index2 + 1;
                end
                durations = [durations (index2-index)];
                index = index2;
            else
                index = index + 1;
            end
        end 
        CBD_bin_count = [CBD_bin_count count];
        CBD_bin_dur = [CBD_bin_dur mean(durations)];
    end
    CBD_bin_dur(isnan(CBD_bin_dur)) = 0;
    C(:,2*kk-1:kk*2) = [CBD_bin_count.' n1];
    E(:,2*kk-1:kk*2) = [CBD_bin_dur.' n1];
    

    avg_nrem_nb_bouts_cbd(kk) = mean(CBD_bin_count(n1));
    avg_nrem_dur_bouts_cbd(kk) = mean(CBD_bin_dur(n1)*10);
    sem_nrem_nb_bouts_cbd(kk) = std(CBD_bin_count(n1))/sqrt(sum(n1));
    sem_nrem_dur_bouts_cbd(kk) = std(CBD_bin_dur(n1)*10)/sqrt(sum(n1));
    
    VEH_bin_count = [];
    VEH_bin_dur = [];
    for ii = 1:size(tmpveh,1)
        tmp = tmpveh(ii,:);
        index = 1;
        count = 0;
        durations = [];
        while index < length(tmp)
            if tmp(index) == 2 |  tmp(index) == 3 
                count = count + 1;
                index2 = index + 1;
                while (tmp(index2) == 2 |  tmp(index2) == 3) & index2 < length(tmp)
                    index2 = index2 + 1;
                end
                durations = [durations (index2-index)];
                index = index2;
            else
                index = index + 1;
            end
        end 
        VEH_bin_count = [VEH_bin_count count];
        VEH_bin_dur = [VEH_bin_dur mean(durations)];
    end
    VEH_bin_dur(isnan(VEH_bin_dur)) = 0;
    D(:,2*kk-1:kk*2) = [VEH_bin_count.' n2];
    F(:,2*kk-1:kk*2) = [VEH_bin_dur.' n2];

    avg_nrem_nb_bouts_veh(kk) = mean(VEH_bin_count(n2));
    avg_nrem_dur_bouts_veh(kk) = mean(VEH_bin_dur(n2)*10);
    sem_nrem_nb_bouts_veh(kk) = std(VEH_bin_count(n2))/sqrt(sum(n2));
    sem_nrem_dur_bouts_veh(kk) = std(VEH_bin_dur(n2)*10)/sqrt(sum(n2));

    mat_nrem_boutsnb = [mat_nrem_boutsnb [CBD_bin_count'; VEH_bin_count']];
    mat_nrem_boutsdur = [mat_nrem_boutsdur [10*CBD_bin_dur' ; 10*VEH_bin_dur']];
end

data_table=[[ratID((logical(type))).' ; ratID(not(logical(type))).'] [ones(ncbd,1); zeros(nveh,1) ] [C;D]];

T=table;
T.Variables=data_table;
T.Properties.VariableNames={'Rat' ,'Treatment', 'Bin1' ,'Bin1_binary' ,'Bin2', 'Bin2_binary', 'Bin3' ,'Bin3_binary', 'Bin4' ,'Bin4_binary','Bin5' ,'Bin5_binary' ,'Bin6', 'Bin6_binary', 'Bin7' ,'Bin7_binary', 'Bin8', 'Bin8_binary' ,'Bin9' ,'Bin9_binary', 'Bin10' ,'Bin10_binary' }
filename = 'NREM_bout_count.xlsx';
writetable(T,filename,'Sheet',1,'Range','A1:Z50')


data_table=[[ratID((logical(type))).' ; ratID(not(logical(type))).'] [ones(ncbd,1); zeros(nveh,1) ] [E;F]];
T=table;
T.Variables=data_table;
T.Properties.VariableNames={'Rat' ,'Treatment', 'Bin1' ,'Bin1_binary' ,'Bin2', 'Bin2_binary', 'Bin3' ,'Bin3_binary', 'Bin4' ,'Bin4_binary','Bin5' ,'Bin5_binary' ,'Bin6', 'Bin6_binary', 'Bin7' ,'Bin7_binary', 'Bin8', 'Bin8_binary' ,'Bin9' ,'Bin9_binary', 'Bin10' ,'Bin10_binary' }
filename = 'NREM_bout_duration.xlsx';
writetable(T,filename,'Sheet',1,'Range','A1:Z50')



mat_nrem_boutsnb2 = normalize_matrix(mat_nrem_boutsnb,N);
mat_nrem_boutsdur2 = normalize_matrix(mat_nrem_boutsdur,N);
%t-test with averaged over whole time
for ii = 1:size(mat_nrem_boutsnb,1)
    tmp1 = mat_nrem_boutsnb2(ii,:);
    tmp2 = mat_nrem_boutsdur2(ii,:);
    n = N(ii,:)
    mat_nrem_boutsnb3(ii) = mean(tmp1(n));
    mat_nrem_boutsdur3(ii) = mean(tmp2(n));
end
[H_nrem_boutsnb,P_nrem_boutsnb,CI_nrem_boutsnb,STATS_nrem_boutsnb] = ttest2(mat_nrem_boutsnb3(1:10), mat_nrem_boutsnb3(11:19))
[H_nrem_boutsdur,P_nrem_boutsdur,CI_nrem_boutsdur,STATS_nrem_boutsdur] = ttest2(mat_nrem_boutsdur3(1:10), mat_nrem_boutsdur3(11:19))

% ANOVA

%Bouts count

% Test 1 is: we keep all bins, and replace NaNs by the bin's average
test1 = mat_nrem_boutsnb;
test1(~N) = NaN;
for ii = 1:size(test1,2)
    tmp = test1(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test1(:,ii) = tmp;
end
t_nrem_boutsnb = table(drug, test1(:,1), test1(:,2), test1(:,3), test1(:,4), test1(:,5), test1(:,6), test1(:,7), test1(:,8), test1(:,9), test1(:,10),...
    'VariableNames', {'drug', 'bin1','bin2','bin3', 'bin4', 'bin5', 'bin6', 'bin7', 'bin8', 'bin9', 'bin10'});
Bins = table([1:10]', 'VariableNames', {'Time'});

rm_nrem_boutsnb = fitrm(t_nrem_boutsnb, 'bin1-bin10~drug', 'WithinDesign', Bins);
tbl_nrem_boutsnb = mauchly(rm_nrem_boutsnb);
ranovatbl_nrem_boutsnb = ranova(rm_nrem_boutsnb);
anovatbl_nrem_boutsnb = anova(rm_nrem_boutsnb);

% Test 2 is: we only keep bins that are full (or let's say almost full = 1 NaN per bin max)
test2 = mat_nrem_boutsnb;
test2(~N) = NaN;
test2 = test2(:,6:9);
for ii = 1:size(test2,2)
    tmp = test2(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test2(:,ii) = tmp;
end

t_nrem_boutsnb2 = table(drug, test2(:,1), test2(:,2), test2(:,3), test2(:,4),...
    'VariableNames', {'drug','bin6', 'bin7', 'bin8', 'bin9'});
Bins2 = table([1:4]', 'VariableNames', {'Time'});

rm_nrem_boutsnb2 = fitrm(t_nrem_boutsnb2, 'bin6-bin9~drug', 'WithinDesign', Bins2);
tbl_nrem_boutsnb2 = mauchly(rm_nrem_boutsnb2);
ranovatbl_nrem_boutsnb2 = ranova(rm_nrem_boutsnb2);
anovatbl_nrem_boutsnb2 = anova(rm_nrem_boutsnb2);

%Bouts duration

% Test 1 is: we keep all bins, and replace NaNs by the bin's average
test1 = mat_nrem_boutsdur;
test1(~N) = NaN;
for ii = 1:size(test1,2)
    tmp = test1(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test1(:,ii) = tmp;
end
t_nrem_boutsdur = table(drug, test1(:,1), test1(:,2), test1(:,3), test1(:,4), test1(:,5), test1(:,6), test1(:,7), test1(:,8), test1(:,9), test1(:,10),...
    'VariableNames', {'drug', 'bin1','bin2','bin3', 'bin4', 'bin5', 'bin6', 'bin7', 'bin8', 'bin9', 'bin10'});
Bins = table([1:10]', 'VariableNames', {'Time'});

rm_nrem_boutsdur = fitrm(t_nrem_boutsdur, 'bin1-bin10~drug', 'WithinDesign', Bins);
tbl_nrem_boutsdur = mauchly(rm_nrem_boutsdur);
ranovatbl_nrem_boutsdur = ranova(rm_nrem_boutsdur);
anovatbl_nrem_boutsdur = anova(rm_nrem_boutsdur);

% Test 2 is: we only keep bins that are full (or let's say almost full = 1 NaN per bin max)
test2 = mat_nrem_boutsdur;
test2(~N) = NaN;
test2 = test2(:,6:9);
for ii = 1:size(test2,2)
    tmp = test2(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test2(:,ii) = tmp;
end

t_nrem_boutsdur2 = table(drug, test2(:,1), test2(:,2), test2(:,3), test2(:,4),...
    'VariableNames', {'drug','bin6', 'bin7', 'bin8', 'bin9'});
Bins2 = table([1:4]', 'VariableNames', {'Time'});

rm_nrem_boutsdur2 = fitrm(t_nrem_boutsdur2, 'bin6-bin9~drug', 'WithinDesign', Bins2);
tbl_nrem_boutsdur2 = mauchly(rm_nrem_boutsdur2);
ranovatbl_nrem_boutsdur2 = ranova(rm_nrem_boutsdur2);
anovatbl_nrem_boutsdur2 = anova(rm_nrem_boutsdur2);

% Number of bouts
figure
tiledlayout(1,5)
t1 = nexttile([1 4]);
curve1 = avg_nrem_nb_bouts_cbd + sem_nrem_nb_bouts_cbd;
curve2 = avg_nrem_nb_bouts_cbd - sem_nrem_nb_bouts_cbd;
curve3 = avg_nrem_nb_bouts_veh + sem_nrem_nb_bouts_veh;
curve4 = avg_nrem_nb_bouts_veh - sem_nrem_nb_bouts_veh;

plot(linspace(time_start, time_end - duration([0 45 0]),size(average_cbd_nrem,2)), avg_nrem_nb_bouts_cbd, '-', 'color',[0.4667    0.7804    0.3529], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_cbd_nrem,2)), curve1, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_cbd_nrem,2)), curve2, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_veh_nrem,2)), avg_nrem_nb_bouts_veh, '-', 'color', [0.5020    0.5020    0.5020], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_veh_nrem,2)), curve3, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_veh_nrem,2)), curve4, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
legend('CBD', 'Vehicle')
title(strcat('Averaged NREM bouts count per',{' '}, num2str(timesize), ' minutes bins'))
xlabel('Time')
ylabel('Number of bouts')
nexttile([1 1])

b1 = bar(0.5, mean(avg_nrem_nb_bouts_cbd));
hold on
ylim(t1.YLim)
hold on 
b2 = bar(1.5, mean(avg_nrem_nb_bouts_veh));
set(b1,'FaceColor',[0.4667    0.78  0.3529]);
set(b2,'FaceColor',[0.5020    0.5020    0.5020]);
hold on
scatter(ones(1,10)*0.5,mat_nrem_boutsnb2(1:10),[],'black', 'markerfacecolor', [0.4667    0.7804    0.3529], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
hold on
scatter(ones(1,9)*1.5,mat_nrem_boutsnb2(11:19),[],'black', 'markerfacecolor', [0.5020    0.5020    0.5020], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
SEM = [std(avg_nrem_nb_bouts_cbd)/sqrt(10) std(avg_nrem_nb_bouts_veh)/sqrt(9)];
er = errorbar([0.5 1.5],[mean(avg_nrem_nb_bouts_cbd) mean(avg_nrem_nb_bouts_veh)],SEM,SEM);      
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
set(gca, 'XTick', [0.5 1.5], 'XTickLabel', {'CBD','Vehicle'})
xtickangle(-30)
if P_nrem_boutsnb <= 0.05
    hold on
    plot([0.1 1.9], [1.06*max(mean(avg_nrem_nb_bouts_cbd)+SEM(1), mean(avg_nrem_nb_bouts_veh)+ SEM(2)) 1.06*max(mean(avg_nrem_nb_bouts_cbd)+SEM(1), mean(avg_nrem_nb_bouts_veh) + SEM(2))], 'black', 'LineWidth', 1)
    hold on
    scatter(1,1.1*max(mean(avg_nrem_nb_bouts_cbd)+SEM(1), mean(avg_nrem_nb_bouts_veh) + SEM(2)), '*k', 'LineWidth', 0.90)
    hold off
end

title('Average per group')

% Bout duration
figure
tiledlayout(1,5)
t1 = nexttile([1 4]);
curve1 = avg_nrem_dur_bouts_cbd + sem_nrem_dur_bouts_cbd;
curve2 = avg_nrem_dur_bouts_cbd - sem_nrem_dur_bouts_cbd;
curve3 = avg_nrem_dur_bouts_veh + sem_nrem_dur_bouts_veh;
curve4 = avg_nrem_dur_bouts_veh - sem_nrem_dur_bouts_veh;
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_cbd_nrem,2)), avg_nrem_dur_bouts_cbd, '-', 'color',[0.4667    0.7804    0.3529], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_cbd_nrem,2)), curve1, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_cbd_nrem,2)), curve2, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_veh_nrem,2)), avg_nrem_dur_bouts_veh, '-', 'color', [0.5020    0.5020    0.5020], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_veh_nrem,2)), curve3, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_veh_nrem,2)), curve4, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
legend('CBD', 'Vehicle')
title(strcat('Averaged NREM bouts duration per',{' '}, num2str(timesize), ' minutes bins'))
xlabel('Time')
ylabel('Duration (s)')
nexttile([1 1])

b1 = bar(0.5, mean(avg_nrem_dur_bouts_cbd));
hold on
ylim(t1.YLim)
hold on 
b2 = bar(1.5, mean(avg_nrem_dur_bouts_veh));
set(b1,'FaceColor',[0.4667    0.78  0.3529]);
set(b2,'FaceColor',[0.5020    0.5020    0.5020]);
hold on
scatter(ones(1,10)*0.5,mat_nrem_boutsdur2(1:10),[],'black', 'markerfacecolor', [0.4667    0.7804    0.3529], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
hold on
scatter(ones(1,9)*1.5,mat_nrem_boutsdur2(11:19),[],'black', 'markerfacecolor', [0.5020    0.5020    0.5020], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
SEM = [std(avg_nrem_dur_bouts_cbd)/sqrt(10) std(avg_nrem_dur_bouts_veh)/sqrt(9)];
er = errorbar([0.5 1.5],[mean(avg_nrem_dur_bouts_cbd) mean(avg_nrem_dur_bouts_veh)],SEM,SEM);      
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
set(gca, 'XTick', [0.5 1.5], 'XTickLabel', {'CBD','Vehicle'})
xtickangle(-30)
if P_nrem_boutsdur <= 0.05
    hold on
    plot([0.1 1.9], [1.06*max(mean(avg_nrem_dur_bouts_cbd)+SEM(1), mean(avg_nrem_dur_bouts_veh)+ SEM(2)) 1.06*max(mean(avg_nrem_dur_bouts_cbd)+SEM(1), mean(avg_nrem_dur_bouts_veh) + SEM(2))], 'black', 'LineWidth', 1)
    hold on
    scatter(1,1.1*max(mean(avg_nrem_dur_bouts_cbd)+SEM(1), mean(avg_nrem_dur_bouts_veh) + SEM(2)), '*k', 'LineWidth', 0.90)
    hold off
end

title('Average per group')

%% Bouts durations histogram
% Here we represent the histogram of the duration of bouts. First NREM,
% then REM. Plot together at the end

%NREM
nrem_bouts_cbd = [];
nrem_bouts_veh = [];
for ii = 2:19 %For this histogram, we removed first animal, rat 2, because he's weird, and that way we have as many CBD animals as VEH
    sta = STATES{ii};
    index = 1;
    bouts_index = [];
    while index < length(sta)
        if sta(index) == 2 
            index2 = index;
            while sta(index2+1) == sta(index2) & index2 < length(sta)-1
                index2 = index2 + 1;
            end
            if ismember(ii,index_cbd)
               nrem_bouts_cbd = [ nrem_bouts_cbd (index2-index+1)];
            else
               nrem_bouts_veh = [ nrem_bouts_veh  (index2-index+1)];
            end
            index = index2 + 1;
        else
            index = index + 1;
        end
    end

end

% Filter out bouts that are too short (20 sec or less)
nrem_bouts_cbd(nrem_bouts_cbd<=2)=[];
nrem_bouts_veh(nrem_bouts_veh<=2)=[];

nrem_bouts_cbd = nrem_bouts_cbd/6; %In minutes
nrem_bouts_veh = nrem_bouts_veh/6;

%Mean durations
meanbout_nrem_cbd = mean(nrem_bouts_cbd);
meanbout_nrem_veh = mean(nrem_bouts_veh);

%For the plot, we group together long bouts, longer than 25 minutes, so we
%first create a copy of data before we group together the long bouts
nrem_bouts_veh_tot = nrem_bouts_veh;
nrem_bouts_cbd_tot = nrem_bouts_cbd;

nrem_bouts_cbd(nrem_bouts_cbd>=25) = 25;
nrem_bouts_veh(nrem_bouts_veh>=25) = 25;

% REM

rem_bouts_cbd = [];
rem_bouts_veh = [];
for ii = 2:19
    sta = STATES{ii};
    index = 1;
    bouts_index = [];
    while index < length(sta)
        if sta(index) == 1 
            index2 = index;
            while sta(index2+1) == sta(index2) & index2 < length(sta)-1
                index2 = index2 + 1;
            end
            if ismember(ii,index_cbd)
               rem_bouts_cbd = [ rem_bouts_cbd (index2-index+1)];
            else
               rem_bouts_veh = [ rem_bouts_veh  (index2-index+1)];
            end
            index = index2 + 1;
        else
            index = index + 1;
        end
    end

end

% Filter out bouts that are too short (20 sec or less)
rem_bouts_cbd(rem_bouts_cbd<=2)=[];
rem_bouts_veh(rem_bouts_veh<=2)=[];

rem_bouts_cbd = rem_bouts_cbd/6; %In minutes
rem_bouts_veh = rem_bouts_veh/6;

meanbout_rem_cbd = mean(rem_bouts_cbd);
meanbout_rem_veh = mean(rem_bouts_veh);

rem_bouts_veh_tot = rem_bouts_veh;
rem_bouts_cbd_tot = rem_bouts_cbd;

rem_bouts_cbd(rem_bouts_cbd>=25) = 25;
rem_bouts_veh(rem_bouts_veh>=25) = 25;

%Plot histogram
figure
tiledlayout(1,2)
nexttile;
h1 = histogram(rem_bouts_cbd, 'BinWidth', 0.5,'FaceAlpha', 0.6, 'FaceColor',[0.4667    0.7804    0.3529] );
hold on
h2 = histogram(rem_bouts_veh, 'BinWidth', 0.5, 'FaceAlpha', 0.6, 'FaceColor',[0.502    0.502    0.502] );
hold on
xline(meanbout_rem_cbd,'--', 'color',[0.4667    0.7804    0.3529], 'LineWidth', 2 );
hold on
xline(meanbout_rem_veh, '--', 'color',[0.502    0.502    0.502], 'LineWidth', 2  );
title('Distribution of REM bouts durations')
xlabel('Duration (min)')
xticks([0 5 10 15 20 25])
xticklabels({'0','5', '10', '15', '20', '>25'})
ylim([0 85])

nexttile;
h1 = histogram(nrem_bouts_cbd, 'BinWidth', 0.5,'FaceAlpha', 0.6, 'FaceColor',[0.4667    0.7804    0.3529]);
hold on
h2 = histogram(nrem_bouts_veh, 'BinWidth', 0.5, 'FaceAlpha', 0.6, 'FaceColor',[0.502    0.502    0.502]);
title('Distribution of NREM bouts durations')
hold on
xline(meanbout_nrem_cbd, '--', 'Color',[0.4667    0.7804    0.3529], 'LineWidth', 2  );
hold on
xline(meanbout_nrem_veh, '--', 'Color',[0.502    0.502    0.502], 'LineWidth', 2  );
xlabel('Duration (min)')
xticks([0 5 10 15 20 25])
xticklabels({'0','5', '10', '15', '20', '>25'})
legend({'CBD','Vehicle'})
ylim([0 85])

T=table;
T.Variables=rem_bouts_cbd.';
filename = 'REM_bouts_cbd_count_distribution.xlsx';
writetable(T,filename,'Sheet',1,'Range','A1:Z1000')

T=table;
T.Variables=rem_bouts_veh.';
filename = 'REM_bouts_veh_count_distribution.xlsx';
writetable(T,filename,'Sheet',1,'Range','A1:Z1000')

T=table;
T.Variables=nrem_bouts_cbd.';
filename = 'NREM_bouts_cbd_count_distribution.xlsx';
writetable(T,filename,'Sheet',1,'Range','A1:Z1000')

T=table;
T.Variables=nrem_bouts_veh.';
filename = 'NREM_bouts_veh_count_distribution.xlsx';
writetable(T,filename,'Sheet',1,'Range','A1:Z1000')


% T-test

[H_nrem_dur_histo, P_nrem_dur_histo, C_nrem_dur_histo, STAT_nrem_dur_histo] = ttest2(nrem_bouts_cbd_tot, nrem_bouts_veh_tot);
[H_rem_dur_histo, P_rem_dur_histo, C_rem_dur_histo, STAT_rem_dur_histo] = ttest2(rem_bouts_cbd_tot, rem_bouts_veh_tot);
%% Overall bout durations

% Here we look at the total number of bouts and their duration, for REM and
% NREM together

mat_all_boutsnb = [];
avg_all_nb_bouts_cbd = [];
avg_all_nb_bouts_veh = [];
sem_all_nb_bouts_cbd = [];
sem_all_nb_bouts_veh = [];

mat_all_boutsdur = [];
avg_all_dur_bouts_cbd = [];
avg_all_dur_bouts_veh = [];
sem_all_dur_bouts_cbd = [];
sem_all_dur_bouts_veh = [];

for kk = 1:(N_bins-1)
    tmpcbd = cbd_align(:,(binsize*(kk-1)+1):kk*binsize);
    tmpveh = veh_align(:,(binsize*(kk-1)+1):kk*binsize);
    n1 = N(1:10,kk);
    n2 = N(11:19,kk);
    tmpcbd(isnan(tmpcbd)) = 0;
    tmpveh(isnan(tmpveh)) = 0;
    
    CBD_bin_count = [];
    CBD_bin_dur = [];
    for ii = 1:size(tmpcbd,1)
        tmp = tmpcbd(ii,:);
        index = 1;
        count = 0;
        durations = [];
        while index < length(tmp)
            if tmp(index) == 1 |  tmp(index) == 2
                count = count + 1;
                index2 = index ;
                while tmp(index2) == tmp(index2 +1) & index2 < length(tmp)-1
                    index2 = index2 + 1;
                end
                durations = [durations (index2-index+1)];
                index = index2 + 1;
            else
                index = index + 1;
            end
        end 
        CBD_bin_count = [CBD_bin_count count];
        CBD_bin_dur = [CBD_bin_dur mean(durations)];
    end
    CBD_bin_dur(isnan(CBD_bin_dur)) = 0;
    
    avg_all_nb_bouts_cbd(kk) = mean(CBD_bin_count(n1));
    avg_all_dur_bouts_cbd(kk) = mean(CBD_bin_dur(n1)*10);
    sem_all_nb_bouts_cbd(kk) = std(CBD_bin_count(n1))/sqrt(sum(n1));
    sem_all_dur_bouts_cbd(kk) = std(CBD_bin_dur(n1)*10)/sqrt(sum(n1));
    
    VEH_bin_count = [];
    VEH_bin_dur = [];
    for ii = 1:size(tmpveh,1)
        tmp = tmpveh(ii,:);
        index = 1;
        count = 0;
        durations = [];
        while index < length(tmp)
            if tmp(index) == 1 |  tmp(index) == 2 
                count = count + 1;
                index2 = index + 1;
                while tmp(index2) == tmp(index2 +1) & index2 < length(tmp)-1
                    index2 = index2 + 1;
                end
                durations = [durations (index2-index +1)];
                index = index2 + 1;
            else
                index = index + 1;
            end
        end 
        VEH_bin_count = [VEH_bin_count count];
        VEH_bin_dur = [VEH_bin_dur mean(durations)];
    end
    VEH_bin_dur(isnan(VEH_bin_dur)) = 0;
    
    avg_all_nb_bouts_veh(kk) = mean(VEH_bin_count(n2));
    avg_all_dur_bouts_veh(kk) = mean(VEH_bin_dur(n2)*10);
    sem_all_nb_bouts_veh(kk) = std(VEH_bin_count(n2))/sqrt(sum(n2));
    sem_all_dur_bouts_veh(kk) = std(VEH_bin_dur(n2)*10)/sqrt(sum(n2));

    mat_all_boutsnb = [mat_all_boutsnb [CBD_bin_count'; VEH_bin_count']];
    mat_all_boutsdur = [mat_all_boutsdur [10*CBD_bin_dur' ; 10*VEH_bin_dur']];
end

mat_all_boutsnb2 = normalize_matrix(mat_all_boutsnb,N);
mat_all_boutsdur2 = normalize_matrix(mat_all_boutsdur,N);
%t-test with averaged over whole time
for ii = 1:size(mat_all_boutsnb,1)
    tmp1 = mat_all_boutsnb2(ii,:);
    tmp2 = mat_all_boutsdur2(ii,:);
    n = N(ii,:)
    mat_all_boutsnb3(ii) = mean(tmp1(n));
    mat_all_boutsdur3(ii) = mean(tmp2(n));
end
[H_all_boutsnb,P_all_boutsnb,CI_all_boutsnb,STATS_all_boutsnb] = ttest2(mat_all_boutsnb3(1:10), mat_all_boutsnb3(11:19))
[H_all_boutsdur,P_all_boutsdur,CI_all_boutsdur,STATS_all_boutsdur] = ttest2(mat_all_boutsdur3(1:10), mat_all_boutsdur3(11:19))

%t-test only in drug time window
for ii = 1:size(mat_all_boutsnb,1)
    tmp1 = mat_all_boutsnb(ii,4:end);
    tmp2 = mat_all_boutsdur(ii,4:end);
    n = N(ii,4:end);
    mat_all_boutsnb3(ii) = mean(tmp1(n));
    mat_all_boutsdur3(ii) = mean(tmp2(n));
end
[H_all_boutsnb2,P_all_boutsnb2,CI_all_boutsnb2,STATS_all_boutsnb2] = ttest2(mat_all_boutsnb3(1:10), mat_all_boutsnb3(11:19))
[H_all_boutsdur2,P_all_boutsdur2,CI_all_boutsdur2,STATS_all_boutsdur2] = ttest2(mat_all_boutsdur3(1:10), mat_all_boutsdur3(11:19))


% ANOVA

%Bouts count

% Test 1 is: we keep all bins, and replace NaNs by the bin's average
test1 = mat_all_boutsnb;
test1(~N) = NaN;
for ii = 1:size(test1,2)
    tmp = test1(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test1(:,ii) = tmp;
end
t_all_boutsnb = table(drug, test1(:,1), test1(:,2), test1(:,3), test1(:,4), test1(:,5), test1(:,6), test1(:,7), test1(:,8), test1(:,9), test1(:,10),...
    'VariableNames', {'drug', 'bin1','bin2','bin3', 'bin4', 'bin5', 'bin6', 'bin7', 'bin8', 'bin9', 'bin10'});
Bins = table([1:10]', 'VariableNames', {'Time'});

rm_all_boutsnb = fitrm(t_all_boutsnb, 'bin1-bin10~drug', 'WithinDesign', Bins);
tbl_all_boutsnb = mauchly(rm_all_boutsnb);
ranovatbl_all_boutsnb = ranova(rm_all_boutsnb);
anovatbl_all_boutsnb = anova(rm_all_boutsnb);

%Bouts duration

% Test 1 is: we keep all bins, and replace NaNs by the bin's average
test1 = mat_all_boutsdur;
test1(~N) = NaN;
for ii = 1:size(test1,2)
    tmp = test1(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test1(:,ii) = tmp;
end
t_all_boutsdur = table(drug, test1(:,1), test1(:,2), test1(:,3), test1(:,4), test1(:,5), test1(:,6), test1(:,7), test1(:,8), test1(:,9), test1(:,10),...
    'VariableNames', {'drug', 'bin1','bin2','bin3', 'bin4', 'bin5', 'bin6', 'bin7', 'bin8', 'bin9', 'bin10'});
Bins = table([1:10]', 'VariableNames', {'Time'});

rm_all_boutsdur = fitrm(t_all_boutsdur, 'bin1-bin10~drug', 'WithinDesign', Bins);
tbl_all_boutsdur = mauchly(rm_all_boutsdur);
ranovatbl_all_boutsdur = ranova(rm_all_boutsdur);
anovatbl_all_boutsdur = anova(rm_all_boutsdur);

% Number of bouts
figure
tiledlayout(1,5)
t1 = nexttile([1 4]);
curve1 = avg_all_nb_bouts_cbd + sem_all_nb_bouts_cbd;
curve2 = avg_all_nb_bouts_cbd - sem_all_nb_bouts_cbd;
curve3 = avg_all_nb_bouts_veh + sem_all_nb_bouts_veh;
curve4 = avg_all_nb_bouts_veh - sem_all_nb_bouts_veh;

plot(linspace(time_start, time_end - duration([0 45 0]),size(average_cbd_nrem,2)), avg_all_nb_bouts_cbd, '-', 'color',[0.4667    0.7804    0.3529], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_cbd_nrem,2)), curve1, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_cbd_nrem,2)), curve2, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_veh_nrem,2)), avg_all_nb_bouts_veh, '-', 'color', [0.5020    0.5020    0.5020], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_veh_nrem,2)), curve3, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_veh_nrem,2)), curve4, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
legend('CBD', 'Vehicle')
title(strcat('Averaged bouts (REM + NREM) count per',{' '}, num2str(timesize), ' minutes bins'))

nexttile([1 1])

b1 = bar(0.5, mean(avg_all_nb_bouts_cbd));
hold on
ylim(t1.YLim)
hold on 
b2 = bar(1.5, mean(avg_all_nb_bouts_veh));
set(b1,'FaceColor',[0.4667    0.78  0.3529]);
set(b2,'FaceColor',[0.5020    0.5020    0.5020]);
hold on
scatter(ones(1,10)*0.5,mat_all_boutsnb2(1:10),[],'black', 'markerfacecolor', [0.4667    0.7804    0.3529], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
hold on
scatter(ones(1,9)*1.5,mat_all_boutsnb2(11:19),[],'black', 'markerfacecolor', [0.5020    0.5020    0.5020], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
SEM = [std(avg_all_nb_bouts_cbd)/sqrt(10) std(avg_all_nb_bouts_veh)/sqrt(9)];
er = errorbar([0.5 1.5],[mean(avg_all_nb_bouts_cbd) mean(avg_all_nb_bouts_veh)],SEM,SEM);      
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
set(gca, 'XTick', [0.5 1.5], 'XTickLabel', {'CBD','Vehicle'})
xtickangle(-30)
if P_all_boutsnb <= 0.05
    hold on
    plot([0.1 1.9], [1.06*max(mean(avg_all_nb_bouts_cbd)+SEM(1), mean(avg_all_nb_bouts_veh)+ SEM(2)) 1.06*max(mean(avg_all_nb_bouts_cbd)+SEM(1), mean(avg_all_nb_bouts_veh) + SEM(2))], 'black', 'LineWidth', 1)
    hold on
    scatter(1,1.1*max(mean(avg_all_nb_bouts_cbd)+SEM(1), mean(avg_all_nb_bouts_veh) + SEM(2)), '*k', 'LineWidth', 0.90)
    hold off
end

title('Average per group')

% Bout duration
figure
tiledlayout(1,5)
t1 = nexttile([1 4]);
curve1 = avg_all_dur_bouts_cbd + sem_all_dur_bouts_cbd;
curve2 = avg_all_dur_bouts_cbd - sem_all_dur_bouts_cbd;
curve3 = avg_all_dur_bouts_veh + sem_all_dur_bouts_veh;
curve4 = avg_all_dur_bouts_veh - sem_all_dur_bouts_veh;
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_cbd_nrem,2)), avg_all_dur_bouts_cbd, '-', 'color',[0.4667    0.7804    0.3529], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_cbd_nrem,2)), curve1, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_cbd_nrem,2)), curve2, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_veh_nrem,2)), avg_all_dur_bouts_veh, '-', 'color', [0.5020    0.5020    0.5020], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_veh_nrem,2)), curve3, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(average_veh_nrem,2)), curve4, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
legend('CBD', 'Vehicle')
title(strcat('Averaged bouts duration (NREM + REM) per',{' '}, num2str(timesize), ' minutes bins'))

nexttile([1 1])

b1 = bar(0.5, mean(avg_all_dur_bouts_cbd));
hold on
ylim(t1.YLim)
hold on 
b2 = bar(1.5, mean(avg_all_dur_bouts_veh));
set(b1,'FaceColor',[0.4667    0.78  0.3529]);
set(b2,'FaceColor',[0.5020    0.5020    0.5020]);
hold on
scatter(ones(1,10)*0.5,mat_all_boutsdur2(1:10),[],'black', 'markerfacecolor', [0.4667    0.7804    0.3529], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
hold on
scatter(ones(1,9)*1.5,mat_all_boutsdur2(11:19),[],'black', 'markerfacecolor', [0.5020    0.5020    0.5020], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
SEM = [std(avg_all_dur_bouts_cbd)/sqrt(10) std(avg_all_dur_bouts_veh)/sqrt(9)];
er = errorbar([0.5 1.5],[mean(avg_all_dur_bouts_cbd) mean(avg_all_dur_bouts_veh)],SEM,SEM);      
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
set(gca, 'XTick', [0.5 1.5], 'XTickLabel', {'CBD','Vehicle'})
xtickangle(-30)
if P_all_boutsdur <= 0.05
    hold on
    plot([0.1 1.9], [1.06*max(mean(avg_all_dur_bouts_cbd)+SEM(1), mean(avg_all_dur_bouts_veh)+ SEM(2)) 1.06*max(mean(avg_all_dur_bouts_cbd)+SEM(1), mean(avg_all_dur_bouts_veh) + SEM(2))], 'black', 'LineWidth', 1)
    hold on
    scatter(1,1.1*max(mean(avg_all_dur_bouts_cbd)+SEM(1), mean(avg_all_dur_bouts_veh) + SEM(2)), '*k', 'LineWidth', 0.90)
    hold off
end

title('Average per group')

%% Transitions
% Same principle as for REM and NREM. The difference will be that, instead
% of looking at the amount of REM/NREM in each bin, we look at the number
% of transitions between REM and NREM.
%NOTE that here we count together transitions REM-> NREM and NREM -> REM.
%When you have others stages, such as intermediate or wake, it is relevant
%to separate the direction of the transition (REM -> NREM and NREM -> REM
%for example)

% We adjust the states by ignoring the transitions into a state that last
% less than 30 seconds (3 data points). So for example if we have: 
% REM REM REM NREM REM REM REM REM
% Then we're going to assume the NREM was wrongly scored, and set it to REM
for ii = 1:nrats
    sta = STATES{ii};
    index = 1;
    while index < (length(sta)-1)
        if sta(index+1) ~= sta(index)
            index = index +1;
            dura = 1;
            while sta(index) == sta(index+1) && index < (length(sta)-1)
               dura = dura +1;
               index = index +1;
            end
            if dura < 3  
                value = sta(index +1);
                sta((index - dura +1):index) = value;
            end
            index = index +1;
        else
            index = index +1;
        end     
    end
    adjusted_states{ii} = sta;
end


% Now we have the ajusted states.
% First we align them, then we compute the diff function on it, which
% gives us 0 when there is no transition, and 1/-1 when there is a transition,
% and we group by bin size

count_transitions = [];

for ii=1:nrats
    align = ALIGNtot(ii)*6;
    trans = adjusted_states{ii};
    after = max_rec - length(trans) - align;
    aligned_trans = [ones(1, align)*trans(1) trans ones(1,after)*trans(end)]; %For the alignment here, instead of adding NaN, we artificially "extend" the first bout and last bout: that way we create no artifical transition
    aligned_trans = abs(diff(aligned_trans));
    aligned_trans = double(aligned_trans~=0);
    tmp = reshape(aligned_trans(1:N_bins*binsize), binsize, N_bins); % Group by bin
    count_transitions = [count_transitions ; sum(tmp)];
end

%count_transition(i,j) contains, for animal i, the number of transitions in
%the bin j

% Average + SEM for both groups
cbd_trans = count_transitions(index_cbd,:);
veh_trans = count_transitions(index_veh,:);
ttest_mat_trans = count_transitions;
tmp1 = ttest_mat_trans(index_cbd,:);
tmp2 = ttest_mat_trans(index_veh,:);
ttest_mat_trans = [tmp1;tmp2];
average_cbd_trans = [];
average_veh_trans = [];
sem_cbd_trans = [];
sem_veh_trans = [];

C=[];
D=[];

for kk = 1:(N_bins-1)
    tmpcbd = cbd_trans(:,kk);
    tmpveh = veh_trans(:,kk);
    n1 = N(1:10,kk);
    n2 = N(11:19,kk);
    average_cbd_trans(kk) = mean(tmpcbd(n1));
    average_veh_trans(kk) = mean(tmpveh(n2));
    sem_cbd_trans(kk) = std(tmpcbd(n1))/sqrt(sum(n1));
    sem_veh_trans(kk) = std(tmpveh(n2))/sqrt(sum(n2));
  
    C(:,2*kk-1:kk*2) = [tmpcbd n1];
    D(:,2*kk-1:kk*2) = [tmpveh n2];

end

data_table=[[ratID((logical(type))).' ; ratID(not(logical(type))).'] [ones(ncbd,1); zeros(nveh,1) ] [C;D]]

T=table;
T.Variables=data_table;
T.Properties.VariableNames={'Rat' ,'Treatment', 'Bin1' ,'Bin1_binary' ,'Bin2', 'Bin2_binary', 'Bin3' ,'Bin3_binary', 'Bin4' ,'Bin4_binary','Bin5' ,'Bin5_binary' ,'Bin6', 'Bin6_binary', 'Bin7' ,'Bin7_binary', 'Bin8', 'Bin8_binary' ,'Bin9' ,'Bin9_binary', 'Bin10' ,'Bin10_binary' }
filename = 'Transitions_counts.xlsx';
writetable(T,filename,'Sheet',1,'Range','A1:Z50')


ttest_mat_trans2 = normalize_matrix(ttest_mat_trans,N);
%t-test with averaged over whole time
for ii = 1:size(ttest_mat_trans,1)
    tmp = ttest_mat_trans2(ii,:);
    n = N(ii,:)
    ttest_mat_trans3(ii) = mean(tmp(n));

end
[H_trans,P_trans,CI_trans,STATS_trans] = ttest2(ttest_mat_trans3(1:10), ttest_mat_trans3([11 13:19]))

% RANOVA

% Test 1 is: we keep all bins, and replace NaNs by the bin's average
test1 = ttest_mat_trans;
test1(~N) = NaN;
for ii = 1:size(test1,2)
    tmp = test1(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test1(:,ii) = tmp;
end
t_trans = table(drug, test1(:,1), test1(:,2), test1(:,3), test1(:,4), test1(:,5), test1(:,6), test1(:,7), test1(:,8), test1(:,9), test1(:,10),...
    'VariableNames', {'drug', 'bin1','bin2','bin3', 'bin4', 'bin5', 'bin6', 'bin7', 'bin8', 'bin9', 'bin10'});
Bins = table([1:10]', 'VariableNames', {'Time'});

rm_trans = fitrm(t_trans, 'bin1-bin10~drug', 'WithinDesign', Bins);
tbl_trans = mauchly(rm_trans);
ranovatbl_trans = ranova(rm_trans);
anovatbl_trans = anova(rm_trans);

% Test 2 is: we only keep bins that are full (or let's say almost full)
test2 = ttest_mat_trans;
test2(~N) = NaN;
test2 = test2(:,6:9);
for ii = 1:size(test2,2)
    tmp = test2(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test2(:,ii) = tmp;
end

t_trans2 = table(drug, test2(:,1), test2(:,2), test2(:,3), test2(:,4),...
    'VariableNames', {'drug','bin6', 'bin7', 'bin8', 'bin9'});
Bins2 = table([1:4]', 'VariableNames', {'Time'});

rm_trans2 = fitrm(t_trans2, 'bin6-bin9~drug', 'WithinDesign', Bins2);
tbl_trans2 = mauchly(rm_trans2);
ranovatbl_trans2 = ranova(rm_trans2);
anovatbl_trans2 = anova(rm_trans2);

%PLOTS

figure
tiledlayout(1,5)
t1 = nexttile([1 4]);
curve1_trans = average_cbd_trans + sem_cbd_trans;
curve2_trans = average_cbd_trans - sem_cbd_trans;
curve3_trans = average_veh_trans + sem_veh_trans;
curve4_trans = average_veh_trans - sem_veh_trans;
plot(linspace(time_start, time_end - duration([0 45 0]), size(average_cbd_trans,2)), average_cbd_trans, '-', 'color', [0.4667    0.7804    0.3529], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]), size(average_cbd_trans,2)), curve1_trans, '-', 'color', [0.4667    0.78  0.3529], 'HandleVisibility','off');
hold on  
plot(linspace(time_start, time_end - duration([0 45 0]), size(average_cbd_trans,2)), curve2_trans, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]), size(average_veh_trans,2)), average_veh_trans, '-', 'color', [0.5020    0.5020    0.5020], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]), size(average_veh_trans,2)), curve3_trans, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]), size(average_veh_trans,2)), curve4_trans, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
legend('CBD','Vehicle')
title(strcat('Averaged amount of NREM/REM transitions per',{' '}, num2str(timesize), ' minutes bins'))
xlabel('Time')
ylabel('Count')
nexttile([1 1])

b1 = bar(0.5, mean(average_cbd_trans));
hold on
ylim(t1.YLim)
hold on 
b2 = bar(1.5, mean(average_veh_trans));
set(b1,'FaceColor',[0.4667    0.78  0.3529]);
set(b2,'FaceColor',[0.5020    0.5020    0.5020]);
hold on
scatter(ones(1,10)*0.5,ttest_mat_trans2(1:10),[],'black', 'markerfacecolor', [0.4667    0.7804    0.3529], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
hold on
scatter(ones(1,9)*1.5,ttest_mat_trans2(11:19),[],'black', 'markerfacecolor', [0.5020    0.5020    0.5020], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
SEM = [std(average_cbd_trans)/sqrt(10) std(average_veh_trans)/sqrt(9)];
er = errorbar([0.5 1.5],[mean(average_cbd_trans) mean(average_veh_trans)],SEM,SEM);      
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
set(gca, 'XTick', [0.5 1.5], 'XTickLabel', {'CBD','Vehicle'})
xtickangle(-30)
if P_trans <= 0.05
    hold on
    plot([0.1 1.9], [1.06*max(mean(average_cbd_trans)+SEM(1), mean(average_veh_trans)+ SEM(2)) 1.06*max(mean(average_cbd_trans)+SEM(1), mean(average_veh_trans) + SEM(2))], 'black', 'LineWidth', 1)
    hold on
    scatter(1,1.1*max(mean(average_cbd_trans)+SEM(1), mean(average_veh_trans) + SEM(2)), '*k', 'LineWidth', 0.90)
    hold off
end

title('Average per group')

%% Ripples - part1

%first we filter the HPC & PFC
HPCfilt = struct([]);
fs = 600;
e_t = 1; %s
e_samples = e_t*(fs); 

for ii = 1:length(HPC)
    HPCtmp = HPC{ii};
    nc = floor(length(HPCtmp)/e_samples); %Number of epochs
    [~, outliers_ref, rem_ep_ref] = detect_artifacts(HPCtmp, fs, e_t, 0, 99.5);
    index = 1;
    index2 = 1;
    for kk=1:nc
       if ismember(kk, rem_ep_ref)
            HPCtmp(index:index+e_samples,1) = zeros(e_samples+1,1);
            index = index + e_samples;
        else
            index = index + e_samples;
       end

    end
    HPCfilt{ii} = HPCtmp;
end

PFCfilt = struct([]);

for ii = 1:length(PFC)
    PFCtmp = PFC{ii};
    nc = floor(length(HPCtmp)/e_samples); %Number of epochs
    [~, outliers_ref, rem_ep_ref] = detect_artifacts(PFCtmp, fs, e_t, 0, 99.5);
    index = 1;
    index2 = 1;
    for kk=1:nc
       if ismember(kk, rem_ep_ref)
            HPCtmp(index:index+e_samples,1) = zeros(e_samples+1,1);
            index = index + e_samples;
        else
            index = index + e_samples;
       end

    end
    PFCfilt{ii} = PFCtmp;
end
%% Ripples - part2
% Ripple detection

SWRs = struct([]);

for ii = 1:length(HPCfilt)
    hpc = HPCfilt{ii};
    [e,f] = butter(3, [90/300 299/300]);
    hpcrip = filtfilt(e,f,hpc);

    yourtimevector = (1:length(hpcrip))/600;

    thresh = mean(hpcrip) + 5*std(hpcrip);
    [S, E, M] = findMoreRipplesLisa(hpcrip', yourtimevector, thresh, (thresh)*(1/2), ds_fhz, [] );
%     [S, E, M] = findRipplesLisa(hpcrip', yourtimevector, thresh, (thresh)*(1/2), [] );

    ripple_hpc = zeros(1,length(hpc));

    %Use this part if you want to take into account the ripple duration
%     index = 1;
%     index2 = 1;
%     while index < length(yourtimevector) & index2<length(E)  
%         if S(index2) == yourtimevector(index)
%             while E(index2) ~= yourtimevector(index)
%                 ripple_hpc(index) = 1;
%                 index = index + 1;
%             end
%             index2 = index2 + 1;
%         else
%             index = index + 1;
%         end
%     end

%     %Use this if you only want to count the number of ripples
    for kk = 1:length(M)  
        ind = floor(M(kk) * 600);
        ripple_hpc(ind) = 1;
    end

    SWRs{ii} = ripple_hpc;
end

% Align ripples

maximum = 0;
for ii = 1:length(HPCfilt)
    maximum = max(maximum, length(HPCfilt{ii}) + ALIGNtot(ii) * 600 * 60);
end

SWRs_align = [];
for ii = 1:length(HPCfilt)
    before = ALIGNtot(ii)*600*60;
    after = maximum - (length(SWRs{ii}) + before);
    SWRs_align = [SWRs_align; NaN(1, before) SWRs{ii} NaN(1, after)];
end

% Now average over bins

SWRs_CBD = SWRs_align(index_cbd,:);
SWRs_VEH = SWRs_align(index_veh,:);

binsize = timesize*60*600;
% N_bins = floor(maximum/binsize);

mat_ripples = [];
mean_swr_cbd = [];
mean_swr_veh = [];
sem_swr_cbd = [];
sem_swr_veh = [];

rip_tot_veh = [];
rip_tot_cbd = [];

for ii = 1:(N_bins-1)
    tmpswrcbd = SWRs_CBD(:,(binsize*(ii-1)+1):ii*binsize);
    tmpswrveh = SWRs_VEH(:,(binsize*(ii-1)+1):ii*binsize);
    n1 = sum(~isnan(tmpswrcbd),2);
    n1 = n1~=0;
    n2 = sum(~isnan(tmpswrveh),2);
    n2 = n2~=0;
    tmpswrcbd(isnan(tmpswrcbd)) = 0;
    tmpswrveh(isnan(tmpswrveh)) = 0;
    sum1 = sum(tmpswrcbd,2);
    sum2 = sum(tmpswrveh,2);
    mean_swr_cbd(ii) = mean(sum1(n1,:));
    mean_swr_veh(ii) = mean(sum2(n2,:));
    sem_swr_cbd(ii) = std(sum1(n1,:))/sqrt(sum(n1));
    sem_swr_veh(ii) = std(sum2(n2,:))/sqrt(sum(n2));
    rip_tot_cbd(:,ii) = sum1;
    rip_tot_veh(:,ii) = sum2;

    mat_ripples = [mat_ripples [sum1;sum2]];
    
end

addpath('C:\Users\students\Documents\Tugdual')
mat_ripples2 = normalize_matrix(mat_ripples, N);
%t-test with averaged over whole time
for ii = 1:size(mat_ripples2,1)
    tmp = mat_ripples2(ii,:);
    mat_ripples3(ii) = mean(tmp(~isnan(tmp)));
end
[H_ripples,P_ripples,CI_ripples,STATS_ripples] = ttest2(mat_ripples3(1:10), mat_ripples3(11:19))

% RANOVA

% Test 1 is: we keep all bins, and replace NaNs by the bin's average
test1 = mat_ripples;
test1(~N) = NaN;
for ii = 1:size(test1,2)
    tmp = test1(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test1(:,ii) = tmp;
end
t_rip = table(drug, test1(:,1), test1(:,2), test1(:,3), test1(:,4), test1(:,5), test1(:,6), test1(:,7), test1(:,8), test1(:,9), test1(:,10),...
    'VariableNames', {'drug', 'bin1','bin2','bin3', 'bin4', 'bin5', 'bin6', 'bin7', 'bin8', 'bin9', 'bin10'});
Bins = table([1:10]', 'VariableNames', {'Time'});

rm_rip = fitrm(t_rip, 'bin1-bin10~drug', 'WithinDesign', Bins);
tbl_rip = mauchly(rm_rip);
ranovatbl_rip = ranova(rm_rip);
anovatbl_rip = anova(rm_rip);

% Test 2 is: we only keep bins that are full (or let's say almost full)
test2 = mat_ripples;
test2(~N) = NaN;
test2 = test2(:,6:9);
for ii = 1:size(test2,2)
    tmp = test2(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test2(:,ii) = tmp;
end

t_rip2 = table(drug, test2(:,1), test2(:,2), test2(:,3), test2(:,4),...
    'VariableNames', {'drug','bin6', 'bin7', 'bin8', 'bin9'});
Bins2 = table([1:4]', 'VariableNames', {'Time'});

rm_rip2 = fitrm(t_rip2, 'bin6-bin9~drug', 'WithinDesign', Bins2);
tbl_rip2 = mauchly(rm_rip2);
ranovatbl_rip2 = ranova(rm_rip2);
anovatbl_rip2 = anova(rm_rip2);
%%
% PLOTS

figure
tiledlayout(1,5)
t1 = nexttile([1 4]);
curve1_swr = mean_swr_cbd + sem_swr_cbd;
curve2_swr = mean_swr_cbd - sem_swr_cbd;
curve3_swr = mean_swr_veh + sem_swr_veh;
curve4_swr = mean_swr_veh - sem_swr_veh;
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_swr_cbd,2)), mean_swr_cbd, '-', 'color', [0.4667    0.7804    0.3529], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_swr_cbd,2)), curve1_swr, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_swr_cbd,2)), curve2_swr, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_swr_veh,2)), mean_swr_veh, '-', 'color', [0.5020    0.5020    0.5020], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_swr_veh,2)), curve3_swr, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_swr_veh,2)), curve4_swr, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
legend('CBD','Vehicle')
title(strcat('Averaged ripple amount per',{' '}, num2str(timesize), ' minutes bins'))
xlabel('Time')
ylabel('Count')

nexttile([1 1])
b1 = bar(0.5, mean(mean_swr_cbd));
hold on
ylim(t1.YLim)
hold on 
b2 = bar(1.5, mean(mean_swr_veh));
set(b1,'FaceColor',[0.4667    0.78  0.3529]);
set(b2,'FaceColor',[0.5020    0.5020    0.5020]);
hold on
scatter(ones(1,10)*0.5, mat_ripples2(1:10),[],'black', 'markerfacecolor', [0.4667    0.7804    0.3529], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
hold on
scatter(ones(1,9)*1.5, mat_ripples2(11:19),[],'black', 'markerfacecolor', [0.5020    0.5020    0.5020], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
SEM = [std(mean_swr_cbd)/sqrt(10) std(mean_swr_veh)/sqrt(9)];
er = errorbar([0.5 1.5],[mean(mean_swr_cbd) mean(mean_swr_veh)],SEM,SEM);      
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
set(gca, 'XTick', [0.5 1.5], 'XTickLabel', {'CBD','Vehicle'})
xtickangle(-30)
if P_ripples <= 0.05
    hold on
    plot([0.1 1.9], [1.06*max(mean(mean_swr_cbd)+SEM(1), mean(mean_swr_veh)+ SEM(2)) 1.06*max(mean(mean_swr_cbd)+SEM(1), mean(mean_swr_veh) + SEM(2))], 'black', 'LineWidth', 1)
    hold on
    scatter(1,1.1*max(mean(mean_swr_cbd)+SEM(1), mean(mean_swr_veh) + SEM(2)), '*k', 'LineWidth', 0.90)
    hold off
end

title('Average per group')

%% Ripples characterization
% Ripples characterization
figure
t = tiledlayout(10,2)
titles = {'Rat 2 CBD', 'Rat 3 VEH', 'Rat 4 VEH', 'Rat 5 CBD', 'Rat 9 VEH', 'Rat 10 CBD', 'Rat 11 CBD', 'Rat 201 VEH', 'Rat 203 VEH', 'Rat 204 CBD', 'Rat 205 CBD', 'Rat 206 VEH', 'Rat 207 CBD', 'Rat 209 CBD', 'Rat 210 VEH', 'Rat 211 VEH', 'Rat 212 CBD', 'Rat 213 VEH', 'Rat 214 CBD'};
title(t,'Amount of ripples per 1 minute bin per rat')
for ii = 1:19
    ii = reorder(ii);
    t1 = nexttile;
    
    tmp = SWRs_align(ii,:);
    tmprip = tmp(~isnan(tmp));
    L = length(tmprip);
    rip_bins = 30; %bin size for the ripples count in seconds
    rip_epoch = tmprip;
    rip_epoch = reshape(rip_epoch(1:floor(L/(rip_bins*600))*rip_bins*600), rip_bins*600,floor(L/(rip_bins*600))); %separate in bins
    rip_fhz = sum(rip_epoch); %Nb of rip per second for each 1min bin   
      
    clusters = STATES{ii};
    timerange = [duration([0 0 0]) duration([0 0 length(HPC{ii})/600])];
     plot(linspace(time_start, duration([0 0 length(HPC{ii})/600]),length(clusters)), mean(clusters))
     hold on
     statesmat = zeros(5, length(clusters));
     statesmat(2,:) = clusters .* (clusters == 1); %REM
%      statesmat(4,:) = clusters .* (clusters == 3); %INT
     statesmat(4,:) = clusters .* (clusters == 2); %NREM
     imagesc(datenum(timerange), [1 5], statesmat);
     set(gca, 'YTick', [2 4], 'YTickLabel', [{'REM'}, {'NREM'}])
     if length(unique(clusters)) == 3
        colormap(t1, [1.0000    0.99    0.95; 0 0.5 1; 0.3 1 0.2; 1 0.2 0.2]);
     else
         colormap(t1, [1.0000    0.99    0.95; 0 0.5 1; 0.3 1 0.2]);
     end
     title(titles(ii))  
%      set(gca,'YDir','reverse')
     hold on
     plot(linspace(duration([0 0 0]), duration([0 0 length(HPC{ii})/600]),length(rip_fhz)), rip_fhz*7/max(rip_fhz), "color", [0.5 0.5 0.5])
     %Uncomment this line to plot rate of change in ripple instead of
     %amount of ripple
%      plot(linspace(time_start, duration([0 0 (length(HPC{ii})-1)/600]),length(rip_fhz)-1), diff(rip_fhz), "color", [0.5 0.5 0.5])

end

%% Rat 203
figure
t = tiledlayout(2,1)

ii = 9
    t1 = nexttile;

    tmp = SWRs_align(ii,:);
    tmprip = tmp(~isnan(tmp));
    L = length(tmprip);
    rip_bins = 30; %bin size for the ripples count in seconds
    rip_epoch = tmprip;
    rip_epoch = reshape(rip_epoch(1:floor(L/(rip_bins*600))*rip_bins*600), rip_bins*600,floor(L/(rip_bins*600))); %separate in bins
    rip_fhz = sum(rip_epoch); %Nb of rip per second for each 1min bin   
      
    clusters = STATES{ii};
    timerange = [duration([0 0 0]) duration([0 0 length(HPC{ii})/600])];
     plot(linspace(time_start, duration([0 0 length(HPC{ii})/600]),length(clusters)), mean(clusters))
     hold on
     statesmat = zeros(5, length(clusters));
     statesmat(2,:) = clusters .* (clusters == 1); %REM
%      statesmat(4,:) = clusters .* (clusters == 3); %INT
     statesmat(4,:) = clusters .* (clusters == 2); %NREM
     imagesc(datenum(timerange), [1 5], statesmat);
     set(gca, 'YTick', [2 4], 'YTickLabel', [{'REM'}, {'NREM'}])
     if length(unique(clusters)) == 3
        colormap(t1, [1.0000    0.99    0.95; 0 0.5 1; 0.3 1 0.2; 1 0.2 0.2]);
     else
         colormap(t1, [1.0000    0.99    0.95; 0 0.5 1; 0.3 1 0.2]);
     end
     title('Amount of ripples per 30 seconds bin, rat 203, VEH')  
%      set(gca,'YDir','reverse')
     hold on
     plot(linspace(duration([0 0 0]), duration([0 0 length(HPC{ii})/600]),length(rip_fhz)), rip_fhz*7/max(rip_fhz), "color", [0.5 0.5 0.5])
     %Uncomment this line to plot rate of change in ripple instead of
     %amount of ripple
%      plot(linspace(time_start, duration([0 0 (length(HPC{ii})-1)/600]),length(rip_fhz)-1), diff(rip_fhz), "color", [0.5 0.5 0.5])
t2 = nexttile;

L = length(BPLfilt_SW_peaks{ii});
    spwpeak = BPLfilt_SW_peaks{ii};
    N_SW = sum(spwpeak); %Number of SW
    sw_bins = 30; %bin size for the sharp waves count in seconds
    sw_epoch = ~isnan(spwpeak);
    sw_epoch = reshape(sw_epoch(1:floor(L/(sw_bins*600))*sw_bins*600), sw_bins*600,floor(L/(sw_bins*600))); %separate in bins
    sw_fhz = sum(sw_epoch); %Nb of SW per second for each bin   
    xlabel('Time')

    clusters = STATES{ii};
    timerange = [duration([0 0 0]) duration([0 0 length(HPC{ii})/600])];
     plot(linspace(time_start, duration([0 0 length(HPC{ii})/600]),length(clusters)), mean(clusters))
     hold on
     statesmat = zeros(5, length(clusters));
     statesmat(2,:) = clusters .* (clusters == 1); %REM
     statesmat(4,:) = clusters .* (clusters == 2); %NREM
     imagesc(datenum(timerange), [1 5], statesmat);
     set(gca, 'YTick', [2 4], 'YTickLabel', [{'REM'}, {'NREM'}])
     if length(unique(clusters)) == 3
        colormap(t2, [1.0000    0.99    0.95; 0 0.5 1; 0.3 1 0.2; 1 0.2 0.2]);
     else
         colormap(t2, [1.0000    0.99    0.95; 0 0.5 1; 0.3 1 0.2]);
     end
     title('Amount of sharp waves per 30 seconds bin, rat 203, VEH')
     hold on
     plot(linspace(duration([0 0 0]), duration([0 0 length(HPC{ii})/600]),length(sw_fhz)), sw_fhz*7/max(sw_fhz), "color", [0.5 0.5 0.5])

%% Ripple durations, number, and freq, between groups
% number and durations of ripples
count_rip = [];
dur_rip = struct([]);
fhz_rip = struct([]);
rip_ampl = struct([]);
rip_ampl2 = struct([]);
BPL_ampl = struct([]);

for ii = 1:length(HPCfilt)
    tic
    disp(strcat('Rat', {' '}, num2str(ii)))
    hpc = HPCfilt{ii};
    [e,f] = butter(3, [80/300 299/300]);
    hpcrip = filtfilt(e,f,hpc);
    sta = STATES{ii};
    sta = repelem(sta, 600*10);
    sta = sta(1:min(length(hpc),length(sta)));
    rem = hpc(sta==1);
    signal_ampl = quantile(rem,0.95) - quantile(rem, 0.05);
    yourtimevector = (1:length(hpcrip))/600;

    thresh = mean(hpcrip) + 5*std(hpcrip);
    [S, E, M] = findMoreRipplesLisa(hpcrip', yourtimevector, thresh, (thresh)*(1/2), ds_fhz, [] );
    count_rip = [count_rip;length(M)/(length(hpcrip)/600/60)] ; %number of ripples per minute
    dur_rip{ii} = (E - S)*1000;
    fhz = [];
    ampl = [];
    bpl = BPLfilt_SW_peaks{ii};
    bplampl = [];
    for jj = 1:length(M)
        start = find(yourtimevector == S(jj));
        fin = find(yourtimevector == E(jj));
        ripple = hpcrip(start:fin);
        [pxx,f] = pmtm(ripple,4,[],600);
        ripple_frequency = meanfreq(pxx, 600, [80 290]);
        fhz = [fhz;ripple_frequency];
        ampl = [ampl; peak2peak(ripple)];
        bplampl = [bplampl; peak2peak(bpl(start:fin))];
    end
    fhz_rip{ii} = fhz;
    rip_ampl{ii} = ampl;
    rip_ampl2{ii} = ampl/signal_ampl;
    BPL_ampl{ii} = bplampl;
    toc
end
rip_dur_cbd = [];
rip_dur_veh = [];
fhz_rip_cbd = [];
fhz_rip_veh = [];
rip_ampl_cbd = [];
rip_ampl_veh = [];
rip_ampl_cbd2 = [];
rip_ampl_veh2 = [];
BPL_ampl_cbd = [];
BPL_ampl_veh = [];
for ii = index_cbd
    rip_dur_cbd = [rip_dur_cbd dur_rip{ii}];
    fhz_rip_cbd = [fhz_rip_cbd fhz_rip{ii}'];
    rip_ampl_cbd = [rip_ampl_cbd rip_ampl{ii}'];
    rip_ampl_cbd2 = [rip_ampl_cbd2 rip_ampl2{ii}'];
    BPL_ampl_cbd = [BPL_ampl_cbd BPL_ampl{ii}'];
end
for ii = index_veh
    rip_dur_veh = [rip_dur_veh dur_rip{ii}];
    fhz_rip_veh = [fhz_rip_veh fhz_rip{ii}'];
    rip_ampl_veh = [rip_ampl_veh rip_ampl{ii}'];
    rip_ampl_veh2 = [rip_ampl_veh2 rip_ampl2{ii}'];
    BPL_ampl_veh = [BPL_ampl_veh BPL_ampl{ii}'];
end
% Plots
% number of ripples

figure
b1 = bar(0.5, mean(count_rip(index_cbd)));
hold on
hold on 
b2 = bar(1.5, mean(count_rip(index_veh)));
set(b1,'FaceColor',[0.4667    0.78  0.3529]);
set(b2,'FaceColor',[0.5020    0.5020    0.5020]);
hold on
scatter(ones(1,10)*0.5, count_rip(index_cbd),[],'black', 'markerfacecolor', [0.4667    0.7804    0.3529], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
hold on
scatter(ones(1,9)*1.5, count_rip(index_veh),[],'black', 'markerfacecolor', [0.5020    0.5020    0.5020], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
SEM = [std(count_rip(index_cbd))/sqrt(10) std(count_rip(index_veh))/sqrt(9)];
er = errorbar([0.5 1.5],[mean(count_rip(index_cbd)) mean(count_rip(index_veh))],SEM,SEM);      
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
set(gca, 'XTick', [0.5 1.5], 'XTickLabel', {'CBD','Vehicle'})
xtickangle(-30)
title('Number of ripples per minute averaged for both group')


%Ripple durations
figure
h1 = histogram(rip_dur_cbd,'FaceAlpha', 0.4, 'FaceColor',[0.4667    0.7804    0.3529]);
hold on
h2 = histogram(rip_dur_veh, 'FaceAlpha', 0.6, 'FaceColor',[0.502    0.502    0.502]);
title('Distribution of ripple durations')
xlabel('Duration (ms)')
legend({'CBD', 'Vehicle'})
[h,pval, c, stats] = ttest2(rip_dur_cbd, rip_dur_veh);
if pval<0.05
    hold on
    p = plot([100 220], [1600 1600], 'black', 'LineWidth', 1)
    hold on
    s = scatter(160,1630, '*k', 'LineWidth', 0.90)
    hold off
end
set(get(get(p,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(s,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');

%Ripple mean power
figure
h1 = histogram(fhz_rip_cbd,'FaceAlpha', 0.4, 'FaceColor',[0.4667    0.7804    0.3529]);
hold on
h2 = histogram(fhz_rip_veh, 'FaceAlpha', 0.6, 'FaceColor',[0.502    0.502    0.502]);
title('Distribution of ripple mean frequencies')
xlabel('Mean frequency (Hz)')
legend({'CBD', 'Vehicle'})
[h,pval,c,stats] = ttest2(fhz_rip_cbd, fhz_rip_veh)
if pval<0.05
    hold on
    p = plot([100 220], [1600 1600], 'black', 'LineWidth', 1)
    hold on
    s = scatter(160,1630, '*k', 'LineWidth', 0.90)
    hold off
end
set(get(get(p,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(s,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');

%Amplitude
rip_ampl_cbd2(rip_ampl_cbd2 == max(rip_ampl_cbd2)) = mean(rip_ampl_cbd2);

figure
h1 = histogram(rip_ampl_cbd2,'FaceAlpha', 0.4, 'FaceColor',[0.4667    0.7804    0.3529]);
hold on
h2 = histogram(rip_ampl_veh2, 'BinWidth', h1.BinWidth, 'FaceAlpha', 0.6, 'FaceColor',[0.502    0.502    0.502]);
title('Distribution of the ripples amplitudes')
xlabel('Normalized peak to trough amplitude')
legend({'CBD', 'Vehicle'})

[h,pval,c,stats] = ttest2(rip_ampl_cbd2, rip_ampl_veh2)
if pval<0.05
    hold on
    p = plot([0.3 0.7], [2000 2000], 'black', 'LineWidth', 1)
    hold on
    s = scatter(0.5,2050, '*k', 'LineWidth', 0.90)
    hold off
end
set(get(get(p,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(s,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');

%% Ripples per bout

for ii = 1:19
    sta = STATES{ii};
    index = 1;
    bouts_index = [];
    while index < length(sta)
        if sta(index) == 2 
            index2 = index;
            while sta(index2+1) == sta(index2) & index2 < length(sta)-1
                index2 = index2 + 1;
            end
            bouts_index = [bouts_index ; [index index2 sta(index2)]];
            index = index2 + 1;
        else
            index = index + 1;
        end
    end

    tmp = SWRs_align(ii,:);
    tmprip = tmp(~isnan(tmp));
    L = length(tmprip);
    rip_bins = 10; %bin size for the ripples count in seconds
    rip_epoch = tmprip;
    rip_epoch = reshape(rip_epoch(1:floor(L/(rip_bins*600))*rip_bins*600), rip_bins*600,floor(L/(rip_bins*600))); %separate in bins
    rip_fhz = sum(rip_epoch); %Nb of rip per bin 
    rip_fhz = [rip_fhz zeros(1,length(sta)-length(rip_fhz))];
    
%     ripples = ~isnan(SWRs_align(ii,:))'; % in 600 points = 1 second
    longest_bout = max(bouts_index(:,2) - bouts_index(:,1)); % in 10 seconds bins
    bouts_align_start = [];
    bouts_align_end = [];
    for jj = 1:size(bouts_index,1)
        start = bouts_index(jj,1);
        stop = bouts_index(jj,2);
        if (stop-start) > 3
            bouts_align_start = [bouts_align_start ; rip_fhz(start:stop) zeros(1,longest_bout - (stop-start))];
            bouts_align_end = [bouts_align_end ; zeros(1,longest_bout - (stop-start)) rip_fhz(start:stop)];
        end
    end

    group_bouts_start = [];
    group_bouts_end = [];
    for jj = 1:size(bouts_align_start,1)
        bout_start = bouts_align_start(jj,:);
        bout_reshape_start = reshape(bout_start(1:(floor(length(bout_start)/3))*3),3,floor(length(bout_start)/3));
        group_bouts_start = [group_bouts_start; sum(bout_reshape_start)];

        bout_end = bouts_align_end(jj,:);
        bout_reshape_end = reshape(bout_end(1:(floor(length(bout_end)/3))*3),3,floor(length(bout_end)/3));
        group_bouts_end = [group_bouts_end; sum(bout_reshape_end)];
    end
    
    if ii == 1 | ii == 11
        figure
        tiledlayout(10,2)
    end
    nexttile
    for jj=1:size(group_bouts_start,1)
        plot(group_bouts_start(jj,:))
        hold on
    end
    plot(mean(group_bouts_start), 'black', 'LineWidth', 2)
    title('Bouts aligned on their beginning')

     nexttile
    for jj=1:size(group_bouts_end,1)
        plot(group_bouts_end(jj,:))
        hold on
    end
    plot(mean(group_bouts_end), 'black', 'LineWidth', 2)
    title('Bouts aligned on their end')

end

%% Sharp Waves

%First we need to filter the BPL (Below Pyramidal Layer)

BPLfilt = struct([]);
fs = 600;
e_t = 1; %s
e_samples = e_t*(fs); 

for ii = 1:length(BPL)
    BPLtmp = BPL{ii};
    nc = floor(length(BPLtmp)/e_samples); %Number of epochs
    [~, outliers_ref, rem_ep_ref] = detect_artifacts(BPLtmp, fs, e_t, 0, 99.5);
    index = 1;
    index2 = 1;
    for kk=1:nc
       if ismember(kk, rem_ep_ref)
            BPLtmp(index:index+e_samples,1) = ones(e_samples+1,1);
            index = index + e_samples;
        else
            index = index + e_samples;
       end

    end
    BPLfilt{ii} = BPLtmp;
end

%% Sharp Waves P2

BPLfilt_SW_peaks = struct([]);

%Band pass filter to better see the sharp waves
for ii = 1:length(BPL)
    bpl = BPLfilt{ii};
    [c,d] = butter(3, [1/300 20/300]);
    tmp = filtfilt(c,d, bpl);
    spw = double(tmp <= -5*std(tmp));
    dspw = abs(diff(spw));

    L = length(bpl);
    %Get the local peak of each sharp wave
    spwpeak = NaN(L,1);
    index = 1;

    while index < L
        if dspw(index) == 1
            index2 = index;
            index = index+1;
            while dspw(index) == 0
                index = index + 1;
            end
            locmin = min(bpl((index2+1):(index+1)));
            if locmin<=-5*std(tmp)
                indmin = find(bpl == locmin);
                spwpeak(indmin) = locmin;;
            end
            index = index+1;
        else
            index = index+1;
        end
    end
    BPLfilt_SW_peaks{ii} = spwpeak;
end

% Mean in each group
% Need to align first
sw_align = struct([]);

max_sw = 0;
for ii = 1:length(BPL)
    max_sw = max(max_sw, length(BPLfilt_SW_peaks{ii}) + ALIGNtot(ii) * 600 * 60);
end

for ii = 1:length(BPL)
    before = ALIGNtot(ii)*600*60;
    after = maximum - (length(BPLfilt_SW_peaks{ii}) + before);
    sw_align{ii} = [NaN(1, before) ~isnan(BPLfilt_SW_peaks{ii})' NaN(1, after)];
end

sw_cbd_align = [];
sw_veh_align = [];

for ii = 1:length(index_cbd)
    sw_cbd_align = [sw_cbd_align; sw_align{index_cbd(ii)}];
end

for ii = 1:length(index_veh)
    sw_veh_align = [sw_veh_align; sw_align{index_veh(ii)}];
end

%Now average

binsize = timesize*60*600;

mat_sw = [];
mean_sw_cbd = [];
mean_sw_veh = [];
sem_sw_cbd = [];
sem_sw_veh = [];

for ii = 1:(N_bins-1)
    tmpswrcbd = sw_cbd_align(:,(binsize*(ii-1)+1):ii*binsize);
    tmpswrveh = sw_veh_align(:,(binsize*(ii-1)+1):ii*binsize);
    n1 = sum(~isnan(tmpswrcbd),2);
    n1 = n1~=0;
    n2 = sum(~isnan(tmpswrveh),2);
    n2 = n2~=0;
    tmpswrcbd(isnan(tmpswrcbd)) = 0;
    tmpswrveh(isnan(tmpswrveh)) = 0;
    sum1 = sum(tmpswrcbd,2);
    sum2 = sum(tmpswrveh,2);
    mean_sw_cbd(ii) = mean(sum1(n1,:));
    mean_sw_veh(ii) = mean(sum2(n2,:));
    sem_sw_cbd(ii) = std(sum1(n1,:))/sqrt(sum(n1));
    sem_sw_veh(ii) = std(sum2(n2,:))/sqrt(sum(n2));
    
    mat_sw = [mat_sw [sum1;sum2]];
end

mat_sw2 = normalize_matrix(mat_sw,N);
%t-test with averaged over whole time
for ii = 1:size(mat_sw,1)
    tmp = mat_sw2(ii,:);
    mat_sw3(ii) = mean(tmp(~isnan(tmp)));
end
[H_sw,P_sw,CI_sw,STATS_sw] = ttest2(mat_sw3(1:10), mat_sw3(11:19))


%ANOVA

% Test 1 is: we keep all bins, and replace NaNs by the bin's average
test1 = mat_sw;
test1(~N) = NaN;
for ii = 1:size(test1,2)
    tmp = test1(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test1(:,ii) = tmp;
end
t_sw = table(drug, test1(:,1), test1(:,2), test1(:,3), test1(:,4), test1(:,5), test1(:,6), test1(:,7), test1(:,8), test1(:,9), test1(:,10),...
    'VariableNames', {'drug', 'bin1','bin2','bin3', 'bin4', 'bin5', 'bin6', 'bin7', 'bin8', 'bin9', 'bin10'});
Bins = table([1:10]', 'VariableNames', {'Time'});

rm_sw = fitrm(t_sw, 'bin1-bin10~drug', 'WithinDesign', Bins);
tbl_sw = mauchly(rm_sw);
ranovatbl_sw = ranova(rm_sw);
anovatbl_sw = anova(rm_sw);

% Test 2 is: we only keep bins that are full (or let's say almost full)
test2 = mat_sw;
test2(~N) = NaN;
test2 = test2(:,6:9);
for ii = 1:size(test2,2)
    tmp = test2(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test2(:,ii) = tmp;
end

t_sw2 = table(drug, test2(:,1), test2(:,2), test2(:,3), test2(:,4),...
    'VariableNames', {'drug','bin6', 'bin7', 'bin8', 'bin9'});
Bins2 = table([1:4]', 'VariableNames', {'Time'});

rm_sw2 = fitrm(t_sw2, 'bin6-bin9~drug', 'WithinDesign', Bins2);
tbl_sw2 = mauchly(rm_sw2);
ranovatbl_sw2 = ranova(rm_sw2);
anovatbl_sw2 = anova(rm_sw2);

%PLOT

figure

tiledlayout(1,5)
t1 = nexttile([1 4]);

curve1_sw = mean_sw_cbd + sem_sw_cbd;
curve2_sw = mean_sw_cbd - sem_sw_cbd;
curve3_sw = mean_sw_veh + sem_sw_veh;
curve4_sw = mean_sw_veh - sem_sw_veh;
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_sw_cbd,2)), mean_sw_cbd, '-', 'color', [0.4667    0.7804    0.3529], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_sw_cbd,2)), curve1_sw, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_sw_cbd,2)), curve2_sw, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_sw_veh,2)), mean_sw_veh, '-', 'color', [0.5020    0.5020    0.5020], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_sw_veh,2)), curve3_sw, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_sw_veh,2)), curve4_sw, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
legend('CBD','Vehicle')
title(strcat('Averaged sharp waves amount per',{' '}, num2str(timesize), ' minutes bins'))
xlabel('Time')
ylabel('Count')
nexttile([1 1])

b1 = bar(0.5, mean(mean_sw_cbd));
hold on
ylim(t1.YLim)
hold on 
b2 = bar(1.5, mean(mean_sw_veh));
set(b1,'FaceColor',[0.4667    0.78  0.3529]);
set(b2,'FaceColor',[0.5020    0.5020    0.5020]);
hold on
scatter(ones(1,10)*0.5, mat_sw2(1:10),[],'black', 'markerfacecolor', [0.4667    0.7804    0.3529], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
hold on
scatter(ones(1,9)*1.5, mat_sw2(11:19),[],'black', 'markerfacecolor', [0.5020    0.5020    0.5020], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
SEM = [std(mean_sw_cbd)/sqrt(10) std(mean_sw_veh)/sqrt(9)];
er = errorbar([0.5 1.5],[mean(mean_sw_cbd) mean(mean_sw_veh)],SEM,SEM);      
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
set(gca, 'XTick', [0.5 1.5], 'XTickLabel', {'CBD','Vehicle'})
xtickangle(-30)
if P_sw <= 0.05
    hold on
    plot([0.1 1.9], [1.06*max(mean(mean_sw_cbd)+SEM(1), mean(mean_sw_veh)+ SEM(2)) 1.06*max(mean(mean_sw_cbd)+SEM(1), mean(mean_sw_veh) + SEM(2))], 'black', 'LineWidth', 1)
    hold on
    scatter(1,1.1*max(mean(mean_sw_cbd)+SEM(1), mean(mean_sw_veh) + SEM(2)), '*k', 'LineWidth', 0.90)
    hold off
end

title('Average per group')

%% Sharp waves characterization

% Sharp Waves characterization
figure
t = tiledlayout(10,2);
titles = {'Rat 2 CBD', 'Rat 3 VEH', 'Rat 4 VEH', 'Rat 5 CBD', 'Rat 9 VEH', 'Rat 10 CBD', 'Rat 11 CBD', 'Rat 201 VEH', 'Rat 203 VEH', 'Rat 204 CBD', 'Rat 205 CBD', 'Rat 206 VEH', 'Rat 207 CBD', 'Rat 209 CBD', 'Rat 210 VEH', 'Rat 211 VEH', 'Rat 212 CBD', 'Rat 213 VEH', 'Rat 214 CBD'};
title(t,'Amount of sharp waves per 1 minute bin per rat')
for ii = 1:length(BPL)
    ii = reorder(ii);
    t1 = nexttile;
        
    L = length(BPLfilt_SW_peaks{ii});
    spwpeak = BPLfilt_SW_peaks{ii};
    N_SW = sum(spwpeak); %Number of SW
    sw_bins = 30; %bin size for the sharp waves count in seconds
    sw_epoch = ~isnan(spwpeak);
    sw_epoch = reshape(sw_epoch(1:floor(L/(sw_bins*600))*sw_bins*600), sw_bins*600,floor(L/(sw_bins*600))); %separate in bins
    sw_fhz = sum(sw_epoch); %Nb of SW per second for each bin   
    

    clusters = STATES{ii};
    timerange = [duration([0 0 0]) duration([0 0 length(HPC{ii})/600])];
     plot(linspace(time_start, duration([0 0 length(HPC{ii})/600]),length(clusters)), mean(clusters))
     hold on
     statesmat = zeros(5, length(clusters));
     statesmat(2,:) = clusters .* (clusters == 1); %REM
     statesmat(4,:) = clusters .* (clusters == 2); %NREM
     imagesc(datenum(timerange), [1 5], statesmat);
     set(gca, 'YTick', [2 4], 'YTickLabel', [{'REM'}, {'NREM'}])
     if length(unique(clusters)) == 3
        colormap(t1, [1.0000    0.99    0.95; 0 0.5 1; 0.3 1 0.2; 1 0.2 0.2]);
     else
         colormap(t1, [1.0000    0.99    0.95; 0 0.5 1; 0.3 1 0.2]);
     end
     title(titles(ii))  
     hold on
     plot(linspace(duration([0 0 0]), duration([0 0 length(HPC{ii})/600]),length(sw_fhz)), sw_fhz*7/max(sw_fhz), "color", [0.5 0.5 0.5])


end

%% Comparison SW features between groups
count_sw = [];
amplitude_sw = struct([]);
for ii = 1:19
    bpl = BPLfilt{ii};
    sta = STATES{ii};
    sta = repelem(sta, 600*10);
    sta = sta(1:min(length(bpl),length(sta)));
    rem = bpl(sta==1);
    rem_ampl = quantile(rem,0.95) - quantile(rem, 0.05); %We use rem amplitude as a metric of the signal amplitude, as it's supposed to be more or less the same (theta oscillations)
    sw_peaks = BPLfilt_SW_peaks{ii};
    count_sw = [count_sw;sum(~isnan(sw_peaks))/(length(sw_peaks)/600/60)];
    ampl = (mean(bpl) - sw_peaks(~isnan(sw_peaks)))/rem_ampl;
    amplitude_sw{ii} = ampl;
end
amplitude_sw_cbd = [];
amplitude_sw_veh = [];
for ii=index_cbd
    amplitude_sw_cbd = [amplitude_sw_cbd; amplitude_sw{ii}];
end
for ii=index_veh
    amplitude_sw_veh = [amplitude_sw_veh; amplitude_sw{ii}];
end

%SW amplitude
amplitude_sw_cbd(amplitude_sw_cbd == max(amplitude_sw_cbd)) = mean(amplitude_sw_cbd);
figure
h1 = histogram(amplitude_sw_cbd,'FaceAlpha', 0.4, 'FaceColor',[0.4667    0.7804    0.3529]);
hold on
h2 = histogram(amplitude_sw_veh, 'BinWidth', h1.BinWidth, 'FaceAlpha', 0.6, 'FaceColor',[0.502    0.502    0.502]);
title('Distribution of the SWs amplitudes')
xlabel('Normalized sharp wave amplitude')
% xlim([0 4000])
% ylim([0 750])
legend([h1 h2],'CBD', 'Vehicle')
[h,pval, c, stats] = ttest2(amplitude_sw_cbd, amplitude_sw_veh)
if pval<0.05
    hold on
    p = plot([1.6 2.6], [550 550], 'black', 'LineWidth', 1)
    hold on
    s = scatter(2.1,570, '*k', 'LineWidth', 0.90)
    hold off
end
set(get(get(p,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(s,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');


%% SW per bout
% Analysis of sharp waves per NREM bout
for ii = 1:19
    sta = STATES{ii};
    index = 1;
    bouts_index = [];
    while index < length(sta)
        if sta(index) == 2 
            index2 = index;
            while sta(index2+1) == sta(index2) & index2 < length(sta)-1
                index2 = index2 + 1;
            end
            bouts_index = [bouts_index ; [index index2 sta(index2)]];
            index = index2 + 1;
        else
            index = index + 1;
        end
    end

    spwpeak = BPLfilt_SW_peaks{ii};
    L = length(BPLfilt_SW_peaks{ii});
        sw_bins = 30; %bin size for the sharp waves count in seconds
        sw_epoch = ~isnan(spwpeak);
        sw_epoch = reshape(sw_epoch(1:floor(L/(sw_bins*600))*sw_bins*600), sw_bins*600,floor(L/(sw_bins*600))); %separate in bins
        sw_fhz = sum(sw_epoch); %Nb of SW per second for each bin   


    spwpeak = ~isnan(BPLfilt_SW_peaks{ii});
    longest_bout = max(bouts_index(:,2) - bouts_index(:,1));
    bouts_align_start = [];
    bouts_align_end = [];
    for jj = 1:size(bouts_index,1)
        start = bouts_index(jj,1);
        stop = bouts_index(jj,2);
        if (stop-start) > 3
            bouts_align_start = [bouts_align_start ; spwpeak(((start-1)*6000+1):stop*6000)' zeros(1,6000*longest_bout - (stop-start)*6000)];
            bouts_align_end = [bouts_align_end ; zeros(1,6000*longest_bout - (stop-start)*6000) spwpeak(((start-1)*6000+1):stop*6000)' ];
        end
    end

    group_bouts_start = [];
    group_bouts_end = [];
    for jj = 1:size(bouts_align_start,1)
        bout_start = bouts_align_start(jj,:);
        bout_reshape_start = reshape(bout_start(1:(floor(length(bout_start)/(30*600)))*30*600),30*600,floor(length(bout_start)/(30*600)));
        group_bouts_start = [group_bouts_start; sum(bout_reshape_start)];

        bout_end = bouts_align_end(jj,:);
        bout_reshape_end = reshape(bout_end(1:(floor(length(bout_end)/(30*600)))*30*600),30*600,floor(length(bout_end)/(30*600)));
        group_bouts_end = [group_bouts_end; sum(bout_reshape_end)];

    end
    if ii == 1 | ii == 11
        figure
        tiledlayout(10,2)
    end
    nexttile
    for jj=1:size(group_bouts_start,1)
        plot(group_bouts_start(jj,:))
        hold on
    end
    plot(mean(group_bouts_start), 'black', 'LineWidth', 2)
    title('Bouts aligned on their beginning')

     nexttile
    for jj=1:size(group_bouts_end,1)
        plot(group_bouts_end(jj,:))
        hold on
    end
    plot(mean(group_bouts_end), 'black', 'LineWidth', 2)
    title('Bouts aligned on their end')

end


%% Theta power 3 - 6

% 10 sec epochs
theta_pwr = struct([]);

for ii=1:length(HPCfilt) %For each  brain area, we compute the spectogram and features that will be included in the PCA
        epdata = data2ep(HPCfilt{ii}, 10, 600); %We use 10 seconds long epochs here, because too short = doesn't detect slow oscillations
        [pxx,f] = pmtm(epdata,4,[],ds_fhz);
    
        %Heatmap of power, for visualizing purposes
        pwr = [];

        for jj=1:size(epdata,2)
                pwr(jj) = spectral_power(3,6, jj, pxx, f);
        end
        theta_pwr{ii} = pwr;
end

% Align the data

theta_pwr_align = [];

for ii = 1:length(theta_pwr)
    before = ALIGNtot(ii)*6;
    after = max_rec - (length(theta_pwr{ii}) + ALIGNtot(ii)*6);
    theta_pwr_align = [theta_pwr_align; NaN(1,before) theta_pwr{ii} NaN(1, after)];
end

% Now compute mean

theta_pwr_cbd = theta_pwr_align(index_cbd,:);
theta_pwr_veh = theta_pwr_align(index_veh,:);

binsize = timesize*6;
N_bins = floor(max_rec/binsize);

mat_theta = [];
mean_theta_cbd = [];
mean_theta_veh = [];
sem_theta_cbd = [];
sem_theta_veh = [];

for ii = 1:(N_bins-1)
    tmpthetacbd = theta_pwr_cbd(:,(binsize*(ii-1)+1):ii*binsize);
    tmpthetaveh = theta_pwr_veh(:,(binsize*(ii-1)+1):ii*binsize);
    n1 = sum(~isnan(tmpthetacbd),2);
    n1 = n1~=0;
    n2 = sum(~isnan(tmpthetaveh),2);
    n2 = n2~=0;
    tmpthetacbd(isnan(tmpthetacbd)) = 0;
    tmpthetaveh(isnan(tmpthetaveh)) = 0;
    sum1 = sum(tmpthetacbd,2);
    sum2 = sum(tmpthetaveh,2);
    mean_theta_cbd(ii) = mean(sum1(n1,:));
    mean_theta_veh(ii) = mean(sum2(n2,:));
    sem_theta_cbd(ii) = std(sum1(n1,:))/sqrt(sum(n1));
    sem_theta_veh(ii) = std(sum2(n2,:))/sqrt(sum(n2));
    
    mat_theta = [mat_theta [sum1;sum2]];
    
end

%t-test with averaged over whole time
mat_theta2 = normalize_matrix(mat_theta,N);
for ii = 1:size(mat_theta,1)
    tmp = mat_theta2(ii,:);
    mat_theta3(ii) = mean(tmp(~isnan(tmp)));
end
[H_theta,P_theta,CI_theta,STATS_theta] = ttest2(mat_theta3(1:10), mat_theta3(11:19))


%ANOVA

% Test 1 is: we keep all bins, and replace NaNs by the bin's average
test1 = mat_theta;
test1(~N) = NaN;
for ii = 1:size(test1,2)
    tmp = test1(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test1(:,ii) = tmp;
end
t_theta = table(drug, test1(:,1), test1(:,2), test1(:,3), test1(:,4), test1(:,5), test1(:,6), test1(:,7), test1(:,8), test1(:,9), test1(:,10),...
    'VariableNames', {'drug', 'bin1','bin2','bin3', 'bin4', 'bin5', 'bin6', 'bin7', 'bin8', 'bin9', 'bin10'});
Bins = table([1:10]', 'VariableNames', {'Time'});

rm_theta = fitrm(t_theta, 'bin1-bin10~drug', 'WithinDesign', Bins);
tbl_theta = mauchly(rm_theta);
ranovatbl_theta = ranova(rm_theta);
anovatbl_theta = anova(rm_theta);

% Test 2 is: we only keep bins that are full (or let's say almost full)
test2 = mat_theta;
test2(~N) = NaN;
test2 = test2(:,6:9);
for ii = 1:size(test2,2)
    tmp = test2(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test2(:,ii) = tmp;
end

t_theta2 = table(drug, test2(:,1), test2(:,2), test2(:,3), test2(:,4),...
    'VariableNames', {'drug','bin6', 'bin7', 'bin8', 'bin9'});
Bins2 = table([1:4]', 'VariableNames', {'Time'});

rm_theta2 = fitrm(t_theta2, 'bin6-bin9~drug', 'WithinDesign', Bins2);
tbl_theta2 = mauchly(rm_theta2);
ranovatbl_theta2 = ranova(rm_theta2);
anovatbl_theta2 = anova(rm_theta2);

%PLOT

figure
tiledlayout(1,5)
t1 = nexttile([1 4]);
curve1_theta = mean_theta_cbd + sem_theta_cbd;
curve2_theta = mean_theta_cbd - sem_theta_cbd;
curve3_theta = mean_theta_veh + sem_theta_veh;
curve4_theta = mean_theta_veh - sem_theta_veh;
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_theta_cbd,2)), mean_theta_cbd, '-', 'color', [0.4667    0.7804    0.3529], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_theta_cbd,2)), curve1_theta, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_theta_cbd,2)), curve2_theta, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_theta_veh,2)), mean_theta_veh, '-', 'color', [0.5020    0.5020    0.5020], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_theta_veh,2)), curve3_theta, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_theta_veh,2)), curve4_theta, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
legend('CBD','Vehicle')
title(strcat('Averaged theta power per',{' '}, num2str(timesize), ' minutes bins'))

nexttile([1 1])

b1 = bar(0.5, mean(mean_theta_cbd));
hold on
ylim(t1.YLim)
hold on 
b2 = bar(1.5, mean(mean_theta_veh));
set(b1,'FaceColor',[0.4667    0.78  0.3529]);
set(b2,'FaceColor',[0.5020    0.5020    0.5020]);
hold on
scatter(ones(1,10)*0.5, mat_theta2(1:10),[],'black', 'markerfacecolor', [0.4667    0.7804    0.3529], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
hold on
scatter(ones(1,9)*1.5, mat_theta2(11:19),[],'black', 'markerfacecolor', [0.5020    0.5020    0.5020], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
SEM = [std(mean_theta_cbd)/sqrt(10) std(mean_theta_veh)/sqrt(9)];
er = errorbar([0.5 1.5],[mean(mean_theta_cbd) mean(mean_theta_veh)],SEM,SEM);      
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
set(gca, 'XTick', [0.5 1.5], 'XTickLabel', {'CBD','Vehicle'})
xtickangle(-30)
if P_theta <= 0.05
    hold on
    plot([0.1 1.9], [1.06*max(mean(mean_theta_cbd)+SEM(1), mean(mean_theta_veh)+ SEM(2)) 1.06*max(mean(mean_theta_cbd)+SEM(1), mean(mean_theta_veh) + SEM(2))], 'black', 'LineWidth', 1)
    hold on
    scatter(1,1.1*max(mean(mean_theta_cbd)+SEM(1), mean(mean_theta_veh) + SEM(2)), '*k', 'LineWidth', 0.90)
    hold off
end

title('Average per group')

%% Delta power 0 - 3

% 10 sec epochs
delta_pwr = struct([]);

for ii=1:length(PFCfilt) 
        epdata = data2ep(PFCfilt{ii}, 10, 600); %We use 10 seconds long epochs here, because too short = doesn't detect slow oscillations
        [pxx,f] = pmtm(epdata,4,[],ds_fhz);
    
        %Heatmap of power, for visualizing purposes
        pwr = [];

        for jj=1:size(epdata,2)
                pwr(jj) = spectral_power(0,3, jj, pxx, f);
        end
        delta_pwr{ii} = pwr;
end

% Align the data
delta_pwr_align = []; 

for ii = 1:length(delta_pwr)
    before = ALIGNtot(ii)*6;
    after = max_rec - (length(delta_pwr{ii}) + ALIGNtot(ii)*6);
    delta_pwr_align = [delta_pwr_align; NaN(1,before) delta_pwr{ii} NaN(1, after)];
end

% Now compute mean

delta_pwr_cbd = delta_pwr_align(index_cbd,:);
delta_pwr_veh = delta_pwr_align(index_veh,:);

binsize = timesize*6;
N_bins = floor(max_rec/binsize);

mat_delta = [];
mean_delta_cbd = [];
mean_delta_veh = [];
sem_delta_cbd = [];
sem_delta_veh = [];

for ii = 1:(N_bins-1)
    tmpdeltacbd = delta_pwr_cbd(:,(binsize*(ii-1)+1):ii*binsize);
    tmpdeltaveh = delta_pwr_veh(:,(binsize*(ii-1)+1):ii*binsize);
    n1 = sum(~isnan(tmpdeltacbd),2);
    n1 = n1~=0;
    n2 = sum(~isnan(tmpdeltaveh),2);
    n2 = n2~=0;
    tmpdeltacbd(isnan(tmpdeltacbd)) = 0;
    tmpdeltaveh(isnan(tmpdeltaveh)) = 0;
    sum1 = sum(tmpdeltacbd,2);
    sum2 = sum(tmpdeltaveh,2);
    mean_delta_cbd(ii) = mean(sum1(n1,:));
    mean_delta_veh(ii) = mean(sum2(n2,:));
    sem_delta_cbd(ii) = std(sum1(n1,:))/sqrt(sum(n1));
    sem_delta_veh(ii) = std(sum2(n2,:))/sqrt(sum(n2));
    
    mat_delta = [mat_delta [sum1;sum2]];
end

mat_delta2 = normalize_matrix(mat_delta,N);
%t-test with averaged over whole time
for ii = 1:size(mat_delta,1)
    tmp = mat_delta2(ii,:);
    mat_delta3(ii) = mean(tmp(~isnan(tmp)));
end
[H_delta,P_delta,CI_delta,STATS_delta] = ttest2(mat_delta3(1:10), mat_delta3(11:19))


%ANOVA

% Test 1 is: we keep all bins, and replace NaNs by the bin's average
test1 = mat_delta;
test1(~N) = NaN;
for ii = 1:size(test1,2)
    tmp = test1(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test1(:,ii) = tmp;
end
t_delta = table(drug, test1(:,1), test1(:,2), test1(:,3), test1(:,4), test1(:,5), test1(:,6), test1(:,7), test1(:,8), test1(:,9), test1(:,10),...
    'VariableNames', {'drug', 'bin1','bin2','bin3', 'bin4', 'bin5', 'bin6', 'bin7', 'bin8', 'bin9', 'bin10'});
Bins = table([1:10]', 'VariableNames', {'Time'});

rm_delta = fitrm(t_delta, 'bin1-bin10~drug', 'WithinDesign', Bins);
tbl_delta = mauchly(rm_delta);
ranovatbl_delta = ranova(rm_delta);
anovatbl_delta = anova(rm_delta);

% Test 2 is: we only keep bins that are full (or let's say almost full)
test2 = mat_delta;
test2(~N) = NaN;
test2 = test2(:,6:9);
for ii = 1:size(test2,2)
    tmp = test2(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test2(:,ii) = tmp;
end

t_delta2 = table(drug, test2(:,1), test2(:,2), test2(:,3), test2(:,4),...
    'VariableNames', {'drug','bin6', 'bin7', 'bin8', 'bin9'});
Bins2 = table([1:4]', 'VariableNames', {'Time'});

rm_delta2 = fitrm(t_delta2, 'bin6-bin9~drug', 'WithinDesign', Bins2);
tbl_delta2 = mauchly(rm_delta2);
ranovatbl_delta2 = ranova(rm_delta2);
anovatbl_delta2 = anova(rm_delta2);

%PLOT

figure
tiledlayout(1,5)
t1 = nexttile([1 4]);
curve1_delta = mean_delta_cbd + sem_delta_cbd;
curve2_delta = mean_delta_cbd - sem_delta_cbd;
curve3_delta = mean_delta_veh + sem_delta_veh;
curve4_delta = mean_delta_veh - sem_delta_veh;
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_delta_cbd,2)), mean_delta_cbd, '-', 'color', [0.4667    0.7804    0.3529], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_delta_cbd,2)), curve1_delta, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_delta_cbd,2)), curve2_delta, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_delta_veh,2)), mean_delta_veh, '-', 'color', [0.5020    0.5020    0.5020], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_delta_veh,2)), curve3_delta, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_delta_veh,2)), curve4_delta, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
legend('CBD','Vehicle')
title(strcat('Averaged delta power per',{' '}, num2str(timesize), ' minutes bins'))

nexttile([1 1])

b1 = bar(0.5, mean(mean_delta_cbd));
hold on
ylim(t1.YLim)
hold on 
b2 = bar(1.5, mean(mean_delta_veh));
set(b1,'FaceColor',[0.4667    0.78  0.3529]);
set(b2,'FaceColor',[0.5020    0.5020    0.5020]);
hold on
scatter(ones(1,10)*0.5, mat_delta2(1:10),[],'black', 'markerfacecolor', [0.4667    0.7804    0.3529], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
hold on
scatter(ones(1,9)*1.5, mat_delta2(11:19),[],'black', 'markerfacecolor', [0.5020    0.5020    0.5020], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
SEM = [std(mean_delta_cbd)/sqrt(10) std(mean_delta_veh)/sqrt(9)];
er = errorbar([0.5 1.5],[mean(mean_delta_cbd) mean(mean_delta_veh)],SEM,SEM);      
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
set(gca, 'XTick', [0.5 1.5], 'XTickLabel', {'CBD','Vehicle'})
xtickangle(-30)
if P_delta <= 0.05
    hold on
    plot([0.1 1.9], [1.06*max(mean(mean_delta_cbd)+SEM(1), mean(mean_delta_veh)+ SEM(2)) 1.06*max(mean(mean_delta_cbd)+SEM(1), mean(mean_delta_veh) + SEM(2))], 'black', 'LineWidth', 1)
    hold on
    scatter(1,1.1*max(mean(mean_delta_cbd)+SEM(1), mean(mean_delta_veh) + SEM(2)), '*k', 'LineWidth', 0.90)
    hold off
end

title('Average per group')
%% Ratio Sharp-Waves / Ripples

%Now average

N_bins = 11;
binsize = timesize*60*600;

mat_swrip = [];
mean_swrip_cbd = [];
mean_swrip_veh = [];
sem_swrip_cbd = [];
sem_swrip_veh = [];

for ii = 1:(N_bins-1)
    tmpswcbd = sw_cbd_align(:,(binsize*(ii-1)+1):ii*binsize);
    tmpswveh = sw_veh_align(:,(binsize*(ii-1)+1):ii*binsize);
    tmpripcbd = SWRs_CBD(:,(binsize*(ii-1)+1):ii*binsize);
    tmpripveh = SWRs_VEH(:,(binsize*(ii-1)+1):ii*binsize);
    n1 = sum(~isnan(tmpswcbd),2);
    n1 = n1~=0;
    n2 = sum(~isnan(tmpswveh),2);
    n2 = n2~=0;
    tmpswcbd(isnan(tmpswcbd)) = 0;
    tmpswveh(isnan(tmpswveh)) = 0;
    tmpripcbd(isnan(tmpripcbd)) = 0;
    tmpripveh(isnan(tmpripveh)) = 0;
    sum1 = sum(tmpswcbd,2);
    sum2 = sum(tmpswveh,2);
    sum3 = sum(tmpripcbd,2);
    sum4 = sum(tmpripveh,2);
    ratio_cbd = sum1(n1,:) ./ sum3(n1,:);
    ratio_veh = sum2(n2,:) ./ sum4(n2,:);
    ratio_cbd = ratio_cbd(~isnan(ratio_cbd));
    ratio_veh = ratio_veh(~isnan(ratio_veh));
    mean_swrip_cbd(ii) = mean(ratio_cbd);
    mean_swrip_veh(ii) = mean(ratio_veh);
    sem_swrip_cbd(ii) = std(ratio_cbd)/sqrt(length(ratio_cbd));
    sem_swrip_veh(ii) = std(ratio_veh)/sqrt(length(ratio_veh));
    
    mat_swrip = [mat_swrip [sum1./sum3;sum2./sum4]];
    
end

%t-test with averaged over whole time
for ii = 1:size(mat_swrip,1)
    tmp = mat_swrip(ii,:);
    mat_swrip2(ii) = mean(tmp(~isnan(tmp)));
end
[H_swrip,P_swrip,CI_swrip,STATS_swrip] = ttest2(mat_swrip2(1:10), mat_swrip2(11:19))


%ANOVA

% Test 1 is: we keep all bins, and replace NaNs by the bin's average
test1 = mat_swrip;
test1(~N) = NaN;
for ii = 1:size(test1,2)
    tmp = test1(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test1(:,ii) = tmp;
end
t_swrip = table(drug, test1(:,1), test1(:,2), test1(:,3), test1(:,4), test1(:,5), test1(:,6), test1(:,7), test1(:,8), test1(:,9), test1(:,10),...
    'VariableNames', {'drug', 'bin1','bin2','bin3', 'bin4', 'bin5', 'bin6', 'bin7', 'bin8', 'bin9', 'bin10'});
Bins = table([1:10]', 'VariableNames', {'Time'});

rm_swrip = fitrm(t_swrip, 'bin1-bin10~drug', 'WithinDesign', Bins);
tbl_swrip = mauchly(rm_swrip);
ranovatbl_swrip = ranova(rm_swrip);
anovatbl_swrip = anova(rm_swrip);

% Test 2 is: we only keep bins that are full (or let's say almost full)
test2 = mat_swrip;
test2(~N) = NaN;
test2 = test2(:,6:9);
for ii = 1:size(test2,2)
    tmp = test2(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test2(:,ii) = tmp;
end

t_swrip2 = table(drug, test2(:,1), test2(:,2), test2(:,3), test2(:,4),...
    'VariableNames', {'drug','bin6', 'bin7', 'bin8', 'bin9'});
Bins2 = table([1:4]', 'VariableNames', {'Time'});

rm_swrip2 = fitrm(t_swrip2, 'bin6-bin9~drug', 'WithinDesign', Bins2);
tbl_swrip2 = mauchly(rm_swrip2);
ranovatbl_swrip2 = ranova(rm_swrip2);
anovatbl_swrip2 = anova(rm_swrip2);

%PLOT

figure
tiledlayout(1,5)
t1 = nexttile([1 4]);
curve1_swrip = mean_swrip_cbd + sem_swrip_cbd;
curve2_swrip = mean_swrip_cbd - sem_swrip_cbd;
curve3_swrip = mean_swrip_veh + sem_swrip_veh;
curve4_swrip = mean_swrip_veh - sem_swrip_veh;
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_swrip_cbd,2)), mean_swrip_cbd, '-', 'color', [0.4667    0.7804    0.3529], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_swrip_cbd,2)), curve1_swrip, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_swrip_cbd,2)), curve2_swrip, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_swrip_veh,2)), mean_swrip_veh, '-', 'color', [0.5020    0.5020    0.5020], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_swrip_veh,2)), curve3_swrip, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_swrip_veh,2)), curve4_swrip, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
legend('CBD','Vehicle')
title(strcat('Averaged sharp waves to ripple amount ratio per',{' '}, num2str(timesize), ' minutes bins'))

nexttile([1 1])

b1 = bar(0.5, mean(mean_swrip_cbd));
hold on
ylim(t1.YLim)
hold on 
b2 = bar(1.5, mean(mean_swrip_veh));
set(b1,'FaceColor',[0.4667    0.78  0.3529]);
set(b2,'FaceColor',[0.5020    0.5020    0.5020]);
hold on
scatter(ones(1,10)*0.5, mat_swrip2(1:10),[],'black', 'markerfacecolor', [0.4667    0.7804    0.3529], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
hold on
scatter(ones(1,9)*1.5, mat_swrip2(11:19),[],'black', 'markerfacecolor', [0.5020    0.5020    0.5020], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
SEM = [std(mean_swrip_cbd)/sqrt(10) std(mean_swrip_veh)/sqrt(9)];
er = errorbar([0.5 1.5],[mean(mean_swrip_cbd) mean(mean_swrip_veh)],SEM,SEM);      
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
set(gca, 'XTick', [0.5 1.5], 'XTickLabel', {'CBD','Vehicle'})
xtickangle(-30)
if P_swrip <= 0.05
    hold on
    plot([0.1 1.9], [1.06*max(mean(mean_swrip_cbd)+SEM(1), mean(mean_swrip_veh)+ SEM(2)) 1.06*max(mean(mean_swrip_cbd)+SEM(1), mean(mean_swrip_veh) + SEM(2))], 'black', 'LineWidth', 1)
    hold on
    scatter(1,1.1*max(mean(mean_swrip_cbd)+SEM(1), mean(mean_swrip_veh) + SEM(2)), '*k', 'LineWidth', 0.90)
    hold off
end

title('Average per group')

%% Ratio Theta (HPC) / Delta (PFC) 

% 10 sec epochs
thedel_pwr = struct([]);

for ii=1:length(PFCfilt) %For each  brain area, we compute the spectogram and features that will be included in the PCA
        epdata = data2ep(PFCfilt{ii}, 10, 600); %We use 10 seconds long epochs here, because too short = doesn't detect slow oscillations
        [pxx,f] = pmtm(epdata,4,[],ds_fhz);
    
        %Heatmap of power, for visualizing purposes
        pwr1 = []; % theta
        pwr2 = []; % delta

        for jj=1:size(epdata,2)
                pwr1(jj) = spectral_power(3,6, jj, pxx, f);
                pwr2(jj) = spectral_power(0,3, jj, pxx, f);
        end
        thedel_pwr{ii} = pwr1 ./ pwr2;
end

% Align the data

thedel_pwr_align = [];


for ii = 1:length(thedel_pwr)
    before = ALIGNtot(ii)*6;
    after = max_rec - (length(thedel_pwr{ii}) + ALIGNtot(ii)*6);
    thedel_pwr_align = [thedel_pwr_align; NaN(1,before) thedel_pwr{ii} NaN(1, after)];
end

% Now compute mean

thedel_pwr_cbd = thedel_pwr_align(index_cbd,:);
thedel_pwr_veh = thedel_pwr_align(index_veh,:);

binsize = timesize2*6;
N_bins = floor(max_rec/binsize);

mat_thedel = [];
mean_thedel_cbd = [];
mean_thedel_veh = [];
sem_thedel_cbd = [];
sem_thedel_veh = [];

for ii = 1:(N_bins-1)
    tmpthedelcbd = thedel_pwr_cbd(:,(binsize*(ii-1)+1):ii*binsize);
    tmpthedelveh = thedel_pwr_veh(:,(binsize*(ii-1)+1):ii*binsize);
    n1 = sum(~isnan(tmpthedelcbd),2);
    n1 = n1~=0;
    n2 = sum(~isnan(tmpthedelveh),2);
    n2 = n2~=0;
    tmpthedelcbd(isnan(tmpthedelcbd)) = 0;
    tmpthedelveh(isnan(tmpthedelveh)) = 0;
    sum1 = sum(tmpthedelcbd,2);
    sum2 = sum(tmpthedelveh,2);
    mean_thedel_cbd(ii) = mean(sum1(n1,:));
    mean_thedel_veh(ii) = mean(sum2(n2,:));
    sem_thedel_cbd(ii) = std(sum1(n1,:))/sqrt(sum(n1));
    sem_thedel_veh(ii) = std(sum2(n2,:))/sqrt(sum(n2));
    
    mat_thedel = [mat_thedel [sum1;sum2]];
end


%t-test with averaged over whole time
for ii = 1:size(mat_thedel,1)
    tmp = mat_thedel(ii,:);
    mat_thedel2(ii) = mean(tmp(~isnan(tmp)));
end
[H_thedel,P_thedel,CI_thedel,STATS_thedel] = ttest2(mat_thedel2(1:10), mat_thedel2(11:19))


%ANOVA

% Test 1 is: we keep all bins, and replace NaNs by the bin's average
test1 = mat_thedel;
test1(~N) = NaN;
for ii = 1:size(test1,2)
    tmp = test1(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test1(:,ii) = tmp;
end
t_thedel = table(drug, test1(:,1), test1(:,2), test1(:,3), test1(:,4), test1(:,5), test1(:,6), test1(:,7), test1(:,8), test1(:,9), test1(:,10),...
    'VariableNames', {'drug', 'bin1','bin2','bin3', 'bin4', 'bin5', 'bin6', 'bin7', 'bin8', 'bin9', 'bin10'});
Bins = table([1:10]', 'VariableNames', {'Time'});

rm_thedel = fitrm(t_thedel, 'bin1-bin10~drug', 'WithinDesign', Bins);
tbl_thedel = mauchly(rm_thedel);
ranovatbl_thedel = ranova(rm_thedel);
anovatbl_thedel = anova(rm_thedel);

% Test 2 is: we only keep bins that are full (or let's say almost full)
test2 = mat_thedel;
test2(~N) = NaN;
test2 = test2(:,6:9);
for ii = 1:size(test2,2)
    tmp = test2(:,ii);
    tmp(isnan(tmp)) = mean(tmp(~isnan(tmp)));
    test2(:,ii) = tmp;
end

t_thedel2 = table(drug, test2(:,1), test2(:,2), test2(:,3), test2(:,4),...
    'VariableNames', {'drug','bin6', 'bin7', 'bin8', 'bin9'});
Bins2 = table([1:4]', 'VariableNames', {'Time'});

rm_thedel2 = fitrm(t_thedel2, 'bin6-bin9~drug', 'WithinDesign', Bins2);
tbl_thedel2 = mauchly(rm_thedel2);
ranovatbl_thedel2 = ranova(rm_thedel2);
anovatbl_thedel2 = anova(rm_thedel2);

%PLOT

figure
tiledlayout(1,5)
t1 = nexttile([1 4]);
curve1_thedel = mean_thedel_cbd + sem_thedel_cbd;
curve2_thedel = mean_thedel_cbd - sem_thedel_cbd;
curve3_thedel = mean_thedel_veh + sem_thedel_veh;
curve4_thedel = mean_thedel_veh - sem_thedel_veh;
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_sw_cbd,2)), mean_thedel_cbd, '-', 'color', [0.4667    0.7804    0.3529], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_sw_cbd,2)), curve1_thedel, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_sw_cbd,2)), curve2_thedel, '-', 'color', [0.4667    0.7804    0.3529], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_sw_veh,2)), mean_thedel_veh, '-', 'color', [0.5020    0.5020    0.5020], 'LineWidth', 2);
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_sw_veh,2)), curve3_thedel, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
hold on
plot(linspace(time_start, time_end - duration([0 45 0]),size(mean_sw_veh,2)), curve4_thedel, '-', 'color', [0.5020    0.5020    0.5020], 'HandleVisibility','off');
legend('CBD','Vehicle')
title(strcat('Averaged theta / delta ratio per',{' '}, num2str(timesize), ' minutes bins'))

nexttile([1 1])

b1 = bar(0.5, mean(mean_thedel_cbd));
hold on
ylim(t1.YLim)
hold on 
b2 = bar(1.5, mean(mean_thedel_veh));
set(b1,'FaceColor',[0.4667    0.78  0.3529]);
set(b2,'FaceColor',[0.5020    0.5020    0.5020]);
hold on
scatter(ones(1,10)*0.5, mat_thedel2(1:10),[],'black', 'markerfacecolor', [0.4667    0.7804    0.3529], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
hold on
scatter(ones(1,9)*1.5, mat_thedel2(11:19),[],'black', 'markerfacecolor', [0.5020    0.5020    0.5020], 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.3)
SEM = [std(mean_thedel_cbd)/sqrt(10) std(mean_thedel_veh)/sqrt(9)];
er = errorbar([0.5 1.5],[mean(mean_thedel_cbd) mean(mean_thedel_veh)],SEM,SEM);      
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
set(gca, 'XTick', [0.5 1.5], 'XTickLabel', {'CBD','Vehicle'})
xtickangle(-30)
if P_thedel <= 0.05
    hold on
    plot([0.1 1.9], [1.06*max(mean(mean_thedel_cbd)+SEM(1), mean(mean_thedel_veh)+ SEM(2)) 1.06*max(mean(mean_thedel_cbd)+SEM(1), mean(mean_thedel_veh) + SEM(2))], 'black', 'LineWidth', 1)
    hold on
    scatter(1,1.1*max(mean(mean_thedel_cbd)+SEM(1), mean(mean_thedel_veh) + SEM(2)), '*k', 'LineWidth', 0.90)
    hold off
end

title('Average per group')

%% Analysis of beginning / end of long bouts

% Ripples

ripbouts_cbd = [];
ripbouts_veh = [];
percent = 0.1; % percentage atthe beginning/end of the bouts we look at
limit = 15; %limit in minutes of the shortest bouts taken into account

ripbouts_avg = [];

for ii = 1:19
    sta = STATES{ii};
    index = 1;
    bouts_index = [];
    TMP = [];
    while index < length(sta)
        if sta(index) == 2 
            index2 = index;
            while sta(index2+1) == sta(index2) & index2 < length(sta)-1
                index2 = index2 + 1;
            end
            bouts_index = [bouts_index ; [index index2 sta(index2)]];
            index = index2 + 1;
        else
            index = index + 1;
        end
    end
    
    bouts_index = bouts_index(bouts_index(:,2)-bouts_index(:,1) >= limit * 6,:); %Keep long bouts, i.e. longer than X minutes
    
    % Count ripples
    tmp = SWRs_align(ii,:);
    tmprip = tmp(~isnan(tmp));
    L = length(tmprip);
    rip_bins = 10; %bin size for the ripples count in seconds
    rip_epoch = tmprip;
    rip_epoch = reshape(rip_epoch(1:floor(L/(rip_bins*600))*rip_bins*600), rip_bins*600,floor(L/(rip_bins*600))); %separate in bins
    rip_fhz = sum(rip_epoch); %Nb of rip per bin 
    rip_fhz = [rip_fhz zeros(1,length(sta)-length(rip_fhz))];
    
    % Now, for each bout, we want to retrieve the average number of ripples
    % for the first X% and the last X% of the bout
    
    for jj = 1:size(bouts_index,1)
        Lbout = bouts_index(jj,2) - bouts_index(jj,1);
        quart = ceil(percent*Lbout);
        Q1 = bouts_index(jj,1) + quart - 1;
        Q3 = bouts_index(jj,2) - quart + 1;
        rip_start = rip_fhz(bouts_index(jj,1):Q1);
        rip_end = rip_fhz(Q3:bouts_index(jj,2));
        if ismember(ii, index_cbd)
            ripbouts_cbd = [ripbouts_cbd; sum(rip_start)/quart sum(rip_end)/quart];
            
        else
            ripbouts_veh = [ripbouts_veh; sum(rip_start)/quart sum(rip_end)/quart];
        end
        TMP = [TMP; sum(rip_start)/quart sum(rip_end)/quart];
    end
    ripbouts_avg = [ripbouts_avg; mean(TMP,1)];
end

ripbouts = [ripbouts_cbd;ripbouts_veh];
%Plot with all bouts
figure
patch([1.5 2.5 2.5 1.5], [0.01  0.01 1.1*max(max(ripbouts)) 1.1*max(max(ripbouts))], [0.8784    0.8902    0.6745], 'LineStyle', 'none', 'FaceAlpha', 0.7)
hold on
for jj = 1:size(ripbouts,1)
if jj <= size(ripbouts_cbd,1)
    COL = [0.4667    0.7804    0.3529];
else
    COL = [0.502 0.502 0.502];
end
h1 = plot([1 2], ripbouts(jj,:), '--o', 'MarkerSize', 10, 'color', COL);
set(h1, 'markerfacecolor', get(h1, 'color'));
end
xlim([0.7 2.3])
ylim([0 1.1*max(max(ripbouts))])
xticks([1 2])
ticks = {strcat('First ',{' '},num2str(percent*100),'% of the bout'),strcat('Last ',{' '},num2str(percent*100),'% of the bout')};
xticklabels({string(ticks{1}), string(ticks{2})})
title(strcat('Normalized amount of ripples at the beginning and end of long NREM bouts (?',{' '},num2str(limit),' min)'))

% Paired t-test
[h_ripbout,p_ripbout,ci_ripbout,stats_ripbout] = ttest(ripbouts(:,1), ripbouts(:,2));

% Plot with average per rat
ripbouts_avg = [ripbouts_avg(index_cbd,:);ripbouts_avg(index_veh,:)];

figure
patch([1.5 2.5 2.5 1.5], [0.01  0.01 1.1*max(max(ripbouts_avg)) 1.1*max(max(ripbouts_avg))], [0.8784    0.8902    0.6745], 'LineStyle', 'none', 'FaceAlpha', 0.7)
hold on
for jj = 1:size(ripbouts_avg,1)
if jj <= ncbd
    COL = [0.4667    0.7804    0.3529];
else
    COL = [0.502 0.502 0.502];
end
h1 = plot([1 2], ripbouts_avg(jj,:), '--o', 'MarkerSize', 10, 'color', COL);
set(h1, 'markerfacecolor', get(h1, 'color'));
end
xlim([0.7 2.3])
ylim([0 1.1*max(max(ripbouts_avg))])
xticks([1 2])
ticks = {strcat('First ',{' '},num2str(percent*100),'% of the bout'),strcat('Last ',{' '},num2str(percent*100),'% of the bout')};
xticklabels({string(ticks{1}), string(ticks{2})})
title(strcat('Normalized animal-averaged amount of ripples at the beginning and end of long NREM bouts (?',{' '},num2str(limit),' min)'))

% Paired t-test
[h_ripbout2,p_ripbout2,ci_ripbout2,stats_ripbout2] = ttest(ripbouts_avg(:,1), ripbouts_avg(:,2));
  
% sharp waves

swbouts_cbd = [];
swbouts_veh = [];
swbouts_avg = [];

for ii = 1:19
    sta = STATES{ii};
    index = 1;
    bouts_index = [];
    TMP = [];
    while index < length(sta)
        if sta(index) == 2 
            index2 = index;
            while sta(index2+1) == sta(index2) & index2 < length(sta)-1
                index2 = index2 + 1;
            end
            bouts_index = [bouts_index ; [index index2 sta(index2)]];
            index = index2 + 1;
        else
            index = index + 1;
        end
    end
    
    bouts_index = bouts_index(bouts_index(:,2)-bouts_index(:,1) >= limit * 6,:); %Keep long bouts, i.e. longer than X minutes
    
    % Count sharpwaves
    
    spwpeak = BPLfilt_SW_peaks{ii};
    L = length(BPLfilt_SW_peaks{ii});
        sw_bins = 10; %bin size for the sharp waves count in seconds
        sw_epoch = ~isnan(spwpeak);
        sw_epoch = reshape(sw_epoch(1:floor(L/(sw_bins*600))*sw_bins*600), sw_bins*600,floor(L/(sw_bins*600))); %separate in bins
        sw_fhz = sum(sw_epoch); %Nb of SW per second for each bin   
        sw_fhz = [sw_fhz zeros(1, length(sta) - length(sw_fhz))];

    
    % Now, for each bout, we want to retrieve the average number of ripples
    % for the first 10% and the last 10% of the bout
    
    for jj = 1:size(bouts_index,1)
        Lbout = bouts_index(jj,2) - bouts_index(jj,1);
        quart = ceil(percent*Lbout);
        Q1 = bouts_index(jj,1) + quart - 1;
        Q3 = bouts_index(jj,2) - quart + 1;
        sw_start = sw_fhz(bouts_index(jj,1):Q1);
        sw_end = sw_fhz(Q3:bouts_index(jj,2));
        if ismember(ii, index_cbd)
            swbouts_cbd = [swbouts_cbd; sum(sw_start)/quart sum(sw_end)/quart];
        else
            swbouts_veh = [swbouts_veh; sum(sw_start)/quart sum(sw_end)/quart];
        end
        TMP = [TMP; sum(sw_start)/quart sum(sw_end)/quart];
    end
    swbouts_avg = [swbouts_avg; mean(TMP,1)];
end
swbouts = [swbouts_cbd;swbouts_veh];
figure
patch([1.5 2.5 2.5 1.5], [0.01  0.01 1.1*max(max(swbouts)) 1.1*max(max(swbouts))], [0.8784    0.8902    0.6745], 'LineStyle', 'none', 'FaceAlpha', 0.7)
hold on
for jj = 1:size(swbouts,1)
if jj <= size(swbouts_cbd,1)
    COL = [0.4667    0.7804    0.3529];
else
    COL = [0.502 0.502 0.502];
end
h1 = plot([1 2], swbouts(jj,:), '--o', 'MarkerSize', 10, 'color', COL);
set(h1, 'markerfacecolor', get(h1, 'color'));
end
xlim([0.7 2.3])
ylim([0 1.1*max(max(swbouts))])
xticks([1 2])
ticks = {strcat('First ',{' '},num2str(percent*100),'% of the bout'),strcat('Last ',{' '},num2str(percent*100),'% of the bout')};
xticklabels({string(ticks{1}), string(ticks{2})})
title(strcat('Normalized amount of sharp waves at the beginning and end of long NREM bouts (?',{' '},num2str(limit),' min)'))

% Paired t-test
[h_swbout,p_swbout,ci_swbout,stats_swbout] = ttest(swbouts(:,1), swbouts(:,2));


% Plot with average per rat
swbouts_avg = [swbouts_avg(index_cbd,:);swbouts_avg(index_veh,:)];

figure
patch([1.5 2.5 2.5 1.5], [0.01  0.01 1.1*max(max(swbouts_avg)) 1.1*max(max(swbouts_avg))], [0.8784    0.8902    0.6745], 'LineStyle', 'none', 'FaceAlpha', 0.7)
hold on
for jj = 1:size(swbouts_avg,1)
if jj <= ncbd
    COL = [0.4667    0.7804    0.3529];
else
    COL = [0.502 0.502 0.502];
end
h1 = plot([1 2], swbouts_avg(jj,:), '--o', 'MarkerSize', 10, 'color', COL);
set(h1, 'markerfacecolor', get(h1, 'color'));
end
xlim([0.7 2.3])
ylim([0 1.1*max(max(swbouts_avg))])
xticks([1 2])
ticks = {strcat('First ',{' '},num2str(percent*100),'% of the bout'),strcat('Last ',{' '},num2str(percent*100),'% of the bout')};
xticklabels({string(ticks{1}), string(ticks{2})})
title(strcat('Normalized animal-averaged amount of sharp waves at the beginning and end of long NREM bouts (?',{' '},num2str(limit),' min)'))

% Paired t-test
[h_swbout2,p_swbout2,ci_swbout2,stats_swbout2] = ttest(swbouts_avg(:,1), swbouts_avg(:,2));


