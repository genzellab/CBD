%This script performs PCA to automatically cluster the signal data. It also
%includes the possiblity to pre-filter the data to remove obvious artifacts
clear all

%Fieldtrip
addpath('C:\Users\students\Documents\Tugdual\GitHub\fieldtrip');

%analysis tools
addpath('C:\Users\students\Documents\Tugdual\GitHub\analysis-tools');

%CorticoHippocampal
addpath('C:\Users\students\Documents\Tugdual\GitHub\CorticoHippocampal');
addpath('C:\Users\students\Documents\Tugdual\GitHub\CorticoHippocampal\Ripple_detection');

%ADRITOOLS
addpath('C:\Users\students\Documents\Tugdual\GitHub\ADRITOOLS');

%FastICA
addpath('C:\Users\students\Documents\Tugdual\GitHub\FastICA_25');

%BlueWhiteRed
addpath('C:\Users\students\Documents\Tugdual\GitHub\bluewhitered');

%CBD
addpath('C:\Users\students\Documents\Tugdual\GitHub\CBD');
%% Input questions

%Brain areas
answer_ba = questdlg('What brain areas do you want to use for the sleep scoring?', ...
	'Which brain area?', ...
	'HPC','PFC', 'Both','HPC');
BA = struct([]);
if strcmp(answer_ba,'Both')
    BA{1} = 'HPC';
    BA{2} = 'PFC';
else
    BA{1} = answer_ba;
end

%Select files

if strcmp(answer_ba,'Both') == 1
    [file,path]=uigetfile('C:\','Select a data file for the HPC');
    patID = strcat([path,file]);
    [file2,path2]=uigetfile(path,'Select a data file for the PFC');
    patID2 = strcat([path2,file2]);
else
    tmp = strcat('Select data file for the ',{' '},answer_ba);
    [file,path]=uigetfile('C:\',tmp{1})
    patID = strcat([path,file]);       
end

% Acquisition frequency / Downsampling frequency
fhz = inputdlg({'Acquisition frequency', 'Downsampling frequency'},...
              'Type your selection', [1 30]);

 acq_fhz = str2num(fhz{1});
 ds_fhz = str2num(fhz{2});
 
Wn = [ds_fhz/acq_fhz ]; % Cutoff=fs_new/2 Hz. 
[b,a] = butter(3,Wn); %Filter coefficients for LPF.

% Anesthesia

answer_anes = questdlg('Were the rats anesthetized during the trial (i.e no wakeful state)?', ...
	'Anesthesia?', ...
	'Yes','No', 'Yes');

% Filter

answer_filt = questdlg('Do you need to filter the data for artifacts?', ...
	'Filter?', ...
	'Filter the data','Filter the data using a reference channel (more accurate)', 'No filter needed', 'Filter the data');

if strcmp(answer_filt,'Filter the data using a reference channel (more accurate)')
    if strcmp(answer_ba,'Both')
        [file,path]=uigetfile('C:\','Select a reference channel for the HPC');
        patIDref = strcat([path,file]);
        [file2,path2]=uigetfile('C:\','Select a reference channel for the PFC');
        patIDref2 = strcat([path2,file2]);
    else
        tmp = strcat('Select a reference channel for the ',{' '},answer_ba);
        [file,path]=uigetfile('C:\',tmp{1})
        patIDref = strcat([path,file]);
    end
end

% If no anesthesia, select accelerometer files

if strcmp(answer_anes, 'No')
    [file,path]=uigetfile('C:\','Select the accelerometer file(s) (select multiple if possible)', 'MultiSelect', 'on');
    patIDacc = {};
    for jj=1:length(file)
        tmp = file(jj);
        patIDacc{jj} = strcat([path,tmp{1}]);
    end
end
%% Loading the data & downsampling

% Data to score

DATA = struct([]);

%In each case, there is at least one file to load
disp("Loading and downsampling of the data for the channels of interest")
[Data, ~, ~] = load_open_ephys_data_faster(patID);
Data=filtfilt(b,a,Data);
Data=downsample(Data,acq_fhz/ds_fhz);
DATA{1} = Data;

if strcmp(answer_ba,'Both') == 1
    [Data2, ~, ~] = load_open_ephys_data_faster(patID2);
    Data2=filtfilt(b,a,Data2);
    Data2=downsample(Data2,acq_fhz/ds_fhz);
    DATA{2} = Data2; %And if we have 2 brain areas, then we load an extra file
end

% Reference channels, if needed
if strcmp(answer_filt,'Filter the data using a reference channel (more accurate)')
    disp("Loading and downsampling of the reference channels")
    REF = struct([]);
    [Data, ~, ~] = load_open_ephys_data_faster(patIDref);
    Data=filtfilt(b,a,Data);
    Data=downsample(Data,acq_fhz/ds_fhz);
    REF{1} = Data;
    if strcmp(answer_ba,'Both') == 1
        [Data2, ~, ~] = load_open_ephys_data_faster(patIDref2);
        Data2=filtfilt(b,a,Data2);
        Data2=downsample(Data2,acq_fhz/ds_fhz);
        REF{2} = Data2; %And if we have 2 brain areas, then we load an extra file
    end
end

% If no anesthesia, load accelerometer data

if strcmp(answer_anes, 'No')
    ACC_RES = [];
    disp('Loading and downsampling of the accelerometer data')
    for jj=1:length(patIDacc)
        [Dataacc, ~, ~] = load_open_ephys_data_faster(patIDacc{jj});
        Dataacc=filtfilt(b,a,Dataacc);
        Dataacc=downsample(Dataacc,acq_fhz/ds_fhz);
        ACC_RES = [ACC_RES  Dataacc]; 
    end
    ACC_RES = sqrt(sum(ACC_RES.^2,2));
end

% Rat 11 Batch 1 has a problem that needs to be fixed (artifacts at the end)
if contains(path, 'cannabis\acutes\rat11')
    tmp1 = DATA{1};
    tmp2 = DATA{2};
    tmp1(8.9e6:end) = [];
    tmp2(8.9e6:end) = [];
    DATA{1} = tmp1;
    DATA{2} = tmp2;
end

%% Filter

% The filter turns the data into 1s epochs, detects outliers in terms of
% amplitude, and removes them (by setting them to 0 in amplitude). If a
% reference channel is used, the reference channel and the working channel
% are put in absolute value, summed, and artifacts (which should occur in
% both channels at the same time) are bigger and more easily detected

if strcmp(answer_filt,'No filter needed') == 0
    disp("Filtering")
    if strcmp(answer_filt,'Filter the data using a reference channel (more accurate)')
        input_data = struct([]);
        for ii=1:length(DATA)
            input_data{ii} = abs(DATA{ii}) + abs(REF{ii});
        end
    else
        input_data = DATA;
    end
    FINAL_DATA = struct([]);
    for ii=1:length(DATA)
        [~, outliers_ref, rem_ep_ref] = detect_artifacts(input_data{ii}, ds_fhz, 1, 0, 99.5); 
        nc = floor(length(input_data{ii} / 600)); %number of epochs in the data
        e_samples = ds_fhz * 1;
        DATA_filtered = DATA{ii};
        index = 1;
        for kk=1:nc
           if ismember(kk, rem_ep_ref)
               DATA_filtered(index:index+e_samples,1) = ones(e_samples+1,1)*mean(DATA_filtered);
               index = index + e_samples;
           else
               index = index + e_samples;
           end
         FINAL_DATA{ii} = DATA_filtered;
        end
    end
else
    FINAL_DATA = DATA;
end
%% PCA - anesthesia case

if strcmp(answer_anes, 'Yes')
    STATES = struct([]);
    pxx_tot = struct([]);
    data2cluster = [];

    %Saving plots
    SPECTRO = struct([]);

    disp("Computing the spectograms")
    for ii=1:length(FINAL_DATA) %For each  brain area, we compute the spectogram and features that will be included in the PCA
        epdata = data2ep(FINAL_DATA{ii}, 10, 600); %We use 10 seconds long epochs here, because too short = doesn't detect slow oscillations
        [pxx,f] = pmtm(epdata,4,[],ds_fhz);
    
        %Heatmap of power, for visualizing purposes
        heatmap_data = [];

        for jj=1:size(epdata,2)
            fhz = 0:0.5:300;
            for kk = 1:(length(fhz)-1)
                heatmap_data(jj,kk) = spectral_power(fhz(kk), fhz(kk+1), jj, pxx, f);
            end

        end

        SPECTRO{ii} = log(heatmap_data)';

        % PCA on several features
        % In order: slow oscillations, delta, theta, low beta, low gamma, high
        % gamma, ripples
        features = [0.1, 1, 1, 3, 3, 6, 10, 20, 30, 45, 55, 80, 90, 299];
        % Compute spectral power for each
        data2cluster_tmp = [];
        for jj=1:1:size(epdata,2)
            for kk=1:(length(features)/2)
                data2cluster_tmp(jj,kk) = log(spectral_power(features(2*(kk-1)+1), features(2*kk), jj, pxx, f));
            end
        end
        data2cluster_tmp(:,length(features)/2+1) = data2cluster_tmp(:,3) ./ data2cluster_tmp(:,1);  %theta/SO
        data2cluster_tmp(:,length(features)/2+2) = max(abs(epdata)); % max amplitude of each epoch
        data2cluster = [data2cluster data2cluster_tmp];
    end
        %normalization over the columns ie for each feature
        MAX = max(data2cluster);
        data2cluster_norm = data2cluster ./ MAX;

        disp("Running PCA")

        [coeff,~,latent,~,explained] = pca(data2cluster_norm);

        % Contribution of each feature in the first components

        if strcmp(answer_ba, 'Both') == 0
            variables = {'Slow oscillations 0.1-1Hz','Delta 1-3Hz','Theta 3-6Hz','Low beta 10-20 Hz','Low gamma 30-45 Hz','High gamma 55-80 Hz', 'Ripples 80-150 Hz', 'Theta/SO ratio', 'Epoch max amplitude'};
        elseif strcmp(answer_ba, 'Both') == 1
            variables = {'Slow oscillations 0.1-1Hz HPC','Delta 1-3Hz HPC','Theta 3-6Hz HPC','Low beta 10-20 Hz HPC','Low gamma 30-45 Hz HPC','High gamma 55-80 Hz HPC', 'Ripples 90-300 Hz HPC', 'Theta/SO ratio HPC', 'Epoch max amplitude HPC', 'Slow oscillations 0.1-1Hz PFC','Delta 1-3Hz PFC','Theta 3-6Hz PFC','Low beta 10-20 Hz PFC','Low gamma 30-45 Hz PFC','High gamma 55-80 Hz PFC', 'Ripples 90-300 Hz PFC', 'Theta/SO ratio PFC', 'Epoch max amplitude PFC'};
        end 
    %     img = imagesc(coeff(:,1:4));
    %     colormap(bluewhitered(256));
    %     colorbar();
    %     set(gca,'YDir','normal')
    %     set(gca,'Ytick',1:length(variables),'YTickLabel',variables)
    %     set(gca,'Xtick',1:4,'XTickLabel',num2str(round(explained(1:4),2)))
    %     xlabel('Principal components (1st - left to 4th - right) and percentage of variance explained by them')
    %     title('Weigth of each PCA feature in each principal component')

        % We retrieve the 2 first components
        PC1 = sum(data2cluster_norm' .* coeff(:,1), 1);
        PC2 = sum(data2cluster_norm' .* coeff(:,2), 1);   

        %Let's detect the outliers
        pca_outliers = isoutlier(abs(PC1) + abs(PC2), 'Percentiles',[0 99.9]);

    %     clusters = kmeans([log(PC1)'  real(log(PC2))'],2);
    % Choose between 2 or 3 clusters based on silhouette plots
        clusters2 = kmeans([PC1(pca_outliers==0)'  PC2(pca_outliers==0)'],2, 'MaxIter', 500);
        silh2 = silhouette([PC1(pca_outliers==0)'  PC2(pca_outliers==0)'],clusters2,'cityblock');
        clusters3 = kmeans([PC1(pca_outliers==0)'  PC2(pca_outliers==0)'],3, 'MaxIter', 500);
        silh3 = silhouette([PC1(pca_outliers==0)'  PC2(pca_outliers==0)'],clusters3,'cityblock');
        if mean(silh2)>mean(silh3)
            clusters = clusters2;
            nclus = 2;
        else
            clusters = clusters3;
            nclus = 3;
        end
            clusters = clusters2;
            nclus = 2;  

%         clusters = kmeans([PC1(pca_outliers==0)'  PC2(pca_outliers==0)'],3, 'MaxIter', 500);
        %If one epoch alone is into other cluster, make it into same cluster
        %than rest ==> Seems like a bad idea
        index = 2;
        while index <= (length(clusters)-1)
            if clusters(index-1) == clusters(index+1) & clusters(index) ~= clusters(index-1)
                clusters(index) = clusters(index-1);
                index = index+1;
            end
            index = index+1;
        end

        % We set REM in cluster 1, the two other clusters are NREM and
        % intermediate
        ampl = data2cluster(:,9);
        %first find the cluster corresponding to REM and NREM
        %starting values
        rems = 1;
        nrems = 1;
        minimum = mean(ampl(clusters==1));
        maximum = mean(ampl(clusters==1));
        for jj=unique(clusters)'
          if  mean(ampl(clusters==jj)) < minimum
              rems = jj;
              minimum = mean(ampl(clusters==jj));
          end
          if mean(ampl(clusters==jj)) > maximum
              nrems = jj;
              maximum = mean(ampl(clusters==jj));
          end
        end
        if length(unique(clusters))>2
            tmp = unique(clusters);
            tmp(tmp == rems) = [];
            tmp(tmp == nrems) = [];
            int = tmp;
        end
        %now that you found the cluster corresponding to rem and nrem and intermediate, put them in
        %position 1 and 2 respectively
        clusters(clusters == rems) = 97;
        clusters(clusters == nrems) = 98;
        if length(unique(clusters))>2
            clusters(clusters == int) = 3;
        end
        clusters(clusters == 97) = 1;
        clusters(clusters == 98) = 2;         

        %Because we need to have a vector the right length, we reintroduce
        %the previously removed outliers as intermediate state
        tmp = double(pca_outliers);
        tmp(tmp==1)=2;
        tmp(tmp==0)=clusters;
        clusters = tmp;

        N = size(epdata,1);
        colors = ['w','b','r','g'];
        index1 = 1;
        index2 = 1;
        tot_clusters = [];
        while index2<length(clusters)
            if clusters(index2)~= clusters(index2+1) || (index2 + 1) == length(clusters)
                    tot_clusters((1+(index1-1)*N):index2*N) = clusters(index2);
                    cl = clusters(index2);
                    index1 = index2 +1;
            end
                index2 = index2 + 1;
        end
end  
    %% PCA - NO anesthesia case

if strcmp(answer_anes,'No')
    STATES = struct([]);
    pxx_tot = struct([]);
    data2cluster = [];

    %Saving plots
    SPECTRO = struct([]);

    disp("Computing the spectograms")
    for ii=1:length(FINAL_DATA) %For each  brain area, we compute the spectogram and features that will be included in the PCA
        epdata = data2ep(FINAL_DATA{ii}, 10, 600); %We use 10 seconds long epochs here, because too short = doesn't detect slow oscillations
        [pxx,f] = pmtm(epdata,4,[],ds_fhz);

        %Heatmap of power, for visualizing purposes
        heatmap_data = [];

        for jj=1:size(epdata,2)
            fhz = 0:0.5:100;
            for kk = 1:(length(fhz)-1)
                heatmap_data(jj,kk) = spectral_power(fhz(kk), fhz(kk+1), jj, pxx, f);
            end

        end

        SPECTRO{ii} = log(heatmap_data)';
    end
    
    % First we detect the wakeful states using the accelerometer data 
    
    epaux = data2ep(ACC_RES, 5, ds_fhz);
    
    var = (max(epaux)-min(epaux))/max(max(epaux)-min(epaux)); %we compute an artificial variable to better detect the high amplitude signals resulting from wake
    
    outl = var>0.05; %Manual thresholding for wake detection ==> A REVOIR
    outl = double(outl);
    outl(outl==0) = 2;
    
    m1 = mean(var(outl == 1));
    m2 = mean(var(outl == 2));
    %We manually put 1 = wake and 2 = sleep
    if m1 < m2
        outl(outl == 1) = 3;
        outl(outl == 2) = 1;
        outl(outl == 3) = 2;
    end
    
   % Smoothing
   %If sudden sleep within wakeful period, we assume it is still wake
   index = 1;
   while index < length(outl)
       if outl(index) == 1
           index = index +1;
       else
           count = 1;
           while outl(index) == 2 & index < length(outl);
               index = index +1;
               count = count +1;
           end
           if count <=2 %If sleep of less than 10 seconds, consider it is still wake (enables to avoid having too many switches between sleep and wake, as the sudden arousals usually last little within a sleep period)
               outl((index-count):(index-1)) = linspace(1,1,count);
           end
       end
   end
   
   % Now we run the PCA on the sleep parts of the data
for ii=1:length(FINAL_DATA)
    
        epdata = data2ep(FINAL_DATA{ii}, 5, 600); 
        epdata = epdata(:,outl==2);
        [pxx,f] = pmtm(epdata,4,[],ds_fhz);
        
        % PCA on several features
        % In order: slow oscillations, delta, theta, low beta, low gamma, high
        % gamma,
        features = [0.5, 3, 3, 5, 5, 11, 30, 45, 55, 80, 80, 150]; %Different frequency bands because anesthesia would slow down oscillations
        % Compute spectral power for each
        data2cluster_tmp = [];
        for jj=1:1:size(pxx,2)
            for kk=1:(length(features)/2)
                data2cluster_tmp(jj,kk) = log(spectral_power(features(2*(kk-1)+1), features(2*kk), jj, pxx, f));
            end
        end
        data2cluster_tmp(:,length(features)/2+1) = data2cluster_tmp(:,3) ./ data2cluster_tmp(:,1);  %theta/SO
        data2cluster_tmp(:,length(features)/2+2) = max(abs(epdata)); % max amplitude of each epoch
        data2cluster = [data2cluster data2cluster_tmp];

end
        %normalization over the columns ie for each feature
        MAX = max(data2cluster);
        data2cluster_norm = data2cluster ./ MAX;

        disp("Running PCA")

        [coeff,~,latent,~,explained] = pca(data2cluster_norm);

        % Contribution of each feature in the first components

        if strcmp(answer_ba, 'Both') == 0
            variables = {'Slow oscillations 0.5-3Hz','Delta 3-5Hz','Theta 5-11Hz','Low beta 30-45 Hz','Low gamma 55-80 Hz','High gamma 80-150 Hz', 'Theta/SO ratio', 'Epoch max amplitude'};
        elseif strcmp(answer_ba, 'Both') == 1
            variables = {'Slow oscillations 0.5-3Hz HPC','Delta 3-5Hz HPC','Theta 5-11Hz HPC','Low beta 30-45 Hz HPC','Low gamma 55-80 Hz HPC','High gamma 80-150 Hz HPC', 'Theta/SO ratio HPC', 'Epoch max amplitude HPC', 'Slow oscillations 0.5-3Hz PFC','Delta 3-5Hz PFC','Theta 5-11Hz PFC','Low beta 30-45 Hz PFC','Low gamma 55-80 Hz PFC','High gamma 80-150 Hz PFC', 'Theta/SO ratio PFC', 'Epoch max amplitude PFC'};
        end 

        % We retrieve the 2 first components
        PC1 = sum(data2cluster_norm' .* coeff(:,1), 1);
        PC2 = sum(data2cluster_norm' .* coeff(:,2), 1);   

    %     clusters = kmeans([log(PC1)'  real(log(PC2))'],2);
        clusters = kmeans([PC1'  PC2'],2, 'MaxIter', 500);

        %If one epoch alone is into other cluster, make it into same cluster
        %than rest ==> Seems like a bad idea
        index = 2;
        while index <= (length(clusters)-1)
            if clusters(index-1) == clusters(index+1) & clusters(index) ~= clusters(index-1)
                clusters(index) = clusters(index-1);
                index = index+1;
            end
            index = index+1;
        end

        % We set REM in cluster 1, the two other clusters are NREM and
        % intermediate
        ampl = data2cluster(:,9);
        %first find the cluster corresponding to REM and NREM
        %starting values
        rems = 1;
        nrems = 1;
        minimum = mean(ampl(clusters==1));
        maximum = mean(ampl(clusters==1));
        for jj=unique(clusters)'
          if  mean(ampl(clusters==jj)) < minimum
              rems = jj;
              minimum = mean(ampl(clusters==jj));
          end
          if mean(ampl(clusters==jj)) > maximum
              nrems = jj;
              maximum = mean(ampl(clusters==jj));
          end
        end
        if length(unique(clusters))>2
            tmp = unique(clusters);
            tmp(tmp == rems) = [];
            tmp(tmp == nrems) = [];
            int = tmp;
        end
        %now that you found the cluster corresponding to rem and nrem and intermediate, put them in
        %position 1 and 2 respectively
        clusters(clusters == rems) = 97;
        clusters(clusters == nrems) = 98;
        if length(unique(clusters))>2
            clusters(clusters == int) = 3;
        end
        clusters(clusters == 97) = 1;
        clusters(clusters == 98) = 2;         


        N = size(epdata,1);
        colors = ['w','b','r','g'];
        index1 = 1;
        index2 = 1;
        tot_clusters = [];
        while index2<length(clusters)
            if clusters(index2)~= clusters(index2+1) || (index2 + 1) == length(clusters)
                    tot_clusters((1+(index1-1)*N):index2*N) = clusters(index2);
                    cl = clusters(index2);
                    index1 = index2 +1;
            end
                index2 = index2 + 1;
        end

tmp = outl;
tmp(outl==1) = 4; %Wake
tmp(outl==2) = clusters; %sleep states

clusters2 = tmp; %for the plot
end
% %% Ajustment
% % Intermediate states will be discriminated between REM and NREM based on
% % the presence or not of ripples
% % So first we need to detect ripples
% clusterstmp = clusters;
% hpc = FINAL_DATA{1};
% [e,f] = butter(3, [90/300 299/300]);
% hpcrip = filtfilt(e,f,hpc);
% 
% yourtimevector = (1:length(hpcrip))/600;
% 
% thresh = mean(hpcrip) + 5*std(hpcrip);
% [S, E, M] = findMoreRipplesLisa(hpcrip', yourtimevector, thresh, (thresh)*(1/2), ds_fhz,[] );
% 
% ripple_hpc = zeros(1,length(hpc));
% 
% %Use this part if you want to take into account the ripple duration
% index = 1;
% index2 = 1;
% while index < length(yourtimevector) & index2<length(E)  
%     if S(index2) == yourtimevector(index)
%         while E(index2) ~= yourtimevector(index)
%             ripple_hpc(index) = 1;
%             index = index + 1;
%         end
%         index2 = index2 + 1;
%     else
%         index = index + 1;
%     end
% end
% 
% % Group the ripples by 10s bins so as to compare with the clustering output
% % of the PCA
% 
% clus_ripples = data2ep(ripple_hpc, 30, 600);
% clus_ripples = sum(clus_ripples);
% clus_ripples = repelem(clus_ripples./10, 10);
% clus_ripples = [clus_ripples zeros(1,length(clusters) - length(clus_ripples))];
% 
% % Compute the average amount of ripples in rem and nrem
% rip_rem = quantile(clus_ripples(clusters==1), [0.25 0.75]);
% rip_nrem = quantile(clus_ripples(clusters==2), [0.25 0.75]);
% 
% %Detect every intermediate bout
% inter = double(clusters == 3);
% dinter = diff(inter);
% index_start = find(dinter == 1) + 1;
% index_end = find(dinter == -1);
% 
% if inter(1) == 1
%     index_start = [1 index_start];
% end
% if inter(end) == 1
%     index_end = [index_end length(inter)];
% end
% 
% % Now go through every one of them and change accordingly
% for ii = 1:length(index_start)
%     start = index_start(ii);
%     fin = index_end(ii);
%     if (fin - start + 1)<=5 & start~=1 & fin~=length(clusters) & (clusters(start-1) == clusters(fin +1))
%         value = clusters(start-1);
%         clusters(start:fin) = value;
%     elseif (fin - start + 1) > 3 
%         tmpmean = mean(clus_ripples(start:fin));
%         if tmpmean >= rip_nrem(1) 
%              clusters(start:fin) = 2; % Then we consider it's NREM
%         end
%     end
% end
% 
% % Problem : we can't say that intermediate bouts with low ripples are REM
% % because it is quite common that NREM periods show a significant amount of
% % time without ripples (but it's still NREM)
% 

    %% Plots
    
    figure('units','normalized','outerposition',[0 0 1 1]) %Full window figure output
    t = tiledlayout(9,5) 
    title(t, 'Automated PCA classifier')
    % Spectrograms
    
    if strcmp(answer_ba, 'Both') == 1
        t1 = nexttile([3 3]);
    else
        t1 = nexttile([5 3])
    end
    plot(linspace(duration([0 0 0]), duration([0 0 length(FINAL_DATA{1})/600]),size(SPECTRO{1},2)), mean(SPECTRO{1}))
    ylim([0 300])
    hold on
    timerange = [duration([0 0 0]) duration([0 0 length(FINAL_DATA{1})/600])];
    imagesc(datenum(timerange),[min(fhz) max(fhz)], SPECTRO{1})
    colormap(t1, 'parula')
    %colorbar();
    set(gca,'YDir','normal')
    title(strcat(BA{1},' Spectrogram'))
    
    if strcmp(answer_ba, 'Both') == 1    %This one we plot only if we use both PFC and HPC   
        t2 = nexttile([3 3]);
        plot(linspace(duration([0 0 0]), duration([0 0 length(FINAL_DATA{1})/600]),size(SPECTRO{1},2)), mean(SPECTRO{1}))
        ylim([0 300])
        hold on
        imagesc(datenum(timerange), [min(fhz) max(fhz)], SPECTRO{2})
        colormap(t2, 'parula')
        %colorbar();
        set(gca,'YDir','normal')
        title(strcat(BA{2},' Spectrogram'))
    end
    
    % Data signals
    
    if strcmp(answer_ba, 'Both') == 1
        t3 = nexttile([1 3]);
    else
        t3 = nexttile([2 3]);
    end
    plot(linspace(duration([0 0 0]), duration([0 0 length(FINAL_DATA{1})/600]),length(FINAL_DATA{1})), FINAL_DATA{1}')
    title(strcat(BA{1}, ' signal'))
    
    if strcmp(answer_ba, 'Both') == 1    % Idem
        t4 = nexttile([1 3]);
        plot(linspace(duration([0 0 0]), duration([0 0 length(FINAL_DATA{2})/600]),length(FINAL_DATA{2})), FINAL_DATA{2}')
        title(strcat(BA{2}, ' signal'))
    end
    
    % State plot
 
    if strcmp(answer_ba, 'Both') == 1
        t5 = nexttile([1 3]);
    else
        t5 = nexttile([2 3]);
    end
    
   if strcmp(answer_anes, 'Yes')
        plot(linspace(duration([0 0 0]), duration([0 0 length(FINAL_DATA{1})/600]),length(clusters)), mean(clusters))
        hold on
        statesmat = zeros(7, length(clusters));
        statesmat(2,:) = clusters .* (clusters == 1); %REM
        statesmat(4,:) = clusters .* (clusters == 3); %INT
        statesmat(6,:) = clusters .* (clusters == 2); %NREM
        imagesc(datenum(timerange), [1 7], statesmat);
        set(gca, 'YTick', [2 4 6], 'YTickLabel', [{'REM'}, {'Inter'}, {'NREM'}])
        if nclus == 3
            colormap(t5, [1.0000    0.99    0.95; 0 0.5 1; 0.3 1 0.2; 1 0.2 0.2]);
        else
            colormap(t5, [1.0000    0.99    0.95; 0 0.5 1; 0.3 1 0.2]);
        end
        title('PCA stage classification')
        set(gca,'YDir','reverse')
    else
        plot(linspace(duration([0 0 0]), duration([0 0 length(FINAL_DATA{1})/600]),length(clusters2)), mean(clusters2))
        hold on
        statesmat = zeros(7, length(clusters2));
        statesmat(2,:) = clusters2 .* (clusters2 == 1); %REM
        statesmat(4,:) = clusters2 .* (clusters2 == 2); %NREM
        statesmat(6,:) = clusters2 .* (clusters2 == 4); %Wake
        imagesc(datenum(timerange), [1 7], statesmat);
        set(gca, 'YTick', [2 4 6], 'YTickLabel', [{'REM'}, {'NREM'}, {'Wake'}])
        colormap(t5, [1.0000    0.99    0.95; 0 0.5 1; 0.3 1 0.2; 1 0.2 0.2]);
        title('PCA stage classification')
        set(gca,'YDir','reverse')
    end
    %Link axes of all previous plots
    if strcmp(answer_ba, 'Both') == 1
        linkaxes([t1 t2 t3 t4 t5], 'x');
    else
        linkaxes([t1 t3 t5], 'x');
    end
 
    % Scatter plot of custering in PCA space
    t6 = nexttile([4 2])
    colors = zeros(length(clusters),3);
    colors(clusters == 1,:) = repmat([ 0 0.5 1], length(colors(clusters == 1)),1);
    colors(clusters == 2,:) = repmat([0.3 1 0.2], length(colors(clusters == 2)),1);
    colors(clusters == 3,:) = repmat([ 1 0.2 0.2], length(colors(clusters == 3)),1);
    scatter(PC1, PC2, [], colors)
    xlabel('1st component')
    ylabel('2nd component')
    title('Kmeans clustering in the PC1 - PC2 space')
    
    %Contribution of features to the PCA components (1st and 2nd)
    t7 = nexttile([4 2])
    img = imagesc(coeff(:,1:2));
    colormap(t7, bluewhitered(256));
    colorbar();
    set(gca,'YDir','normal')
    set(gca,'Ytick',1:length(variables),'YTickLabel',variables)
    set(gca,'Xtick',1:2,'XTickLabel',num2str(round(explained(1:2),2)))
    xlabel('Principal components (1st - left and 2nd - right) and percentage of variance explained by them')
    title('Weigth of each PCA feature in the two first principal components')
 
    savepath = uigetdir('C:\','Select where to save the clustering file and PC result');
    save(strcat(savepath,'\states2'), 'clusters')
    
    PCres = struct([]);
    PCres{1} = PC1;
    PCres{2} = PC2;
    PCres{3} = explained;
    save(strcat(savepath,'\pcares'), 'PCres')