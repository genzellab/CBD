
% event_Veh = delta_waveforms_broadband_chronic_veh;
% event_CBD = delta_waveforms_broadband_chronic_cbd;

% event_Veh = ripple_waveforms_broadband_chronic_veh;
% event_CBD = ripple_waveforms_broadband_chronic_cbd;

event_Veh = spindle_waveforms_broadband_chronic_veh;
event_CBD = spindle_waveforms_broadband_chronic_cbd;

event_Veh_PT14 = event_Veh(:,1:5);
event_Veh_PT14 = {vertcat(event_Veh_PT14{:})};

event_CBD_PT14 = event_CBD(:,1:5);
event_CBD_PT14 = {vertcat(event_CBD_PT14{:})};

event_Veh_PT5 = event_Veh(:,6:9);
event_Veh_PT5 = {vertcat(event_Veh_PT5{:})};

event_CBD_PT5 = event_CBD(:,6:9);
event_CBD_PT5 = {vertcat(event_CBD_PT5{:})};

event_Veh_R = [event_Veh_PT14,event_Veh_PT5];
event_CBD_R = [event_CBD_PT14,event_CBD_PT5];

for j = 1:2
 %% Removing NaNs if any    
    event_v = event_Veh_R{j};
si_index = cellfun(@(equis) sum(isnan(equis)),event_v,'UniformOutput',false);
si_index= cell2mat(si_index);
si_index = ~logical(si_index);
event_v = event_v(si_index);
clear si_index
   event_c = event_CBD_R{j};
si_index = cellfun(@(equis) sum(isnan(equis)), event_c,'UniformOutput',false);
si_index = cell2mat(si_index);
si_index = ~logical(si_index);
event_c = event_c(si_index); 
clear si_index

%% Removing zerors if any 
si_index = cellfun(@(equis) sum(isequal(equis,0)), event_v,'UniformOutput',false);
si_index = find(cell2mat(si_index));
if ~isempty(si_index)
event_v(si_index) = []; 
end
clear si_index

si_index = cellfun(@(equis) sum(isequal(equis,0)), event_c,'UniformOutput',false);
si_index = find(cell2mat(si_index));
if ~isempty(si_index)
event_c(si_index) = []; 
end
clear si_index

%% Ripple filter
% Wn1=[100/(2500/2) 300/(2500/2)]; % Cutoff = 100-300 Hz
% [b1,a1] = butter(3,Wn1,'bandpass'); % Filter coefficients
% event_c = cellfun(@(equis)filtfilt(b1,a1,equis),event_c ,'UniformOutput',false);
% event_v = cellfun(@(equis)filtfilt(b1,a1,equis),event_v ,'UniformOutput',false);

%% Delta filter 
% Wn1 = [1/(2500/2) 6/(2500/2)]; % Cutoff = 1-6 Hz
% [b2,a2] = butter(3,Wn1); % Filter coefficients
% event_c = cellfun(@(equis)filtfilt(b2,a2,equis), event_c,'UniformOutput',false);
% event_v = cellfun(@(equis)filtfilt(b2,a2,equis), event_v,'UniformOutput',false);

%% Spindle filter 
Wn1 = [9/(2500/2) 20/(2500/2)]; % 9-20Hz
[b2,a2] = butter(3,Wn1); %Filter coefficients
event_c = cellfun(@(equis)filtfilt(b2,a2,equis), event_c,'UniformOutput',false);
event_v = cellfun(@(equis)filtfilt(b2,a2,equis), event_v,'UniformOutput',false);

%% Entropy (entp)
% x_veh = cellfun(@(equis) mean(instfreq(equis,1000)),event_v,'UniformOutput',false);
x_veh = cellfun(@(equis) entropy(equis),event_v,'UniformOutput',false);
x_veh = vertcat(x_veh{:});
% x_CBD = cellfun(@(equis) mean(instfreq(equis,1000)),event_c,'UniformOutput',false);
x_CBD = cellfun(@(equis) entropy(equis),event_c,'UniformOutput',false);
x_CBD = vertcat(x_CBD{:});

entp_v(j) = {x_veh};
entp_c(j) = {x_CBD};

%% Average Frequency (avfr)
y_veh = cellfun(@(equis) (meanfreq(equis,2500)),event_v,'UniformOutput',false);
% y_veh = cellfun(@(equis) (freqmaxpeak(equis)),event_v,'UniformOutput',false);
y_veh = vertcat(y_veh{:});

y_CBD = cellfun(@(equis) (meanfreq(equis,2500)),event_c,'UniformOutput',false);
% y_CBD = cellfun(@(equis) (freqmaxpeak(equis)),event_c,'UniformOutput',false);
y_CBD = vertcat(y_CBD{:});

avfr_v(j) = {y_veh};
avfr_c(j) = {y_CBD};

%% Amplitude (ampl)
z_veh = cellfun(@(equis) max(abs(hilbert(equis))) ,event_v,'UniformOutput',false);
z_veh = vertcat(z_veh{:});

z_CBD = cellfun(@(equis) max(abs(hilbert(equis))),event_c,'UniformOutput',false);
z_CBD = vertcat(z_CBD{:});

ampl_v(j) = {z_veh};
ampl_c(j) = {z_CBD};

%% AUC (auc)
l_veh = cell2mat(cellfun(@(equis) trapz((1:length(equis))./2500,abs(equis)), event_v,'UniformOutput',false));
l_CBD = cell2mat(cellfun(@(equis) trapz((1:length(equis))./2500,abs(equis)), event_c,'UniformOutput',false));

auc_v(j) = {l_veh};
auc_c(j) = {l_CBD};

%% Duration (dur)
q_veh =(cellfun('length',event_v)/2500);
q_CBD = (cellfun('length',event_c)/2500);

dur_v(j) = {q_veh};
dur_c(j) = {q_CBD};

%% Peak2Peak (p2p)
p_veh = cellfun(@peak2peak,event_v);
p_CBD = cellfun(@peak2peak,event_c);

p2p_v(j) = {p_veh};
p2p_c(j) = {p_CBD};

clear x_veh x_CBD y_veh y_CBD z_veh z_CBD l_veh l_CBD q_veh q_CBD p_veh p_CBD event_v event_c
end 

% % ripples_Veh = vertcat(ripples_waveforms_total_vehicle{:}).';
% % ripples_CBD = vertcat(ripples_waveforms_total_CBD{:}).';
% % 
% % ripples_Veh = ripples_waveforms_broadband_veh.';
% % ripples_CBD = ripples_waveforms_broadband_CBD.';
% 
% ripples_Veh = delta_waveform_broadband_veh.';
% ripples_CBD = delta_waveform_broadband_CBD.';
% 
% si_index = cellfun(@(equis) sum(isnan(equis)), ripples_Veh,'UniformOutput',false);
% si_index= cell2mat(si_index);
% si_index = ~logical(si_index);
% ripples_Veh= ripples_Veh(si_index);
% 
% si_index = cellfun(@(equis) sum(isnan(equis)), ripples_CBD,'UniformOutput',false);
% si_index = cell2mat(si_index);
% si_index = ~logical(si_index);
% ripples_CBD = ripples_CBD(si_index);
% 
% % ripples_CBD(14144) = [];
% % ripples_CBD(15679) = [];
% 
% % ripples_CBD = ripples_CBD(IF_CBD<=CBD_threshold);
% % ripples_Veh = ripples_Veh(IF_veh<=veh_threshold);
% 
% x_veh = cellfun(@(equis) mean(instfreq(equis,1000)),ripples_Veh,'UniformOutput',false);
% x_veh = vertcat(x_veh{:});
% x_CBD = cellfun(@(equis) mean(instfreq(equis,1000)),ripples_CBD,'UniformOutput',false);
% x_CBD = vertcat(x_CBD{:});
% 
% % y_veh = cellfun(@(equis) (meanfreq(equis,1000)),ripples_Veh,'UniformOutput',false);
% % y_veh = cellfun(@(equis) (freqmaxpeak(equis)),ripples_Veh,'UniformOutput',false);
% y_veh = cellfun(@(equis) (meanfreq2(equis,1000)),ripples_Veh,'UniformOutput',false);
% y_veh = vertcat(y_veh{:});
% % y_CBD = cellfun(@(equis) (meanfreq(equis,1000)),ripples_CBD,'UniformOutput',false);
% % y_CBD = cellfun(@(equis) (freqmaxpeak(equis)),ripples_CBD,'UniformOutput',false);
% y_CBD = cellfun(@(equis) (meanfreq2(equis,1000)),ripples_CBD,'UniformOutput',false);
% y_CBD = vertcat(y_CBD{:});
% 
% z_veh = cellfun(@(equis) max(abs(hilbert(equis))) ,ripples_Veh,'UniformOutput',false);
% z_veh = vertcat(z_veh{:});
% z_CBD = cellfun(@(equis) max(abs(hilbert(equis))),ripples_CBD,'UniformOutput',false);
% z_CBD = vertcat(z_CBD{:});
% 
% 
% l_veh = cell2mat(cellfun(@(equis) trapz((1:length(equis))./1000,abs(equis)), ripples_Veh,'UniformOutput',false));
% l_CBD = cell2mat(cellfun(@(equis) trapz((1:length(equis))./1000,abs(equis)), ripples_CBD,'UniformOutput',false));
% 
% q_veh =(cellfun('length',ripples_Veh)/1000);
% q_CBD = (cellfun('length',ripples_CBD)/1000);
% 
% p_veh = cellfun(@peak2peak,ripples_Veh);
% p_CBD = cellfun(@peak2peak,ripples_CBD);


           subplot(3,2,1)
            h1=histogram(x_veh); title('Entropy');xlabel('Entropy');ylabel('Count')
%             h1.BinWidth= 1;
            h1.FaceColor= [1 1 1]; h1.LineWidth=1;
            hold on
            h2=histogram(x_CBD); title('Entropy');xlabel('Entropy');ylabel('Count')
%             h2.BinWidth= 1;
            h2.FaceColor= [0.4940 0.1840 0.5560];
            legend('Vehicle', 'CBD')
            alpha(0.7)
%                   xlim([0 5])
            hold off
            
            subplot(3,2,2)
         
            h1=histogram(y_veh); title('Average Frequency');xlabel('Frequency (Hz)');ylabel('Count')
%             h1=histogram(y_veh); title('Peak Frequencies');xlabel('Frequency (Hz)');ylabel('Count')
            h1.BinWidth = 0.25;
            h1.FaceColor= [1 1 1];h1.LineWidth=1;
            hold on
            h2=histogram(y_CBD); title('Average Frequency');xlabel('Frequency (Hz)');ylabel('Count')
%             h2=histogram(y_CBD); title('Peak Frequencies');xlabel('Frequency (Hz)');ylabel('Count')
            h2.BinWidth = 0.25;
            h2.FaceColor= [0.4940 0.1840 0.5560];
            legend('Vehicle', 'CBD')
            alpha(0.7)
%              xlim([0 12])
            hold off
            
            
            subplot(3,2,3)
          
            h1=histogram(z_veh); title('Amplitude');xlabel('\muV');ylabel('Count')
            h1.BinWidth = 2;
            h1.FaceColor= [1 1 1];h1.LineWidth=1;
            hold on
            h2=histogram(z_CBD); title('Amplitude');xlabel('\muV');ylabel('Count')
            h2.BinWidth = 2;
            h2.FaceColor= [0.4940 0.1840 0.5560];
            legend('Vehicle', 'CBD')
            alpha(0.7)
                   xlim([0 150])
            hold off
            
            
            subplot(3,2,4)
        
            h1=histogram(l_veh); title('Area under the curve');xlabel('AUC');ylabel('Count')
            h1.BinWidth = 0.25;
            h1.FaceColor = [1 1 1]; h1.LineWidth=1;
            hold on
            h2=histogram(l_CBD); title('Area under the curve');xlabel('AUC');ylabel('Count')
            h2.BinWidth = 0.25;
            h2.FaceColor = [0.4940 0.1840 0.5560];
            legend('Vehicle', 'CBD')
            alpha(0.7)
%                     xlim([0 20])
            hold off
            
            subplot(3,2,5)
         
            h1=histogram(q_veh*2500); title('Duration');xlabel('Miliseconds');ylabel('Count') 
            h1.BinWidth = 6;
            h1.FaceColor = [1 1 1];h1.LineWidth=1;
            hold on
            h2=histogram(q_CBD*2500); title('Duration');xlabel('Miliseconds');ylabel('Count')
            h2.BinWidth = 6;
            h2.FaceColor= [0.4940 0.1840 0.5560];
            legend('Vehicle', 'CBD')
            alpha(0.7)
%                   xlim([400 1150])
            hold off
            
            subplot(3,2,6)
           
            h1=histogram(p_veh); title('Peak-to-peak amplitude');xlabel('\muV');ylabel('Count'); 
            h1.BinWidth = 4;
            h1.FaceColor = [1 1 1];h1.LineWidth=1;
            hold on
            h2=histogram(p_CBD); title('Peak-to-peak amplitude');xlabel('\muV');ylabel('Count'); 
            h2.BinWidth = 4;
            h2.FaceColor= [0.4940 0.1840 0.5560];
            legend('Vehicle', 'CBD')
             alpha(0.7)
%             xlim([0 250])
            hold off
            
      
