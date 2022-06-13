%% SPECTROGRAM
% per condition (Veh vs CBD) & per event type (ripple vs SW vs SWR vs complex SWR)

clc
clear
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD_project/fieldtrip');
load('detections_PFCdeep_veh.mat'); 


%% concat data
data_ripple=GC_detections_PFCdeep_ripple_veh;
data_sw=GC_detections_PFCdeep_sw_veh;
data_swr=GC_detections_PFCdeep_swr_veh;
data_complex_swr=GC_detections_PFCdeep_complex_swr_veh;

clearvars -except data_ripple data_sw data_swr data_complex_swr

%% compute spectrograms

%% Groups of events
input1 = data_ripple; 
input2 = data_sw; 
input3 = data_swr;
input4 = data_complex_swr;

%% ripple vs SW

% 0-30 Hz
freqrange = [0:0.5:30]; % [0:0.5:30] or [30:1:100] or [100:2:300]
channel = [{'PFCdeep'}];

[freq,freq2,zlim] = spectrogram_automation_2inputs_lowfreq(input1,input2,freqrange,channel);

% 1
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq); 
g=title('Veh - PFCdeep - Ripple'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_030_2s_ripple_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_030_2s_ripple_veh.pdf');
close all

% 2
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq2); 
g=title('Veh - PFCdeep - SW'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_030_2s_sw_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_030_2s_sw_veh.pdf');
close all

% 30 - 100 Hz
freqrange = [30:1:100]; % [0:0.5:30] or [30:1:100] or [100:2:300]
channel = [{'PFCdeep'}];

[freq,freq2,zlim] = spectrogram_automation_2inputs(input1,input2,freqrange,channel);

% 1
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq); 
g=title('Veh - PFCdeep - Ripple'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_30100_2s_ripple_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_30100_2s_ripple_veh.pdf');
close all

% 2
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq2); 
g=title('Veh - PFCdeep - SW'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_30100_2s_sw_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_30100_2s_sw_veh.pdf');
close all

% 100 - 300 Hz
freqrange = [100:2:300]; % [0:0.5:30] or [30:1:100] or [100:2:300]
channel = [{'PFCdeep'}];

[freq,freq2,zlim] = spectrogram_automation_2inputs(input1,input2,freqrange,channel);

% 1
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq); 
g=title('Veh - PFCdeep - Ripple'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_100300_2s_ripple_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_100300_2s_ripple_veh.pdf');
close all

% 2
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq2); 
g=title('Veh - PFCdeep - SW'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_100300_2s_sw_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_100300_2s_sw_veh.pdf');
close all

%% ripple vs SWR

% 0-30 Hz
freqrange = [0:0.5:30]; % [0:0.5:30] or [30:1:100] or [100:2:300]
channel = [{'PFCdeep'}];

[freq,freq2,zlim] = spectrogram_automation_2inputs_lowfreq(input1,input3,freqrange,channel);

% 1
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq); 
g=title('Veh - PFCdeep - Ripple'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_030_2s_ripple_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_030_2s_ripple_veh.pdf');
close all

% 2
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq2); 
g=title('Veh - PFCdeep - SWR'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_030_2s_swr_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_030_2s_swr_veh.pdf');
close all

% 30 - 100 Hz
freqrange = [30:1:100]; % [0:0.5:30] or [30:1:100] or [100:2:300]
channel = [{'PFCdeep'}];

[freq,freq2,zlim] = spectrogram_automation_2inputs(input1,input3,freqrange,channel);

% 1
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq); 
g=title('Veh - PFCdeep - Ripple'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_30100_2s_ripple_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_30100_2s_ripple_veh.pdf');
close all

% 2
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq2); 
g=title('Veh - PFCdeep - SWR'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_30100_2s_swr_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_30100_2s_swr_veh.pdf');
close all

% 100 - 300 Hz
freqrange = [100:2:300]; % [0:0.5:30] or [30:1:100] or [100:2:300]
channel = [{'PFCdeep'}];

[freq,freq2,zlim] = spectrogram_automation_2inputs(input1,input3,freqrange,channel);

% 1
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq); 
g=title('Veh - PFCdeep - Ripple'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_100300_2s_ripple_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_100300_2s_ripple_veh.pdf');
close all

% 2
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq2); 
g=title('Veh - PFCdeep - SWR'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_100300_2s_swr_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_100300_2s_swr_veh.pdf');
close all

%% SW vs SWR

% 0-30 Hz
freqrange = [0:0.5:30]; % [0:0.5:30] or [30:1:100] or [100:2:300]
channel = [{'PFCdeep'}];

[freq,freq2,zlim] = spectrogram_automation_2inputs_lowfreq(input2,input3,freqrange,channel);

% 1
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq); 
g=title('Veh - PFCdeep - SW'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_030_2s_sw_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_030_2s_sw_veh.pdf');
close all

% 2
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq2); 
g=title('Veh - PFCdeep - SWR'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_030_2s_swr_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_030_2s_swr_veh.pdf');
close all

% 30 - 100 Hz
freqrange = [30:1:100]; % [0:0.5:30] or [30:1:100] or [100:2:300]
channel = [{'PFCdeep'}];

[freq,freq2,zlim] = spectrogram_automation_2inputs(input2,input3,freqrange,channel);

% 1
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq); 
g=title('Veh - PFCdeep - SW'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_30100_2s_sw_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_30100_2s_sw_veh.pdf');
close all

% 2
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq2); 
g=title('Veh - PFCdeep - SWR'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_30100_2s_swr_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_30100_2s_swr_veh.pdf');
close all

% 100 - 300 Hz
freqrange = [100:2:300]; % [0:0.5:30] or [30:1:100] or [100:2:300]
channel = [{'PFCdeep'}];

[freq,freq2,zlim] = spectrogram_automation_2inputs(input2,input3,freqrange,channel);

% 1
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq); 
g=title('Veh - PFCdeep - SW'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_100300_2s_sw_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_100300_2s_sw_veh.pdf');
close all

% 2
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq2); 
g=title('Veh - PFCdeep - SWR'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_100300_2s_swr_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_100300_2s_swr_veh.pdf');
close all

%% SWR vs complex SWR

% 0-30 Hz
freqrange = [0:0.5:30]; % [0:0.5:30] or [30:1:100] or [100:2:300]
channel = [{'PFCdeep'}];

[freq,freq2,zlim] = spectrogram_automation_2inputs_lowfreq(input3,input4,freqrange,channel);

% 1
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq); 
g=title('Veh - PFCdeep - SWR'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_030_2s_swr_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_030_2s_swr_veh.pdf');
close all

% 2
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq2); 
g=title('Veh - PFCdeep - complex SWR'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_030_2s_complex_swr_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_030_2s_complex_swr_veh.pdf');
close all

% 30 - 100 Hz
freqrange = [30:1:100]; % [0:0.5:30] or [30:1:100] or [100:2:300]
channel = [{'PFCdeep'}];

[freq,freq2,zlim] = spectrogram_automation_2inputs(input3,input4,freqrange,channel);

% 1
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq); 
g=title('Veh - PFCdeep - SWR'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_30100_2s_swr_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_30100_2s_swr_veh.pdf');
close all

% 2
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq2); 
g=title('Veh - PFCdeep - complex SWR'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_30100_2s_complex_swr_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_30100_2s_complex_swr_veh.pdf');
close all

% 100 - 300 Hz
freqrange = [100:2:300]; % [0:0.5:30] or [30:1:100] or [100:2:300]
channel = [{'PFCdeep'}];

[freq,freq2,zlim] = spectrogram_automation_2inputs(input3,input4,freqrange,channel);

% 1
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq); 
g=title('Veh - PFCdeep - SWR'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_100300_2s_swr_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_100300_2s_swr_veh.pdf');
close all

% 2
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = 'PFCdeep';
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq2); 
g=title('Veh - PFCdeep - complex SWR'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'PFCdeep_100300_2s_complex_swr_veh.jpg'); % change accordingly
saveas(gcf,'PFCdeep_100300_2s_complex_swr_veh.pdf');
close all


