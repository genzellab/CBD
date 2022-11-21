%% Pelin Ozsezer

%% Compute Sepctra for Event Types


%%%%%%%%%%%%%
%% Vehicle %%
%%%%%%%%%%%%%
clc
clear all
close all
addpath('/home/genzellab/Desktop/Pelin/fieldtrip');
addpath('/home/genzellab/Desktop/Pelin/functions');

load GC_veh.mat

GC_ripple_veh=GC_ripple_veh.waveforms;
GC_sw_veh=GC_sw_veh.waveforms;
GC_swr_veh=GC_swr_veh.waveforms;
GC_complex_swr_veh=GC_complex_swr_veh.waveforms;

GC_ripple_veh=cellfun(@(x) extract_range(x,1801,-1200,1200),GC_ripple_veh,'UniformOutput',false);
GC_sw_veh=cellfun(@(x) extract_range(x,1801,-1200,1200),GC_sw_veh,'UniformOutput',false);
GC_swr_veh=cellfun(@(x) extract_range(x,1801,-1200,1200),GC_swr_veh,'UniformOutput',false);
GC_complex_swr_veh=cellfun(@(x) extract_range(x,1801,-1200,1200),GC_complex_swr_veh,'UniformOutput',false);

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


%% Ripple
% Fieldtrip format
clear data
input1=GC_ripple_veh;
fn=600;
leng=length(input1);
ro=1200;
tm = create_timecell(ro,leng);

channel = [{'PFCshal'},{'HPCpyra'},{'HPCbelo'},{'PFCdeep'}];

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
sterror_ripple_veh=std(log10(power_spec)) / sqrt(length(power_spec));
mean_ripple_veh=mean(log10(power_spec),1);
freq=freq.freq;


%% SW
clear data
% Fieldtrip format
input1=GC_sw_veh;
fn=600;
leng=length(input1);
ro=1200;
tm = create_timecell(ro,leng);

channel = [{'PFCshal'},{'HPCpyra'},{'HPCbelo'},{'PFCdeep'}];

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
sterror_sw_veh=std(log10(power_spec)) / sqrt(length(power_spec));
mean_sw_veh=mean(log10(power_spec),1);
freq=freq.freq;


%% SWR
clear data
% Fieldtrip format
input1=GC_swr_veh;
fn=600;
leng=length(input1);
ro=1200;
tm = create_timecell(ro,leng);

channel = [{'PFCshal'},{'HPCpyra'},{'HPCbelo'},{'PFCdeep'}];

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
sterror_swr_veh=std(log10(power_spec)) / sqrt(length(power_spec));
mean_swr_veh=mean(log10(power_spec),1);
freq=freq.freq;


%% Complex SWR
clear data
% Fieldtrip format
input1=GC_complex_swr_veh;
fn=600;
leng=length(input1);
ro=1200;
tm = create_timecell(ro,leng);

channel = [{'PFCshal'},{'HPCpyra'},{'HPCbelo'},{'PFCdeep'}];

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
sterror_complex_swr_veh=std(log10(power_spec)) / sqrt(length(power_spec));
mean_complex_swr_veh=mean(log10(power_spec),1);
freq=freq.freq;


%%%%%%%%%%%%%%
%% Plotting %%
%%%%%%%%%%%%%%

% Baseline
figure;
hold on

y = mean_baseline_veh; % mean vector
x = log10(freq);

curve1 = mean_baseline_veh-sterror_baseline_veh;
curve2 = mean_baseline_veh+sterror_baseline_veh;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];

p=fill(x2, inBetween,[0 0 0]);
hold on

plot(x, y, 'Color',[0 0 0], 'LineWidth', 1.5);


% Ripple

y = mean_ripple_veh; % mean vector
x = log10(freq);

curve1 = mean_ripple_veh-sterror_ripple_veh;
curve2 = mean_ripple_veh+sterror_ripple_veh;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];

p=fill(x2, inBetween,'b');
hold on

plot(x, y, 'Color','b', 'LineWidth', 1.5);


xlabel('Frequency (Hz) - log10(x)','FontSize',26);
ylabel('absolute power (uV^2) - log10(y)','FontSize',17);
title('Periodogram - Veh - Event Types','FontSize',19)

% SW
y = mean_sw_veh; % mean vector
x = log10(freq);

curve1 = mean_sw_veh-sterror_sw_veh;
curve2 = mean_sw_veh+sterror_sw_veh;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];

p=fill(x2, inBetween,'r');
hold on

plot(x, y, 'Color','r', 'LineWidth', 1.5);


% SWR
y = mean_swr_veh; % mean vector
x = log10(freq);

curve1 = mean_swr_veh-sterror_swr_veh;
curve2 = mean_swr_veh+sterror_swr_veh;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];

p=fill(x2, inBetween,[126/255 47/255 142/255]);
hold on

plot(x, y, 'Color',[126/255 47/255 142/255], 'LineWidth', 1.5);


% Complex SWR
y = mean_complex_swr_veh; % mean vector
x = log10(freq);

curve1 = mean_complex_swr_veh-sterror_complex_swr_veh;
curve2 = mean_complex_swr_veh+sterror_complex_swr_veh;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];

p=fill(x2, inBetween,[237/255 177/255 32/255]);
hold on

plot(x, y,'Color', [237/255 177/255 32/255], 'LineWidth', 1.5);

legend('SE Baseline','Mean Baseline','SE Ripple','Mean Ripple','SE SW','Mean SW','SE SWR','Mean SWR','SE C-SWr','Mean C-SWR')

xticklabels({'0.32','1','3.16','10','31.62','100'})
ylim([-2.5 5])

saveas(gcf,'periodogram_event_types_veh.jpg')
saveas(gcf,'periodogram_event_types_veh.pdf')
saveas(gcf,'periodogram_event_types_veh.fig')
close all


%%%%%%%%%
%% CBD %%
%%%%%%%%%
clc
clear all
close all

load GC_cbd.mat

GC_ripple_cbd=GC_ripple_cbd.waveforms;
GC_sw_cbd=GC_sw_cbd.waveforms;
GC_swr_cbd=GC_swr_cbd.waveforms;
GC_complex_swr_cbd=GC_complex_swr_cbd.waveforms;

GC_ripple_cbd=cellfun(@(x) extract_range(x,1801,-1200,1200),GC_ripple_cbd,'UniformOutput',false);
GC_sw_cbd=cellfun(@(x) extract_range(x,1801,-1200,1200),GC_sw_cbd,'UniformOutput',false);
GC_swr_cbd=cellfun(@(x) extract_range(x,1801,-1200,1200),GC_swr_cbd,'UniformOutput',false);
GC_complex_swr_cbd=cellfun(@(x) extract_range(x,1801,-1200,1200),GC_complex_swr_cbd,'UniformOutput',false);

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


%% Ripple
clear data
% Fieldtrip format
input1=GC_ripple_cbd;
fn=600;
leng=length(input1);
ro=1200;
tm = create_timecell(ro,leng);

channel = [{'PFCshal'},{'HPCpyra'},{'HPCbelo'},{'PFCdeep'}];

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
sterror_ripple_cbd=std(log10(power_spec)) / sqrt(length(power_spec));
mean_ripple_cbd=mean(log10(power_spec),1);
freq=freq.freq;


%% SW
clear data
% Fieldtrip format
input1=GC_sw_cbd;
fn=600;
leng=length(input1);
ro=1200;
tm = create_timecell(ro,leng);

channel = [{'PFCshal'},{'HPCpyra'},{'HPCbelo'},{'PFCdeep'}];

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
sterror_sw_cbd=std(log10(power_spec)) / sqrt(length(power_spec));
mean_sw_cbd=mean(log10(power_spec),1);
freq=freq.freq;


%% SWR
clear data
% Fieldtrip format
input1=GC_swr_cbd;
fn=600;
leng=length(input1);
ro=1200;
tm = create_timecell(ro,leng);

channel = [{'PFCshal'},{'HPCpyra'},{'HPCbelo'},{'PFCdeep'}];

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
sterror_swr_cbd=std(log10(power_spec)) / sqrt(length(power_spec));
mean_swr_cbd=mean(log10(power_spec),1);
freq=freq.freq;


%% Complex SWR
clear data
% Fieldtrip format
input1=GC_complex_swr_cbd;
fn=600;
leng=length(input1);
ro=1200;
tm = create_timecell(ro,leng);

channel = [{'PFCshal'},{'HPCpyra'},{'HPCbelo'},{'PFCdeep'}];

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
sterror_complex_swr_cbd=std(log10(power_spec)) / sqrt(length(power_spec));
mean_complex_swr_cbd=mean(log10(power_spec),1);
freq=freq.freq;


%%%%%%%%%%%%%%
%% Plotting %%
%%%%%%%%%%%%%%

% Baseline
figure;
hold on

y = mean_baseline_cbd; % mean vector
x = log10(freq);

curve1 = mean_baseline_cbd-sterror_baseline_cbd;
curve2 = mean_baseline_cbd+sterror_baseline_cbd;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];

p=fill(x2, inBetween,[0 0 0]);
hold on

plot(x, y, 'Color',[0 0 0], 'LineWidth', 1.5);


% Ripple

y = mean_ripple_cbd; % mean vector
x = log10(freq);

curve1 = mean_ripple_cbd-sterror_ripple_cbd;
curve2 = mean_ripple_cbd+sterror_ripple_cbd;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];

p=fill(x2, inBetween,'b');
hold on

plot(x, y, 'Color','b', 'LineWidth', 1.5);

xlabel('Frequency (Hz) - log10(x)','FontSize',26);
ylabel('absolute power (uV^2) - log10(y)','FontSize',17);
title('Periodogram - CBD - Event Types','FontSize',19)

% SW
y = mean_sw_cbd; % mean vector
x = log10(freq);

curve1 = mean_sw_cbd-sterror_sw_cbd;
curve2 = mean_sw_cbd+sterror_sw_cbd;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];

p=fill(x2, inBetween,'r');
hold on

plot(x, y, 'Color','r', 'LineWidth', 1.5);


% SWR
y = mean_swr_cbd; % mean vector
x = log10(freq);

curve1 = mean_swr_cbd-sterror_swr_cbd;
curve2 = mean_swr_cbd+sterror_swr_cbd;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];

p=fill(x2, inBetween,[126/255 47/255 142/255]);
hold on

plot(x, y, 'Color',[126/255 47/255 142/255], 'LineWidth', 1.5);


% Complex SWR
y = mean_complex_swr_cbd; % mean vector
x = log10(freq);

curve1 = mean_complex_swr_cbd-sterror_complex_swr_cbd;
curve2 = mean_complex_swr_cbd+sterror_complex_swr_cbd;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];

p=fill(x2, inBetween,[237/255 177/255 32/255]);
hold on

plot(x, y,'Color', [237/255 177/255 32/255], 'LineWidth', 1.5);

legend('SE Baseline','Mean Baseline','SE Ripple','Mean Ripple','SE SW','Mean SW','SE SWR','Mean SWR','SE C-SWr','Mean C-SWR')

xticklabels({'0.32','1','3.16','10','31.62','100'})
ylim([-2.5 5])

saveas(gcf,'periodogram_event_types_cbd.jpg')
saveas(gcf,'periodogram_event_types_cbd.pdf')
saveas(gcf,'periodogram_event_types_cbd.fig')
close all

