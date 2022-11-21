%% Pelin Ozsezer

%% PERIODOGRAMS

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vehicle - All events %%
%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all
close all
addpath('/home/genzellab/Desktop/Pelin/functions');
addpath('/home/genzellab/Desktop/Pelin/fieldtrip');

load GC_veh.mat

% Combine all events and select 4 sec of time window centered around the peak
GC_all_events_veh=[GC_ripple_veh.waveforms;GC_sw_veh.waveforms;...
GC_swr_veh.waveforms;GC_complex_swr_veh.waveforms];
GC_all_events_veh=cellfun(@(x) extract_range(x,1801,-1200,1200),GC_all_events_veh,'UniformOutput',false);

% Fieldtrip format
input1=GC_all_events_veh;
fn=600;
leng=length(input1);
ro=1200;
tm = create_timecell(ro,leng);

channel = [{'PFCshal'},{'HPCpyra'},{'HPCbelo'},{'PFCdeep'}];

label=channel;
data_all_events.label=label;
data_all_events.time=tm;
data_all_events.trial=input1.';

%% Filtering
% remove line noise
cfg                = [];
cfg.channel        = {'all'};
cfg.dftfilter      = 'yes';
data_all_events        = ft_preprocessing(cfg,data_all_events);

%% Compute power spectra
cfg1         = [];
cfg1.overlap = 0.25;
cfg1.length        = 4;
rpt_all_events     = ft_redefinetrial(cfg1, data_all_events);

% periodogram
cfg2 = [];
cfg2.output  = 'pow';
cfg2.channel = 'PFCshal';
cfg2.method  = 'mtmfft'; % multitaper
cfg2.taper   = 'hanning';
cfg2.keeptrials = 'yes';

cfg2.foi     = 0.5:0.25:100; % 1/cfg1.length  = 4;
freq_all_events = ft_freqanalysis(cfg2, rpt_all_events);
power_spec=squeeze(freq_all_events.powspctrm);

%% Calculate STerror & mean
sterror_all_events_veh=std(log10(power_spec)) / sqrt(length(power_spec));
mean_all_events_veh=mean(log10(power_spec),1);
freq=freq_all_events.freq;

clearvars -except sterror_all_events_veh mean_all_events_veh freq
save mean_sterror_veh.mat


%% BASELINE - VEH
%% Baseline
load('baseline_PFC_wa.mat');
% Fieldtrip format
input1=GC_baseline_PFCshal_veh;
fn=600;
leng=length(input1);
ro=1800;
tm = create_timecell(ro,leng);

channel = [{'PFCshal'}];

label=channel;
data.label=label;
data.time=tm;
data.trial=input1.';

%% Filtering
% remove line noise
cfg                = [];
cfg.channel        = {'all'};
cfg.dftfilter      = 'yes';
data        = ft_preprocessing(cfg,data);

%% Compute power spectra
cfg1         = [];
cfg1.overlap = 0.25;
cfg1.length        = 4;
rpt     = ft_redefinetrial(cfg1, data);

% periodogram
cfg2 = [];
cfg2.output  = 'pow';
cfg2.channel = 'PFCshal';
cfg2.method  = 'mtmfft'; % multitaper
cfg2.taper   = 'hanning';
cfg2.keeptrials = 'yes';

cfg2.foi     = 0.5:0.25:100; % 1/cfg1.length  = 4;
freq = ft_freqanalysis(cfg2, rpt);
power_spec=squeeze(freq.powspctrm);

%% Calculate STerror & mean
sterror_baseline_veh=std(log10(power_spec)) / sqrt(length(power_spec));
mean_baseline_veh=mean(log10(power_spec),1);
freq=freq.freq;

clearvars -except sterror_baseline_veh mean_baseline_veh freq
save mean_sterror_baseline_veh.mat


%%%%%%%%%%%%%%%%%%%%%%
%% CBD - All events %%
%%%%%%%%%%%%%%%%%%%%%%

clc
clear all
close all
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/fieldtrip');
addpath('/home/genzellab/Desktop/Pelin/functions');

load GC_cbd.mat

% Combine all events and select 4 sec of time window centered around the peak
GC_all_events_cbd=[GC_ripple_cbd.waveforms;GC_sw_cbd.waveforms;...
GC_swr_cbd.waveforms;GC_complex_swr_cbd.waveforms];
GC_all_events_cbd=cellfun(@(x) extract_range(x,1801,-1200,1200),GC_all_events_cbd,'UniformOutput',false);

% Fieldtrip format
input1=GC_all_events_cbd;
fn=600;
leng=length(input1);
ro=1200;
tm = create_timecell(ro,leng);

channel = [{'PFCshal'},{'HPCpyra'},{'HPCbelo'},{'PFCdeep'}];

label=channel;
data_all_events.label=label;
data_all_events.time=tm;
data_all_events.trial=input1.';

%% Filtering
% remove line noise
cfg                = [];
cfg.channel        = {'all'};
cfg.dftfilter      = 'yes';
data_all_events        = ft_preprocessing(cfg,data_all_events);

%% Compute power spectra
cfg1         = [];
cfg1.overlap = 0.25;
cfg1.length        = 4;
rpt_all_events     = ft_redefinetrial(cfg1, data_all_events);

% periodogram
cfg2 = [];
cfg2.output  = 'pow';
cfg2.channel = 'PFCshal';
cfg2.method  = 'mtmfft'; % multitaper
cfg2.taper   = 'hanning';
cfg2.keeptrials = 'yes';

cfg2.foi     = 0.5:0.25:100; % 1/cfg1.length  = 4;
freq_all_events = ft_freqanalysis(cfg2, rpt_all_events);
power_spec=squeeze(freq_all_events.powspctrm);


%% Calculate STerror & mean
sterror_all_events_cbd=std(log10(power_spec)) / sqrt(length(power_spec));
mean_all_events_cbd=mean(log10(power_spec),1);
freq=freq_all_events.freq;

clearvars -except sterror_all_events_cbd mean_all_events_cbd freq
save mean_sterror_cbd.mat



%% BASELINE - CBD
%% Baseline
load('baseline_PFC_wa.mat');
% Fieldtrip format
input1=GC_baseline_PFCshal_cbd;
fn=600;
leng=length(input1);
ro=1800;
tm = create_timecell(ro,leng);

channel = [{'PFCshal'}];

label=channel;
data.label=label;
data.time=tm;
data.trial=input1.';

%% Filtering
% remove line noise
cfg                = [];
cfg.channel        = {'all'};
cfg.dftfilter      = 'yes';
data        = ft_preprocessing(cfg,data);

%% Compute power spectra
cfg1         = [];
cfg1.overlap = 0.25;
cfg1.length        = 4;
rpt     = ft_redefinetrial(cfg1, data);

% periodogram
cfg2 = [];
cfg2.output  = 'pow';
cfg2.channel = 'PFCshal';
cfg2.method  = 'mtmfft'; % multitaper
cfg2.taper   = 'hanning';
cfg2.keeptrials = 'yes';

cfg2.foi     = 0.5:0.25:100; % 1/cfg1.length  = 4;
freq = ft_freqanalysis(cfg2, rpt);
power_spec=squeeze(freq.powspctrm);

%% Calculate STerror & mean
sterror_baseline_cbd=std(log10(power_spec)) / sqrt(length(power_spec));
mean_baseline_cbd=mean(log10(power_spec),1);
freq=freq.freq;

clearvars -except sterror_baseline_cbd mean_baseline_cbd freq
save mean_sterror_baseline_cbd.mat


%%%%%%%%%%%%%%
%% Plotting %%
%%%%%%%%%%%%%%
clear
load('mean_sterror_veh.mat');
load('mean_sterror_cbd.mat');
load('mean_sterror_baseline_veh.mat');
load('mean_sterror_baseline_cbd.mat');

figure;

%% Veh
y = mean_all_events_veh; % mean vector
x = (freq);

curve1 = mean_all_events_veh-sterror_all_events_veh;
curve2 = mean_all_events_veh+sterror_all_events_veh;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];

p=fill(x2, inBetween,'k');
p.FaceAlpha = 1;
p.FaceColor='#A6A6A6';
p.EdgeColor='#A6A6A6';
hold on

plot(x, y, 'k', 'LineWidth', 0.5);
hold on

xlabel('Frequency (Hz)','FontSize',31);
ylabel('absolute power (uV^2) - log10(y)','FontSize',17);
title('Periodogram - Veh vs CBD','FontSize',20)

% Baseline - Veh
y = mean_baseline_veh; % mean vector
x = (freq);

% curve1 = mean_baseline_veh-sterror_baseline_veh;
% curve2 = mean_baseline_veh+sterror_baseline_veh;
% x2 = [x, fliplr(x)];
% inBetween = [curve1, fliplr(curve2)];
% 
% p=fill(x2, inBetween,[0 0 0]);
% p.FaceAlpha = 1;
% hold on

plot(x, y,'LineStyle',':' ,'Color',[0 0 0], 'LineWidth', 2);

%% CBD
y = mean_all_events_cbd; % your mean vector;
x = (freq);

curve1 = mean_all_events_cbd-sterror_all_events_cbd;
curve2 = mean_all_events_cbd+sterror_all_events_cbd;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];

p=fill(x2, inBetween,'g');
p.FaceAlpha = 1;
p.FaceColor='#53BF33';
p.EdgeColor='#53BF33';
hold on

plot(x, y,'Color',[12/255 97/255 13/255], 'LineWidth', 0.5);


% Baseline - CBD
y = mean_baseline_cbd; % mean vector
x = (freq);

% curve1 = mean_baseline_cbd-sterror_baseline_cbd;
% curve2 = mean_baseline_cbd+sterror_baseline_cbd;
% x2 = [x, fliplr(x)];
% inBetween = [curve1, fliplr(curve2)];
% 
% p=fill(x2, inBetween,[0 0 0]);
% p.FaceAlpha = 1;
% hold on

plot(x, y,'LineStyle',':' ,'Color',[12/255 97/255 13/255], 'LineWidth', 2);

% 

lgd =legend('SE Veh','Mean Veh','Baseline Veh','SE CBD','Mean CBD','Baseline CBD');

saveas(gcf,'periodogram_all_events.fig')
saveas(gcf,'periodogram_all_events.jpg')
saveas(gcf,'periodogram_all_events.pdf')
close all




