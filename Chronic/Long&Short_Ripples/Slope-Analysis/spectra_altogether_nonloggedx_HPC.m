
%%
clc
clear all
close all
addpath('/home/genzellab/Desktop/Pelin/functions');
addpath('/home/genzellab/Desktop/Pelin/fieldtrip');

load("baselines_HPC_veh.mat");
load("baselines_HPC_cbd.mat");
load("short_ripples_chronics_veh.mat");
load("short_ripples_chronics_cbd.mat");
load("long_ripples_chronics_veh.mat");
load("long_ripples_chronics_cbd.mat");

%% data preparation
all_ripples_chronics_veh=[short_ripples_chronics_veh;long_ripples_chronics_veh];
all_ripples_chronics_cbd=[short_ripples_chronics_cbd;long_ripples_chronics_cbd];

%% Baselines - Vehicle
% Fieldtrip format
input=baselines_veh_HPC;
fn=2500;
leng=length(input);
ro=5000;
tm = create_timecell_chronics(ro,leng);

channel = [{'HPC'}];

label=channel;
data.label=label;
data.time=tm;
data.trial=input.';

%% Filtering
% remove line noise
cfg                = [];
cfg.channel        = {'all'};
cfg.dftfilter      = 'yes';
data       = ft_preprocessing(cfg,data);


%% Compute power spectra
cfg1         = [];
cfg1.length        = 4;
rpt     = ft_redefinetrial(cfg1,data);

% periodogram
cfg2 = [];
cfg2.output  = 'pow';
cfg2.channel = 'HPC';
cfg2.method  = 'mtmfft'; % multitaper
cfg2.taper   = 'hanning';
cfg2.keeptrials = 'yes';

cfg2.foi     = 0:0.25:100; % 1/cfg1.length  = 4;
freq= ft_freqanalysis(cfg2, rpt);
power_spec=squeeze(freq.powspctrm);

%% Calculate STerror & mean
sterror_baselines_veh=std(log10(power_spec)) / sqrt(length(power_spec));
mean_baselines_veh=mean(log10(power_spec),1);
freq=freq.freq;

save mean_sterror_baselines_veh.mat sterror_baselines_veh mean_baselines_veh freq


%% Baselines - CBD
% Fieldtrip format
clear data
input=baselines_cbd_HPC;
fn=2500;
leng=length(input);
ro=5000;
tm = create_timecell_chronics(ro,leng);

channel = [{'HPC'}];

label=channel;
data.label=label;
data.time=tm;
data.trial=input.';

%% Filtering
% remove line noise
cfg                = [];
cfg.channel        = {'all'};
cfg.dftfilter      = 'yes';
data       = ft_preprocessing(cfg,data);


%% Compute power spectra
cfg1         = [];
cfg1.length        = 4;
rpt     = ft_redefinetrial(cfg1,data);

% periodogram
cfg2 = [];
cfg2.output  = 'pow';
cfg2.channel = 'HPC';
cfg2.method  = 'mtmfft'; % multitaper
cfg2.taper   = 'hanning';
cfg2.keeptrials = 'yes';

cfg2.foi     = 0:0.25:100; % 1/cfg1.length  = 4;
freq= ft_freqanalysis(cfg2, rpt);
power_spec=squeeze(freq.powspctrm);

%% Calculate STerror & mean
sterror_baselines_cbd=std(log10(power_spec)) / sqrt(length(power_spec));
mean_baselines_cbd=mean(log10(power_spec),1);
freq=freq.freq;

save mean_sterror_baselines_cbd.mat sterror_baselines_cbd mean_baselines_cbd freq


%% All Ripples - Vehicle
% Fieldtrip format
clear data
input=all_ripples_chronics_veh;
fn=2500;
leng=length(input);
ro=5000;
tm = create_timecell_chronics(ro,leng);

channel = [{'PFC'},{'HPC'}];

label=channel;
data.label=label;
data.time=tm;
data.trial=input.';

%% Filtering
% remove line noise
cfg                = [];
cfg.channel        = {'all'};
cfg.dftfilter      = 'yes';
data       = ft_preprocessing(cfg,data);


%% Compute power spectra
cfg1         = [];
cfg1.length        = 4;
rpt     = ft_redefinetrial(cfg1,data);

% periodogram
cfg2 = [];
cfg2.output  = 'pow';
cfg2.channel = 'HPC';
cfg2.method  = 'mtmfft'; % multitaper
cfg2.taper   = 'hanning';
cfg2.keeptrials = 'yes';

cfg2.foi     = 0:0.25:100; % 1/cfg1.length  = 4;
freq= ft_freqanalysis(cfg2, rpt);
power_spec=squeeze(freq.powspctrm);

%% Calculate STerror & mean
sterror_all_ripples_veh=std(log10(power_spec)) / sqrt(length(power_spec));
mean_all_ripples_veh=mean(log10(power_spec),1);
freq=freq.freq;

save mean_sterror_all_ripples_veh.mat sterror_all_ripples_veh mean_all_ripples_veh freq


%% All Ripples - CBD
% Fieldtrip format
clear data
input=all_ripples_chronics_cbd;
fn=2500;
leng=length(input);
ro=5000;
tm = create_timecell_chronics(ro,leng);

channel = [{'PFC'},{'HPC'}];

label=channel;
data.label=label;
data.time=tm;
data.trial=input.';

%% Filtering
% remove line noise
cfg                = [];
cfg.channel        = {'all'};
cfg.dftfilter      = 'yes';
data       = ft_preprocessing(cfg,data);


%% Compute power spectra
cfg1         = [];
cfg1.length        = 4;
rpt     = ft_redefinetrial(cfg1,data);

% periodogram
cfg2 = [];
cfg2.output  = 'pow';
cfg2.channel = 'HPC';
cfg2.method  = 'mtmfft'; % multitaper
cfg2.taper   = 'hanning';
cfg2.keeptrials = 'yes';

cfg2.foi     = 0:0.25:100; % 1/cfg1.length  = 4;
freq= ft_freqanalysis(cfg2, rpt);
power_spec=squeeze(freq.powspctrm);

%% Calculate STerror & mean
sterror_all_ripples_cbd=std(log10(power_spec)) / sqrt(length(power_spec));
mean_all_ripples_cbd=mean(log10(power_spec),1);
freq=freq.freq;

save mean_sterror_all_ripples_cbd.mat sterror_all_ripples_cbd mean_all_ripples_cbd freq





%% Plotting
clear
load('mean_sterror_baselines_veh.mat');
load('mean_sterror_baselines_cbd.mat');
load('mean_sterror_all_ripples_veh.mat');
load('mean_sterror_all_ripples_cbd.mat');

figure;

%% All Events - Veh
y = mean_all_ripples_veh; % mean vector
x = (freq);

plot(x, y, 'Color','k', 'LineStyle','-','LineWidth', 1.5); 
hold on

%% Baselines - Veh
y = mean_baselines_veh; % mean vector
x = (freq);

plot(x, y, 'Color','k', 'LineStyle','--','LineWidth', 1.5); 
xlim([-1 101])


xlabel('Frequency (Hz)','FontSize',26);
ylabel('absolute power (uV^2) - log10(y)','FontSize',15);
title('Periodogram - Baselines vs All Ripples','FontSize',15)

%% All Events - CBD
y = mean_all_ripples_cbd; % mean vector
x = (freq);

plot(x, y, 'Color',[12/255 97/255 13/255], 'LineStyle','-','LineWidth', 1.5); 

%% Baselines - CBD
y = mean_baselines_cbd; % mean vector
x = (freq);

plot(x, y, 'Color',[12/255 97/255 13/255], 'LineStyle','--','LineWidth', 1.5); 




lgd =legend('Ripple Veh','Baseline Veh','Ripples CBD','Baseline CBD');

saveas(gcf,'periodogram_altogether.fig')
saveas(gcf,'periodogram_altogether.jpg')
saveas(gcf,'periodogram_altogether.pdf')
close all
