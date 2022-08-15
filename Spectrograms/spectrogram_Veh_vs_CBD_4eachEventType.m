%% Pelin Ozsezer

%% SPECTROGRAM
% same event type comparison across treatments (i.e., Ripple Veh vs Ripple CBD)
% (Veh vs CBD) for each event type

clc
clear
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/fieldtrip');
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/functions');
load('GC_median_wa.mat');
load('baseline_PFC_wa.mat');

%% data (8 inputs per spec)
GC_PFCdeep_ripple_median1956_cbd=GC_PFCdeep_ripple_median2000_cbd(1:1956);
GC_PFCdeep_ripple_median1956_veh=GC_PFCdeep_ripple_median2000_veh(1:1956);
GC_PFCdeep_sw_median1956_cbd= GC_PFCdeep_sw_median2000_cbd(1:1956);
GC_PFCdeep_sw_median1956_veh= GC_PFCdeep_sw_median2000_veh(1:1956);
GC_PFCdeep_swr_median1956_veh= GC_PFCdeep_swr_median2000_veh(1:1956);
GC_PFCdeep_swr_median1956_cbd=GC_PFCdeep_swr_median2000_cbd(1:1956);


%%%%%%%%%%%%%
%% 0-30 Hz %%
%%%%%%%%%%%%%

%% compute spectrograms
freqrange = [0:0.5:30] ; % [0:0.5:30] or [30:1:100] or [100:2:300]
channel = [{'PFCdeep'}];

[freq_ripple_veh,freq_sw_veh,freq_swr_veh,freq_complex_swr_veh,...
    freq_ripple_cbd,freq_sw_cbd,freq_swr_cbd,freq_complex_swr_cbd,zlim]=...
    ...
    spectrogram_automation_8inputs_lowfreq...
    ...
    (GC_PFCdeep_ripple_median1956_veh,GC_PFCdeep_sw_median1956_veh,...
    GC_PFCdeep_swr_median1956_veh,GC_PFCdeep_complex_swr_median1781_veh,...
    ...
    GC_PFCdeep_ripple_median1956_cbd,GC_PFCdeep_sw_median1956_cbd,...
    GC_PFCdeep_swr_median1956_cbd,GC_PFCdeep_complex_swr_median1274_cbd,freqrange,channel);

%% Ripple
cd /Users/pelinozsezer/Desktop/spectrograms2/PFCdeep/Ripple/0-30
    % Veh
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

    % CBD
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
    subs_freq = ft_math(cfg_m,  freq_ripple_veh, freq_ripple_cbd); %first-second!!
    
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(colorbar_treatment); % change accordingly
    g=title('PFCdeep - Ripple - Contrast: Veh-CBD'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_030_ripple_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_030_ripple_veh-cbd_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_ripple_cbd,freq_ripple_veh); % second-first, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_ripple_veh.time,freq_ripple_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(colorbar_treatment) % change accordingly
    
    J=title('PFCdeep - Ripple - Stats for Contrast: Veh-CBD');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_030_ripple_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_030_ripple_veh-cbd_2s_veh.pdf');
    close all

%% SW
cd /Users/pelinozsezer/Desktop/spectrograms2/PFCdeep/SW/0-30
    % Veh
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

    % CBD
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
    subs_freq = ft_math(cfg_m,  freq_sw_veh, freq_sw_cbd); %first-second!!
        
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(colorbar_treatment); % change accordingly
    g=title('PFCdeep - SW - Contrast: Veh-CBD'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_030_sw_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_030_sw_veh-cbd_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_sw_cbd,freq_sw_veh); % second-first, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_sw_veh.time,freq_sw_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(colorbar_treatment) % change accordingly
    
    J=title('PFCdeep - SW - Stats for Contrast: Veh-CBD');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_030_sw_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_030_sw_veh-cbd_2s_veh.pdf');
    close all

%% SWR
cd /Users/pelinozsezer/Desktop/spectrograms2/PFCdeep/SWR/0-30
    % Veh
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

    % CBD
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
    subs_freq = ft_math(cfg_m,  freq_swr_veh, freq_swr_cbd); %first-second!!   
    
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(colorbar_treatment); % change accordingly
    g=title('PFCdeep - SWR - Contrast: Veh-CBD'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_030_swr_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_030_swr_veh-cbd_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_swr_cbd,freq_swr_veh); % second-first, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_swr_veh.time,freq_swr_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(colorbar_treatment) % change accordingly
    
    J=title('PFCdeep - SWR - Stats for Contrast: Veh-CBD');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_030_swr_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_030_swr_veh-cbd_2s_veh.pdf');
    close all

%% Complex SWR
cd /Users/pelinozsezer/Desktop/spectrograms2/PFCdeep/Complex-SWR/0-30
    % Veh
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    freq_complex_swr_veh.powspctrm=freq_complex_swr_veh.powspctrm(1:1265,:,:,:);
    ft_singleplotTFR(cfg, freq_complex_swr_veh); 
    g=title('Veh - PFCdeep - Complex SWR'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_complex_swr_030_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_complex_swr_030_2s_veh.pdf');
    close all

    % CBD
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
    subs_freq = ft_math(cfg_m,  freq_complex_swr_veh, freq_complex_swr_cbd); %first-second!!
      
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(colorbar_treatment); % change accordingly
    g=title('PFCdeep - Complex SWR - Contrast: Veh-CBD'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_030_complex_swr_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_030_complex_swr_veh-cbd_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_complex_swr_cbd,freq_complex_swr_veh); % second-first, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_complex_swr_cbd.time,freq_complex_swr_cbd.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(colorbar_treatment) % change accordingly
    
    J=title('PFCdeep - Complex SWR - Stats for Contrast: Veh-CBD');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_030_complex_swr_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_030_complex_swr_veh-cbd_2s_veh.pdf');
    close all


%%%%%%%%%%%%%%%
%% 30-100 Hz %%
%%%%%%%%%%%%%%%

%% compute spectrograms
freqrange = [30:1:100] ; % [0:0.5:30] or [30:1:100] or [100:2:300]
channel = [{'PFCdeep'}];

[freq_ripple_veh,freq_sw_veh,freq_swr_veh,freq_complex_swr_veh,...
    freq_ripple_cbd,freq_sw_cbd,freq_swr_cbd,freq_complex_swr_cbd,zlim]=...
    ...
    spectrogram_automation_8inputs...
    ...
    (GC_PFCdeep_ripple_median1956_veh,GC_PFCdeep_sw_median1956_veh,...
    GC_PFCdeep_swr_median1956_veh,GC_PFCdeep_complex_swr_median1781_veh,...
    ...
    GC_PFCdeep_ripple_median1956_cbd,GC_PFCdeep_sw_median1956_cbd,...
    GC_PFCdeep_swr_median1956_cbd,GC_PFCdeep_complex_swr_median1274_cbd,freqrange,channel);

%% Ripple
cd /Users/pelinozsezer/Desktop/spectrograms2/PFCdeep/Ripple/30-100
    % Veh
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

    % CBD
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
    subs_freq = ft_math(cfg_m,  freq_ripple_veh, freq_ripple_cbd); %first-second!!   
    
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(colorbar_treatment); % change accordingly
    g=title('PFCdeep - Ripple - Contrast: Veh-CBD'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_30100_ripple_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_30100_ripple_veh-cbd_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_ripple_cbd,freq_ripple_veh); % second-first, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_ripple_veh.time,freq_ripple_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(colorbar_treatment) % change accordingly
    
    J=title('PFCdeep - Ripple - Stats for Contrast: Veh-CBD');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_30100_ripple_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_30100_ripple_veh-cbd_2s_veh.pdf');
    close all

%% SW
cd /Users/pelinozsezer/Desktop/spectrograms2/PFCdeep/SW/30-100
    % Veh
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

    % CBD
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
    subs_freq = ft_math(cfg_m,  freq_sw_veh, freq_sw_cbd); %first-second!!
      
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(colorbar_treatment); % change accordingly
    g=title('PFCdeep - SW - Contrast: Veh-CBD'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_30100_sw_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_30100_sw_veh-cbd_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_sw_cbd,freq_sw_veh); % second-first, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_sw_veh.time,freq_sw_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(colorbar_treatment) % change accordingly
    
    J=title('PFCdeep - SW - Stats for Contrast: Veh-CBD');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_30100_sw_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_30100_sw_veh-cbd_2s_veh.pdf');
    close all

%% SWR
cd /Users/pelinozsezer/Desktop/spectrograms2/PFCdeep/SWR/30-100
    % Veh
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

    % CBD
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
    subs_freq = ft_math(cfg_m,  freq_swr_veh, freq_swr_cbd); %first-second!!
        
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(colorbar_treatment); % change accordingly
    g=title('PFCdeep - SWR - Contrast: Veh-CBD'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_30100_swr_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_30100_swr_veh-cbd_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_swr_cbd,freq_swr_veh); % second-first, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_swr_veh.time,freq_swr_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(colorbar_treatment) % change accordingly
    
    J=title('PFCdeep - SWR - Stats for Contrast: Veh-CBD');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_30100_swr_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_30100_swr_veh-cbd_2s_veh.pdf');
    close all

%% Complex SWR
cd /Users/pelinozsezer/Desktop/spectrograms2/PFCdeep/Complex-SWR/30-100
    % Veh
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    freq_complex_swr_veh.powspctrm=freq_complex_swr_veh.powspctrm(1:1265,:,:,:);
    ft_singleplotTFR(cfg, freq_complex_swr_veh); 
    g=title('Veh - PFCdeep - Complex SWR'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_complex_swr_30100_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_complex_swr_30100_2s_veh.pdf');
    close all

    % CBD
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
    subs_freq = ft_math(cfg_m,  freq_complex_swr_veh, freq_complex_swr_cbd); %first-second!!    
    
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(colorbar_treatment); % change accordingly
    g=title('PFCdeep - Complex SWR - Contrast: Veh-CBD'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_30100_complex_swr_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_30100_complex_swr_veh-cbd_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_complex_swr_cbd,freq_complex_swr_veh); % second-first, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_complex_swr_cbd.time,freq_complex_swr_cbd.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(colorbar_treatment) % change accordingly
    
    J=title('PFCdeep - Complex SWR - Stats for Contrast: Veh-CBD');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_30100_complex_swr_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_30100_complex_swr_veh-cbd_2s_veh.pdf');
    close all


%%%%%%%%%%%%%%%%
%% 100-300 Hz %%
%%%%%%%%%%%%%%%%

%% compute spectrograms
freqrange = [100:2:300] ; % [0:0.5:30] or [30:1:100] or [100:2:300]
channel = [{'PFCdeep'}];

[freq_ripple_veh,freq_sw_veh,freq_swr_veh,freq_complex_swr_veh,...
    freq_ripple_cbd,freq_sw_cbd,freq_swr_cbd,freq_complex_swr_cbd,zlim]=...
    ...
    spectrogram_automation_8inputs...
    ...
    (GC_PFCdeep_ripple_median1956_veh,GC_PFCdeep_sw_median1956_veh,...
    GC_PFCdeep_swr_median1956_veh,GC_PFCdeep_complex_swr_median1781_veh,...
    ...
    GC_PFCdeep_ripple_median1956_cbd,GC_PFCdeep_sw_median1956_cbd,...
    GC_PFCdeep_swr_median1956_cbd,GC_PFCdeep_complex_swr_median1274_cbd,freqrange,channel);

%% Ripple
cd /Users/pelinozsezer/Desktop/spectrograms2/PFCdeep/Ripple/100-300
    % Veh
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

    % CBD
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
    subs_freq = ft_math(cfg_m,  freq_ripple_veh, freq_ripple_cbd); %first-second!!    
    
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(colorbar_treatment); % change accordingly
    g=title('PFCdeep - Ripple - Contrast: Veh-CBD'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_100300_ripple_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_100300_ripple_veh-cbd_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_ripple_cbd,freq_ripple_veh); % second-first, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_ripple_veh.time,freq_ripple_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(colorbar_treatment) % change accordingly
    
    J=title('PFCdeep - Ripple - Stats for Contrast: Veh-CBD');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_100300_ripple_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_100300_ripple_veh-cbd_2s_veh.pdf');
    close all

%% SW
cd /Users/pelinozsezer/Desktop/spectrograms2/PFCdeep/SW/100-300
    % Veh
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

    % CBD
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
    subs_freq = ft_math(cfg_m,  freq_sw_veh, freq_sw_cbd); %first-second!!
        
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(colorbar_treatment); % change accordingly
    g=title('PFCdeep - SW - Contrast: Veh-CBD'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_100300_sw_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_100300_sw_veh-cbd_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_sw_cbd,freq_sw_veh); % second-first, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_sw_veh.time,freq_sw_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(colorbar_treatment) % change accordingly
    
    J=title('PFCdeep - SW - Stats for Contrast: Veh-CBD');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_100300_sw_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_100300_sw_veh-cbd_2s_veh.pdf');
    close all

%% SWR
cd /Users/pelinozsezer/Desktop/spectrograms2/PFCdeep/SWR/100-300
    % Veh
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

    % CBD
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
    subs_freq = ft_math(cfg_m,  freq_swr_veh, freq_swr_cbd); %first-second!!
       
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(colorbar_treatment); % change accordingly
    g=title('PFCdeep - SWR - Contrast: Veh-CBD'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_100300_swr_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_100300_swr_veh-cbd_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_swr_cbd,freq_swr_veh); % second-first, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_swr_veh.time,freq_swr_veh.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(colorbar_treatment) % change accordingly
    
    J=title('PFCdeep - SWR - Stats for Contrast: Veh-CBD');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_100300_swr_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_100300_swr_veh-cbd_2s_veh.pdf');
    close all

%% Complex SWR
cd /Users/pelinozsezer/Desktop/spectrograms2/PFCdeep/Complex-SWR/100-300
    % Veh
    cfg              = [];
    cfg.zlim         = zlim;
    cfg.channel      = 'PFCdeep';
    cfg.colormap     = colormap(hot);
    
    freq_complex_swr_veh.powspctrm=freq_complex_swr_veh.powspctrm(1:1265,:,:,:);
    ft_singleplotTFR(cfg, freq_complex_swr_veh); 
    g=title('Veh - PFCdeep - Complex SWR'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'PFCdeep_complex_swr_100300_2s_veh.jpg'); % change accordingly
    saveas(gcf,'PFCdeep_complex_swr_100300_2s_veh.pdf');
    close all

    % CBD
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
    subs_freq = ft_math(cfg_m,  freq_complex_swr_veh, freq_complex_swr_cbd); %first-second!!   
    
    cfg              = [];
    cfg.channel      = channel;
    ft_singleplotTFR(cfg, subs_freq); 
    colormap(colorbar_treatment); % change accordingly
    g=title('PFCdeep - Complex SWR - Contrast: Veh-CBD'); % change accordingly
    g.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'contrast_PFCdeep_100300_complex_swr_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'contrast_PFCdeep_100300_complex_swr_veh-cbd_2s_veh.pdf');
    close all

    % Stats
    zmap=stats_high_spec(freq_complex_swr_cbd,freq_complex_swr_veh); % second-first, output= freq x time

    zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
    J=imagesc(freq_complex_swr_cbd.time,freq_complex_swr_cbd.freq,zmap)
    xlabel('Time (s)'), ylabel('Frequency (Hz)')
    set(gca,'xlim',xlim,'ydir','no')
    set(J,'AlphaData',~isnan(zmap))
    colorbar()
    colormap(colorbar_treatment) % change accordingly
    
    J=title('PFCdeep - Complex SWR - Stats for Contrast: Veh-CBD');
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'stats_contrast_PFCdeep_100300_complex_swr_veh-cbd_2s_veh.jpg'); % change accordingly
    saveas(gcf,'stats_contrast_PFCdeep_100300_complex_swr_veh-cbd_2s_veh.pdf');
    close all



