%% Pelin Ozsezer

%% SPECTROGRAM

% PFCdepth - CHANGE ACCORDINGLY!
% [0-30] Hz, [30-100] Hz, & [100-300] Hz
% Baseline: Veh vs CBD
clc
clear
restoredefaultpath
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD-project/fieldtrip');
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/functions');
load('baseline_PFC_wa.mat');
 

%%%%%%%%%%%%%
%% 0-30 Hz %%
%%%%%%%%%%%%%

%% compute spectrograms
freqrange = [0:0.5:30] ; % [0:0.5:30] or [30:1:100] or [100:2:300]
channel = [{'PFCdeep'}];

[freq_veh,freq_cbd,zlim]=spectrogram_automation_2inputs_lowfreq...
    (GC_baseline_PFCdeep_veh,GC_baseline_PFCdeep_cbd,freqrange,channel);

%% Plotting

    % Veh
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_veh); 
    g=title('Veh - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_030_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_030_2s_veh.pdf');
    close all

    % CBD
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_cbd); 
    g=title('CBD - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_030_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_030_2s_cbd.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_veh, freq_cbd); %first-second!!
       
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(colorbar_treatment); % change accordingly
    g=title('PFCdeep - Baseline - Contrast: Veh-CBD'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_030_baseline_veh-cbd_2s.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_030_baseline_veh-cbd_2s.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_cbd,freq_veh); % veh-cbd, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_veh.time,freq_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(colorbar_treatment) % change accordingly
    
    J=title('PFCdeep - Baseline - Stats for Contrast: Veh-CBD');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_030_baseline_veh-cbd_2s.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_030_baseline_veh-cbd_2s.pdf');
    close all
    

%%%%%%%%%%%%%%%
%% 30-100 Hz %%
%%%%%%%%%%%%%%%

%% compute spectrograms
freqrange = [30:1:100] ; % [0:0.5:30] or [30:1:100] or [100:2:300]
channel = [{'PFCdeep'}];

[freq_veh,freq_cbd,zlim]=spectrogram_automation_2inputs...
    (GC_baseline_PFCdeep_veh,GC_baseline_PFCdeep_cbd,freqrange,channel);

%% Plotting

    % Veh
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_veh); 
    g=title('Veh - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_30100_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_30100_2s_veh.pdf');
    close all

    % CBD
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_cbd); 
    g=title('CBD - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_30100_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_30100_2s_cbd.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_veh, freq_cbd); %first-second!!
       
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(colorbar_treatment); % change accordingly
    g=title('PFCdeep - Baseline - Contrast: Veh-CBD'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_30100_baseline_veh-cbd_2s.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_30100_baseline_veh-cbd_2s.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_cbd,freq_veh); % veh-cbd, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_veh.time,freq_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(colorbar_treatment) % change accordingly
    
    J=title('PFCdeep - Baseline - Stats for Contrast: Veh-CBD');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_30100_baseline_veh-cbd_2s.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_30100_baseline_veh-cbd_2s.pdf');
    close all


%%%%%%%%%%%%%%%%
%% 100-300 Hz %%
%%%%%%%%%%%%%%%%

%% compute spectrograms
freqrange =  [100:2:300] ; % [0:0.5:30] or [30:1:100] or [100:2:300]
channel = [{'PFCdeep'}];

[freq_veh,freq_cbd,zlim]=spectrogram_automation_2inputs...
    (GC_baseline_PFCdeep_veh,GC_baseline_PFCdeep_cbd,freqrange,channel);

%% Plotting

    % Veh
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_veh); 
    g=title('Veh - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_100300_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_100300_2s_veh.pdf');
    close all

    % CBD
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_cbd); 
    g=title('CBD - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_100300_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_100300_2s_cbd.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_veh, freq_cbd); %first-second!!
       
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(colorbar_treatment); % change accordingly
    g=title('PFCdeep - Baseline - Contrast: Veh-CBD'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_100300_baseline_veh-cbd_2s.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_100300_baseline_veh-cbd_2s.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_cbd,freq_veh); % veh-cbd, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_veh.time,freq_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(colorbar_treatment) % change accordingly
    
    J=title('PFCdeep - Baseline - Stats for Contrast: Veh-CBD');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_100300_baseline_veh-cbd_2s.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_100300_baseline_veh-cbd_2s.pdf');
    close all
    