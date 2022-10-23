function [contrast_zlim] = ft_getminmax_contrast_baseline_vs_eventtype(freq_base1,freq1,freq2,freq3,freq4,...
    freq_base2,freq5,freq6,freq7,freq8,channel)

    cfg              = [];
    cfg.channel      = channel;
    %
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m, freq1, freq_base1); %first-second!!
    [zmin1, zmax1] = ft_getminmax(cfg, subs_freq);
    %
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m, freq2, freq_base1); %first-second!!
    [zmin2, zmax2] = ft_getminmax(cfg, subs_freq);
    %
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m, freq3, freq_base1); %first-second!!
    [zmin3, zmax3] = ft_getminmax(cfg, subs_freq);
    %
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    freq_base1.powspctrm=freq_base1.powspctrm(1:1777,:,:,:);
    subs_freq = ft_math(cfg_m, freq4, freq_base1); %first-second!!
    [zmin4, zmax4] = ft_getminmax(cfg, subs_freq);

    %%
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m, freq5, freq_base2); %first-second!!
    [zmin5, zmax5] = ft_getminmax(cfg, subs_freq);
    %
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m, freq6, freq_base2); %first-second!!
    [zmin6, zmax6] = ft_getminmax(cfg, subs_freq);
    %
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m, freq7, freq_base2); %first-second!!
    [zmin7, zmax7] = ft_getminmax(cfg, subs_freq);
    %
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    freq_base2.powspctrm=freq_base2.powspctrm(1:1265,:,:,:);
    subs_freq = ft_math(cfg_m, freq8, freq_base2); %first-second!!
    [zmin8, zmax8] = ft_getminmax(cfg, subs_freq);

    %%
    contrast_zlim=[min([zmin1 zmin2 zmin3 zmin4 zmin5 zmin6 zmin7 zmin8]) max([zmax1 zmax2 zmax3 zmax4 zmax5 zmax6 zmax7 zmax8])];

end