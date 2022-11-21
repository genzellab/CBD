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
input=input(randperm(length(input)));
input=input(1:400);
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
freq=freq.freq;

%% Calculate STerror & mean
pow_vals_short_ripples_HPC_veh=power_spec;

save pow_vals_short_ripples_HPC_veh.mat pow_vals_short_ripples_HPC_veh 
save freq.mat freq
clear

FileData = load('freq.mat');
csvwrite('freq.csv', FileData.freq);
clear

FileData = load('pow_vals_short_ripples_HPC_veh.mat');
csvwrite('pow_vals_short_ripples_HPC_veh.csv', FileData.pow_vals_short_ripples_HPC_veh);



%% Long Ripples %%
clear variables
load('long_ripples_chronics_veh.mat');

% Fieldtrip format
input=long_ripples_chronics_veh;
input=input(randperm(length(input)));
input=input(1:400);
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
pow_vals_long_ripples_HPC_veh=power_spec;

save pow_vals_long_ripples_HPC_veh.mat pow_vals_long_ripples_HPC_veh 
clear

FileData = load('pow_vals_long_ripples_HPC_veh.mat');
csvwrite('pow_vals_long_ripples_HPC_veh.csv', FileData.pow_vals_long_ripples_HPC_veh);


%% Baseline %%
clear variables
load('baselines_HPC_veh.mat');

% Fieldtrip format
input=baselines_veh_HPC;
input=input(randperm(length(input)));
input=input(1:400);
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
pow_vals_baselines_HPC_veh=power_spec;

save pow_vals_baselines_HPC_veh.mat pow_vals_baselines_HPC_veh 
clear

FileData = load('pow_vals_baselines_HPC_veh.mat');
csvwrite('pow_vals_baselines_HPC_veh.csv', FileData.pow_vals_baselines_HPC_veh);






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
input=input(randperm(length(input)));
input=input(1:300);
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
pow_vals_short_ripples_HPC_cbd=power_spec;

save pow_vals_short_ripples_HPC_cbd.mat pow_vals_short_ripples_HPC_cbd 
clear

FileData = load('pow_vals_short_ripples_HPC_cbd.mat');
csvwrite('pow_vals_short_ripples_HPC_cbd.csv', FileData.pow_vals_short_ripples_HPC_cbd);



%% Long Ripples %%
clear variables
load('long_ripples_chronics_cbd.mat');

% Fieldtrip format
input=long_ripples_chronics_cbd;
input=input(randperm(length(input)));
input=input(1:300);
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
pow_vals_long_ripples_HPC_cbd=power_spec;

save pow_vals_long_ripples_HPC_cbd.mat pow_vals_long_ripples_HPC_cbd 
clear

FileData = load('pow_vals_long_ripples_HPC_cbd.mat');
csvwrite('pow_vals_long_ripples_HPC_cbd.csv', FileData.pow_vals_long_ripples_HPC_cbd);


%% Baseline %%
clear variables
load('baselines_HPC_cbd.mat');

% Fieldtrip format
input=baselines_cbd_HPC;
input=input(randperm(length(input)));
input=input(1:300);
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
pow_vals_baselines_HPC_cbd=power_spec;

save pow_vals_baselines_HPC_cbd.mat pow_vals_baselines_HPC_cbd 
clear

FileData = load('pow_vals_baselines_HPC_cbd.mat');
csvwrite('pow_vals_baselines_HPC_cbd.csv', FileData.pow_vals_baselines_HPC_cbd);
clear





