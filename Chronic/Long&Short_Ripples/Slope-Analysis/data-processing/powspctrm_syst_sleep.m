% The aim of this script is to examine the coherence between HPC and PFC
% during the REM states as part of rgs14 project 

clear all; close all; clc

% parameters for the analysis 
srate           = 1000; 
winsize         = 1*srate;                      % Equivalent to 1s
overlap         = 0.8*winsize;                      % Equivalent to 50% of the window
nfft            = 2^nextpow2(winsize);

% 1. choose the folder to be analyzed 
selpath = uigetdir;
cd(selpath)

% 2. get all the folders within this foler
files = dir(selpath);
SubfolderNmaes = {files(3:end).name};
k = 1;
i = 1;


% 3. Looping through the trials of each rat 
for iSubfolder = 1:numel(SubfolderNmaes)
    cd(selpath)
    TrialsFolder = dir(SubfolderNmaes{iSubfolder});
    indxRat = strfind(SubfolderNmaes{iSubfolder},'_');
    RatName = SubfolderNmaes{iSubfolder}(indxRat(3)+1:indxRat(4)-1);
    cd(SubfolderNmaes{iSubfolder}) 
    TrialNames = {TrialsFolder(3:end).name};
  
    for iTrial = 1:numel(TrialNames)
        filesTrial = dir(TrialNames{iTrial});
        filesTrialName = {filesTrial(3:end).name};
        cd(TrialNames{iTrial})
        % up load the pfc data
        h3          = contains(filesTrialName,'-states');
        h           = contains(filesTrialName,'PFC_100');
        h2          = contains(filesTrialName,'HPC_100');
        matSleep    = load(char(filesTrialName(h3)));
        sleepStates = matSleep.states; 
        dataPFC     = load(char(filesTrialName(h)));
        dataHPC     = load(char(filesTrialName(h2)));
        lfp         = dataPFC.PFC';
        lfp2        = dataHPC.HPC';
        [sigHPC, sigPFC] = extract_rem_epochs_rgs14(sleepStates, lfp2,lfp,srate);
        if ~isempty(sigHPC)
        [Cxy,F]     = mscohere(sigPFC,sigHPC,winsize,overlap,nfft,srate);
        [Gxy,F2]    = cpsd(sigPFC,sigHPC,winsize,overlap,nfft,srate);
        Gxy         = Gxy .* conj(Gxy);
        [Gpfc,F2]   = pwelch(detrend(sigPFC),winsize,overlap,nfft,srate);
        [Ghpc,F2]   = pwelch(detrend(sigHPC),winsize,overlap,nfft,srate);
        Gpfc = 20*log10(Gpfc);
        Ghpc = 20*log10(Ghpc);
        Ghcpfc = 20*log10(Gxy);

        if contains(RatName,'Rat3') || contains(RatName,'Rat4')||...
                contains(RatName,'Rat7')|| contains(RatName,'Rat8')
            SpectrumAllRGSPFC(k,:) = Gpfc;
            SpectrumAllRGSHPC(k,:) = Ghpc;
            CoherenceAllRGS(k,:)    = Cxy;
            CrossSpecAllRGS(k,:)    = Ghcpfc;
            AnimalName{k,1} = RatName;
            TiranNum{k,1} = TrialNames{iTrial}(end-5:end);
            Cond{k,1} = 'RGS14';
            k = k + 1;
        end
        
        if contains(RatName,'Rat1') || contains(RatName,'Rat2')||...
                contains(RatName,'Rat6')|| contains(RatName,'Rat9')
            SpectrumAllControlPFC(i,:) = Gpfc;
            SpectrumAllControlHPC(i,:) = Ghpc;
            CoherenceAllControl(i,:)    = Cxy;
             CrossSpecAllControl(i,:)    = Ghcpfc;
             AnimalNameCtrl{i,1} = RatName;
            TiranNumCtrl{i,1} = TrialNames{iTrial}(end-5:end);
            CondCtrl{i,1} = 'Control';
            i = i + 1;
        end
        
        

        end
        cd(selpath)
        cd(SubfolderNmaes{iSubfolder}) 
    end
end
disp('Finished')

%% 
meanRGS14 = mean(SpectrumAllRGSPFC,1);
semRGS14 = nanstd(SpectrumAllRGSPFC,1) / sqrt(size(SpectrumAllRGSPFC,1));
meanHPCRGS14 = mean(SpectrumAllRGSHPC,1);
semHPCRGS14 = nanstd(SpectrumAllRGSHPC,1) / sqrt(size(SpectrumAllRGSHPC,1));

meanControl = mean(SpectrumAllControlPFC,1);
semControl = nanstd(SpectrumAllControlPFC,1) / sqrt(size(SpectrumAllControlPFC,1));
meanControlHPC = mean(SpectrumAllControlHPC,1);
semControlHPC = nanstd(SpectrumAllControlHPC,1) / sqrt(size(SpectrumAllControlHPC,1));

meanRGS14CSPD = mean(CrossSpecAllRGS,1);
semRGS14CSPD = nanstd(CrossSpecAllRGS,1) / sqrt(size(CrossSpecAllRGS,1));
meanCtrlCSPD = mean(CrossSpecAllControl,1);
semCtrlCSPD = nanstd(CrossSpecAllControl,1) / sqrt(size(CrossSpecAllControl,1));

meanCohRGs= mean(CoherenceAllRGS,1);
semCohRGS = nanstd(CoherenceAllRGS,1) / sqrt(size(CoherenceAllRGS,1));
meanCohCtrl = mean(CoherenceAllControl,1);
semCohCtrl = nanstd(CoherenceAllControl,1) / sqrt(size(CoherenceAllControl,1));
figName1 = 'stable_spect_coherence_REM';

figure
subplot(2,2,1)
boundedline(F2,meanRGS14,semRGS14,...
    'k',F2,meanControl,semControl,'c')
axis square
legend('','','RGS14','Control','Location','best')
legend boxoff
set(gca,'FontSize',10,'LineWidth',1.5,'FontWeight','bold','FontName','Times')
set(gcf, 'Color','w')
xlabel('Frequency')
ylabel('Power dB')
xlim([0 50])
title('PFC')

subplot(2,2,2)
boundedline(F2,meanHPCRGS14,semHPCRGS14,...
    'k',F2,meanControlHPC,semControlHPC,'c')
axis square
legend('','','RGS14','Control','Location','best')
legend boxoff
set(gca,'FontSize',10,'LineWidth',1.5,'FontWeight','bold','FontName','Times')
set(gcf, 'Color','w')
xlabel('Frequency')
ylabel('Power dB')
xlim([0 50])
title('HPC')

subplot(2,2,3) 
boundedline(F2,meanRGS14CSPD,semRGS14CSPD,...
    'k',F2,meanCtrlCSPD,semCtrlCSPD,'c')
axis square
legend('','','RGS14','Control','Location','best')
legend boxoff
set(gca,'FontSize',10,'LineWidth',1.5,'FontWeight','bold','FontName','Times')
set(gcf, 'Color','w')
xlabel('Frequency')
ylabel('CSPD [dB]')
xlim([0 50])
title('CSPD HPC-PFC')


subplot(2,2,4)
boundedline(F,meanCohRGs,semCohRGS,...
    'k',F,meanCohCtrl,semCohCtrl,'c')
axis square
legend('','','RGS14','Control','Location','best')
legend boxoff
set(gca,'FontSize',10,'LineWidth',1.5,'FontWeight','bold','FontName','Times')
set(gcf, 'Color','w')
xlabel('Frequency')
ylabel('Coherence')
xlim([0 50])
title('Coherence HPC-PFC')
suptitle(figName1)

% export_fig(figName1,'-pdf','-r300','-q70','-transparent')
print(gcf, '-dpdf', [figName1,'.pdf']);
