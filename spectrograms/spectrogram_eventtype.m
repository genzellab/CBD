%% SPECTROGRAM
% event type-based (ripple vs SW vs SWR vs complex SWR)

clc
clear
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD_project/fieldtrip');
load('detections_PFCdeep_veh.mat'); 
load('detections_PFCdeep_cbd.mat'); 

%% concat data
data_ripple=[GC_detections_PFCdeep_ripple_veh;GC_detections_PFCdeep_ripple_cbd];
data_sw=[GC_detections_PFCdeep_sw_veh;GC_detections_PFCdeep_sw_cbd];
data_swr=[GC_detections_PFCdeep_swr_veh;GC_detections_PFCdeep_swr_cbd];
data_complex_swr=[GC_detections_PFCdeep_complex_swr_veh;GC_detections_PFCdeep_complex_swr_cbd];

clearvars -except data_ripple data_sw data_swr data_complex_swr

%% compute spectrograms

%% Groups of events
input1 = data_ripple; 
input2 = data_sw; 
input3 = data_swr;
input4 = data_complex_swr;

freqrange = [0:0.5:30]; 
channel = [{'PFCdeep'}];

% compute spectrogram
[freq,freq2,freq3,freq4,zlim] = spectrogram_automation_4inputs_lowfreq(input1,input2,input3,input4,freqrange,channel);

%% Plot

%% 0-30 Hz

% ripple
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq); 
g=title('Ripple - PFCdeep'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_030_2s_ripple.jpg'); % change accordingly
saveas(gcf,'PFCdeep_030_2s_ripple.pdf');
close all

% sw
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq2); 
g=title('SW - PFCdeep'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_030_2s_sw.jpg'); % change accordingly
saveas(gcf,'PFCdeep_030_2s_sw.pdf');
close all

% swr
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq3); 
g=title('SWR - PFCdeep'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_030_2s_swr.jpg'); % change accordingly
saveas(gcf,'PFCdeep_030_2s_swr.pdf');
close all

% complex swr
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq4); 
g=title('complex SWR - PFCdeep'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_030_2s_complex_swr.jpg'); % change accordingly
saveas(gcf,'PFCdeep_030_2s_complex_swr.pdf');
close all

%% 30-100 Hz
freqrange = [30:1:100]; 
[freq,freq2,freq3,freq4,zlim] = spectrogram_automation_4inputs(input1,input2,input3,input4,freqrange,channel);

% ripple
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq); 
g=title('Ripple - PFCdeep'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_30100_2s_ripple.jpg'); % change accordingly
saveas(gcf,'PFCdeep_30100_2s_ripple.pdf');
close all

% sw
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq2); 
g=title('SW - PFCdeep'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_30100_2s_sw.jpg'); % change accordingly
saveas(gcf,'PFCdeep_30100_2s_sw.pdf');
close all

% swr
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq3); 
g=title('SWR - PFCdeep'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_30100_2s_swr.jpg'); % change accordingly
saveas(gcf,'PFCdeep_30100_2s_swr.pdf');
close all

% complex swr
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq4); 
g=title('complex SWR - PFCdeep'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_30100_2s_complex_swr.jpg'); % change accordingly
saveas(gcf,'PFCdeep_30100_2s_complex_swr.pdf');
close all

%% 100-300 Hz
freqrange = [100:2:300]; 
[freq,freq2,freq3,freq4,zlim] = spectrogram_automation_4inputs(input1,input2,input3,input4,freqrange,channel);

% ripple
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq); 
g=title('Ripple - PFCdeep'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_100300_2s_ripple.jpg'); % change accordingly
saveas(gcf,'PFCdeep_100300_2s_ripple.pdf');
close all

% sw
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq2); 
g=title('SW - PFCdeep'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_100300_2s_sw.jpg'); % change accordingly
saveas(gcf,'PFCdeep_100300_2s_sw.pdf');
close all

% swr
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq3); 
g=title('SWR - PFCdeep'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_100300_2s_swr.jpg'); % change accordingly
saveas(gcf,'PFCdeep_100300_2s_swr.pdf');
close all

% complex swr
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq4); 
g=title('complex SWR - PFCdeep'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_100300_2s_complex_swr.jpg'); % change accordingly
saveas(gcf,'PFCdeep_100300_2s_complex_swr.pdf');
close all