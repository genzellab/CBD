function [contrast_zlim] = ft_getminmax_contrast_Veh_vs_CBD_4eacheventtype(freq1,freq2,freq3,freq4,...
    freq5,freq6,freq7,freq8,channel)

    cfg              = [];
    cfg.channel      = channel;
    %
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m, freq1, freq2); %first-second!!
    [zmin1, zmax1] = ft_getminmax(cfg, subs_freq);
    %
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m, freq3, freq4); %first-second!!
    [zmin2, zmax2] = ft_getminmax(cfg, subs_freq);
    %
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    subs_freq = ft_math(cfg_m, freq5, freq6); %first-second!!
    [zmin3, zmax3] = ft_getminmax(cfg, subs_freq);
    %
    cfg_m = [];
    cfg_m.operation = 'subtract';
    cfg_m.parameter = 'powspctrm';
    freq7.powspctrm=freq7.powspctrm(1:1265,:,:,:);
    subs_freq = ft_math(cfg_m, freq7, freq8); %first-second!!
    [zmin4, zmax4] = ft_getminmax(cfg, subs_freq);


    %%
    contrast_zlim=[min([zmin1 zmin2 zmin3 zmin4]) max([zmax1 zmax2 zmax3 zmax4])];

end