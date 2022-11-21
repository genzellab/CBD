%% Pelin Ozsezer

%% PERIODOGRAMS

%%%%%%%%%%%%%
%% Vehicle %%
%%%%%%%%%%%%%
clc
clear all
close all
addpath('/home/genzellab/Desktop/Pelin/functions');
addpath('/home/genzellab/Desktop/Pelin/fieldtrip');


%% Short Ripples %%
load('short_ripples_chronics_veh.mat');

% Fieldtrip format
input=short_ripples_chronics_veh;
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
% sterror_short_ripples_veh=std(log10(power_spec)) / sqrt(length(power_spec));
% mean_short_ripples_veh=mean(log10(power_spec),1);
freq=freq.freq;
pow_vals_short_ripples_veh=power_spec;

save mean_sterror_short_ripples_veh.mat pow_vals_short_ripples_veh freq



%% Long Ripples %%
clear variables
load('long_ripples_chronics_veh.mat');

% Fieldtrip format
input=long_ripples_chronics_veh;
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
% sterror_long_ripples_veh=std(log10(power_spec)) / sqrt(length(power_spec));
% mean_long_ripples_veh=mean(log10(power_spec),1);
freq=freq.freq;
pow_vals_long_ripples_veh=power_spec;

save mean_sterror_long_ripples_veh.mat pow_vals_long_ripples_veh freq

%% Baseline %%
clear variables
load('baselines_HPC_veh.mat');

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
% sterror_baselines_veh=std(log10(power_spec)) / sqrt(length(power_spec));
% mean_baselines_veh=mean(log10(power_spec),1);
freq=freq.freq;
pow_vals_baselines_veh=power_spec;

save mean_sterror_baselines_veh.mat pow_vals_baselines_veh freq



%% Plotting
clear
load('mean_sterror_long_ripples_veh.mat');
load('mean_sterror_short_ripples_veh.mat');
load('mean_sterror_baselines_veh.mat');

figure;

%% short ripples
amatrix=pow_vals_short_ripples_veh;
x = log10(freq);
stdshade_loggedxy(amatrix,0.7,[233/255 255/255 114/255],x) %rgb(233, 255, 114)
hold on

xlabel('Frequency (Hz) - log10(x)','FontSize',26);
ylabel('absolute power (uV^2) - log10(y)','FontSize',17);
title('Veh - ShortR vs LongR vs Baselines','FontSize',15)

%% long ripples
amatrix=pow_vals_long_ripples_veh;
x = log10(freq);
stdshade_loggedxy(amatrix,0.7,[154/255 100/155 244/255],x) %rgb(154, 190, 244)

%% Baselines
amatrix=pow_vals_baselines_veh;
x = log10(freq);
stdshade_loggedxy(amatrix,0.7,[0 0 0],x)

lgd =legend('SE short r','Mean short r','SE long r','Mean long r','SE Baseline','Mean baseline');
lgd.Location='southwest';
xlim([-0.75 2.1])

xticklabels({'0.32','1','3.16','10','31.62','100'})

saveas(gcf,'periodogram_veh.fig')
saveas(gcf,'periodogram_veh.jpg')
saveas(gcf,'periodogram_veh.pdf')
close all

%%%%%%%%%
%% CBD %%
%%%%%%%%%
clc
clear all
close all
addpath('/home/genzellab/Desktop/Pelin/functions');
addpath('/home/genzellab/Desktop/Pelin/fieldtrip');


%% Short Ripples %%
load('short_ripples_chronics_cbd.mat');

% Fieldtrip format
input=short_ripples_chronics_cbd;
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
% sterror_short_ripples_cbd=std(log10(power_spec)) / sqrt(length(power_spec));
% mean_short_ripples_cbd=mean(log10(power_spec),1);
freq=freq.freq;
pow_vals_short_ripples_cbd=power_spec;

save mean_sterror_short_ripples_cbd.mat pow_vals_short_ripples_cbd freq



%% Long Ripples %%
clear variables
load('long_ripples_chronics_cbd.mat');

% Fieldtrip format
input=long_ripples_chronics_cbd;
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
% sterror_long_ripples_cbd=std(log10(power_spec)) / sqrt(length(power_spec));
% mean_long_ripples_cbd=mean(log10(power_spec),1);
freq=freq.freq;
pow_vals_long_ripples_cbd=power_spec;

save mean_sterror_long_ripples_cbd.mat pow_vals_long_ripples_cbd freq

%% Baseline %%
clear variables
load('baselines_HPC_cbd.mat');

% Fieldtrip format
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
% sterror_baselines_cbd=std(log10(power_spec)) / sqrt(length(power_spec));
% mean_baselines_cbd=mean(log10(power_spec),1);
freq=freq.freq;
pow_vals_baselines_cbd=power_spec;

save mean_sterror_baselines_cbd.mat pow_vals_baselines_cbd freq



%% Plotting
clear
load('mean_sterror_long_ripples_cbd.mat');
load('mean_sterror_short_ripples_cbd.mat');
load('mean_sterror_baselines_cbd.mat');

figure;

%% short ripples
amatrix=pow_vals_short_ripples_cbd;
x = log10(freq);
stdshade_loggedxy(amatrix,0.7,[233/255 255/255 114/255],x) %rgb(233, 255, 114)
hold on

xlabel('Frequency (Hz) - log10(x)','FontSize',26);
ylabel('absolute power (uV^2) - log10(y)','FontSize',17);
title('CBD - ShortR vs LongR vs Baselines','FontSize',15)

%% long ripples
amatrix=pow_vals_long_ripples_cbd;
x = log10(freq);
stdshade_loggedxy(amatrix,0.7,[154/255 100/155 244/255],x) %rgb(154, 190, 244)

%% Baselines
amatrix=pow_vals_baselines_cbd;
x = log10(freq);
stdshade_loggedxy(amatrix,0.7,[0 0 0],x)

lgd =legend('SE short r','Mean short r','SE long r','Mean long r','SE Baseline','Mean baseline');
lgd.Location='southwest';
xlim([-0.75 2.1])

xticklabels({'0.32','1','3.16','10','31.62','100'})

saveas(gcf,'periodogram_cbd.fig')
saveas(gcf,'periodogram_cbd.jpg')
saveas(gcf,'periodogram_cbd.pdf')
close all


