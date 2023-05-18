
%% Chronics - HPC & PFC

%%%%%%%%%
%% REM %%
%%%%%%%%%
clc
clear
addpath('C:\Users\students\Desktop\Pelin\november_periodograms');
addpath('C:\Users\students\Desktop\Pelin\november_periodograms\github_repo');
cd('F:\OSF\chronic\UMAP - All study days')

% parameters for the analysis
srate           = 2500;
winsize         = 1*srate;                      % Equivalent to 1 s
overlap         = 0.8*winsize;                      % Equivalent to 50% of the window
nfft            = 2^nextpow2(winsize);

% 1. choose the folder to be analyzed
selpath = uigetdir; % UMAP all study days
cd(selpath)

% 2. get all the folders within this foler
files = dir(selpath);
SubfolderNames = [4 5 6 ]; % rat 4,5,6
k = 1;
i = 1;

rat4_SDs=[162,163,164,165,167,168]; % SD: 1,2,3,4,6,7
rat5_SDs=[166:1:171]; % SD: 1,2,3,4,5,6
rat6_SDs=[133:1:138]; % SD: 1,2,3,4,5,6


% 3. Looping through rats
for iSubfolder = SubfolderNames
    cd(num2str(iSubfolder))
    
    SDsFolder = dir(pwd);
    
    if iSubfolder==4
        rat_handler=rat4_SDs;
    elseif iSubfolder==5
        rat_handler=rat5_SDs;
    elseif iSubfolder==6
        rat_handler=rat6_SDs;
    end
    
    if iSubfolder==4 || iSubfolder==5
        for sd=rat_handler
            cd(SDsFolder(sd).name)
            TrialNames = dir(pwd); TrialNames=TrialNames(3:8);
            
            % loop through trials
            for iTrial = 1:numel(TrialNames)
                filesTrial = dir(TrialNames(iTrial).name);
                filesTrialName = {filesTrial(3:end).name};
                
                cd(TrialNames(iTrial).name)
                
                % load the pfc data
                h3          = contains(filesTrialName,'-states');
                h           = contains(filesTrialName,'PFC_100');
                h2          = contains(filesTrialName,'HPC_100');
                matSleep    = load(char(filesTrialName(h3)));
                sleepStates = matSleep.states;
                dataPFC     = load(char(filesTrialName(h)));
                dataHPC     = load(char(filesTrialName(h2)));
                lfp         = dataPFC.PFC';
                lfp2        = dataHPC.HPC';
                [sigHPC, sigPFC] = extract_rem_epochs(sleepStates, lfp2,lfp,srate);
                if ~isempty(sigHPC)
                    [Cxy,F]     = mscohere(sigPFC,sigHPC,winsize,overlap,nfft,srate);
                    [Gxy,F2]    = cpsd(sigPFC,sigHPC,winsize,overlap,nfft,srate);
                    Gxy         = Gxy .* conj(Gxy);
                    [Gpfc,F2]   = pwelch(detrend(sigPFC),winsize,overlap,nfft,srate);
                    [Ghpc,F2]   = pwelch(detrend(sigHPC),winsize,overlap,nfft,srate);
                    Gpfc = 20*log10(Gpfc);
                    Ghpc = 20*log10(Ghpc);
                    Ghcpfc = 20*log10(Gxy);
                    
                    %% put if condition for rat
                    if iSubfolder==4
                        if  sd== 163 || sd== 164 || sd== 168
                            SpectrumAllCBDPFC(k,:) = Gpfc;
                            SpectrumAllCBDHPC(k,:) = Ghpc;
                            CoherenceAllCBD(k,:)    = Cxy;
                            CrossSpecAllCBD(k,:)    = Ghcpfc;
                            AnimalName{k,1} = iSubfolder;
                            % TiranNum{k,1} = TrialNames{iTrial}(end-5:end);
                            Cond{k,1} = 'CBD';
                            k = k + 1;
                        end
                        
                        if sd== 162 || sd== 165 || sd== 167
                            SpectrumAllControlPFC(i,:) = Gpfc;
                            SpectrumAllControlHPC(i,:) = Ghpc;
                            CoherenceAllControl(i,:)    = Cxy;
                            CrossSpecAllControl(i,:)    = Ghcpfc;
                            AnimalNameCtrl{i,1} = iSubfolder;
                            % TiranNumCtrl{i,1} = TrialNames{iTrial}(end-5:end);
                            CondCtrl{i,1} = 'Vehicle';
                            i = i + 1;
                        end
                        
                    elseif iSubfolder==5
                        if  sd== 166 || sd== 170 || sd== 171
                            SpectrumAllCBDPFC(k,:) = Gpfc;
                            SpectrumAllCBDHPC(k,:) = Ghpc;
                            CoherenceAllCBD(k,:)    = Cxy;
                            CrossSpecAllCBD(k,:)    = Ghcpfc;
                            AnimalName{k,1} = iSubfolder;
                            % TiranNum{k,1} = TrialNames{iTrial}(end-5:end);
                            Cond{k,1} = 'CBD';
                            k = k + 1;
                        end
                        
                        if sd== 167 || sd== 168 || sd== 169
                            SpectrumAllControlPFC(i,:) = Gpfc;
                            SpectrumAllControlHPC(i,:) = Ghpc;
                            CoherenceAllControl(i,:)    = Cxy;
                            CrossSpecAllControl(i,:)    = Ghcpfc;
                            AnimalNameCtrl{i,1} = iSubfolder;
                            % TiranNumCtrl{i,1} = TrialNames{iTrial}(end-5:end);
                            CondCtrl{i,1} = 'Vehicle';
                            i = i + 1;
                        end
                    elseif iSubfolder==6
                        if  sd== 134 || sd== 135 || sd== 138
                            SpectrumAllCBDPFC(k,:) = Gpfc;
                            SpectrumAllCBDHPC(k,:) = Ghpc;
                            CoherenceAllCBD(k,:)    = Cxy;
                            CrossSpecAllCBD(k,:)    = Ghcpfc;
                            AnimalName{k,1} = iSubfolder;
                            % TiranNum{k,1} = TrialNames{iTrial}(end-5:end);
                            Cond{k,1} = 'CBD';
                            k = k + 1;
                        end
                        
                        if sd== 133 || sd== 136 || sd== 137
                            SpectrumAllControlPFC(i,:) = Gpfc;
                            SpectrumAllControlHPC(i,:) = Ghpc;
                            CoherenceAllControl(i,:)    = Cxy;
                            CrossSpecAllControl(i,:)    = Ghcpfc;
                            AnimalNameCtrl{i,1} = iSubfolder;
                            % TiranNumCtrl{i,1} = TrialNames{iTrial}(end-5:end);
                            CondCtrl{i,1} = 'Vehicle';
                            i = i + 1;
                        end
                    end
                    
                    
                end
                cd ..
                
            end
            cd ..
        end
    elseif iSubfolder==6
        for sd=rat_handler
            cd(SDsFolder(sd).name)
            TrialNames = dir(pwd); TrialNames=TrialNames(3:8);
            
            % loop through trials
            for iTrial = 2:numel(TrialNames)
                filesTrial = dir(TrialNames(iTrial).name);
                filesTrialName = {filesTrial(3:end).name};
                
                cd(TrialNames(iTrial).name)
                
                % load the pfc data
                h3          = contains(filesTrialName,'-states');
                h           = contains(filesTrialName,'PFC_100');
                h2          = contains(filesTrialName,'HPC_100');
                matSleep    = load(char(filesTrialName(h3)));
                sleepStates = matSleep.states;
                dataPFC     = load(char(filesTrialName(h)));
                dataHPC     = load(char(filesTrialName(h2)));
                lfp         = dataPFC.PFC';
                lfp2        = dataHPC.HPC';
                [sigHPC, sigPFC] = extract_rem_epochs(sleepStates, lfp2,lfp,srate);
                if ~isempty(sigHPC)
                    [Cxy,F]     = mscohere(sigPFC,sigHPC,winsize,overlap,nfft,srate);
                    [Gxy,F2]    = cpsd(sigPFC,sigHPC,winsize,overlap,nfft,srate);
                    Gxy         = Gxy .* conj(Gxy);
                    [Gpfc,F2]   = pwelch(detrend(sigPFC),winsize,overlap,nfft,srate);
                    [Ghpc,F2]   = pwelch(detrend(sigHPC),winsize,overlap,nfft,srate);
                    Gpfc = 20*log10(Gpfc);
                    Ghpc = 20*log10(Ghpc);
                    Ghcpfc = 20*log10(Gxy);
                    
                    %% put if condition for rat
                    if iSubfolder==4
                        if  sd== 163 || sd== 164 || sd== 168
                            SpectrumAllCBDPFC(k,:) = Gpfc;
                            SpectrumAllCBDHPC(k,:) = Ghpc;
                            CoherenceAllCBD(k,:)    = Cxy;
                            CrossSpecAllCBD(k,:)    = Ghcpfc;
                            AnimalName{k,1} = iSubfolder;
                            % TiranNum{k,1} = TrialNames{iTrial}(end-5:end);
                            Cond{k,1} = 'CBD';
                            k = k + 1;
                        end
                        
                        if sd== 162 || sd== 165 || sd== 167
                            SpectrumAllControlPFC(i,:) = Gpfc;
                            SpectrumAllControlHPC(i,:) = Ghpc;
                            CoherenceAllControl(i,:)    = Cxy;
                            CrossSpecAllControl(i,:)    = Ghcpfc;
                            AnimalNameCtrl{i,1} = iSubfolder;
                            % TiranNumCtrl{i,1} = TrialNames{iTrial}(end-5:end);
                            CondCtrl{i,1} = 'Vehicle';
                            i = i + 1;
                        end
                        
                    elseif iSubfolder==5
                        if  sd== 166 || sd== 170 || sd== 171
                            SpectrumAllCBDPFC(k,:) = Gpfc;
                            SpectrumAllCBDHPC(k,:) = Ghpc;
                            CoherenceAllCBD(k,:)    = Cxy;
                            CrossSpecAllCBD(k,:)    = Ghcpfc;
                            AnimalName{k,1} = iSubfolder;
                            % TiranNum{k,1} = TrialNames{iTrial}(end-5:end);
                            Cond{k,1} = 'CBD';
                            k = k + 1;
                        end
                        
                        if sd== 167 || sd== 168 || sd== 169
                            SpectrumAllControlPFC(i,:) = Gpfc;
                            SpectrumAllControlHPC(i,:) = Ghpc;
                            CoherenceAllControl(i,:)    = Cxy;
                            CrossSpecAllControl(i,:)    = Ghcpfc;
                            AnimalNameCtrl{i,1} = iSubfolder;
                            % TiranNumCtrl{i,1} = TrialNames{iTrial}(end-5:end);
                            CondCtrl{i,1} = 'Vehicle';
                            i = i + 1;
                        end
                    elseif iSubfolder==6
                        if  sd== 134 || sd== 135 || sd== 138
                            SpectrumAllCBDPFC(k,:) = Gpfc;
                            SpectrumAllCBDHPC(k,:) = Ghpc;
                            CoherenceAllCBD(k,:)    = Cxy;
                            CrossSpecAllCBD(k,:)    = Ghcpfc;
                            AnimalName{k,1} = iSubfolder;
                            % TiranNum{k,1} = TrialNames{iTrial}(end-5:end);
                            Cond{k,1} = 'CBD';
                            k = k + 1;
                        end
                        
                        if sd== 133 || sd== 136 || sd== 137
                            SpectrumAllControlPFC(i,:) = Gpfc;
                            SpectrumAllControlHPC(i,:) = Ghpc;
                            CoherenceAllControl(i,:)    = Cxy;
                            CrossSpecAllControl(i,:)    = Ghcpfc;
                            AnimalNameCtrl{i,1} = iSubfolder;
                            % TiranNumCtrl{i,1} = TrialNames{iTrial}(end-5:end);
                            CondCtrl{i,1} = 'Vehicle';
                            i = i + 1;
                        end
                    end
                    
                    
                end
                cd ..
                
            end
            cd ..
        end
        
    end %sd
    cd(selpath)
end
disp('Finished')

%%
meanCBD = mean(SpectrumAllCBDPFC,1);
semCBD = nanstd(SpectrumAllCBDPFC,1) / sqrt(size(SpectrumAllCBDPFC,1));
meanHPCCBD = mean(SpectrumAllCBDHPC,1);
semHPCCBD = nanstd(SpectrumAllCBDHPC,1) / sqrt(size(SpectrumAllCBDHPC,1));

meanControl = mean(SpectrumAllControlPFC,1);
semControl = nanstd(SpectrumAllControlPFC,1) / sqrt(size(SpectrumAllControlPFC,1));
meanControlHPC = mean(SpectrumAllControlHPC,1);
semControlHPC = nanstd(SpectrumAllControlHPC,1) / sqrt(size(SpectrumAllControlHPC,1));

meanCBDCSPD = mean(CrossSpecAllCBD,1);
semCBDCSPD = nanstd(CrossSpecAllCBD,1) / sqrt(size(CrossSpecAllCBD,1));
meanCtrlCSPD = mean(CrossSpecAllControl,1);
semCtrlCSPD = nanstd(CrossSpecAllControl,1) / sqrt(size(CrossSpecAllControl,1));

meanCohRGs= mean(CoherenceAllCBD,1);
semCohCBD = nanstd(CoherenceAllCBD,1) / sqrt(size(CoherenceAllCBD,1));
meanCohCtrl = mean(CoherenceAllControl,1);
semCohCtrl = nanstd(CoherenceAllControl,1) / sqrt(size(CoherenceAllControl,1));



%% Plotting
cd('C:\Users\students\Desktop\Pelin\november_periodograms')
save rem_chronics_workspace.mat

figure
boundedline(F2,meanCBD,semCBD,'Color',[12/255 97/255 13/255]);
hold on
boundedline(F2,meanControl,semControl,'k');
axis square
set(gca,'FontSize',22,'LineWidth',1.5,'FontWeight','bold','FontName','Arial')
set(gcf, 'Color','w')
%lgd=legend('SEM CBD','SEM Veh','CBD','Vehicle','Location','southwest');
%legend boxoff
%lgd.FontSize = 10;
% %
% lgd=legend('SEM CBD','SEM Veh','CBD','Vehicle','Location','southwest');
% legend boxoff
% lgd.FontName='Arial';
% lgd.FontSize=3;
% set(lgd,'Units','centimeters')
% lgd.Position=([11.2 11.6 0.1 0.2]);
% %
% set(hnd, 'visible', 'off');
% set(gca, 'visible', 'off');
% exportgraphics(gcf,'legend.pdf');

xlabel('Frequency')
ylabel('Power log10')
xlim([-1 100])
%xlim([-0.5 2])
ylim([0 80])
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
print(gcf, '-dpdf', ['chronics_rem_PFC_nonloggedx','.pdf']);
close all

%%
figure
boundedline(F2,meanHPCCBD,semHPCCBD,'Color',[12/255 97/255 13/255]);
hold on
boundedline(F2,meanControlHPC,semControlHPC,'k');
axis square
%legend('','','CBD','Vehicle','Location','southwest')
%legend boxoff
set(gca,'FontSize',22,'LineWidth',1.5,'FontWeight','bold','FontName','Arial')
set(gcf, 'Color','w')
xlabel('Frequency')
ylabel('Power log10')
xlim([-1 100])
ylim([0 80])
title('HPC - REM')
f=gcf;
set(f,'Units','centimeters')

f.Position(3)=3;
f.Position(4)=3;
f.PaperSize=[3.05 3.05];

ax=gca;
ax.YColor=[0 0 0];
ax.XColor=[0 0 0];
ax.FontSize=8; % 8 or 10
ax.FontName='Arial';
print(gcf, '-dpdf', ['chronics_rem_HPC_nonloggedx','.pdf']);
close all







%%%%%%%%%%
%% NREM %%
%%%%%%%%%%
clc
clear
addpath('C:\Users\students\Desktop\Pelin\november_periodograms');
addpath('C:\Users\students\Desktop\Pelin\november_periodograms\github_repo');
cd('F:\OSF\chronic\UMAP - All study days')

% parameters for the analysis
srate           = 2500;
winsize         = 1*srate;                      % Equivalent to 1s
overlap         = 0.8*winsize;                      % Equivalent to 50% of the window
nfft            = 2^nextpow2(winsize);

% 1. choose the folder to be analyzed
selpath = uigetdir; % U-MAp all study days
cd(selpath)

% 2. get all the folders within this foler
files = dir(selpath);
SubfolderNames = [4 5 6 ]; % rat 4,5,6
k = 1;
i = 1;

rat4_SDs=[162,163,164,165,167,168]; % SD: 1,2,3,4,6,7
rat5_SDs=[166:1:171]; % SD: 1,2,3,4,5,6
rat6_SDs=[133:1:138]; % SD: 1,2,3,4,5,6


% 3. Looping through rats
for iSubfolder = SubfolderNames
    cd(num2str(iSubfolder))
    
    SDsFolder = dir(pwd);
    
    if iSubfolder==4
        rat_handler=rat4_SDs;
    elseif iSubfolder==5
        rat_handler=rat5_SDs;
    elseif iSubfolder==6
        rat_handler=rat6_SDs;
    end
    
    if iSubfolder==4 || iSubfolder==5
        for sd=rat_handler
            cd(SDsFolder(sd).name)
            TrialNames = dir(pwd); TrialNames=TrialNames(3:8);
            
            % loop through trials
            for iTrial = 1:numel(TrialNames)
                filesTrial = dir(TrialNames(iTrial).name);
                filesTrialName = {filesTrial(3:end).name};
                
                cd(TrialNames(iTrial).name)
                
                % load the pfc data
                h3          = contains(filesTrialName,'-states');
                h           = contains(filesTrialName,'PFC_100');
                h2          = contains(filesTrialName,'HPC_100');
                matSleep    = load(char(filesTrialName(h3)));
                sleepStates = matSleep.states;
                dataPFC     = load(char(filesTrialName(h)));
                dataHPC     = load(char(filesTrialName(h2)));
                lfp         = dataPFC.PFC';
                lfp2        = dataHPC.HPC';
                [sigHPC, sigPFC] = extract_nrem_epochs(sleepStates, lfp2,lfp,srate);
                if ~isempty(sigHPC)
                    [Cxy,F]     = mscohere(sigPFC,sigHPC,winsize,overlap,nfft,srate);
                    [Gxy,F2]    = cpsd(sigPFC,sigHPC,winsize,overlap,nfft,srate);
                    Gxy         = Gxy .* conj(Gxy);
                    [Gpfc,F2]   = pwelch(detrend(sigPFC),winsize,overlap,nfft,srate);
                    [Ghpc,F2]   = pwelch(detrend(sigHPC),winsize,overlap,nfft,srate);
                    Gpfc = 20*log10(Gpfc);
                    Ghpc = 20*log10(Ghpc);
                    Ghcpfc = 20*log10(Gxy);
                    
                    %% put if condition for rat
                    if iSubfolder==4
                        if  sd== 163 || sd== 164 || sd== 168
                            SpectrumAllCBDPFC(k,:) = Gpfc;
                            SpectrumAllCBDHPC(k,:) = Ghpc;
                            CoherenceAllCBD(k,:)    = Cxy;
                            CrossSpecAllCBD(k,:)    = Ghcpfc;
                            AnimalName{k,1} = iSubfolder;
                            % TiranNum{k,1} = TrialNames{iTrial}(end-5:end);
                            Cond{k,1} = 'CBD';
                            k = k + 1;
                        end
                        
                        if sd== 162 || sd== 165 || sd== 167
                            SpectrumAllControlPFC(i,:) = Gpfc;
                            SpectrumAllControlHPC(i,:) = Ghpc;
                            CoherenceAllControl(i,:)    = Cxy;
                            CrossSpecAllControl(i,:)    = Ghcpfc;
                            AnimalNameCtrl{i,1} = iSubfolder;
                            % TiranNumCtrl{i,1} = TrialNames{iTrial}(end-5:end);
                            CondCtrl{i,1} = 'Vehicle';
                            i = i + 1;
                        end
                        
                    elseif iSubfolder==5
                        if  sd== 166 || sd== 170 || sd== 171
                            SpectrumAllCBDPFC(k,:) = Gpfc;
                            SpectrumAllCBDHPC(k,:) = Ghpc;
                            CoherenceAllCBD(k,:)    = Cxy;
                            CrossSpecAllCBD(k,:)    = Ghcpfc;
                            AnimalName{k,1} = iSubfolder;
                            % TiranNum{k,1} = TrialNames{iTrial}(end-5:end);
                            Cond{k,1} = 'CBD';
                            k = k + 1;
                        end
                        
                        if sd== 167 || sd== 168 || sd== 169
                            SpectrumAllControlPFC(i,:) = Gpfc;
                            SpectrumAllControlHPC(i,:) = Ghpc;
                            CoherenceAllControl(i,:)    = Cxy;
                            CrossSpecAllControl(i,:)    = Ghcpfc;
                            AnimalNameCtrl{i,1} = iSubfolder;
                            % TiranNumCtrl{i,1} = TrialNames{iTrial}(end-5:end);
                            CondCtrl{i,1} = 'Vehicle';
                            i = i + 1;
                        end
                    elseif iSubfolder==6
                        if  sd== 134 || sd== 135 || sd== 138
                            SpectrumAllCBDPFC(k,:) = Gpfc;
                            SpectrumAllCBDHPC(k,:) = Ghpc;
                            CoherenceAllCBD(k,:)    = Cxy;
                            CrossSpecAllCBD(k,:)    = Ghcpfc;
                            AnimalName{k,1} = iSubfolder;
                            % TiranNum{k,1} = TrialNames{iTrial}(end-5:end);
                            Cond{k,1} = 'CBD';
                            k = k + 1;
                        end
                        
                        if sd== 133 || sd== 136 || sd== 137
                            SpectrumAllControlPFC(i,:) = Gpfc;
                            SpectrumAllControlHPC(i,:) = Ghpc;
                            CoherenceAllControl(i,:)    = Cxy;
                            CrossSpecAllControl(i,:)    = Ghcpfc;
                            AnimalNameCtrl{i,1} = iSubfolder;
                            % TiranNumCtrl{i,1} = TrialNames{iTrial}(end-5:end);
                            CondCtrl{i,1} = 'Vehicle';
                            i = i + 1;
                        end
                    end
                    
                    
                end
                cd ..
                
            end
            cd ..
        end
    elseif iSubfolder==6
        for sd=rat_handler
            cd(SDsFolder(sd).name)
            TrialNames = dir(pwd); TrialNames=TrialNames(3:8);
            
            % loop through trials
            for iTrial = 2:numel(TrialNames)
                filesTrial = dir(TrialNames(iTrial).name);
                filesTrialName = {filesTrial(3:end).name};
                
                cd(TrialNames(iTrial).name)
                
                % load the pfc data
                h3          = contains(filesTrialName,'-states');
                h           = contains(filesTrialName,'PFC_100');
                h2          = contains(filesTrialName,'HPC_100');
                matSleep    = load(char(filesTrialName(h3)));
                sleepStates = matSleep.states;
                dataPFC     = load(char(filesTrialName(h)));
                dataHPC     = load(char(filesTrialName(h2)));
                lfp         = dataPFC.PFC';
                lfp2        = dataHPC.HPC';
                [sigHPC, sigPFC] = extract_nrem_epochs(sleepStates, lfp2,lfp,srate);
                if ~isempty(sigHPC)
                    [Cxy,F]     = mscohere(sigPFC,sigHPC,winsize,overlap,nfft,srate);
                    [Gxy,F2]    = cpsd(sigPFC,sigHPC,winsize,overlap,nfft,srate);
                    Gxy         = Gxy .* conj(Gxy);
                    [Gpfc,F2]   = pwelch(detrend(sigPFC),winsize,overlap,nfft,srate);
                    [Ghpc,F2]   = pwelch(detrend(sigHPC),winsize,overlap,nfft,srate);
                    Gpfc = 20*log10(Gpfc);
                    Ghpc = 20*log10(Ghpc);
                    Ghcpfc = 20*log10(Gxy);
                    
                    %% put if condition for rat
                    if iSubfolder==4
                        if  sd== 163 || sd== 164 || sd== 168
                            SpectrumAllCBDPFC(k,:) = Gpfc;
                            SpectrumAllCBDHPC(k,:) = Ghpc;
                            CoherenceAllCBD(k,:)    = Cxy;
                            CrossSpecAllCBD(k,:)    = Ghcpfc;
                            AnimalName{k,1} = iSubfolder;
                            % TiranNum{k,1} = TrialNames{iTrial}(end-5:end);
                            Cond{k,1} = 'CBD';
                            k = k + 1;
                        end
                        
                        if sd== 162 || sd== 165 || sd== 167
                            SpectrumAllControlPFC(i,:) = Gpfc;
                            SpectrumAllControlHPC(i,:) = Ghpc;
                            CoherenceAllControl(i,:)    = Cxy;
                            CrossSpecAllControl(i,:)    = Ghcpfc;
                            AnimalNameCtrl{i,1} = iSubfolder;
                            % TiranNumCtrl{i,1} = TrialNames{iTrial}(end-5:end);
                            CondCtrl{i,1} = 'Vehicle';
                            i = i + 1;
                        end
                        
                    elseif iSubfolder==5
                        if  sd== 166 || sd== 170 || sd== 171
                            SpectrumAllCBDPFC(k,:) = Gpfc;
                            SpectrumAllCBDHPC(k,:) = Ghpc;
                            CoherenceAllCBD(k,:)    = Cxy;
                            CrossSpecAllCBD(k,:)    = Ghcpfc;
                            AnimalName{k,1} = iSubfolder;
                            % TiranNum{k,1} = TrialNames{iTrial}(end-5:end);
                            Cond{k,1} = 'CBD';
                            k = k + 1;
                        end
                        
                        if sd== 167 || sd== 168 || sd== 169
                            SpectrumAllControlPFC(i,:) = Gpfc;
                            SpectrumAllControlHPC(i,:) = Ghpc;
                            CoherenceAllControl(i,:)    = Cxy;
                            CrossSpecAllControl(i,:)    = Ghcpfc;
                            AnimalNameCtrl{i,1} = iSubfolder;
                            % TiranNumCtrl{i,1} = TrialNames{iTrial}(end-5:end);
                            CondCtrl{i,1} = 'Vehicle';
                            i = i + 1;
                        end
                    elseif iSubfolder==6
                        if  sd== 134 || sd== 135 || sd== 138
                            SpectrumAllCBDPFC(k,:) = Gpfc;
                            SpectrumAllCBDHPC(k,:) = Ghpc;
                            CoherenceAllCBD(k,:)    = Cxy;
                            CrossSpecAllCBD(k,:)    = Ghcpfc;
                            AnimalName{k,1} = iSubfolder;
                            % TiranNum{k,1} = TrialNames{iTrial}(end-5:end);
                            Cond{k,1} = 'CBD';
                            k = k + 1;
                        end
                        
                        if sd== 133 || sd== 136 || sd== 137
                            SpectrumAllControlPFC(i,:) = Gpfc;
                            SpectrumAllControlHPC(i,:) = Ghpc;
                            CoherenceAllControl(i,:)    = Cxy;
                            CrossSpecAllControl(i,:)    = Ghcpfc;
                            AnimalNameCtrl{i,1} = iSubfolder;
                            % TiranNumCtrl{i,1} = TrialNames{iTrial}(end-5:end);
                            CondCtrl{i,1} = 'Vehicle';
                            i = i + 1;
                        end
                    end
                    
                    
                end
                cd ..
                
            end
            cd ..
        end
        
    end %sd
    cd(selpath)
end
disp('Finished')

%%
meanCBD = mean(SpectrumAllCBDPFC,1);
semCBD = nanstd(SpectrumAllCBDPFC,1) / sqrt(size(SpectrumAllCBDPFC,1));
meanHPCCBD = mean(SpectrumAllCBDHPC,1);
semHPCCBD = nanstd(SpectrumAllCBDHPC,1) / sqrt(size(SpectrumAllCBDHPC,1));

meanControl = mean(SpectrumAllControlPFC,1);
semControl = nanstd(SpectrumAllControlPFC,1) / sqrt(size(SpectrumAllControlPFC,1));
meanControlHPC = mean(SpectrumAllControlHPC,1);
semControlHPC = nanstd(SpectrumAllControlHPC,1) / sqrt(size(SpectrumAllControlHPC,1));

meanCBDCSPD = mean(CrossSpecAllCBD,1);
semCBDCSPD = nanstd(CrossSpecAllCBD,1) / sqrt(size(CrossSpecAllCBD,1));
meanCtrlCSPD = mean(CrossSpecAllControl,1);
semCtrlCSPD = nanstd(CrossSpecAllControl,1) / sqrt(size(CrossSpecAllControl,1));

meanCohRGs= mean(CoherenceAllCBD,1);
semCohCBD = nanstd(CoherenceAllCBD,1) / sqrt(size(CoherenceAllCBD,1));
meanCohCtrl = mean(CoherenceAllControl,1);
semCohCtrl = nanstd(CoherenceAllControl,1) / sqrt(size(CoherenceAllControl,1));


%% Plotting
cd('C:\Users\students\Desktop\Pelin\november_periodograms')
save nrem_chronics_workspace.mat

figure
boundedline(F2,meanCBD,semCBD,'Color',[12/255 97/255 13/255]);
hold on
boundedline(F2,meanControl,semControl,'k');
axis square
set(gca,'FontSize',22,'LineWidth',1.5,'FontWeight','bold','FontName','Arial')
set(gcf, 'Color','w')
%lgd=legend('SEM CBD','SEM Veh','CBD','Vehicle','Location','southwest');
%legend boxoff
%lgd.FontSize = 10;
% %
% lgd=legend('SEM CBD','SEM Veh','CBD','Vehicle','Location','southwest');
% legend boxoff
% lgd.FontName='Arial';
% lgd.FontSize=3;
% set(lgd,'Units','centimeters')
% lgd.Position=([11.2 11.6 0.1 0.2]);
% %
% set(hnd, 'visible', 'off');
% set(gca, 'visible', 'off');
% exportgraphics(gcf,'legend.pdf');

xlabel('Frequency')
ylabel('Power log10')
xlim([-1 100])
%xlim([-0.5 2])
ylim([0 80])
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
print(gcf, '-dpdf', ['chronics_nrem_PFC_nonloggedx','.pdf']);
close all

%%
figure
boundedline(F2,meanHPCCBD,semHPCCBD,'Color',[12/255 97/255 13/255]);
hold on
boundedline(F2,meanControlHPC,semControlHPC,'k');
axis square
%legend('','','CBD','Vehicle','Location','southwest')
%legend boxoff
set(gca,'FontSize',22,'LineWidth',1.5,'FontWeight','bold','FontName','Arial')
set(gcf, 'Color','w')
xlabel('Frequency')
ylabel('Power log10')
xlim([-1 100])
ylim([0 80])
title('HPC - NREM')
f=gcf;
set(f,'Units','centimeters')

f.Position(3)=3;
f.Position(4)=3;
f.PaperSize=[3.05 3.05];

ax=gca;
ax.YColor=[0 0 0];
ax.XColor=[0 0 0];
ax.FontSize=8; % 8 or 10
ax.FontName='Arial';
print(gcf, '-dpdf', ['chronics_nrem_HPC_nonloggedx','.pdf']);
close all
























