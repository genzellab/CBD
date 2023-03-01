function []=compute_spectra(waveform)

%% PFC %%
% Fieldtrip format
clear data
input=waveform;
fn=2500;
leng=length(input);
ro=7500;
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
cfg2.channel = 'PFC';
cfg2.method  = 'mtmfft'; % multitaper
cfg2.taper   = 'hanning';
cfg2.keeptrials = 'yes';

cfg2.foi     = 0:0.25:100; % 1/cfg1.length  = 4;
freq= ft_freqanalysis(cfg2, rpt);
power_spec_pfc=squeeze(freq.powspctrm);
freq=freq.freq;

save power_spec_pfc.mat power_spec_pfc
save freq.mat freq

FileData = load('freq.mat');
csvwrite('freq.csv', FileData.freq);
clear FileData

FileData = load('power_spec_pfc.mat');
csvwrite('power_spec_pfc.csv', FileData.power_spec_pfc);
clear FileData

%% HPC %%
clear data
% Fieldtrip format
input=waveform;
fn=2500;
leng=length(input);
ro=7500;
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
power_spec_hpc=squeeze(freq.powspctrm);
freq=freq.freq;

save power_spec_hpc.mat power_spec_hpc
save freq.mat freq

FileData = load('freq.mat');
csvwrite('freq.csv', FileData.freq);
clear FileData

FileData = load('power_spec_hpc.mat');
csvwrite('power_spec_hpc.csv', FileData.power_spec_hpc);
clear FileData

end