addpath(genpath('/home/genzel/Documents/CorticoHippocampal'))
addpath('/home/genzel/Documents/ADRITOOLS/')
cd('/media/genzel/genzel1/CBD_wake')
clc
clear variables
rat_folders=getfolder;
fn=30000;
Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass');

%rat_folders=rat_folders(2:end);
for i=3:length(rat_folders)
    cd(rat_folders{i})
    
    g=getfolder;
    for j=5:length(g)
        cd(g{j})
        trialfolder=getfolder;
        HPC_alltrials=[];
        ACC_alltrials=[];
        HPCraw_alltrials=[];
        for trial=1:length(trialfolder)
            cd(trialfolder{trial})

            if trial==1 % cutoff artifacts counter
                clear count_cutoff
                count_cutoff=0;
            end

            %Get hippocampal channel
            if str2num(rat_folders{i})==4
                HPC=dir('*18*.continuous');
            end
            if str2num(rat_folders{i})==5
                HPC=dir('*14*.continuous');
            end
            if str2num(rat_folders{i})==6
                HPC=dir('*15*.continuous');
            end
            if isempty(HPC)
                cd ..
                continue
            end

            HPC=load_open_ephys_data_faster(HPC.name);
%              length(HPC)/fn/60
% if length(HPC)/fn/60>9
%     xo
% end

            AUX1=load_open_ephys_data_faster('100_CH33_0.continuous');
            AUX2=load_open_ephys_data_faster('100_CH34_0.continuous');
            AUX3=load_open_ephys_data_faster('100_CH35_0.continuous');

            %Truncating.

            HPC=HPC(1: fn*60*5);
            AUX1=AUX1(1: fn*60*5);
            AUX2=AUX2(1: fn*60*5);
            AUX3=AUX3(1: fn*60*5);
%                         length(HPC)/fn/60
                        if   (length(HPC)/fn/60)~=5
                                error('shorter recording found')
                        end


HPC_filt=filtfilt(b1,a1,HPC);
AUX1=filtfilt(b1,a1,AUX1);
AUX2=filtfilt(b1,a1,AUX2);
AUX3=filtfilt(b1,a1,AUX3);

% if trial==4
%     xo
% end
[consec]=ConsecutiveOnes(diff(HPC)==0); %Find amplitude saturation.

if  max(unique(consec(consec~=0)))>=65 %100
    count_cutoff=count_cutoff+1;
    warning('cut-off signal')
    g{j}
    ['trial ' num2str(trial)]
% HPC_filt=nan(size(HPC));
% AUX1=nan(size(HPC));
% AUX2=nan(size(HPC));
% AUX3=nan(size(HPC));
% HPC=nan(size(HPC));
end


ACC=sqrt(AUX1.^2+AUX2.^2+AUX3.^2);
HPC_alltrials=[HPC_alltrials ;HPC_filt(:)];
ACC_alltrials=[ACC_alltrials ;ACC(:)];
HPCraw_alltrials=[HPCraw_alltrials ; HPC(:)];



%xo
%             if             length(HPC)/fn/60>9
%                 xo
%             end
            cd ..
        end
%%  
% if count_cutoff>=3 % Most of the signal has saturation artifacts
%     warning('Study day has saturation artifacts, ignoring')
%     cd ..
%     continue
% end
%%
%xo
nansamples=find(isnan(ACC_alltrials));
ACC_alltrials(nansamples)=0;

ACC_rms=(abs(hilbert(ACC_alltrials)));
Wn1=[ 30/(fn/2)]; % Cutoff=100-300 Hz
[b2,a2] = butter(3,Wn1,'low');
ACC_rms=filtfilt(b2,a2,ACC_rms);
% ACC_rms=abs(zscore(ACC_rms));
ACC_rms(nansamples)=NaN;

m_ACC=nanmedian(ACC_rms);
sd_ACC=nanstd(ACC_rms);
th=m_ACC+1.25*sd_ACC;


%%
HPC_alltrials2=HPC_alltrials;   
HPCraw_alltrials2=HPCraw_alltrials;   

% indices_above_threshold = find(ACC_alltrials >  mean(ACC_alltrials)*0.6 );
% Find samples that exceed the threshold
above_threshold = ACC_rms > th;
above_threshold=above_threshold.';
% Find start and end indices of segments above threshold
% segment_starts = [0, find(diff([0, above_threshold]) == 1)];
% segment_ends = [find(diff(above_threshold) == -1), numel(HPC_alltrials2)];
segment_starts = [find(diff([0, above_threshold]) == 1)];
% segment_ends = [find(diff(above_threshold) == -1), numel(HPC_alltrials2)];
segment_ends = [find(diff(above_threshold) == -1)];

if length(segment_starts)>length(segment_ends)
    segment_ends = [find(diff(above_threshold) == -1), numel(HPC_alltrials2)];
end

if length(segment_ends)>length(segment_starts)
    xo
%    segment_ends = [find(diff(above_threshold) == -1), numel(HPC_alltrials2)];
end

% segment_starts=segment_starts(2:end);
% segment_ends=segment_ends(1:end-1);


% below_threshold = ACC_rms <= th;
% below_threshold=below_threshold.';
% belowsegment_starts = [0, find(diff([0, below_threshold]) == 1)];
% belowsegment_ends = [find(diff(below_threshold) == -1), numel(HPC_alltrials2)];

% for i = 1:length(belowsegment_starts)-1
%     belowsegment_duration = belowsegment_ends(i) - belowsegment_starts(i) + 1;
%     if belowsegment_duration <1*fn
%         HPC_alltrials2(belowsegment_starts(i)+1:belowsegment_ends(i)) = NaN;
%     end
% end


% % Merge segments that are closer than the merge distance
% segments_to_remove = [];
% for i = 2:length(segment_starts)
%     if segment_starts(i) - segment_ends(i - 1) <= .050*fn
%         segments_to_remove = [segments_to_remove, i - 1];
%         segment_ends(i) = segment_ends(i - 1);
%     end
% end
% 


% segment_starts(segments_to_remove) = [];
% segment_ends(segments_to_remove) = [];

% Remove segments with duration below the minimum duration
for in = 1:length(segment_starts)
    if in>1
        if segment_starts(in)-segment_ends(in-1)<1*fn
            segment_starts(in)=segment_ends(in-1);

        end    
    end
%     segment_duration = segment_ends(i) - segment_starts(i) ;
%     if segment_duration > .030*fn
        HPC_alltrials2(segment_starts(in)+1:segment_ends(in)) = NaN;
%     end
end
%xo
%% Remove high theta periods
% Wn1=[5/(fn/2) 10/(fn/2)]; % Cutoff=100-300 Hz
% [b1,a1] = butter(2,Wn1,'bandpass');

% HPC_theta=filtfilt(b1,a1,HPCraw_alltrials);
% HPC_theta2=HPC_theta;
% HPC_theta=(abs(hilbert(HPC_theta)));
% Parameters for STFT

HPCraw_alltrials(nansamples)=0;


window_length = 0.5*fn;
overlap = window_length/2;
nfft = [];

% Compute the STFT
[s, f, t_spec] = spectrogram(HPCraw_alltrials, hamming(window_length), overlap, nfft, fn);

% Define frequency band of interest
freq_band = [5, 10];  % Frequency band from 5 Hz to 10 Hz

% Find indices of frequency bins within the frequency band
freq_indices = find(f >= freq_band(1) & f <= freq_band(2));

% Calculate power in the frequency band for each time frame
power_in_band = sum(abs(s(freq_indices, :)).^2, 1);
Wn1=[ 150/(fn/2)]; % Cutoff=100-300 Hz
[b2,a2] = butter(3,Wn1,'low');
HPC_theta2=filtfilt(b2,a2,power_in_band);
HPC_theta=HPC_theta2;

nandown=zeros(size(HPCraw_alltrials));
nandown(nansamples)=1;
nandown=downsample(nandown,fn/(1/(t_spec(2)-t_spec(1)))); % 4 Hz downsampling due to windowing.
nandown=nandown(1:end-1);

HPC_theta(find(nandown))=NaN;

m_theta=nanmean(HPC_theta);
sd_theta=nanstd(HPC_theta);
th_theta=m_theta+1.5.*sd_theta;
% th_theta=m_theta+2.*sd_theta;

%%
timestamps= [1:length(HPC_alltrials2)]'./fn;

above_theta = HPC_theta > th_theta;
% above_theta=above_theta.';
% Find start and end indices of segments above threshold
thsegment_starts = [find(diff([0, above_theta]) == 1)];
% thsegment_ends = [find(diff(above_theta) == -1), numel(HPC_theta)];
thsegment_ends = [find(diff(above_theta) == -1)];


if length(thsegment_starts)>length(thsegment_ends)
    thsegment_ends = [find(diff(above_theta) == -1), numel(above_theta)];
end

if length(thsegment_ends)>length(thsegment_starts)
    xo
%    segment_ends = [find(diff(above_threshold) == -1), numel(HPC_alltrials2)];
end


%%
% Calculate closest minimum values before and after each segment
trough_indices = find(islocalmin(HPC_theta));

for indd = 1:length(thsegment_starts)
    if thsegment_starts(indd)~=1   &   ~isempty(trough_indices(trough_indices<= thsegment_starts(indd))) % if not first sample, and if no empty minimum values
            current_start =trough_indices(trough_indices<= thsegment_starts(indd));
            current_start=current_start(end);
    else
            current_start=thsegment_starts(indd); 
    end

    if ~isempty(trough_indices(trough_indices>= thsegment_ends(indd)))
        current_end =trough_indices(trough_indices>= thsegment_ends(indd));
        current_end=current_end(1);
    else
        current_end=thsegment_ends(indd);
    end
 
 thsegment_starts(indd)= thsegment_starts(indd)- round((thsegment_starts(indd)-current_start)/2);   
 thsegment_ends(indd)= thsegment_ends(indd)+ round((current_end-thsegment_ends(indd))/2);

end

%%
thsegment_starts=findclosest(timestamps, t_spec(thsegment_starts));
thsegment_ends=findclosest(timestamps, t_spec(thsegment_ends));

% Remove segments with duration below the minimum duration
for in = 1:length(thsegment_starts)
    if in>1
         if thsegment_starts(in)-thsegment_ends(in-1)<1*fn
%        if t_spec(thsegment_starts(in))-t_spec(thsegment_ends(in-1))<1 %less than a second inter-theta interval

            %xo
            thsegment_starts(in)=thsegment_ends(in-1);

        end    
    end
    %xo
        HPC_alltrials2(thsegment_starts(in)+1:thsegment_ends(in)) = NaN;
%        HPC_alltrials2(findclosest(timestamps, t_spec(thsegment_starts(in)))+1:findclosest(timestamps, t_spec(thsegment_ends(in))))=NaN; 
end
%xo
%%
m_HPC=nanmean(HPC_alltrials2);
sd_HPC=nanstd(HPC_alltrials2);
th_HPC=m_HPC+5.*sd_HPC;
%%

% %%
% % % Interpolate over NaN values to smooth the signal
% % %HPC_alltrials2 = fillmissing(HPC_alltrials2, 'linear');
% 
% h1=subplot(3,1,1)
% plot(timestamps,HPC_alltrials); hold on; plot(timestamps,HPC_alltrials2)
% h2=subplot(3,1,2)
% plot(timestamps,ACC_rms)
% h3=subplot(3,1,3)
% % plot(timestamps,filtfilt(b2,a2, abs([diff(ACC_rms); 0])))
% plot(timestamps,HPC_theta)
% 
% 
% linkaxes([h1 h2 h3],'x')
%%
% indices_above_threshold = find(ACC_rms >  th);
% 
% HPC_alltrials2(indices_above_threshold) = [];
% HPCraw_alltrials2(indices_above_threshold) = [];

[S,E,M]=findRipplesLisa(HPC_alltrials2,timestamps, th_HPC, th_HPC/2);

n_s=sort([segment_starts thsegment_starts]).';
n_e=sort([segment_ends thsegment_ends]).';


[co_vec1, co_vec2, count_co_vec1, count_co_vec2]=cooccurrence_vec(S*fn,E*fn,n_s, n_e);

S(co_vec1)=[];
E(co_vec1)=[];
M(co_vec1)=[];

%%
% Wn1=[5/(fn/2) 10/(fn/2)]; % Cutoff=100-300 Hz
% [b1,a1] = butter(2,Wn1,'bandpass');
% 
% HPCraw_alltrials2=filtfilt(b1,a1,HPCraw_alltrials2);
%%
xo
%plot(timestamps,HPC_alltrials2)
% plot(timestamps,HPCraw_alltrials2)
%%
h1=subplot(4,1,1)
plot(timestamps,HPC_alltrials)

hold on
plot(timestamps,[th_HPC.*ones(size(timestamps))])

stem(M, ones(size(M))*400)
stem(E, ones(size(M))*400)
stem(S, ones(size(M))*400)
title('HPC Filtered (100-300 Hz)')
h2=subplot(4,1,2)
plot(timestamps,HPCraw_alltrials)

title('HPC RAW')

h3=subplot(4,1,3)
plot(timestamps,ACC_rms)
hold on
plot(timestamps,[th.*ones(size(timestamps))])
        
title('Accelerometer')

h4=subplot(4,1,4)
% plot(timestamps,filtfilt(b2,a2, abs([diff(ACC_rms); 0])))
plot(t_spec,HPC_theta)
hold on
plot(t_spec,[th_theta.*ones(size(t_spec))])
title('HPC Theta power envelope')
xlabel('Seconds')

linkaxes([h1 h2 h3 h4] ,'x')

%%
waveforms_ripples_broadband= {};
waveforms_ripples_filtered= {};

for c=1:length(S)

            if (S(c)/60<= 5)
                trialnumber=1;
            elseif  (S(c)/60> 5) && (S(c)/60<= 10)   
                trialnumber=2;
            elseif  (S(c)/60> 10) && (S(c)/60<= 15)   
                trialnumber=3;
            elseif  (S(c)/60> 15) && (S(c)/60<= 20)   
                trialnumber=4;
            else
                trialnumber=5;
            
            end

%            waveforms_ripples_broadband{c,trialnumber}= HPCraw_alltrials(S(c)*fn:E(c)*fn);
           waveforms_ripples_filtered{c,trialnumber}= HPC_alltrials(S(c)*fn:E(c)*fn);

end
% Find indices of non-empty cells
non_empty_indices = ~cellfun(@isempty, waveforms_ripples_filtered);
clear ripple_waveform_broadband_total

if ~isempty(waveforms_ripples_filtered)
    ripple_waveform_broadband_total{1,1}=waveforms_ripples_filtered(non_empty_indices(:,1),1);
    ripple_waveform_broadband_total{1,2}=waveforms_ripples_filtered(non_empty_indices(:,2),2);
    ripple_waveform_broadband_total{1,3}=waveforms_ripples_filtered(non_empty_indices(:,3),3);
    if size(non_empty_indices,2)>3
        ripple_waveform_broadband_total{1,4}=waveforms_ripples_filtered(non_empty_indices(:,4),4);
    else
       ripple_waveform_broadband_total{1,4}={};        
    end
    
    if size(non_empty_indices,2)>4 % In case there are no ripples in the last trial the size would be 4. 
      ripple_waveform_broadband_total{1,5}=waveforms_ripples_filtered(non_empty_indices(:,5),5);
    else
      ripple_waveform_broadband_total{1,5}={};
    end
else
    warning('No ripples in this study day!')
    g{j}
    ripple_waveform_broadband_total{1,1}={};
    ripple_waveform_broadband_total{1,2}={};
    ripple_waveform_broadband_total{1,3}={};
    ripple_waveform_broadband_total{1,4}={};
    ripple_waveform_broadband_total{1,5}={};
end
%xo

%%
%        xo
        cd ..
if ~isempty(waveforms_ripples_filtered)        
    save(strcat('ripple_waveforms_broadband_',g{j},'.mat'),'ripple_waveform_broadband_total','-v7.3')
else
     save(strcat('ripple_waveforms_broadband_EMPTY',g{j},'.mat'),'ripple_waveform_broadband_total','-v7.3')   
end

clear ripple_waveform_broadband_total waveforms_ripples_filtered S E M HPC_alltrials HPC_alltrials2 HPC_filt HPC_theta HPCraw_alltrials HPCraw_alltrials2 co_vec1 co_vec2 segment_ends segment_starts thsegment_ends thsegment_starts n_s n_e nansamples nandown
    end
    cd ..
end

% 
% 
% [x]=load_open_ephys_data_faster('100_CH18_0.continuous');
% %%
% fn=30000; % New sampling frequency. 
% Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=100-300 Hz
% % Wn1=[50/(fn/2) 80/(fn/2)]; 
% [b1,a1] = butter(3,Wn1,'bandpass');
% 
% x_filt=filtfilt(b1,a1,x);