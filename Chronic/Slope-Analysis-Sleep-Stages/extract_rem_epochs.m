function [sigHPC, sigPFC] = extract_rem_epochs(stateMat, lfpHPC,lfpPFC,Fs)
% The aim of this function is to extract the REM epochs from the lfp of the
% HPC and the PFC for further analysis
% Input
% stateMat --> matrix of the sleep states
% lfpHPC --> HPC lfp
% lfpPFC --> PFC lfp
% Fs --> the sampling frequency
REMsleepIdx = find(stateMat == 5);
sigHPC = [];
sigPFC = [];
for ii = 1: numel(REMsleepIdx) -1
    if REMsleepIdx(ii+1) - REMsleepIdx(ii) == 1
        sig1 = lfpHPC(REMsleepIdx(ii)*Fs:REMsleepIdx(ii+1)*Fs);
        sigHPC = [sigHPC sig1];
        sig2 = lfpPFC(REMsleepIdx(ii)*Fs:REMsleepIdx(ii+1)*Fs);
        sigPFC = [sigPFC sig2];
    else
        continue
    end
end
end