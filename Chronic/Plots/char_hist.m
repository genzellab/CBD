Ripples_Veh = ripple_waveforms_broadband_chronic_veh.';
Ripples_CBD = ripple_waveforms_broadband_chronic_cbd.';

si_index = cellfun(@(equis) sum(isnan(equis)), Ripples_Veh,'UniformOutput',false);
si_index= cell2mat(si_index);
si_index = ~logical(si_index);
Ripples_Veh= Ripples_Veh(si_index);

si_index = cellfun(@(equis) sum(isnan(equis)), Ripples_CBD,'UniformOutput',false);
si_index = cell2mat(si_index);
si_index = ~logical(si_index);
Ripples_CBD = Ripples_CBD(si_index); 

Wn1=[100/(2500/2) 300/(2500/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
Ripples_CBD = cellfun(@(equis)filtfilt(b1,a1,equis),Ripples_CBD ,'UniformOutput',false);
Ripples_Veh = cellfun(@(equis)filtfilt(b1,a1,equis),Ripples_Veh ,'UniformOutput',false);

% x_veh = cellfun(@(equis) mean(instfreq(equis,1000)),Ripples_Veh,'UniformOutput',false);
x_veh = cellfun(@(equis) entropy(equis),Ripples_Veh,'UniformOutput',false);
x_veh = vertcat(x_veh{:});
% x_CBD = cellfun(@(equis) mean(instfreq(equis,1000)),Ripples_CBD,'UniformOutput',false);
x_CBD = cellfun(@(equis) entropy(equis),Ripples_CBD,'UniformOutput',false);
x_CBD = vertcat(x_CBD{:});

y_veh = cellfun(@(equis) (meanfreq(equis,2500)),Ripples_Veh,'UniformOutput',false);
% y_veh = cellfun(@(equis) (freqmaxpeak(equis)),Ripples_Veh,'UniformOutput',false);
y_veh = vertcat(y_veh{:});
y_CBD = cellfun(@(equis) (meanfreq(equis,2500)),Ripples_CBD,'UniformOutput',false);
% y_CBD = cellfun(@(equis) (freqmaxpeak(equis)),Ripples_CBD,'UniformOutput',false);
y_CBD = vertcat(y_CBD{:});

z_veh = cellfun(@(equis) max(abs(hilbert(equis))) ,Ripples_Veh,'UniformOutput',false);
z_veh = vertcat(z_veh{:});
z_CBD = cellfun(@(equis) max(abs(hilbert(equis))),Ripples_CBD,'UniformOutput',false);
z_CBD = vertcat(z_CBD{:});

l_veh = cell2mat(cellfun(@(equis) trapz((1:length(equis))./2500,abs(equis)), Ripples_Veh,'UniformOutput',false));
l_CBD = cell2mat(cellfun(@(equis) trapz((1:length(equis))./2500,abs(equis)), Ripples_CBD,'UniformOutput',false));

q_veh =(cellfun('length',Ripples_Veh)/2500);
q_CBD = (cellfun('length',Ripples_CBD)/2500);

p_veh = cellfun(@peak2peak,Ripples_Veh);
p_CBD = cellfun(@peak2peak,Ripples_CBD);

% % Spindles_Veh = vertcat(spindles_waveforms_total_vehicle{:}).';
% % Spindles_CBD = vertcat(spindles_waveforms_total_CBD{:}).';
% % 
% % Spindles_Veh = spindles_waveforms_broadband_veh.';
% % Spindles_CBD = spindles_waveforms_broadband_CBD.';
% 
% Spindles_Veh = delta_waveform_broadband_veh.';
% Spindles_CBD = delta_waveform_broadband_CBD.';
% 
% si_index = cellfun(@(equis) sum(isnan(equis)), Spindles_Veh,'UniformOutput',false);
% si_index= cell2mat(si_index);
% si_index = ~logical(si_index);
% Spindles_Veh= Spindles_Veh(si_index);
% 
% si_index = cellfun(@(equis) sum(isnan(equis)), Spindles_CBD,'UniformOutput',false);
% si_index = cell2mat(si_index);
% si_index = ~logical(si_index);
% Spindles_CBD = Spindles_CBD(si_index);
% 
% % Spindles_CBD(14144) = [];
% % Spindles_CBD(15679) = [];
% 
% % Spindles_CBD = Spindles_CBD(IF_CBD<=CBD_threshold);
% % Spindles_Veh = Spindles_Veh(IF_veh<=veh_threshold);
% 
% x_veh = cellfun(@(equis) mean(instfreq(equis,1000)),Spindles_Veh,'UniformOutput',false);
% x_veh = vertcat(x_veh{:});
% x_CBD = cellfun(@(equis) mean(instfreq(equis,1000)),Spindles_CBD,'UniformOutput',false);
% x_CBD = vertcat(x_CBD{:});
% 
% % y_veh = cellfun(@(equis) (meanfreq(equis,1000)),Spindles_Veh,'UniformOutput',false);
% % y_veh = cellfun(@(equis) (freqmaxpeak(equis)),Spindles_Veh,'UniformOutput',false);
% y_veh = cellfun(@(equis) (meanfreq2(equis,1000)),Spindles_Veh,'UniformOutput',false);
% y_veh = vertcat(y_veh{:});
% % y_CBD = cellfun(@(equis) (meanfreq(equis,1000)),Spindles_CBD,'UniformOutput',false);
% % y_CBD = cellfun(@(equis) (freqmaxpeak(equis)),Spindles_CBD,'UniformOutput',false);
% y_CBD = cellfun(@(equis) (meanfreq2(equis,1000)),Spindles_CBD,'UniformOutput',false);
% y_CBD = vertcat(y_CBD{:});
% 
% z_veh = cellfun(@(equis) max(abs(hilbert(equis))) ,Spindles_Veh,'UniformOutput',false);
% z_veh = vertcat(z_veh{:});
% z_CBD = cellfun(@(equis) max(abs(hilbert(equis))),Spindles_CBD,'UniformOutput',false);
% z_CBD = vertcat(z_CBD{:});
% 
% 
% l_veh = cell2mat(cellfun(@(equis) trapz((1:length(equis))./1000,abs(equis)), Spindles_Veh,'UniformOutput',false));
% l_CBD = cell2mat(cellfun(@(equis) trapz((1:length(equis))./1000,abs(equis)), Spindles_CBD,'UniformOutput',false));
% 
% q_veh =(cellfun('length',Spindles_Veh)/1000);
% q_CBD = (cellfun('length',Spindles_CBD)/1000);
% 
% p_veh = cellfun(@peak2peak,Spindles_Veh);
% p_CBD = cellfun(@peak2peak,Spindles_CBD);


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
%                  xlim([0 60])
            hold off
            
            subplot(3,2,2)
         
            h1=histogram(y_veh); title('Average Frequencies');xlabel('Frequency (Hz)');ylabel('Count')
%             h1=histogram(y_veh); title('Peak Frequencies');xlabel('Frequency (Hz)');ylabel('Count')
            h1.BinWidth = 0.75;
            h1.FaceColor= [1 1 1];h1.LineWidth=1;
            hold on
            h2=histogram(y_CBD); title('Average Frequencies');xlabel('Frequency (Hz)');ylabel('Count')
%             h2=histogram(y_CBD); title('Peak Frequencies');xlabel('Frequency (Hz)');ylabel('Count')
            h2.BinWidth = 0.75;
            h2.FaceColor= [0.4940 0.1840 0.5560];
            legend('Vehicle', 'CBD')
            alpha(0.7)
            xlim([120 220])
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
                  xlim([0 100])
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
                    xlim([-1 10])
            hold off
            
            subplot(3,2,5)
         
            h1=histogram(q_veh*2500); title('Duration');xlabel('Miliseconds');ylabel('Count') 
            h1.BinWidth = 2;
            h1.FaceColor = [1 1 1];h1.LineWidth=1;
            hold on
            h2=histogram(q_CBD*2500); title('Duration');xlabel('Miliseconds');ylabel('Count')
            h2.BinWidth = 2;
            h2.FaceColor= [0.4940 0.1840 0.5560];
            legend('Vehicle', 'CBD')
            alpha(0.7)
                  xlim([30 200])
            hold off
            
            subplot(3,2,6)
           
            h1=histogram(p_veh); title('Peak-to-peak amplitude');xlabel('\muV');ylabel('Count'); 
            h1.BinWidth = 8;
            h1.FaceColor = [1 1 1];h1.LineWidth=1;
            hold on
            h2=histogram(p_CBD); title('Peak-to-peak amplitude');xlabel('\muV');ylabel('Count'); 
            h2.BinWidth = 8;
            h2.FaceColor= [0.4940 0.1840 0.5560];
            legend('Vehicle', 'CBD')
             alpha(0.7)
            xlim([0 250])
            hold off
            
      
