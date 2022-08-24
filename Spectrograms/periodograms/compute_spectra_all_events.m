%% Pelin Ozsezer

%% PERIODOGRAMS

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vehicle - All events %%
%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all
close all
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/fieldtrip');
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/functions');

clear
load GC_veh.mat

GC_all_events_veh=[GC_ripple_veh.waveforms;GC_sw_veh.waveforms;...
GC_swr_veh.waveforms;GC_complex_swr_veh.waveforms];

% Fieldtrip format
input1=GC_all_events_veh;
fn=600;
leng=length(input1);
ro=1800;
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
cfg1.length  = 1;
cfg1.overlap = 0.25;

%
cfg1.length        = 4;
rpt_all_events     = ft_redefinetrial(cfg1, data_all_events);

%% Plotting
cfg2 = [];
cfg2.output  = 'pow';
cfg2.channel = 'PFCshal';
cfg2.method  = 'mtmfft'; % multitaper
cfg2.taper   = 'hanning';
cfg2.keeptrials = 'yes';

cfg2.foi     = 0.5:0.25:100; % 1/cfg1.length  = 4;

%
freq_all_events = ft_freqanalysis(cfg2, rpt_all_events);

power_spec=squeeze(freq_all_events.powspctrm);

%% Calculate STDerror & mean
stderror_all_events_veh=std(log(power_spec)) / log(sqrt(length(power_spec)));
mean_all_events_veh=mean(log(power_spec),1);
freq=freq_all_events.freq;

%% Plotting
figure;

y = mean_all_events_veh; % mean vector
x = log10(freq);

curve1 = mean_all_events_veh-stderror_all_events_veh;
curve2 = mean_all_events_veh+stderror_all_events_veh;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];

p=fill(x2, inBetween,'g');
p.FaceAlpha = .6;
p.FaceColor='#A6A6A6';
p.EdgeColor='#A6A6A6';
hold on

plot(x, y, 'k', 'LineWidth', 1);
ylim([-6 10])

legend('STDerror','Mean')
xlabel('Frequency (Hz)');
ylabel('absolute power (uV^2)');
title('Periodogram - VEHICLE')
saveas(gcf,'periodogram_all_events_veh.jpg')
saveas(gcf,'periodogram_all_events_veh.pdf')
saveas(gcf,'periodogram_all_events_veh.fig')
close all


%%%%%%%%%%%%%%%%%%%%%%
%% CBD - All events %%
%%%%%%%%%%%%%%%%%%%%%%

clc
clear all
close all
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/fieldtrip');
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/functions');

clear
load GC_cbd.mat

GC_all_events_cbd=[GC_ripple_cbd.waveforms;GC_sw_cbd.waveforms;...
GC_swr_cbd.waveforms;GC_complex_swr_cbd.waveforms];

% Fieldtrip format
input1=GC_all_events_cbd;
fn=600;
leng=length(input1);
ro=1800;
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
cfg1.length  = 1;
cfg1.overlap = 0.25;

%
cfg1.length        = 4;
rpt_all_events     = ft_redefinetrial(cfg1, data_all_events);

%% Plotting
cfg2 = [];
cfg2.output  = 'pow';
cfg2.channel = 'PFCshal';
cfg2.method  = 'mtmfft'; % multitaper
cfg2.taper   = 'hanning';
cfg2.keeptrials = 'yes';

cfg2.foi     = 0.5:0.25:100; % 1/cfg1.length  = 4;

%
freq_all_events = ft_freqanalysis(cfg2, rpt_all_events);

power_spec=squeeze(freq_all_events.powspctrm);

%% Calculate STDerror & mean
stderror_all_events_cbd=std(log(power_spec)) / log(sqrt(length(power_spec)));
mean_all_events_cbd=mean(log(power_spec),1);
freq=freq_all_events.freq;

%% Plotting
figure;

y = mean_all_events_cbd; % your mean vector;
x = log10(freq);

curve1 = mean_all_events_cbd-stderror_all_events_cbd;
curve2 = mean_all_events_cbd+stderror_all_events_cbd;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];

p=fill(x2, inBetween,'g');
p.FaceAlpha = .6;
p.FaceColor='#53BF33';
p.EdgeColor='#53BF33';
hold on

plot(x, y, 'k', 'LineWidth', 1);
ylim([-6 10])

legend('STDerror','Mean')
xlabel('Frequency (Hz)');
ylabel('absolute power (uV^2)');
title('Periodogram - CBD')
saveas(gcf,'periodogram_all_events_cbd.jpg')
saveas(gcf,'periodogram_all_events_cbd.pdf')
saveas(gcf,'periodogram_all_events_cbd.fig')
close all

