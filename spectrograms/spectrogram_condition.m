%% SPECTROGRAM
% condition-based (Veh vs CDB)

clc
clear
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD_project/fieldtrip');
%addpath('/Users/pelinozsezer/Documents/Science/Radboud/RGSProject/code/ripples');
load('detections_PFCdeep_veh.mat'); 
load('detections_PFCdeep_cbd.mat'); 

%% concat data
data_veh=[GC_detections_PFCdeep_sw_veh;GC_detections_PFCdeep_ripple_veh;...
    GC_detections_PFCdeep_swr_veh;GC_detections_PFCdeep_complex_swr_veh];
data_cbd=[GC_detections_PFCdeep_sw_cbd;GC_detections_PFCdeep_ripple_cbd;...
    GC_detections_PFCdeep_swr_cbd;GC_detections_PFCdeep_complex_swr_cbd];

clearvars -except data_veh data_cbd

%% compute spectrograms

%% Groups of events
input1 = data_veh; 
input2 = data_cbd; 

freqrange = [0:0.5:30]; % [0:0.5:30] or [30:1:100] or [100:2:300]
channel = [{'PFCdeep'}];

% compute spectrogram
[freq,freq2,zlim] = spectrogram_automation_2inputs_lowfreq(input1,input2,freqrange,channel);

%% PLOTTING

%% 0-30 Hz
%% Veh
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq); 
g=title('Veh - PFCdeep'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_030_2s_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_030_2s_veh.pdf');
close all

%% CBD
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq2); 
g=title('CBD - PFCdeep'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_030_2s_cbd.jpg'); % change accordingly
saveas(gcf,'PFCdeep_030_2s_cbd.pdf');
close all

%% 30-100 Hz
freqrange = [30:1:100]; % [0:0.5:30] or [30:2:300]
[freq,freq2,zlim] = spectrogram_automation_2inputs(input1,input2,freqrange,channel);

%% Veh
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq); 
g=title('Veh - PFCdeep'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_30100_2s_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_30100_2s_veh.pdf');
close all

%% CBD
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq2); 
g=title('CBD - PFCdeep'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_30100_2s_cbd.jpg'); % change accordingly
saveas(gcf,'PFCdeep_30100_2s_cbd.pdf');
close all

%% 100-300 Hz
freqrange = [100:2:300]; % [0:0.5:30] or [30:2:300]
[freq,freq2,zlim] = spectrogram_automation_2inputs(input1,input2,freqrange,channel);

%% Veh
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq); 
g=title('Veh - PFCdeep'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_100300_2s_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_100300_2s_veh.pdf');
close all

%% CBD
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq2); 
g=title('CBD - PFCdeep'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_100300_2s_cbd.jpg'); % change accordingly
saveas(gcf,'PFCdeep_100300_2s_cbd.pdf');
close all

