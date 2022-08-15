%% Pelin Ozsezer

%% SPECTROGRAM

% PFCdepth - CHANGE ACCORDINGLY!
% [0-30] Hz, [30-100] Hz, & [100-300] Hz
% Baseline vs Event Type (Ripple, SW, SWR, & Complex SWR)

clc
clear
restoredefaultpath
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD-project/fieldtrip');
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/functions');
load('GC_median_wa.mat');
load('baseline_PFC_wa.mat');
 
%%
% Ripple, SW, & SWR: 1956 events
GC_PFCdeep_ripple_median1956_cbd=GC_PFCdeep_ripple_median2000_cbd(1:1956);
GC_PFCdeep_ripple_median1956_veh=GC_PFCdeep_ripple_median2000_veh(1:1956);
GC_PFCdeep_sw_median1956_cbd= GC_PFCdeep_sw_median2000_cbd(1:1956);
GC_PFCdeep_sw_median1956_veh= GC_PFCdeep_sw_median2000_veh(1:1956);
GC_PFCdeep_swr_median1956_veh= GC_PFCdeep_swr_median2000_veh(1:1956);
GC_PFCdeep_swr_median1956_cbd=GC_PFCdeep_swr_median2000_cbd(1:1956);

% INFO: Final: complex SWR - Veh: 1777 events & complex SWR - CBD: 1265 events
 

%%%%%%%%%%%%%
%% 0-30 Hz %%
%%%%%%%%%%%%%

% compute spectrogram

freqrange = [0:0.5:30]; % [0:0.5:30] or [30:1:100] or [100:2:300]
channel = [{'PFCdeep'}];

[freq_baseline_veh,freq_ripple_veh,freq_sw_veh,freq_swr_veh,freq_complex_swr_veh,...
    freq_baseline_cbd,freq_ripple_cbd,freq_sw_cbd,freq_swr_cbd,freq_complex_swr_cbd,zlim]=...
    ...
    spectrogram_automation_10inputs_lowfreq...
    ...
    (GC_baseline_PFCdeep_veh,GC_PFCdeep_ripple_median1956_veh,GC_PFCdeep_sw_median1956_veh,...
    GC_PFCdeep_swr_median1956_veh,GC_PFCdeep_complex_swr_median1781_veh,...
    ...
    GC_baseline_PFCdeep_cbd,GC_PFCdeep_ripple_median1956_cbd,GC_PFCdeep_sw_median1956_cbd,...
    GC_PFCdeep_swr_median1956_cbd,GC_PFCdeep_complex_swr_median1274_cbd,freqrange,channel);


%% Veh %%

    %% Ripple vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/Vehicle/Ripple/0-30
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_baseline_veh); 
    g=title('Veh - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_030_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_030_2s_veh.pdf');
    close all

    % Ripple
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_ripple_veh); 
    g=title('Veh - PFCdeep - Ripple'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_ripple_030_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_ripple_030_2s_veh.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_ripple_veh, freq_baseline_veh); %first-second!!
       
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - Veh - Contrast: Ripple-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_030_ripple-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_030_ripple-baseline_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_veh,freq_ripple_veh); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_ripple_veh.time,freq_ripple_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - Veh - Stats for Contrast: Ripple-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_030_ripple-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_030_ripple-baseline_2s_veh.pdf');
    close all
    
    %% SW vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/Vehicle/SW/0-30
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_baseline_veh); 
    g=title('Veh - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_030_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_030_2s_veh.pdf');
    close all

    % SW
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_sw_veh); 
    g=title('Veh - PFCdeep - SW'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_sw_030_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_sw_030_2s_veh.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_sw_veh, freq_baseline_veh); %first-second!!
        
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - Veh - Contrast: SW-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_030_sw-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_030_sw-baseline_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_veh,freq_sw_veh); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_sw_veh.time,freq_sw_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - Veh - Stats for Contrast: SW-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_030_sw-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_030_sw-baseline_2s_veh.pdf');
    close all   
    
    %% SWR vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/Vehicle/SWR/0-30
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_baseline_veh); 
    g=title('Veh - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_030_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_030_2s_veh.pdf');
    close all

    % SWR
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_swr_veh); 
    g=title('Veh - PFCdeep - SWR'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_swr_030_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_swr_030_2s_veh.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_swr_veh, freq_baseline_veh); %first-second!!
       
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - Veh - Contrast: SWR-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_030_swr-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_030_swr-baseline_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_veh,freq_swr_veh); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_swr_veh.time,freq_swr_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - Veh - Stats for Contrast: SWR-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_030_swr-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_030_swr-baseline_2s_veh.pdf');
    close all
   
    %% Complex SWR vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/Vehicle/'Complex SWR'/100-300
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    freq_baseline_veh.powspctrm=freq_baseline_veh.powspctrm(1:1777,:,:,:);
    ft_singleplotTFR(cfg, freq_baseline_veh); 
    g=title('Veh - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_030_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_030_2s_veh.pdf');
    close all

    % complex_swr
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_complex_swr_veh); 
    g=title('Veh - PFCdeep - Complex SWR'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_complex_swr_030_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_complex_swr_030_2s_veh.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_complex_swr_veh, freq_baseline_veh); %first-second!!
        
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - Veh - Contrast: Complex SWR-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_030_complex_swr-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_030_complex_swr-baseline_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_veh,freq_complex_swr_veh); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_complex_swr_veh.time,freq_complex_swr_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - Veh - Stats for Contrast: Complex SWR-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_030_complex_swr-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_030_complex_swr-baseline_2s_veh.pdf');
    close all
   

%% CBD %%

    %% Ripple vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/CBD/Ripple/0-30
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_baseline_cbd); 
    g=title('CBD - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_030_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_030_2s_cbd.pdf');
    close all

    % Ripple
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_ripple_cbd); 
    g=title('CBD - PFCdeep - Ripple'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_ripple_030_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_ripple_030_2s_cbd.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_ripple_cbd, freq_baseline_cbd); %first-second!!
        
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - CBD - Contrast: Ripple-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_030_ripple-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_030_ripple-baseline_2s_cbd.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_cbd,freq_ripple_cbd); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_ripple_cbd.time,freq_ripple_cbd.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - CBD - Stats for Contrast: Ripple-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_030_ripple-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_030_ripple-baseline_2s_cbd.pdf');
    close all
    
    %% SW vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/CBD/SW/0-30
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_baseline_cbd); 
    g=title('CBD - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_030_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_030_2s_cbd.pdf');
    close all

    % SW
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_sw_cbd); 
    g=title('CBD - PFCdeep - SW'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_sw_030_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_sw_030_2s_cbd.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_sw_cbd, freq_baseline_cbd); %first-second!!
    
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - CBD - Contrast: SW-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_030_sw-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_030_sw-baseline_2s_cbd.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_cbd,freq_sw_cbd); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_sw_cbd.time,freq_sw_cbd.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - CBD - Stats for Contrast: SW-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_030_sw-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_030_sw-baseline_2s_cbd.pdf');
    close all
        
    %% SWR vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/CBD/SWR/0-30
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_baseline_cbd); 
    g=title('CBD - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_030_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_030_2s_cbd.pdf');
    close all

    % SWR
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_swr_cbd); 
    g=title('CBD - PFCdeep - SWR'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_swr_030_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_swr_030_2s_cbd.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_swr_cbd, freq_baseline_cbd); %first-second!!
    
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - CBD - Contrast: SWR-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_030_swr-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_030_swr-baseline_2s_cbd.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_cbd,freq_swr_cbd); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_swr_cbd.time,freq_swr_cbd.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - CBD - Stats for Contrast: SWR-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_030_swr-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_030_swr-baseline_2s_cbd.pdf');
    close all
   
    %% Complex SWR vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/CBD/'Complex SWR'/0-30
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    freq_baseline_cbd.powspctrm=freq_baseline_cbd.powspctrm(1:1265,:,:,:);
    ft_singleplotTFR(cfg, freq_baseline_cbd); 
    g=title('CBD - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_030_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_030_2s_cbd.pdf');
    close all

    % complex_swr
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_complex_swr_cbd); 
    g=title('CBD - PFCdeep - Complex SWR'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_complex_swr_030_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_complex_swr_030_2s_cbd.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_complex_swr_cbd, freq_baseline_cbd); %first-second!!    
    
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - CBD - Contrast: Complex SWR-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_030_complex_swr-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_030_complex_swr-baseline_2s_cbd.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_cbd,freq_complex_swr_cbd); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_complex_swr_cbd.time,freq_complex_swr_cbd.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - CBD - Stats for Contrast: Complex SWR-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_030_complex_swr-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_030_complex_swr-baseline_2s_cbd.pdf');
    close all
   

%%%%%%%%%%%%%%%
%% 30-100 Hz %%
%%%%%%%%%%%%%%%

% compute spectrogram

freqrange = [30:1:100]; % [0:0.5:30] or [30:1:100] or [100:2:300]
channel = [{'PFCdeep'}];

[freq_baseline_veh,freq_ripple_veh,freq_sw_veh,freq_swr_veh,freq_complex_swr_veh,...
    freq_baseline_cbd,freq_ripple_cbd,freq_sw_cbd,freq_swr_cbd,freq_complex_swr_cbd,zlim]=...
    ...
    spectrogram_automation_10inputs...
    ...
    (GC_baseline_PFCdeep_veh,GC_PFCdeep_ripple_median1956_veh,GC_PFCdeep_sw_median1956_veh,...
    GC_PFCdeep_swr_median1956_veh,GC_PFCdeep_complex_swr_median1781_veh,...
    ...
    GC_baseline_PFCdeep_cbd,GC_PFCdeep_ripple_median1956_cbd,GC_PFCdeep_sw_median1956_cbd,...
    GC_PFCdeep_swr_median1956_cbd,GC_PFCdeep_complex_swr_median1274_cbd,freqrange,channel);


%% Veh %%

    %% Ripple vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/Vehicle/Ripple/30-100
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_baseline_veh); 
    g=title('Veh - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_30100_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_30100_2s_veh.pdf');
    close all

    % Ripple
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_ripple_veh); 
    g=title('Veh - PFCdeep - Ripple'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_ripple_30100_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_ripple_30100_2s_veh.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_ripple_veh, freq_baseline_veh); %first-second!!    
    
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - Veh - Contrast: Ripple-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_30100_ripple-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_30100_ripple-baseline_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_veh,freq_ripple_veh); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_ripple_veh.time,freq_ripple_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - Veh - Stats for Contrast: Ripple-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_30100_ripple-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_30100_ripple-baseline_2s_veh.pdf');
    close all
    
    %% SW vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/Vehicle/SW/30-100
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_baseline_veh); 
    g=title('Veh - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_30100_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_30100_2s_veh.pdf');
    close all

    % SW
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_sw_veh); 
    g=title('Veh - PFCdeep - SW'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_sw_30100_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_sw_30100_2s_veh.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_sw_veh, freq_baseline_veh); %first-second!!    
    
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - Veh - Contrast: SW-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_30100_sw-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_30100_sw-baseline_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_veh,freq_sw_veh); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_sw_veh.time,freq_sw_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - Veh - Stats for Contrast: SW-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_30100_sw-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_30100_sw-baseline_2s_veh.pdf');
    close all
    
    
    %% SWR vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/Vehicle/SWR/30-100
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_baseline_veh); 
    g=title('Veh - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_30100_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_30100_2s_veh.pdf');
    close all

    % SWR
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_swr_veh); 
    g=title('Veh - PFCdeep - SWR'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_swr_30100_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_swr_30100_2s_veh.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_swr_veh, freq_baseline_veh); %first-second!!    
    
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - Veh - Contrast: SWR-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_30100_swr-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_30100_swr-baseline_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_veh,freq_swr_veh); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_swr_veh.time,freq_swr_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - Veh - Stats for Contrast: SWR-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_30100_swr-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_30100_swr-baseline_2s_veh.pdf');
    close all
   
    %% Complex SWR vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/Vehicle/'Complex SWR'/30-100
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    freq_baseline_veh.powspctrm=freq_baseline_veh.powspctrm(1:1777,:,:,:);
    ft_singleplotTFR(cfg, freq_baseline_veh); 
    g=title('Veh - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_30100_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_30100_2s_veh.pdf');
    close all

    % complex_swr
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_complex_swr_veh); 
    g=title('Veh - PFCdeep - Complex SWR'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_complex_swr_30100_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_complex_swr_30100_2s_veh.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_complex_swr_veh, freq_baseline_veh); %first-second!!
       
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - Veh - Contrast: Complex SWR-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_30100_complex_swr-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_30100_complex_swr-baseline_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_veh,freq_complex_swr_veh); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_complex_swr_veh.time,freq_complex_swr_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - Veh - Stats for Contrast: Complex SWR-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_30100_complex_swr-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_30100_complex_swr-baseline_2s_veh.pdf');
    close all
   

%% CBD %%

    %% Ripple vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/CBD/Ripple/30-100
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_baseline_cbd); 
    g=title('CBD - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_30100_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_30100_2s_cbd.pdf');
    close all

    % Ripple
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_ripple_cbd); 
    g=title('CBD - PFCdeep - Ripple'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_ripple_30100_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_ripple_30100_2s_cbd.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_ripple_cbd, freq_baseline_cbd); %first-second!!
       
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - CBD - Contrast: Ripple-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_30100_ripple-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_30100_ripple-baseline_2s_cbd.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_cbd,freq_ripple_cbd); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_ripple_cbd.time,freq_ripple_cbd.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - CBD - Stats for Contrast: Ripple-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_30100_ripple-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_30100_ripple-baseline_2s_cbd.pdf');
    close all
    
    %% SW vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/CBD/SW/30-100
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_baseline_cbd); 
    g=title('CBD - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_30100_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_30100_2s_cbd.pdf');
    close all

    % SW
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_sw_cbd); 
    g=title('CBD - PFCdeep - SW'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_sw_30100_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_sw_30100_2s_cbd.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_sw_cbd, freq_baseline_cbd); %first-second!!
        
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - CBD - Contrast: SW-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_30100_sw-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_30100_sw-baseline_2s_cbd.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_cbd,freq_sw_cbd); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_sw_cbd.time,freq_sw_cbd.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - CBD - Stats for Contrast: SW-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_30100_sw-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_30100_sw-baseline_2s_cbd.pdf');
    close all   
    
    %% SWR vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/CBD/SWR/30-100
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_baseline_cbd); 
    g=title('CBD - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_30100_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_30100_2s_cbd.pdf');
    close all

    % SWR
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_swr_cbd); 
    g=title('CBD - PFCdeep - SWR'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_swr_30100_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_swr_30100_2s_cbd.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_swr_cbd, freq_baseline_cbd); %first-second!!
    
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - CBD - Contrast: SWR-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_30100_swr-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_30100_swr-baseline_2s_cbd.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_cbd,freq_swr_cbd); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_swr_cbd.time,freq_swr_cbd.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - CBD - Stats for Contrast: SWR-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_30100_swr-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_30100_swr-baseline_2s_cbd.pdf');
    close all
   
    %% Complex SWR vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/CBD/'Complex SWR'/30-100
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    freq_baseline_cbd.powspctrm=freq_baseline_cbd.powspctrm(1:1265,:,:,:);
    ft_singleplotTFR(cfg, freq_baseline_cbd); 
    g=title('CBD - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_30100_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_30100_2s_cbd.pdf');
    close all

    % complex_swr
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_complex_swr_cbd); 
    g=title('CBD - PFCdeep - Complex SWR'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_complex_swr_30100_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_complex_swr_30100_2s_cbd.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_complex_swr_cbd, freq_baseline_cbd); %first-second!!
     
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - CBD - Contrast: Complex SWR-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_30100_complex_swr-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_30100_complex_swr-baseline_2s_cbd.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_cbd,freq_complex_swr_cbd); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_complex_swr_cbd.time,freq_complex_swr_cbd.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - CBD - Stats for Contrast: Complex SWR-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_30100_complex_swr-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_30100_complex_swr-baseline_2s_cbd.pdf');
    close all


%%%%%%%%%%%%%%%%
%% 100-300 Hz %%
%%%%%%%%%%%%%%%%

% compute spectrogram

freqrange = [100:2:300]; % [0:0.5:30] or [30:1:100] or [100:2:300]
channel = [{'PFCdeep'}];

[freq_baseline_veh,freq_ripple_veh,freq_sw_veh,freq_swr_veh,freq_complex_swr_veh,...
    freq_baseline_cbd,freq_ripple_cbd,freq_sw_cbd,freq_swr_cbd,freq_complex_swr_cbd,zlim]=...
    ...
    spectrogram_automation_10inputs...
    ...
    (GC_baseline_PFCdeep_veh,GC_PFCdeep_ripple_median1956_veh,GC_PFCdeep_sw_median1956_veh,...
    GC_PFCdeep_swr_median1956_veh,GC_PFCdeep_complex_swr_median1781_veh,...
    ...
    GC_baseline_PFCdeep_cbd,GC_PFCdeep_ripple_median1956_cbd,GC_PFCdeep_sw_median1956_cbd,...
    GC_PFCdeep_swr_median1956_cbd,GC_PFCdeep_complex_swr_median1274_cbd,freqrange,channel);


%% Veh %%

    %% Ripple vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/Vehicle/Ripple/100-300
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_baseline_veh); 
    g=title('Veh - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_100300_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_100300_2s_veh.pdf');
    close all

    % Ripple
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_ripple_veh); 
    g=title('Veh - PFCdeep - Ripple'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_ripple_100300_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_ripple_100300_2s_veh.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_ripple_veh, freq_baseline_veh); %first-second!!   
    
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - Veh - Contrast: Ripple-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_100300_ripple-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_100300_ripple-baseline_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_veh,freq_ripple_veh); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_ripple_veh.time,freq_ripple_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - Veh - Stats for Contrast: Ripple-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_100300_ripple-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_100300_ripple-baseline_2s_veh.pdf');
    close all
    
    %% SW vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/Vehicle/SW/100-300
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_baseline_veh); 
    g=title('Veh - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_100300_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_100300_2s_veh.pdf');
    close all

    % SW
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_sw_veh); 
    g=title('Veh - PFCdeep - SW'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_sw_100300_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_sw_100300_2s_veh.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_sw_veh, freq_baseline_veh); %first-second!!
      
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - Veh - Contrast: SW-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_100300_sw-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_100300_sw-baseline_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_veh,freq_sw_veh); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_sw_veh.time,freq_sw_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - Veh - Stats for Contrast: SW-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_100300_sw-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_100300_sw-baseline_2s_veh.pdf');
    close all
     
    %% SWR vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/Vehicle/SWR/100-300
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_baseline_veh); 
    g=title('Veh - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_100300_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_100300_2s_veh.pdf');
    close all

    % SWR
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_swr_veh); 
    g=title('Veh - PFCdeep - SWR'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_swr_100300_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_swr_100300_2s_veh.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_swr_veh, freq_baseline_veh); %first-second!!
        
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - Veh - Contrast: SWR-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_100300_swr-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_100300_swr-baseline_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_veh,freq_swr_veh); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_swr_veh.time,freq_swr_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - Veh - Stats for Contrast: SWR-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_100300_swr-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_100300_swr-baseline_2s_veh.pdf');
    close all
   
    %% Complex SWR vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/Vehicle/'Complex SWR'/100-300
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    freq_baseline_veh.powspctrm=freq_baseline_veh.powspctrm(1:1777,:,:,:);
    ft_singleplotTFR(cfg, freq_baseline_veh); 
    g=title('Veh - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_100300_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_100300_2s_veh.pdf');
    close all

    % complex_swr
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_complex_swr_veh); 
    g=title('Veh - PFCdeep - Complex SWR'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_complex_swr_100300_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_complex_swr_100300_2s_veh.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_complex_swr_veh, freq_baseline_veh); %first-second!!
    
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - Veh - Contrast: Complex SWR-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_100300_complex_swr-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_100300_complex_swr-baseline_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_veh,freq_complex_swr_veh); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_complex_swr_veh.time,freq_complex_swr_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - Veh - Stats for Contrast: Complex SWR-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_100300_complex_swr-baseline_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_100300_complex_swr-baseline_2s_veh.pdf');
    close all
   

%% CBD %%

    %% Ripple vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/CBD/Ripple/100-300
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_baseline_cbd); 
    g=title('CBD - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_100300_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_100300_2s_cbd.pdf');
    close all

    % Ripple
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_ripple_cbd); 
    g=title('CBD - PFCdeep - Ripple'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_ripple_100300_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_ripple_100300_2s_cbd.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_ripple_cbd, freq_baseline_cbd); %first-second!!   
    
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - CBD - Contrast: Ripple-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_100300_ripple-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_100300_ripple-baseline_2s_cbd.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_cbd,freq_ripple_cbd); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_ripple_cbd.time,freq_ripple_cbd.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - CBD - Stats for Contrast: Ripple-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_100300_ripple-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_100300_ripple-baseline_2s_cbd.pdf');
    close all
    
    %% SW vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/CBD/SW/100-300
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_baseline_cbd); 
    g=title('CBD - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_100300_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_100300_2s_cbd.pdf');
    close all

    % SW
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_sw_cbd); 
    g=title('CBD - PFCdeep - SW'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_sw_100300_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_sw_100300_2s_cbd.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_sw_cbd, freq_baseline_cbd); %first-second!!
       
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - CBD - Contrast: SW-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_100300_sw-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_100300_sw-baseline_2s_cbd.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_cbd,freq_sw_cbd); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_sw_cbd.time,freq_sw_cbd.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - CBD - Stats for Contrast: SW-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_100300_sw-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_100300_sw-baseline_2s_cbd.pdf');
    close all
      
    %% SWR vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/CBD/SWR/100-300
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_baseline_cbd); 
    g=title('CBD - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_100300_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_100300_2s_cbd.pdf');
    close all

    % SWR
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_swr_cbd); 
    g=title('CBD - PFCdeep - SWR'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_swr_100300_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_swr_100300_2s_cbd.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_swr_cbd, freq_baseline_cbd); %first-second!!
        
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - CBD - Contrast: SWR-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_100300_swr-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_100300_swr-baseline_2s_cbd.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_cbd,freq_swr_cbd); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_swr_cbd.time,freq_swr_cbd.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - CBD - Stats for Contrast: SWR-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_100300_swr-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_100300_swr-baseline_2s_cbd.pdf');
    close all
   
    %% Complex SWR vs Baseline
cd /Users/pelinozsezer/Desktop/spectrograms/PFCdeep/CBD/'Complex SWR'/100-300
    % Baseline
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    freq_baseline_cbd.powspctrm=freq_baseline_cbd.powspctrm(1:1265,:,:,:);
    ft_singleplotTFR(cfg, freq_baseline_cbd); 
    g=title('CBD - PFCdeep - Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_baseline_100300_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_baseline_100300_2s_cbd.pdf');
    close all

    % complex_swr
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    ft_singleplotTFR(cfg, freq_complex_swr_cbd); 
    g=title('CBD - PFCdeep - Complex SWR'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_complex_swr_100300_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_complex_swr_100300_2s_cbd.pdf');
    close all

    % Contrast
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m,  freq_complex_swr_cbd, freq_baseline_cbd); %first-second!!
      
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(bluewhitered); % change accordingly
    g=title('PFCdeep - CBD - Contrast: Complex SWR-Baseline'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_100300_complex_swr-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_100300_complex_swr-baseline_2s_cbd.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_baseline_cbd,freq_complex_swr_cbd); % event-baseline, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_complex_swr_cbd.time,freq_complex_swr_cbd.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(bluewhitered) % change accordingly
    
    J=title('PFCdeep - CBD - Stats for Contrast: Complex SWR-Baseline');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_100300_complex_swr-baseline_2s_cbd.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_100300_complex_swr-baseline_2s_cbd.pdf');
    close all

    