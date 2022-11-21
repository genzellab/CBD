
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% remove artifact from the data %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear
cd("/home/genzellab/Desktop/Pelin/hynospecs/data");
fs=2500;

%% PFC
PFC=dir('*PFC_*.mat');
PFC=PFC.name;
PFC=load(PFC);
PFC=PFC.PFC;

% Detect artifact 
x=PFC(801*fs:801*fs+(45*60*fs),1);
plot(abs(diff(x)))
xlim([0 size(x,1)] )
close all

% remove artifact
idx_rmv=find(abs(diff(x))>76); 
A = arrayfun(@(dum) dum-fs*1:dum+fs*1,idx_rmv,'UniformOutput',false); % remove 2 seconds around the artifact
idx_rmv=cell2mat(A);
idx_rmv=idx_rmv(:);
PFC_wa=x;
PFC_wa(idx_rmv)=nan;

plot(abs(diff(PFC_wa)))
xlim([0 size(x,1)] )
ylim([0 7000])
close all

PFC_wa(isnan(PFC_wa))=nanmean(PFC_wa);

save PFC_wa.mat PFC_wa -v7.3


%% HPC
HPC=dir('*HPC_*.mat');
HPC=HPC.name;
HPC=load(HPC);
HPC=HPC.HPC;

% Detect artifact 
x=HPC(801*fs:801*fs+(45*60*fs),1);
plot(abs(diff(x)))
xlim([0 size(x,1)] )
close all

% remove artifact
idx_rmv=find(abs(diff(x))>88); 
A = arrayfun(@(dum) dum-fs*1:dum+fs*1,idx_rmv,'UniformOutput',false); % remove 2 seconds around the artifact
idx_rmv=cell2mat(A);
idx_rmv=idx_rmv(:);
HPC_wa=x;
HPC_wa(idx_rmv)=nan;

plot(abs(diff(HPC_wa)))
xlim([0 size(x,1)] )
ylim([0 7000])
close all

HPC_wa(isnan(HPC_wa))=nanmean(HPC_wa);

save HPC_wa.mat HPC_wa -v7.3


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CREATE HYPNOGRAM & SPECTROGRAMS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear all
cd("/home/genzellab/Desktop/Pelin/hynospecs/data");
addpath('/home/genzellab/Desktop/Pelin/functions');
addpath(genpath('/home/genzellab/Desktop/Pelin/ADRITOOLS'));
addpath(genpath('/home/genzellab/Desktop/Pelin/chronux'));

% load mat files
load('2021-06-04_13-54-11_posttrial5-states_SM.mat');
load('PFC_wa.mat');
load('HPC_wa.mat');
fs=2500; 

%% 1 - NREM - chronics
subplot(6,2,1)
% 5 - 6 min
t=[0:length(HPC_wa(5*60*2500:6*60*2500))-1]/fs/60;
plot(t,zscore(HPC_wa(5*60*2500:6*60*2500)),'Color','k')
hold on
plot(t,zscore(PFC_wa(5*60*2500:6*60*2500))+10,'Color','k')
title('NREM chronics')

ax=gca;
ax.YTick=[0 10];
ax.YTickLabel=[{'HPC'};{'PFC'}];

%
ax=gca;
ax.YColor=[0 0 0];
ax.XColor=[0 0 0];
ax.FontSize=8; 
ax.FontName='Arial';

%% 2 - REM - chronics
subplot(6,2,2)
% 20-21 min
t=[0:length(HPC_wa(35.85*60*2500:36.85*60*2500))-1]/fs/60;
plot(t,zscore(HPC_wa(35.85*60*2500:36.85*60*2500)),'Color','k')
hold on
plot(t,zscore(PFC_wa(35.85*60*2500:36.85*60*2500))+10,'Color','k')
title('REM chronics')

ax=gca;
ax.YTick=[0 10];
ax.YTickLabel=[{'HPC'};{'PFC'}];

%
ax=gca;
ax.YColor=[0 0 0];
ax.XColor=[0 0 0];
ax.FontSize=8; 
ax.FontName='Arial';

%% 3 - Hypnogram (only REM & NREM)
states=states(1,801:801+60*45);

max(states)
min(states)

idx=find(states>1);
states(idx)=states(idx)-1;

% plotting
t=[0:length(states)-1]/60;
subplot(6,2,3:4)
scatter(t,states,20,'k','filled')
ylim([0.5 5])
xlim([0 45])

ax=gca;
ax.YTick=[1 2 3 4];
ax.YTickLabels=[{'Wake'};{'NREM'};{'Inter'};{'REM'}];
set(gca,'xticklabel',{[]})

title('Sleep Stages')
colorbar
colormap('hot')
xlabel('')
hold on

%
ax=gca;
ax.YColor=[0 0 0];
ax.XColor=[0 0 0];
ax.FontSize=8; 
ax.FontName='Arial';

%% 4 - HPC raw signal
fs=2500;
data=HPC_wa.';

[data] = ft_notch(data,fs,[13 14 15 15.5 17 18 19 20 ],3,3);

subplot(6,2,5:6)
plot((0:(length(data)-1))/fs/60,data,'Color','k')
colorbar
colormap('hot')
xlim([0 45])
xlabel('')
title('HPC Raw Signal')
set(gca,'xticklabel',{[]})

%
ax=gca;
ax.YColor=[0 0 0];
ax.XColor=[0 0 0];
ax.FontSize=8; 
ax.FontName='Arial';

%% 5 - HPC Spectrogram
movingwin=[10 7];
params.Fs=2500; % sampling frequency
params.fpass=[0 30]; % frequencies of interest

[S,t,f]=mtspecgramc(data,movingwin,params);

subplot(6,2,7:8)
plot_matrix(S,t/60,f);
ylim([0 30])
xlim([0 45])
colorbar
colormap('hot')
title('HPC - Spectrogram')
set(gca,'xticklabel',{[]})
xlabel('')

%
ax=gca;
ax.YColor=[0 0 0];
ax.XColor=[0 0 0];
ax.FontSize=8; 
ax.FontName='Arial';

%% 6 - PFC Raw Signal
fs=2500;
data=PFC_wa.';

[data] = ft_notch(data,fs,[13 14 15 15.5 17 18 19 20 ],3,3);

subplot(6,2,9:10)
plot((0:(length(data)-1))/fs/60,data,'Color','k')
colorbar
colormap('hot')
xlim([0 45])
ylim([-1000 1000])
xlabel('')
set(gca,'xticklabel',{[]})
title('PFC Raw Signal')

%
ax=gca;
ax.YColor=[0 0 0];
ax.XColor=[0 0 0];
ax.FontSize=8; 
ax.FontName='Arial';

%% 7 - PFC Spectrogram
movingwin=[10 7];
params.Fs=2500; % sampling frequency
params.fpass=[0 30]; % frequencies of interest

[S,t,f]=mtspecgramc(data,movingwin,params);

subplot(6,2,11:12)
plot_matrix(S,t/60,f);ylim([0 30])
colorbar
colormap('hot')
xlabel('time (min)')
xlim([0 45])
title('PFC - Spectrogram')
set(gca,'xticklabel',{[]})

%
ax=gca;
ax.YColor=[0 0 0];
ax.XColor=[0 0 0];
ax.FontSize=8; 
ax.FontName='Arial';


%% adjust for printing
f=gcf;
set(f,'Units','centimeters')

f.Position(3)=25;
f.Position(4)=12.5;

filename='chronics_spec_sleepstages';
orient(f,'landscape')
printing_image(filename)
print('-painters',f,filename,'-dpdf');%'-r0'
close all


