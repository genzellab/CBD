function [freq,freq2,freq3,freq4,freq5,freq6,freq7,freq8,zlim] = spectrogram_automation_8inputs(input1,input2,input3,input4,input5,input6,input7,input8,freqrange,channel)

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
   
    %% input3
    fn=600;
    leng=length(input3);
    ro=1800;
    tm = create_timecell(ro,leng);
    
    label=channel;
    Data.label=label;
    Data.time=tm;
    Data.trial=input3.';
    
    [freq3]=time_frequency_wavelet(Data,freqrange,[-1.1:0.01:1.1]);  % use 10 ms for the analysis
   
    %% input4
    fn=600;
    leng=length(input4);
    ro=1800;
    tm = create_timecell(ro,leng);
    
    label=channel;
    Data.label=label;
    Data.time=tm;
    Data.trial=input4.';
    
    [freq4]=time_frequency_wavelet(Data,freqrange,[-1.1:0.01:1.1]);  % use 10 ms for the analysis
   
    %% input5
    fn=600;
    leng=length(input5);
    ro=1800;
    tm = create_timecell(ro,leng);
    
    label=channel;
    Data.label=label;
    Data.time=tm;
    Data.trial=input5.';
    
    [freq5]=time_frequency_wavelet(Data,freqrange,[-1.1:0.01:1.1]);  % use 10 ms for the analysis

    %% input6
    fn=600;
    leng=length(input6);
    ro=1800;
    tm = create_timecell(ro,leng);
    
    label=channel;
    Data.label=label;
    Data.time=tm;
    Data.trial=input6.';
    
    [freq6]=time_frequency_wavelet(Data,freqrange,[-1.1:0.01:1.1]);  % use 10 ms for the analysis

    %% input7
    fn=600;
    leng=length(input7);
    ro=1800;
    tm = create_timecell(ro,leng);
    
    label=channel;
    Data.label=label;
    Data.time=tm;
    Data.trial=input7.';
    
    [freq7]=time_frequency_wavelet(Data,freqrange,[-1.1:0.01:1.1]);  % use 10 ms for the analysis

    %% input8
    fn=600;
    leng=length(input8);
    ro=1800;
    tm = create_timecell(ro,leng);
    
    label=channel;
    Data.label=label;
    Data.time=tm;
    Data.trial=input8.';
    
    [freq8]=time_frequency_wavelet(Data,freqrange,[-1.1:0.01:1.1]);  % use 10 ms for the analysis


    %%
    %% Normalize the limits of colorbar 
    cfg              = [];
    cfg.channel      = channel{1,1};
    [zmin1, zmax1] = ft_getminmax(cfg, freq);
    [zmin2, zmax2] = ft_getminmax(cfg, freq2);
    [zmin3, zmax3] = ft_getminmax(cfg, freq3);
    [zmin4, zmax4] = ft_getminmax(cfg, freq4);
    [zmin5, zmax5] = ft_getminmax(cfg, freq5);
    [zmin6, zmax6] = ft_getminmax(cfg, freq6);
    [zmin7, zmax7] = ft_getminmax(cfg, freq7);
    [zmin8, zmax8] = ft_getminmax(cfg, freq8);
    zlim=[min([zmin1 zmin2 zmin3 zmin4 zmin5 zmin6 zmin7 zmin8]) max([zmax1 zmax2 zmax3 zmax4 zmax5 zmax6 zmax7 zmax8])];

end