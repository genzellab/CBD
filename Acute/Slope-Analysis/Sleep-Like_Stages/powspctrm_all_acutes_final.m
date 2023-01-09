
% %% Acutes - HPCpyra & PFCshal
% clear
% load('processed_HPCpyra.mat');
% signals_v2=signals;
% clear signals
% save processed_HPCpyra_v2.mat -v7.3
%
% clear
% load('processed_PFCshal.mat');
% signals_v2=signals;
% clear signals
% save processed_PFCshal_v2.mat -v7.3


%%%%%%%%%
%% REM %%
%%%%%%%%%
clc
clear
cd("/home/genzellab/Desktop/Pelin/november_periodograms")
addpath('/home/genzellab/Desktop/Pelin/november_periodograms/github_repo');
addpath('/home/genzellab/Desktop/Pelin/ADRITOOLS');


% parameters for the analysis
srate           = 600;
winsize         = 1*srate;                      % Equivalent to 1s
overlap         = 0.8*winsize;                  % Equivalent to 80% of the window
nfft            = 2^nextpow2(winsize);
fn=srate;

%%
rats_veh=[3, 4, 9, 201, 203, 206, 210, 211, 213];
rats_cbd=[2, 5, 10, 11, 204, 205, 207, 209, 212, 214];
rats=[rats_veh,rats_cbd];
rats=sort(rats);

SpectrumAllControlPFC   = [];
SpectrumAllControlHPC   = [];
SpectrumAllCBDPFC   = [];
SpectrumAllCBDHPC   = [];
for i=1:size(rats,2) % loop through all rats
    i
    rat=rats(1,i);
    if any(rats_veh == rat) % vehicle

        %% PFCshal
        load('processed_PFCshal_v2.mat');

        lfpSig              = signals_v2(i,:);
        lfpSig=lfpSig(signals_indexes(i,1):signals_indexes(i,2));
        sleepstate          = sleep_states(i,:);
        sleepstate=sleepstate(signals_indexes(i,1):signals_indexes(i,2));

        %Rearrange signal in 10 sec epochs.
        e_t=10;
        e_samples=e_t*(fn); %fs=600 Hz
        ch=length(lfpSig);
        nc=floor(ch/e_samples); %Number of epochsw
        NC=[];
        for kk=1:nc
            NC(:,kk)= lfpSig(1+e_samples*(kk-1):e_samples*kk);
        end
        %Find if epoch is REM (state=1)
        vec_bin=sleepstate;
        vec_bin(vec_bin~=1)=0;
        vec_bin(vec_bin==1)=1;
        %Cluster one values:
        v2=ConsecutiveOnes(vec_bin);
        v_index=find(v2~=0);
        v_values=v2(v2~=0);
        %Extract REM epochs
        for epoch_count=1:length(v_index)-1
            sig_bout{epoch_count,1}=reshape(lfpSig(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1) ), [], 1);
        end
        %         % finding the REM indices
        %         % extract the epochs of the REM sleep
        %         %[sigPFC] = extract_rem_epochs_acutes(sleepstate, lfpSig,srate);
        %         REMsleepIdx = find(sleepstate == 1);
        %
        %         x=find(diff(REMsleepIdx) ~= 1) + 1;
        %         bouts_no=length(x)+1;
        %         bouts_idx=[1 x length(REMsleepIdx)-1];
        %         %REMsleepIdx = size(stateMat,2);
        %
        %         sig_bout={ };
        %         sig_hnd=[  ] ;
        %         for b = 1:bouts_no
        %             b
        %             for  ii=bouts_idx(b):bouts_idx(b+1)
        %                 if REMsleepIdx(ii+1) - REMsleepIdx(ii) == 1
        %                     sigh = lfpSig(REMsleepIdx(ii):REMsleepIdx(ii+1));
        %
        %                     sig_hnd= [sig_hnd sigh];
        %                 else
        %                     continue
        %                 end
        %             end
        %             sig_bout=[sig_bout; sig_hnd];
        %         end

        % doing the power spectrum


        [Gpfc,F2]   = cellfun(@(x) pwelch(detrend(x),winsize,overlap,nfft,srate),sig_bout,'UniformOutput',false);
        for qq=1:size(Gpfc,1)
            hnd=cell2mat(Gpfc(qq));
            SpectrumAllControlPFC   =  [SpectrumAllControlPFC; 20*log10(hnd')] ;
        end
        clear sig_bout

        %% HPCpyra

        load('processed_HPCpyra_v2.mat');

        lfpSig              = signals_v2(i,:);
        lfpSig=lfpSig(signals_indexes(i,1):signals_indexes(i,2));
        sleepstate          = sleep_states(i,:);
        sleepstate=sleepstate(signals_indexes(i,1):signals_indexes(i,2));

        %Rearrange signal in 10 sec epochs.
        e_t=10;
        e_samples=e_t*(fn); %fs=600 Hz
        ch=length(lfpSig);
        nc=floor(ch/e_samples); %Number of epochsw
        NC=[];
        for kk=1:nc
            NC(:,kk)= lfpSig(1+e_samples*(kk-1):e_samples*kk);
        end
        %Find if epoch is REM (state=1)
        vec_bin=sleepstate;
        vec_bin(vec_bin~=1)=0;
        vec_bin(vec_bin==1)=1;
        %Cluster one values:
        v2=ConsecutiveOnes(vec_bin);
        v_index=find(v2~=0);
        v_values=v2(v2~=0);
        %Extract REM epochs
        for epoch_count=1:length(v_index)-1
            sig_bout{epoch_count,1}=reshape(lfpSig(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1) ), [], 1);
        end


        % doing the power spectrum


        [Gpfc,F2]   = cellfun(@(x) pwelch(detrend(x),winsize,overlap,nfft,srate),sig_bout,'UniformOutput',false);
        for qq=1:size(Gpfc,1)
            hnd=cell2mat(Gpfc(qq));
            SpectrumAllControlHPC   =  [SpectrumAllControlHPC; 20*log10(hnd')] ;
        end
         clear sig_bout

    elseif any(rats_cbd == rat) % CBD


        %% PFCshal
        load('processed_PFCshal_v2.mat');

        lfpSig              = signals_v2(i,:);
        lfpSig=lfpSig(signals_indexes(i,1):signals_indexes(i,2));
        sleepstate          = sleep_states(i,:);
        sleepstate=sleepstate(signals_indexes(i,1):signals_indexes(i,2));

        %Rearrange signal in 10 sec epochs.
        e_t=10;
        e_samples=e_t*(fn); %fs=600 Hz
        ch=length(lfpSig);
        nc=floor(ch/e_samples); %Number of epochsw
        NC=[];
        for kk=1:nc
            NC(:,kk)= lfpSig(1+e_samples*(kk-1):e_samples*kk);
        end
        %Find if epoch is REM (state=1)
        vec_bin=sleepstate;
        vec_bin(vec_bin~=1)=0;
        vec_bin(vec_bin==1)=1;
        %Cluster one values:
        v2=ConsecutiveOnes(vec_bin);
        v_index=find(v2~=0);
        v_values=v2(v2~=0);
        %Extract REM epochs
        for epoch_count=1:length(v_index)-1
            sig_bout{epoch_count,1}=reshape(lfpSig(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1) ), [], 1);
        end


        % doing the power spectrum


        [Gpfc,F2]   = cellfun(@(x) pwelch(detrend(x),winsize,overlap,nfft,srate),sig_bout,'UniformOutput',false);
        for qq=1:size(Gpfc,1)
            hnd=cell2mat(Gpfc(qq));
            SpectrumAllCBDPFC   =  [SpectrumAllCBDPFC; 20*log10(hnd')] ;
        end
         clear sig_bout

        %% HPCpyra

        load('processed_HPCpyra_v2.mat');

        lfpSig              = signals_v2(i,:);
        lfpSig=lfpSig(signals_indexes(i,1):signals_indexes(i,2));
        sleepstate          = sleep_states(i,:);
        sleepstate=sleepstate(signals_indexes(i,1):signals_indexes(i,2));

        %Rearrange signal in 10 sec epochs.
        e_t=10;
        e_samples=e_t*(fn); %fs=600 Hz
        ch=length(lfpSig);
        nc=floor(ch/e_samples); %Number of epochsw
        NC=[];
        for kk=1:nc
            NC(:,kk)= lfpSig(1+e_samples*(kk-1):e_samples*kk);
        end
        %Find if epoch is REM (state=1)
        vec_bin=sleepstate;
        vec_bin(vec_bin~=1)=0;
        vec_bin(vec_bin==1)=1;
        %Cluster one values:
        v2=ConsecutiveOnes(vec_bin);
        v_index=find(v2~=0);
        v_values=v2(v2~=0);
        %Extract REM epochs
        for epoch_count=1:length(v_index)-1
            sig_bout{epoch_count,1}=reshape(lfpSig(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1) ), [], 1);
        end

        % doing the power spectrum


        [Gpfc,F2]   = cellfun(@(x) pwelch(detrend(x),winsize,overlap,nfft,srate),sig_bout,'UniformOutput',false);
        for qq=1:size(Gpfc,1)
            hnd=cell2mat(Gpfc(qq));
            SpectrumAllCBDHPC   =  [SpectrumAllCBDHPC; 20*log10(hnd')] ;
        end
         clear sig_bout

    end
end


%%
meanCBD = mean(SpectrumAllCBDPFC,1);
semCBD = nanstd(SpectrumAllCBDPFC,1) / sqrt(size(SpectrumAllCBDPFC,1));
meanHPCCBD = mean(SpectrumAllCBDHPC,1);
semHPCCBD = nanstd(SpectrumAllCBDHPC,1) / sqrt(size(SpectrumAllCBDHPC,1));

meanControl = mean(SpectrumAllControlPFC,1);
semControl = nanstd(SpectrumAllControlPFC,1) / sqrt(size(SpectrumAllControlPFC,1));
meanControlHPC = mean(SpectrumAllControlHPC,1);
semControlHPC = nanstd(SpectrumAllControlHPC,1) / sqrt(size(SpectrumAllControlHPC,1));
F2=F2{1,1};
F2=F2';   

save rem_acutes_workspace.mat -v7.3
%% Plotting
cd('/home/genzellab/Desktop/Pelin/november_periodograms')
figure
boundedline(log10(F2),meanCBD,semCBD,'Color',[12/255 97/255 13/255]);
hold on
boundedline(log10(F2),meanControl,semControl,'k');

axis square
set(gca,'FontSize',10,'LineWidth',1.5,'FontWeight','bold','FontName','Arial')
set(gcf, 'Color','w')
xlabel('Frequency log10')
ylabel('Power log10')
%xlim([-1 101])
xlim([-0.5 2])
ylim([-25 90])
xticklabels({'0.32','1','3.16','10','31.62','100'})
title('PFC - REM')
f=gcf;
set(f,'Units','centimeters')

f.Position(3)=3;
f.Position(4)=3;
f.PaperSize=[3.05 3.05];

ax=gca;
ax.YColor=[0 0 0];
ax.XColor=[0 0 0];
ax.FontSize=8; %8 if figure is too big
ax.FontName='Arial';
print(gcf, '-dpdf', ['acutes_rem_PFC_log10edxy','.pdf']);
close all
%
figure
boundedline(log10(F2),meanCBD,semCBD,'Color',[12/255 97/255 13/255]);
hold on
boundedline(log10(F2),meanControl,semControl,'k');

axis square
set(gca,'FontSize',10,'LineWidth',1.5,'FontWeight','bold','FontName','Arial')
set(gcf, 'Color','w')
xlabel('Frequency (log)')
ylabel('Power (log10)')
xlim([-0.5 2])
%ylim([-30 100])
ylim([-25 90])
xticklabels({'0.32','1','3.16','10','31.62','100'})
title('HPC - REM')
f=gcf;
set(f,'Units','centimeters')

f.Position(3)=3;
f.Position(4)=3;
f.PaperSize=[3.05 3.05];

ax=gca;
ax.YColor=[0 0 0];
ax.XColor=[0 0 0];
ax.FontSize=8; %8 if figure is too big
ax.FontName='Arial';
print(gcf, '-dpdf', ['acutes_rem_HPC_log10edxy','.pdf']);
close all
%%
%
figure
boundedline(F2,meanCBD,semCBD,'Color',[12/255 97/255 13/255]);
hold on
boundedline(F2,meanControl,semControl,'k');

axis square
set(gca,'FontSize',10,'LineWidth',1.5,'FontWeight','bold','FontName','Arial')
set(gcf, 'Color','w')
xlabel('Frequency')
ylabel('Power log10')
xlim([-1 50])
ylim([-5 90])
title('PFC - REM')
f=gcf;
set(f,'Units','centimeters')

f.Position(3)=3;
f.Position(4)=3;
f.PaperSize=[3.05 3.05];

ax=gca;
ax.YColor=[0 0 0];
ax.XColor=[0 0 0];
ax.FontSize=8; %8 if figure is too big
ax.FontName='Arial';
print(gcf, '-dpdf', ['acutes_rem_PFC_nonlog10edx','.pdf']);
close all
%
figure
boundedline(F2,meanCBD,semCBD,'Color',[12/255 97/255 13/255]);
hold on
boundedline(F2,meanControl,semControl,'k');

axis square
set(gca,'FontSize',10,'LineWidth',1.5,'FontWeight','bold','FontName','Arial')
set(gcf, 'Color','w')
xlabel('Frequency')
ylabel('Power log10')
xlim([-1 50])
%ylim([-30 100])
ylim([-5 90])
title('HPC - REM')
f=gcf;
set(f,'Units','centimeters')

f.Position(3)=3;
f.Position(4)=3;
f.PaperSize=[3.05 3.05];

ax=gca;
ax.YColor=[0 0 0];
ax.XColor=[0 0 0];
ax.FontSize=8; %8 if figure is too big
ax.FontName='Arial';
print(gcf, '-dpdf', ['acutes_rem_HPC_nonlog10edx','.pdf']);
close all








%%%%%%%%%%%
%% NREM %%
%%%%%%%%%%%
clc
clear
cd("/home/genzellab/Desktop/Pelin/november_periodograms")
addpath('/home/genzellab/Desktop/Pelin/november_periodograms/github_repo');
addpath('/home/genzellab/Desktop/Pelin/ADRITOOLS');


% parameters for the analysis
srate           = 600;
winsize         = 1*srate;                      % Equivalent to 1s
overlap         = 0.8*winsize;                  % Equivalent to 80% of the window
nfft            = 2^nextpow2(winsize);
fn=srate;

%%
rats_veh=[3, 4, 9, 201, 203, 206, 210, 211, 213];
rats_cbd=[2, 5, 10, 11, 204, 205, 207, 209, 212, 214];
rats=[rats_veh,rats_cbd];
rats=sort(rats);

SpectrumAllControlPFC   = [];
SpectrumAllControlHPC   = [];
SpectrumAllCBDPFC   = [];
SpectrumAllCBDHPC   = [];
for i=1:size(rats,2) % loop through all rats
    i
    rat=rats(1,i);
    if any(rats_veh == rat) % vehicle

        %% PFCshal
        load('processed_PFCshal_v2.mat');

        lfpSig              = signals_v2(i,:);
        lfpSig=lfpSig(signals_indexes(i,1):signals_indexes(i,2));
        sleepstate          = sleep_states(i,:);
        sleepstate=sleepstate(signals_indexes(i,1):signals_indexes(i,2));

        %Rearrange signal in 10 sec epochs.
        e_t=10;
        e_samples=e_t*(fn); %fs=600 Hz
        ch=length(lfpSig);
        nc=floor(ch/e_samples); %Number of epochsw
        NC=[];
        for kk=1:nc
            NC(:,kk)= lfpSig(1+e_samples*(kk-1):e_samples*kk);
        end
        %Find if epoch is nrem (state=1)
        vec_bin=sleepstate;
        vec_bin(vec_bin~=2)=0;
        vec_bin(vec_bin==2)=1;
        %Cluster one values:
        v2=ConsecutiveOnes(vec_bin);
        v_index=find(v2~=0);
        v_values=v2(v2~=0);
        %Extract nrem epochs
        for epoch_count=1:length(v_index)-1
            sig_bout{epoch_count,1}=reshape(lfpSig(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1) ), [], 1);
        end
        %         % finding the nrem indices
        %         % extract the epochs of the nrem sleep
        %         %[sigPFC] = extract_nrem_epochs_acutes(sleepstate, lfpSig,srate);
        %         nremsleepIdx = find(sleepstate == 1);
        %
        %         x=find(diff(nremsleepIdx) ~= 1) + 1;
        %         bouts_no=length(x)+1;
        %         bouts_idx=[1 x length(nremsleepIdx)-1];
        %         %nremsleepIdx = size(stateMat,2);
        %
        %         sig_bout={ };
        %         sig_hnd=[  ] ;
        %         for b = 1:bouts_no
        %             b
        %             for  ii=bouts_idx(b):bouts_idx(b+1)
        %                 if nremsleepIdx(ii+1) - nremsleepIdx(ii) == 1
        %                     sigh = lfpSig(nremsleepIdx(ii):nremsleepIdx(ii+1));
        %
        %                     sig_hnd= [sig_hnd sigh];
        %                 else
        %                     continue
        %                 end
        %             end
        %             sig_bout=[sig_bout; sig_hnd];
        %         end

        % doing the power spectrum


        [Gpfc,F2]   = cellfun(@(x) pwelch(detrend(x),winsize,overlap,nfft,srate),sig_bout,'UniformOutput',false);
        for qq=1:size(Gpfc,1)
            hnd=cell2mat(Gpfc(qq));
            SpectrumAllControlPFC   =  [SpectrumAllControlPFC; 20*log10(hnd')] ;
        end
        clear sig_bout

        %% HPCpyra

        load('processed_HPCpyra_v2.mat');

        lfpSig              = signals_v2(i,:);
        lfpSig=lfpSig(signals_indexes(i,1):signals_indexes(i,2));
        sleepstate          = sleep_states(i,:);
        sleepstate=sleepstate(signals_indexes(i,1):signals_indexes(i,2));

        %Rearrange signal in 10 sec epochs.
        e_t=10;
        e_samples=e_t*(fn); %fs=600 Hz
        ch=length(lfpSig);
        nc=floor(ch/e_samples); %Number of epochsw
        NC=[];
        for kk=1:nc
            NC(:,kk)= lfpSig(1+e_samples*(kk-1):e_samples*kk);
        end
        %Find if epoch is nrem (state=1)
        vec_bin=sleepstate;
        vec_bin(vec_bin~=2)=0;
        vec_bin(vec_bin==2)=1;
        %Cluster one values:
        v2=ConsecutiveOnes(vec_bin);
        v_index=find(v2~=0);
        v_values=v2(v2~=0);
        %Extract nrem epochs
        for epoch_count=1:length(v_index)-1
            sig_bout{epoch_count,1}=reshape(lfpSig(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1) ), [], 1);
        end


        % doing the power spectrum


        [Gpfc,F2]   = cellfun(@(x) pwelch(detrend(x),winsize,overlap,nfft,srate),sig_bout,'UniformOutput',false);
        for qq=1:size(Gpfc,1)
            hnd=cell2mat(Gpfc(qq));
            SpectrumAllControlHPC   =  [SpectrumAllControlHPC; 20*log10(hnd')] ;
        end
         clear sig_bout

    elseif any(rats_cbd == rat) % CBD


        %% PFCshal
        load('processed_PFCshal_v2.mat');

        lfpSig              = signals_v2(i,:);
        lfpSig=lfpSig(signals_indexes(i,1):signals_indexes(i,2));
        sleepstate          = sleep_states(i,:);
        sleepstate=sleepstate(signals_indexes(i,1):signals_indexes(i,2));

        %Rearrange signal in 10 sec epochs.
        e_t=10;
        e_samples=e_t*(fn); %fs=600 Hz
        ch=length(lfpSig);
        nc=floor(ch/e_samples); %Number of epochsw
        NC=[];
        for kk=1:nc
            NC(:,kk)= lfpSig(1+e_samples*(kk-1):e_samples*kk);
        end
        %Find if epoch is nrem (state=1)
        vec_bin=sleepstate;
        vec_bin(vec_bin~=2)=0;
        vec_bin(vec_bin==2)=1;
        %Cluster one values:
        v2=ConsecutiveOnes(vec_bin);
        v_index=find(v2~=0);
        v_values=v2(v2~=0);
        %Extract nrem epochs
        for epoch_count=1:length(v_index)-1
            sig_bout{epoch_count,1}=reshape(lfpSig(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1) ), [], 1);
        end


        % doing the power spectrum


        [Gpfc,F2]   = cellfun(@(x) pwelch(detrend(x),winsize,overlap,nfft,srate),sig_bout,'UniformOutput',false);
        for qq=1:size(Gpfc,1)
            hnd=cell2mat(Gpfc(qq));
            SpectrumAllCBDPFC   =  [SpectrumAllCBDPFC; 20*log10(hnd')] ;
        end
         clear sig_bout

        %% HPCpyra

        load('processed_HPCpyra_v2.mat');

        lfpSig              = signals_v2(i,:);
        lfpSig=lfpSig(signals_indexes(i,1):signals_indexes(i,2));
        sleepstate          = sleep_states(i,:);
        sleepstate=sleepstate(signals_indexes(i,1):signals_indexes(i,2));

        %Rearrange signal in 10 sec epochs.
        e_t=10;
        e_samples=e_t*(fn); %fs=600 Hz
        ch=length(lfpSig);
        nc=floor(ch/e_samples); %Number of epochsw
        NC=[];
        for kk=1:nc
            NC(:,kk)= lfpSig(1+e_samples*(kk-1):e_samples*kk);
        end
        %Find if epoch is nrem (state=1)
        vec_bin=sleepstate;
        vec_bin(vec_bin~=2)=0;
        vec_bin(vec_bin==2)=1;
        %Cluster one values:
        v2=ConsecutiveOnes(vec_bin);
        v_index=find(v2~=0);
        v_values=v2(v2~=0);
        %Extract nrem epochs
        for epoch_count=1:length(v_index)-1
            sig_bout{epoch_count,1}=reshape(lfpSig(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1) ), [], 1);
        end

        % doing the power spectrum


        [Gpfc,F2]   = cellfun(@(x) pwelch(detrend(x),winsize,overlap,nfft,srate),sig_bout,'UniformOutput',false);
        for qq=1:size(Gpfc,1)
            hnd=cell2mat(Gpfc(qq));
            SpectrumAllCBDHPC   =  [SpectrumAllCBDHPC; 20*log10(hnd')] ;
        end
         clear sig_bout

    end
end


%%
meanCBD = mean(SpectrumAllCBDPFC,1);
semCBD = nanstd(SpectrumAllCBDPFC,1) / sqrt(size(SpectrumAllCBDPFC,1));
meanHPCCBD = mean(SpectrumAllCBDHPC,1);
semHPCCBD = nanstd(SpectrumAllCBDHPC,1) / sqrt(size(SpectrumAllCBDHPC,1));

meanControl = mean(SpectrumAllControlPFC,1);
semControl = nanstd(SpectrumAllControlPFC,1) / sqrt(size(SpectrumAllControlPFC,1));
meanControlHPC = mean(SpectrumAllControlHPC,1);
semControlHPC = nanstd(SpectrumAllControlHPC,1) / sqrt(size(SpectrumAllControlHPC,1));
F2=F2{1,1};
F2=F2';   

save nrem_acutes_workspace.mat -v7.3

%% Plotting
cd('/home/genzellab/Desktop/Pelin/november_periodograms')
%
figure
boundedline(log10(F2),meanCBD,semCBD,'Color',[12/255 97/255 13/255]);
hold on
boundedline(log10(F2),meanControl,semControl,'k');

axis square
set(gca,'FontSize',10,'LineWidth',1.5,'FontWeight','bold','FontName','Arial')
set(gcf, 'Color','w')
xlabel('Frequency log10')
ylabel('Power log10')
%xlim([-1 101])
xlim([-0.5 2])
ylim([-25 90])
xticklabels({'0.32','1','3.16','10','31.62','100'})
title('PFC - NREM')
f=gcf;
set(f,'Units','centimeters')

f.Position(3)=3;
f.Position(4)=3;
f.PaperSize=[3.05 3.05];

ax=gca;
ax.YColor=[0 0 0];
ax.XColor=[0 0 0];
ax.FontSize=8; %8 if figure is too big
ax.FontName='Arial';
print(gcf, '-dpdf', ['acutes_nrem_PFC_log10edxy','.pdf']);
close all
%
figure
boundedline(log10(F2),meanCBD,semCBD,'Color',[12/255 97/255 13/255]);
hold on
boundedline(log10(F2),meanControl,semControl,'k');

axis square
set(gca,'FontSize',10,'LineWidth',1.5,'FontWeight','bold','FontName','Arial')
set(gcf, 'Color','w')
xlabel('Frequency (log)')
ylabel('Power (log10)')
xlim([-0.5 2])
%ylim([-30 100])
ylim([-25 90])
xticklabels({'0.32','1','3.16','10','31.62','100'})
title('HPC - NREM')
f=gcf;
set(f,'Units','centimeters')

f.Position(3)=3;
f.Position(4)=3;
f.PaperSize=[3.05 3.05];

ax=gca;
ax.YColor=[0 0 0];
ax.XColor=[0 0 0];
ax.FontSize=8; %8 if figure is too big
ax.FontName='Arial';
print(gcf, '-dpdf', ['acutes_nrem_HPC_log10edxy','.pdf']);
close all
%%
%
figure
boundedline(F2,meanCBD,semCBD,'Color',[12/255 97/255 13/255]);
hold on
boundedline(F2,meanControl,semControl,'k');

axis square
set(gca,'FontSize',10,'LineWidth',1.5,'FontWeight','bold','FontName','Arial')
set(gcf, 'Color','w')
xlabel('Frequency')
ylabel('Power log10')
xlim([-1 50])
ylim([-5 90])
title('PFC - NREM')
f=gcf;
set(f,'Units','centimeters')

f.Position(3)=3;
f.Position(4)=3;
f.PaperSize=[3.05 3.05];

ax=gca;
ax.YColor=[0 0 0];
ax.XColor=[0 0 0];
ax.FontSize=8; %8 if figure is too big
ax.FontName='Arial';
print(gcf, '-dpdf', ['acutes_nrem_PFC_nonlog10edx','.pdf']);
close all
%
figure
boundedline(F2,meanCBD,semCBD,'Color',[12/255 97/255 13/255]);
hold on
boundedline(F2,meanControl,semControl,'k');

axis square
set(gca,'FontSize',10,'LineWidth',1.5,'FontWeight','bold','FontName','Arial')
set(gcf, 'Color','w')
xlabel('Frequency')
ylabel('Power log10')
xlim([-1 50])
%ylim([-30 100])
ylim([-5 90])
title('HPC - NREM')
f=gcf;
set(f,'Units','centimeters')

f.Position(3)=3;
f.Position(4)=3;
f.PaperSize=[3.05 3.05];

ax=gca;
ax.YColor=[0 0 0];
ax.XColor=[0 0 0];
ax.FontSize=8; %8 if figure is too big
ax.FontName='Arial';
print(gcf, '-dpdf', ['acutes_nrem_HPC_nonlog10edx','.pdf']);
close all




















