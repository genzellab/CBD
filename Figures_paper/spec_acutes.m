addpath(genpath('/home/adrian/Downloads/chronux_2_12.v03'))

HPC1=hpc_period;
PFC1=pfc_period;
fn=600;
Wn1=[0.1/(fn/2) 30/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
% Wn1=[100/(fn/2) 299/(fn/2)]; % Cutoff=100-300 Hz
% [b2,a2] = butter(3,Wn1,'bandpass'); %Filter coefficients


2*length(196500:200800)
filler=HPC1(196500-2*length(196500:200800):196500-1);
filler_pfc=PFC1(196500-2*length(196500:200800):196500-1);

HPC1(196500:196500-1+2*length(196500:200800))=filler;
PFC1(196500:196500-1+2*length(196500:200800))=filler_pfc;

HPC2=HPC1;
PFC2=PFC1;
% 
% HPC1=filtfilt(b1,a1,HPC1);
% PFC1=filtfilt(b1,a1,PFC1);

%%
% frequencies=[3:0.25:30];
% superlet=aslt(HPC1, 600, frequencies, 1, [10, 20], 0);
%%
% imagesc(superlet)
% colormap hot
%%
% [cfs,f]=cwt(HPC1,600);
%%
% signal=HPC1;
% n=10; %Filter order
% d = designfilt('bandstopiir','FilterOrder',n, ...
%                'HalfPowerFrequency1',1.6,'HalfPowerFrequency2',52, ...
%                'DesignMethod','butter','SampleRate',fn);
% 
% signal2 = filtfilt(d,signal);
% 
% d = designfilt('bandstopiir','FilterOrder',n, ...
%                'HalfPowerFrequency1',3.5,'HalfPowerFrequency2',52, ...
%                'DesignMethod','butter','SampleRate',fn);
% 
% signal3 = filtfilt(d,signal2);
% %%
% [cfs,f]=cwt(signal3,600,'TimeBandwidth',80);
% [cfs_pfc,f_pfc]=cwt(PFC1,600,'TimeBandwidth',80);
%%
[signal3] = ft_notch(HPC1,600,[1.5 3.5 4 4.5 5],1,1);
[PFC1] = ft_notch(PFC1,600,[1.5 3.5 4 4.5 5],1,1);

    %%
% params.tapers=[5 9]
params.tapers=[1 3]

params.Fs=600;
[S,t,f]=mtspecgramc(signal3,[10 7],params);

[S_pfc,t_pfc,f_pfc]=mtspecgramc(PFC1,[10 7],params);

%%
ax1=subplot(6,2,[3 4])
plot([0:length(signal3)-1]/600/60,sleep_period,'o','Color','k');ylim([0.5 2.5]);
ax=gca;
ax.YTick=[1 2];
ax.YTickLabels=[{'Rem-like'};{'NREM-like'}];
c=colorbar;

title('Sleep stages')

ax2=subplot(6,2,[5 6])
plot([0:length(signal3)-1]/600/60,HPC2,'Color','k');
title('HPC raw signal')
c=colorbar;

ax3=subplot(6,2,[ 7 8])
plot_matrix(S,t/60,f);ylim([0 30])
%caxis([5 30]); 
caxis([5 20]); 

c=colorbar;
% c.Location ='southoutside'
colormap('hot')
xlabel('Time (minutes)')
title('Hippocampus (1-30Hz)')
ax=gca;
ax4=subplot(6,2,[9 10])
plot([0:length(PFC2)-1]/600/60,PFC2,'Color','k');
title('PFC raw signal')
c=colorbar;

ax5=subplot(6,2,[11 12])
plot_matrix(S_pfc,t_pfc/60,f_pfc);ylim([0 30])
%caxis([5 45]); 
caxis([5 30]); 

c=colorbar;
%c.Location ='southoutside'
colormap('hot')
xlabel('Time (minutes)')
title('PFC (1-30Hz)')


linkaxes([ax1,ax2,ax3,ax4,ax5],'x')
xlim([0 45])
%% CWT
ax1=subplot(4,1,1)
plot([0:length(signal3)-1]/600/60,HPC2,'Color','k');
title('HPC raw signal')

ax2=subplot(4,1,2)
image("XData",[0:length(HPC1)-1]/600/60,"YData",f,"CData",abs(cfs),"CDataMapping","scaled")
set(gca,"YScale","log")
axis tight
xlabel("Time (Seconds)")
ylabel("Frequency (Hz)")

% imagesc([0:length(HPC1)-1],f,abs(cfs));
caxis([1 80])

c=colorbar();
colormap hot
c.Location='southoutside'
% % c.Limits=[0.0003 100]

ax3=subplot(4,1,3)
plot([0:length(PFC2)-1]/600/60,PFC2,'Color','k');
title('PFC raw signal')

ax4=subplot(4,1,4)
image("XData",[0:length(HPC1)-1]/600/60,"YData",f_pfc,"CData",abs(cfs_pfc),"CDataMapping","scaled")
set(gca,"YScale","log")
axis tight
xlabel("Time (Seconds)")
ylabel("Frequency (Hz)")

% imagesc([0:length(HPC1)-1],f,abs(cfs));
% caxis([1 40])

c=colorbar();
c.Location='southoutside'

colormap hot
%%
linkaxes([ax1,ax2,ax3,ax4],'x')