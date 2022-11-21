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
sterror_short_ripples_veh=std(log10(power_spec)) / sqrt(length(power_spec));
mean_short_ripples_veh=mean(log10(power_spec),1);
freq=freq.freq;

save mean_sterror_short_ripples_veh.mat sterror_short_ripples_veh mean_short_ripples_veh freq



%% Long Ripples %%
clear
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
sterror_long_ripples_veh=std(log10(power_spec)) / sqrt(length(power_spec));
mean_long_ripples_veh=mean(log10(power_spec),1);
freq=freq.freq;

save mean_sterror_long_ripples_veh.mat sterror_long_ripples_veh mean_long_ripples_veh freq


%% Plotting
clear
load('mean_sterror_long_ripples_veh.mat');
load('mean_sterror_short_ripples_veh.mat');

figure;

%% short ripples
y = mean_short_ripples_veh; % mean vector
x = (freq);
sd=sterror_short_ripples_veh;

curve1 = y-sd;
curve2 = y+sd;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];

p=fill(x2, inBetween,'g');
%patch([x fliplr(x)], [y-sd  fliplr(y+sd)], 'r')
%fill([x;flipud(x)],[y-sd;flipud(y+sd)],[1 1 1],'linestyle','none');
p.FaceColor='#F6FFC6';
p.EdgeColor='#F6FFC6';
hold on

plot(x, y, 'Color',[246/255 255/255 198/255], 'LineWidth', 0.5); % rgb(246, 255, 198)
hold on

xlabel('Frequency (Hz) - log10(x)','FontSize',26);
ylabel('absolute power (uV^2)','FontSize',17);
title('Periodogram - Veh - Short vs Long Ripples','FontSize',20)

%% long ripples
y = mean_long_ripples_veh; % your mean vector;
x = (freq);

curve1 = mean_long_ripples_veh-sterror_long_ripples_veh;
curve2 = mean_long_ripples_veh+sterror_long_ripples_veh;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];

p=fill(x2, inBetween,'g');
p.FaceColor='#9ABEF4';
p.EdgeColor='#9ABEF4';
hold on

plot(x, y,'Color',[154/255 190/255 244/255], 'LineWidth', 0.5); % rgb(154, 190, 244)


lgd =legend('SE short r','Mean short r','SE long r','Mean long r');

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
sterror_short_ripples_cbd=std(log10(power_spec)) / sqrt(length(power_spec));
mean_short_ripples_cbd=mean(log10(power_spec),1);
freq=freq.freq;

save mean_sterror_short_ripples_cbd.mat sterror_short_ripples_cbd mean_short_ripples_cbd freq



%% Long Ripples %%
clear
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
sterror_long_ripples_cbd=std(log10(power_spec)) / sqrt(length(power_spec));
mean_long_ripples_cbd=mean(log10(power_spec),1);
freq=freq.freq;

save mean_sterror_long_ripples_cbd.mat sterror_long_ripples_cbd mean_long_ripples_cbd freq

%% Plotting
clear
load('mean_sterror_long_ripples_cbd.mat');
load('mean_sterror_short_ripples_cbd.mat');

figure;

%% short ripples
y = mean_short_ripples_cbd; % mean vector
x = (freq);
sd=sterror_short_ripples_cbd;

curve1 = y-sd;
curve2 = y+sd;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];

p=fill(x2, inBetween,'g');
%patch([x fliplr(x)], [y-sd  fliplr(y+sd)], 'r')
%fill([x;flipud(x)],[y-sd;flipud(y+sd)],[1 1 1],'linestyle','none');
p.FaceColor='#F6FFC6';
p.EdgeColor='#F6FFC6';
hold on

plot(x, y, 'Color',[246/255 255/255 198/255], 'LineWidth', 0.5); % rgb(246, 255, 198)
hold on

xlabel('Frequency (Hz) - log10(x)','FontSize',26);
ylabel('absolute power (uV^2)','FontSize',17);
title('Periodogram - CBD - Short vs Long Ripples','FontSize',20)

%% long ripples
y = mean_long_ripples_cbd; % your mean vector;
x = (freq);

curve1 = mean_long_ripples_cbd-sterror_long_ripples_cbd;
curve2 = mean_long_ripples_cbd+sterror_long_ripples_cbd;
x2 = [x, fliplr(x)];
inBetween = [curve1, fliplr(curve2)];

p=fill(x2, inBetween,'g');
p.FaceColor='#9ABEF4';
p.EdgeColor='#9ABEF4';
hold on

plot(x, y,'Color',[154/255 190/255 244/255], 'LineWidth', 0.5); % rgb(154, 190, 244)


lgd =legend('SE short r','Mean short r','SE long r','Mean long r');

saveas(gcf,'periodogram_cbd.fig')
saveas(gcf,'periodogram_cbd.jpg')
saveas(gcf,'periodogram_cbd.pdf')
close all
