
%%%%%%%%%%%%%%%%
%% ALL EVENTS %%
%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vehicle - All events %%
%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all
close all
addpath('/home/genzellab/Desktop/Pelin/fieldtrip');
addpath('/home/genzellab/Desktop/Pelin/functions');

load detections_HPC_veh.mat

% Combine all events and select 4 sec of time window centered around the peak
GC_all_events_veh=[GC_detections_HPCpyra_ripple_veh;GC_detections_HPCpyra_sw_veh;...
GC_detections_HPCpyra_swr_veh;GC_detections_HPCpyra_complex_swr_veh];
GC_all_events_veh=cellfun(@(x) extract_range(x,1801,-1200,1200),GC_all_events_veh,'UniformOutput',false);

% Fieldtrip format
input1=GC_all_events_veh;
fn=600;
leng=length(input1);
ro=1200;
tm = create_timecell(ro,leng);

channel = [{'HPCpyra'}];

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
cfg2.channel = 'HPCpyra';
cfg2.method  = 'mtmfft'; % multitaper
cfg2.taper   = 'hanning';
cfg2.keeptrials = 'yes';

cfg2.foi     = 0.5:0.25:100; % 1/cfg1.length  = 4;
freq_all_events = ft_freqanalysis(cfg2, rpt_all_events);
power_spec=squeeze(freq_all_events.powspctrm);
freq=freq_all_events.freq;

power_spec = power_spec(randperm(size(power_spec, 1)), :);
power_spec=power_spec(1:1200,:);

%% Vehicle (all events)
save freq.mat freq
power_spec_all_events_veh=power_spec;
save power_spec_all_events_veh.mat power_spec_all_events_veh
clear

FileData = load('freq.mat');
csvwrite('freq.csv', FileData.freq);

FileData = load('power_spec_all_events_veh.mat');
csvwrite('power_spec_all_events_veh.csv', FileData.power_spec_all_events_veh);


%%%%%%%%%%%%%%%%%%%%%%
%% CBD - All events %%
%%%%%%%%%%%%%%%%%%%%%%

clc
clear all
close all
addpath('/home/genzellab/Desktop/Pelin/fieldtrip');
addpath('/home/genzellab/Desktop/Pelin/functions');

load detections_HPC_cbd.mat

% Combine all events and select 4 sec of time window centered around the peak
GC_all_events_cbd=[GC_detections_HPCpyra_ripple_cbd;GC_detections_HPCpyra_sw_cbd;...
GC_detections_HPCpyra_swr_cbd;GC_detections_HPCpyra_complex_swr_cbd];
GC_all_events_cbd=cellfun(@(x) extract_range(x,1801,-1200,1200),GC_all_events_cbd,'UniformOutput',false);

% Fieldtrip format
input1=GC_all_events_cbd;
fn=600;
leng=length(input1);
ro=1200;
tm = create_timecell(ro,leng);

channel = [{'HPCpyra'}];

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
cfg2.channel = 'HPCpyra';
cfg2.method  = 'mtmfft'; % multitaper
cfg2.taper   = 'hanning';
cfg2.keeptrials = 'yes';

cfg2.foi     = 0.5:0.25:100; % 1/cfg1.length  = 4;
freq_all_events = ft_freqanalysis(cfg2, rpt_all_events);
power_spec=squeeze(freq_all_events.powspctrm);
freq=freq_all_events.freq;

power_spec = power_spec(randperm(size(power_spec, 1)), :);
power_spec=power_spec(1:1200,:);

%% CBD (all events)
power_spec_all_events_cbd=power_spec;
save power_spec_all_events_cbd.mat power_spec_all_events_cbd
clear

FileData = load('power_spec_all_events_cbd.mat');
csvwrite('power_spec_all_events_cbd.csv', FileData.power_spec_all_events_cbd);
  


%%%%%%%%%%%%%%%%%
%% EVENT TYPES %%
%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%
%% Vehicle %%
%%%%%%%%%%%%%
clc
clear all
close all


load detections_HPC_veh.mat
load baseline_2000_HPCpyra.mat

GC_ripple_veh=GC_detections_HPCpyra_ripple_veh;
GC_sw_veh=GC_detections_HPCpyra_sw_veh;
GC_swr_veh=GC_detections_HPCpyra_swr_veh;
GC_complex_swr_veh=GC_detections_HPCpyra_complex_swr_veh;

GC_ripple_veh=cellfun(@(x) extract_range(x,1801,-1200,1200),GC_ripple_veh,'UniformOutput',false);
GC_sw_veh=cellfun(@(x) extract_range(x,1801,-1200,1200),GC_sw_veh,'UniformOutput',false);
GC_swr_veh=cellfun(@(x) extract_range(x,1801,-1200,1200),GC_swr_veh,'UniformOutput',false);
GC_complex_swr_veh=cellfun(@(x) extract_range(x,1801,-1200,1200),GC_complex_swr_veh,'UniformOutput',false);

%% Baseline
% Fieldtrip format
input1=GC_baseline_HPCpyra_veh;
fn=600;
leng=length(input1);
ro=1800;
tm = create_timecell(ro,leng);

channel = [{'HPCpyra'}];

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
cfg2.channel = 'HPCpyra';
cfg2.method  = 'mtmfft'; % multitaper
cfg2.taper   = 'hanning';
cfg2.keeptrials = 'yes';

cfg2.foi     = 0.5:0.25:100; % 1/cfg1.length  = 4;
freq = ft_freqanalysis(cfg2, rpt);
power_spec_baseline_veh=squeeze(freq.powspctrm);
freq=freq.freq;

power_spec_baseline_veh = power_spec_baseline_veh(randperm(size(power_spec_baseline_veh, 1)), :);
power_spec_baseline_veh=power_spec_baseline_veh(1:1200,:);


%% Ripple
% Fieldtrip format
clear data
input1=GC_ripple_veh;
fn=600;
leng=length(input1);
ro=1200;
tm = create_timecell(ro,leng);

channel = [{'HPCpyra'}];

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
cfg2.channel = 'HPCpyra';
cfg2.method  = 'mtmfft'; % multitaper
cfg2.taper   = 'hanning';
cfg2.keeptrials = 'yes';

cfg2.foi     = 0.5:0.25:100; % 1/cfg1.length  = 4;
freq = ft_freqanalysis(cfg2, rpt);
power_spec_ripple_veh=squeeze(freq.powspctrm);


power_spec_ripple_veh = power_spec_ripple_veh(randperm(size(power_spec_ripple_veh, 1)), :);
power_spec_ripple_veh=power_spec_ripple_veh(1:1200,:);

%% SW
clear data
% Fieldtrip format
input1=GC_sw_veh;
fn=600;
leng=length(input1);
ro=1200;
tm = create_timecell(ro,leng);

channel = [{'HPCpyra'}];

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
cfg2.channel = 'HPCpyra';
cfg2.method  = 'mtmfft'; % multitaper
cfg2.taper   = 'hanning';
cfg2.keeptrials = 'yes';

cfg2.foi     = 0.5:0.25:100; % 1/cfg1.length  = 4;
freq = ft_freqanalysis(cfg2, rpt);
power_spec_sw_veh=squeeze(freq.powspctrm);

power_spec_sw_veh = power_spec_sw_veh(randperm(size(power_spec_sw_veh, 1)), :);
power_spec_sw_veh=power_spec_sw_veh(1:1200,:);

%% SWR
clear data
% Fieldtrip format
input1=GC_swr_veh;
fn=600;
leng=length(input1);
ro=1200;
tm = create_timecell(ro,leng);

channel = [{'HPCpyra'}];

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
cfg2.channel = 'HPCpyra';
cfg2.method  = 'mtmfft'; % multitaper
cfg2.taper   = 'hanning';
cfg2.keeptrials = 'yes';

cfg2.foi     = 0.5:0.25:100; % 1/cfg1.length  = 4;
freq = ft_freqanalysis(cfg2, rpt);
power_spec_swr_veh=squeeze(freq.powspctrm);

power_spec_swr_veh = power_spec_swr_veh(randperm(size(power_spec_swr_veh, 1)), :);
power_spec_swr_veh=power_spec_swr_veh(1:1200,:);


%% Complex SWR
clear data
% Fieldtrip format
input1=GC_complex_swr_veh;
fn=600;
leng=length(input1);
ro=1200;
tm = create_timecell(ro,leng);

channel = [{'HPCpyra'}];

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
cfg2.channel = 'HPCpyra';
cfg2.method  = 'mtmfft'; % multitaper
cfg2.taper   = 'hanning';
cfg2.keeptrials = 'yes';

cfg2.foi     = 0.5:0.25:100; % 1/cfg1.length  = 4;
freq = ft_freqanalysis(cfg2, rpt);
power_spec_complex_swr_veh=squeeze(freq.powspctrm);

power_spec_complex_swr_veh= power_spec_complex_swr_veh(randperm(size(power_spec_complex_swr_veh, 1)), :);
power_spec_complex_swr_veh=power_spec_complex_swr_veh(1:1200,:);

%% save
save power_spec_baseline_veh.mat power_spec_baseline_veh
save power_spec_ripple_veh.mat power_spec_ripple_veh
save power_spec_sw_veh.mat power_spec_sw_veh
save power_spec_swr_veh.mat power_spec_swr_veh
save power_spec_complex_swr_veh.mat power_spec_complex_swr_veh


%% mat file to csv

clear
FileData = load('power_spec_baseline_veh.mat');
csvwrite('power_spec_baseline_veh.csv', FileData.power_spec_baseline_veh);

clear
FileData = load('power_spec_ripple_veh.mat');
csvwrite('power_spec_ripple_veh.csv', FileData.power_spec_ripple_veh);

clear
FileData = load('power_spec_sw_veh.mat');
csvwrite('power_spec_sw_veh.csv', FileData.power_spec_sw_veh);

clear
FileData = load('power_spec_swr_veh.mat');
csvwrite('power_spec_swr_veh.csv', FileData.power_spec_swr_veh);

clear
FileData = load('power_spec_complex_swr_veh.mat');
csvwrite('power_spec_complex_swr_veh.csv', FileData.power_spec_complex_swr_veh);




%%%%%%%%%
%% CBD %%
%%%%%%%%%
clc
clear all
close all


load detections_HPC_cbd.mat
load baseline_2000_HPCpyra.mat

GC_ripple_cbd=GC_detections_HPCpyra_ripple_cbd;
GC_sw_cbd=GC_detections_HPCpyra_sw_cbd;
GC_swr_cbd=GC_detections_HPCpyra_swr_cbd;
GC_complex_swr_cbd=GC_detections_HPCpyra_complex_swr_cbd;

GC_ripple_cbd=cellfun(@(x) extract_range(x,1801,-1200,1200),GC_ripple_cbd,'UniformOutput',false);
GC_sw_cbd=cellfun(@(x) extract_range(x,1801,-1200,1200),GC_sw_cbd,'UniformOutput',false);
GC_swr_cbd=cellfun(@(x) extract_range(x,1801,-1200,1200),GC_swr_cbd,'UniformOutput',false);
GC_complex_swr_cbd=cellfun(@(x) extract_range(x,1801,-1200,1200),GC_complex_swr_cbd,'UniformOutput',false);

%% Baseline
% Fieldtrip format
input1=GC_baseline_HPCpyra_cbd;
fn=600;
leng=length(input1);
ro=1800;
tm = create_timecell(ro,leng);

channel = [{'HPCpyra'}];

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
cfg2.channel = 'HPCpyra';
cfg2.method  = 'mtmfft'; % multitaper
cfg2.taper   = 'hanning';
cfg2.keeptrials = 'yes';

cfg2.foi     = 0.5:0.25:100; % 1/cfg1.length  = 4;
freq = ft_freqanalysis(cfg2, rpt);
power_spec_baseline_cbd=squeeze(freq.powspctrm);
freq=freq.freq;

power_spec_baseline_cbd = power_spec_baseline_cbd(randperm(size(power_spec_baseline_cbd, 1)), :);
power_spec_baseline_cbd=power_spec_baseline_cbd(1:1200,:);

%% Ripple
clear data
% Fieldtrip format
input1=GC_ripple_cbd;
fn=600;
leng=length(input1);
ro=1200;
tm = create_timecell(ro,leng);

channel = [{'HPCpyra'}];

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
cfg2.channel = 'HPCpyra';
cfg2.method  = 'mtmfft'; % multitaper
cfg2.taper   = 'hanning';
cfg2.keeptrials = 'yes';

cfg2.foi     = 0.5:0.25:100; % 1/cfg1.length  = 4;
freq = ft_freqanalysis(cfg2, rpt);
power_spec_ripple_cbd=squeeze(freq.powspctrm);

power_spec_ripple_cbd = power_spec_ripple_cbd(randperm(size(power_spec_ripple_cbd, 1)), :);
power_spec_ripple_cbd=power_spec_ripple_cbd(1:1200,:);

%% SW
clear data
% Fieldtrip format
input1=GC_sw_cbd;
fn=600;
leng=length(input1);
ro=1200;
tm = create_timecell(ro,leng);

channel = [{'HPCpyra'}];

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
cfg2.channel = 'HPCpyra';
cfg2.method  = 'mtmfft'; % multitaper
cfg2.taper   = 'hanning';
cfg2.keeptrials = 'yes';

cfg2.foi     = 0.5:0.25:100; % 1/cfg1.length  = 4;
freq = ft_freqanalysis(cfg2, rpt);
power_spec_sw_cbd=squeeze(freq.powspctrm);

power_spec_sw_cbd = power_spec_sw_cbd(randperm(size(power_spec_sw_cbd, 1)), :);
power_spec_sw_cbd=power_spec_sw_cbd(1:1200,:);


%% SWR
clear data
% Fieldtrip format
input1=GC_swr_cbd;
fn=600;
leng=length(input1);
ro=1200;
tm = create_timecell(ro,leng);

channel = [{'HPCpyra'}];

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
cfg2.channel = 'HPCpyra';
cfg2.method  = 'mtmfft'; % multitaper
cfg2.taper   = 'hanning';
cfg2.keeptrials = 'yes';

cfg2.foi     = 0.5:0.25:100; % 1/cfg1.length  = 4;
freq = ft_freqanalysis(cfg2, rpt);
power_spec_swr_cbd=squeeze(freq.powspctrm);

power_spec_swr_cbd = power_spec_swr_cbd(randperm(size(power_spec_swr_cbd, 1)), :);
power_spec_swr_cbd=power_spec_swr_cbd(1:1200,:);


%% Complex SWR
clear data
% Fieldtrip format
input1=GC_complex_swr_cbd;
fn=600;
leng=length(input1);
ro=1200;
tm = create_timecell(ro,leng);

channel = [{'HPCpyra'}];

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
cfg2.channel = 'HPCpyra';
cfg2.method  = 'mtmfft'; % multitaper
cfg2.taper   = 'hanning';
cfg2.keeptrials = 'yes';

cfg2.foi     = 0.5:0.25:100; % 1/cfg1.length  = 4;
freq = ft_freqanalysis(cfg2, rpt);
power_spec_complex_swr_cbd=squeeze(freq.powspctrm);

power_spec_complex_swr_cbd= power_spec_complex_swr_cbd(randperm(size(power_spec_complex_swr_cbd, 1)), :);
power_spec_complex_swr_cbd=power_spec_complex_swr_cbd(1:1200,:);

%% save 
save power_spec_baseline_cbd.mat power_spec_baseline_cbd
save power_spec_ripple_cbd.mat power_spec_ripple_cbd
save power_spec_sw_cbd.mat power_spec_sw_cbd
save power_spec_swr_cbd.mat power_spec_swr_cbd
save power_spec_complex_swr_cbd.mat power_spec_complex_swr_cbd

% mat file to csv

clear
FileData = load('power_spec_baseline_cbd.mat');
csvwrite('power_spec_baseline_cbd.csv', FileData.power_spec_baseline_cbd);

clear
FileData = load('power_spec_ripple_cbd.mat');
csvwrite('power_spec_ripple_cbd.csv', FileData.power_spec_ripple_cbd);

clear
FileData = load('power_spec_sw_cbd.mat');
csvwrite('power_spec_sw_cbd.csv', FileData.power_spec_sw_cbd);

clear
FileData = load('power_spec_swr_cbd.mat');
csvwrite('power_spec_swr_cbd.csv', FileData.power_spec_swr_cbd);

clear
FileData = load('power_spec_complex_swr_cbd.mat');
csvwrite('power_spec_complex_swr_cbd.csv', FileData.power_spec_complex_swr_cbd);
clear







