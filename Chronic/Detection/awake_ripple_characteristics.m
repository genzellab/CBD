clearvars
clc
close all

%cd('/media/genzel/genzel1/CBD_wake/4_CBD')
% cd('/media/genzel/genzel1/CBD_wake/4_VEH')
% cd('/media/genzel/genzel1/CBD_wake/5_VEH')
% cd('/media/genzel/genzel1/CBD_wake/6_VEH')
cd('/media/genzel/genzel1/CBD_wake/6_CBD')

fn=30000; % sampling rate. 
TotalCharacteristicsHC= [];
TotalCharacteristicsOD= [];
TotalCharacteristicsOR= [];
[Conditions,path]=uigetfile('ripple_waveforms_broadband*.mat','MultiSelect','on');
%%

for m=1:5 %5 trials

    clear Ripples_OR_NN_S Ripples_OR_N_S Ripples_HC Ripples_CN Ripples_OR_N Ripples_OD Ripples_OR
    clear Ripples_OR_NN_S_total Ripples_OR_N_S_total Ripples_HC_total Ripples_CN_total Ripples_OR_N_total Ripples_OD_total Ripples_OR_total


HC=Conditions(find(contains(Conditions,'HC')))
if ~isempty(HC)
FileHC=fullfile(path,HC{1,1})
ripple_waveform_broadband_total_HC=load(FileHC);
Ripples_HC_total=ripple_waveform_broadband_total_HC.ripple_waveform_broadband_total;
Ripples_HC = Ripples_HC_total{1, m}';
else
    Ripples_HC={};
end


OD=Conditions(find(contains(Conditions,'OD'))) 
if ~isempty(OD) 
%     if contains(OD,'r') & size(Conditions,1)==1
%         OD={Conditions};
%     end
FileOD=fullfile(path,OD{1,1})
ripple_waveform_broadband_total_OD=load(FileOD);
Ripples_OD_total=ripple_waveform_broadband_total_OD.ripple_waveform_broadband_total;
Ripples_OD = Ripples_OD_total{1, m}';
else
   Ripples_OD={};
end

OR=Conditions(find(contains(Conditions,'OR')))

if ~isempty(OR)
FileOR=fullfile(path,OR{1,end})
ripple_waveform_broadband_total_OR=load(FileOR);
Ripples_OR_total=ripple_waveform_broadband_total_OR.ripple_waveform_broadband_total;
Ripples_OR = Ripples_OR_total{1, m}';
else
    Ripples_OR={};
end

if ~iscell(Ripples_HC)
    if isnan(Ripples_HC)
        Ripples_HC={};
    elseif isempty(Ripples_HC)
        Ripples_HC={};
    end
end
if ~iscell(Ripples_OR)
     if isnan(Ripples_OR)
        Ripples_OR={};
     elseif isempty(Ripples_OR)
        Ripples_OR={};
     end
end
if ~iscell(Ripples_OD)
     if isnan(Ripples_OD)
        Ripples_OD={};   
     elseif isempty(Ripples_OD)
         Ripples_OD={};
     end
end

si_index = cellfun(@(equis) sum(isnan(equis)), Ripples_HC,'UniformOutput',false);
si_index= cell2mat(si_index);
si_index = ~logical(si_index);
Ripples_HC= Ripples_HC(si_index);

si_index = cellfun(@(equis) sum(isnan(equis)), Ripples_OR,'UniformOutput',false);
si_index = cell2mat(si_index);
si_index = ~logical(si_index);
Ripples_OR = Ripples_OR(si_index); 

si_index = cellfun(@(equis) sum(isnan(equis)), Ripples_OD,'UniformOutput',false);
si_index= cell2mat(si_index);
si_index = ~logical(si_index);
Ripples_OD= Ripples_OD(si_index);

% Entropy
x_or = cellfun(@(equis) entropy(equis),Ripples_OR,'UniformOutput',false);
x_or = vertcat(x_or{:});
x_hc = cellfun(@(equis) entropy(equis),Ripples_HC,'UniformOutput',false);
x_hc = vertcat(x_hc{:});
x_od = cellfun(@(equis) entropy(equis),Ripples_OD,'UniformOutput',false);
x_od = vertcat(x_od{:});

% Mean Freqs
y_or = cellfun(@(equis) (meanfreq(equis,fn)),Ripples_OR,'UniformOutput',false);
y_or = vertcat(y_or{:});
y_hc = cellfun(@(equis) (meanfreq(equis,fn)),Ripples_HC,'UniformOutput',false);
y_hc = vertcat(y_hc{:});
y_od = cellfun(@(equis) (meanfreq(equis,fn)),Ripples_OD,'UniformOutput',false);
y_od = vertcat(y_od{:});

% Amplitude
z_or = cellfun(@(equis) max(abs(hilbert(equis))) ,Ripples_OR,'UniformOutput',false);
z_or = vertcat(z_or{:});
z_hc = cellfun(@(equis) max(abs(hilbert(equis))),Ripples_HC,'UniformOutput',false);
z_hc = vertcat(z_hc{:});
z_od = cellfun(@(equis) max(abs(hilbert(equis))) ,Ripples_OD,'UniformOutput',false);
z_od = vertcat(z_od{:});

% Area under curve
l_or = cell2mat(cellfun(@(equis) trapz((1:length(equis))./fn,abs(equis)), Ripples_OR,'UniformOutput',false));
l_hc = cell2mat(cellfun(@(equis) trapz((1:length(equis))./fn,abs(equis)), Ripples_HC,'UniformOutput',false));
l_od = cell2mat(cellfun(@(equis) trapz((1:length(equis))./fn,abs(equis)), Ripples_OD,'UniformOutput',false));

% Duration
q_or =(cellfun('length',Ripples_OR)/fn);
q_hc = (cellfun('length',Ripples_HC)/fn);
q_od =(cellfun('length',Ripples_OD)/fn);

% PeaktoPeak Amplitude
p_or = cellfun(@peak2peak,Ripples_OR);
p_hc = cellfun(@peak2peak,Ripples_HC);
p_od = cellfun(@peak2peak,Ripples_OD);

% Combination of characteristics 
try
l_hc = l_hc';
l_od = l_od';
l_or = l_or';

q_hc = q_hc';
q_od = q_od';
q_or = q_or';

p_hc = p_hc';
p_od = p_od';
p_or = p_or';

totalCharacteristicsHC= [zeros(size(x_hc))+m x_hc y_hc z_hc l_hc q_hc p_hc];
totalCharacteristicsOD= [zeros(size(x_od))+m x_od y_od z_od l_od q_od p_od];
totalCharacteristicsOR= [zeros(size(x_or))+m x_or y_or z_or l_or q_or p_or];

catch 
totalCharacteristicsHC= [zeros(size(x_hc))+m x_hc y_hc z_hc l_hc q_hc p_hc];
totalCharacteristicsOD= [zeros(size(x_od))+m x_od y_od z_od l_od q_od p_od];
totalCharacteristicsOR= [zeros(size(x_or))+m x_or y_or z_or l_or q_or p_or];

end

TotalCharacteristicsHC= [TotalCharacteristicsHC ; totalCharacteristicsHC];
TotalCharacteristicsOD= [TotalCharacteristicsOD; totalCharacteristicsOD];
TotalCharacteristicsOR= [TotalCharacteristicsOR; totalCharacteristicsOR];

end

TotalCharacteristicsHC= table(TotalCharacteristicsHC);
TotalCharacteristicsOD= table(TotalCharacteristicsOD);
TotalCharacteristicsOR= table(TotalCharacteristicsOR);

filename = 'characteristics_sheet.xlsx';
writetable(TotalCharacteristicsHC,filename,'Sheet','HC','Range','A1:H100000','WriteVariableNames',false)
writetable(TotalCharacteristicsOD,filename,'Sheet','OD','Range','A1:H100000','WriteVariableNames',false)
writetable(TotalCharacteristicsOR,filename,'Sheet','OR','Range','A1:H100000','WriteVariableNames',false)
