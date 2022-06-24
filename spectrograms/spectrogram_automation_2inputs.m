function [freq,freq2,zlim] = spectrogram_automation_condition(input1,input2,freqrange,channel)

    %% input1
    fn=600;
    leng=length(input1);
    ro=1800;
    tm = create_timecell(ro,leng);
    
    label=channel;
    Data.label=label;
    Data.time=tm;
    Data.trial=input1.';
    
    [freq]=time_frequency_wavelet(Data,freqrange,[-1.1:0.01:1.1]);  % use 10 ms for the analysis
    

    %% input2
    fn=600;
    leng=length(input2);
    ro=1800;
    tm = create_timecell(ro,leng);
    
    label=channel;
    Data.label=label;
    Data.time=tm;
    Data.trial=input2.';


    [freq2]=time_frequency_wavelet(Data,freqrange,[-1.1:0.01:1.1]);  % use 10 ms for the analysis
   

    %%
    %% Normalize the limits of colorbar 
    cfg              = [];
    cfg.channel      = channel{1,1};
    [zmin1, zmax1] = ft_getminmax(cfg, freq);
    [zmin2, zmax2] = ft_getminmax(cfg, freq2);
    zlim=[min([zmin1 zmin2]) max([zmax1 zmax2])];

end