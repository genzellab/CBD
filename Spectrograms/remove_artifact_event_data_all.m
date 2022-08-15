%% Pelin Ozsezer

clc
clear
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/functions');

%% CHECK ARTIFACT IN PFC DATA

%%%%%%%%%%%%%
%% Vehicle %%
%%%%%%%%%%%%%
load('detections_PFCshal_veh.mat');
data_ripple=GC_detections_PFCshal_ripple_veh;
data_sw=GC_detections_PFCshal_sw_veh;
data_swr=GC_detections_PFCshal_swr_veh;
data_complex_swr=GC_detections_PFCshal_complex_swr_veh;

%% Ripple
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(data_ripple)
    i
    v=data_ripple{i,1}(1,:);
    x=[x;v];
end

% bandpass filter
fn=600;
Wn1=[100/(fn/2) 299/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
x=filtfilt(b1,a1,x);

% plot
PFCshal_veh_ripple_noise_idx=[];
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
    if max(diff(x(i,:)))>146 || min(diff(x(i,:)))<-130
       PFCshal_veh_ripple_noise_idx=[PFCshal_veh_ripple_noise_idx;i];
   else
        plot(diff(x(i,:)),'b-')
        hold on
         ylim([-1000 1000]) 
        title('PFCshal - Veh - Ripple')
    end       
end
saveas(gcf,'PFCshal - Veh - Ripple.jpg')
close all

%% SW
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(data_sw)
    i
    v=data_sw{i,1}(1,:);
    x=[x;v];
end

% bandpass filter
fn=600;
Wn1=[100/(fn/2) 299/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
x=filtfilt(b1,a1,x);

% plot
PFCshal_veh_sw_noise_idx=[];
for i=1:size(x,1)  
    if max(diff(x(i,:)))>136 || min(diff(x(i,:)))<-130
       PFCshal_veh_sw_noise_idx=[PFCshal_veh_sw_noise_idx;i];
   else
        plot(diff(x(i,:)),'b-')
        hold on
         ylim([-1000 1000]) 
        title('PFCshal - Veh - SW')
    end       
end
saveas(gcf,'PFCshal - Veh - SW.jpg')
close all

%% SWR
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(data_swr)
    i
    v=data_swr{i,1}(1,:);
    x=[x;v];
end

% bandpass filter
fn=600;
Wn1=[100/(fn/2) 299/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
x=filtfilt(b1,a1,x);

% plot
PFCshal_veh_swr_noise_idx=[];
for i=1:size(x,1)  
    if max(diff(x(i,:)))>117 || min(diff(x(i,:)))<-116
       PFCshal_veh_swr_noise_idx=[PFCshal_veh_swr_noise_idx;i];
   else
        plot(diff(x(i,:)),'b-')
        hold on
         ylim([-1000 1000]) 
        title('PFCshal - Veh - SW')
    end       
end
saveas(gcf,'PFCshal - Veh - SWR.jpg')
close all

%% Complex SWR
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(data_complex_swr)
    i
    v=data_complex_swr{i,1}(1,:);
    x=[x;v];
end

% bandpass filter
fn=600;
Wn1=[100/(fn/2) 299/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
x=filtfilt(b1,a1,x);

% plot
PFCshal_veh_complex_swr_noise_idx=[];
for i=1:size(x,1)  
    if max(diff(x(i,:)))>110 || min(diff(x(i,:)))<-100
       PFCshal_veh_complex_swr_noise_idx=[PFCshal_veh_complex_swr_noise_idx;i];
   else
        plot(diff(x(i,:)),'b-')
        hold on
         ylim([-1000 1000]) 
        title('PFCshal - Veh - Complex SWR')
    end       
end
saveas(gcf,'PFCshal - Veh - Complex SWR.jpg')
close all

clearvars -except -regexp noise
save noise_idx_event_veh.mat


%%%%%%%%%
%% CBD %%
%%%%%%%%%
clear
load('detections_PFCshal_cbd.mat');
data_ripple=GC_detections_PFCshal_ripple_cbd;
data_sw=GC_detections_PFCshal_sw_cbd;
data_swr=GC_detections_PFCshal_swr_cbd;
data_complex_swr=GC_detections_PFCshal_complex_swr_cbd;

%% Ripple
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(data_ripple)
    i
    v=data_ripple{i,1}(1,:);
    x=[x;v];
end

% bandpass filter
fn=600;
Wn1=[100/(fn/2) 299/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
x=filtfilt(b1,a1,x);

% plot
PFCshal_cbd_ripple_noise_idx=[];
for i=1:size(x,1)  
    if max(diff(x(i,:)))>110 || min(diff(x(i,:)))<-103
       PFCshal_cbd_ripple_noise_idx=[PFCshal_cbd_ripple_noise_idx;i];
   else
        plot(diff(x(i,:)),'b-')
        hold on
         ylim([-1000 1000]) 
        title('PFCshal - CBD - Ripple')
    end       
end
saveas(gcf,'PFCshal - CBD - Ripple.jpg')
close all

%% SW
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(data_sw)
    i
    v=data_sw{i,1}(1,:);
    x=[x;v];
end

% bandpass filter
fn=600;
Wn1=[100/(fn/2) 299/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
x=filtfilt(b1,a1,x);

% plot
PFCshal_cbd_sw_noise_idx=[];
for i=1:size(x,1)  
    if max(diff(x(i,:)))>120 || min(diff(x(i,:)))<-93
       PFCshal_cbd_sw_noise_idx=[PFCshal_cbd_sw_noise_idx;i];
   else
        plot(diff(x(i,:)),'b-')
        hold on
         ylim([-1000 1000]) 
        title('PFCshal - CBD - SW')
    end       
end
saveas(gcf,'PFCshal - CBD - SW.jpg')
close all

%% SWR
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(data_swr)
    i
    v=data_swr{i,1}(1,:);
    x=[x;v];
end

% bandpass filter
fn=600;
Wn1=[100/(fn/2) 299/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
x=filtfilt(b1,a1,x);

% plot
PFCshal_cbd_swr_noise_idx=[];
for i=1:size(x,1)  
    if max(diff(x(i,:)))>114 || min(diff(x(i,:)))<-83
       PFCshal_cbd_swr_noise_idx=[PFCshal_cbd_swr_noise_idx;i];
   else
        plot(diff(x(i,:)),'b-')
        hold on
         ylim([-1000 1000]) 
        title('PFCshal - CBD - SWR')
    end       
end
saveas(gcf,'PFCshal - CBD - SWR.jpg')
close all

%% Complex SWR
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(data_complex_swr)
    i
    v=data_complex_swr{i,1}(1,:);
    x=[x;v];
end

% bandpass filter
fn=600;
Wn1=[100/(fn/2) 299/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
x=filtfilt(b1,a1,x);

% plot
PFCshal_cbd_complex_swr_noise_idx=[];
t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
    if max(diff(x(i,:)))>101 || min(diff(x(i,:)))<-88
       PFCshal_cbd_complex_swr_noise_idx=[PFCshal_cbd_complex_swr_noise_idx;i];
   else
        plot(t,diff(x(i,:)),'b-')
        hold on
         ylim([-1000 1000]) 
        title('PFCshal - CBD - Complex SWR')
    end       
end
saveas(gcf,'PFCshal - CBD - Complex SWR.jpg')
close all

clearvars -except -regexp noise
save noise_idx_event_cbd.mat


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% CHECK ARTIFACT IN HPC DATA

%%%%%%%%%%%%%
%% Vehicle %%
%%%%%%%%%%%%%
clear
load('detections_HPC_veh.mat');
data_ripple=GC_detections_HPCpyra_ripple_veh;
data_sw=GC_detections_HPCpyra_sw_veh;
data_swr=GC_detections_HPCpyra_swr_veh;
data_complex_swr=GC_detections_HPCpyra_complex_swr_veh;

%% Ripple
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(data_ripple)
    i
    v=data_ripple{i,1}(1,:);
    x=[x;v];
end

% bandpass filter
fn=600;
Wn1=[100/(fn/2) 299/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
x=filtfilt(b1,a1,x);

% plot
HPCpyra_veh_ripple_noise_idx=[];
for i=1:size(x,1)  
        plot(diff(x(i,:)),'b-')
        hold on
         ylim([-1000 1000]) 
        title('HPCpyra - Veh - Ripple')      
end
saveas(gcf,'HPCpyra - Veh - Ripple.jpg')
close all

%% SW
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(data_sw)
    i
    v=data_sw{i,1}(1,:);
    x=[x;v];
end

% bandpass filter
fn=600;
Wn1=[100/(fn/2) 299/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
x=filtfilt(b1,a1,x);

% plot
HPCpyra_veh_sw_noise_idx=[];
for i=1:size(x,1)  


        plot(diff(x(i,:)),'b-')
        hold on
         ylim([-1000 1000]) 
        title('HPCpyra - Veh - SW')
      
end
saveas(gcf,'HPCpyra - Veh - SW.jpg')
close all

%% SWR
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(data_swr)
    i
    v=data_swr{i,1}(1,:);
    x=[x;v];
end

% bandpass filter
fn=600;
Wn1=[100/(fn/2) 299/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
x=filtfilt(b1,a1,x);

% plot
HPCpyra_veh_swr_noise_idx=[];
for i=1:size(x,1)  
    
        plot(diff(x(i,:)),'b-')
        hold on
         ylim([-1000 1000]) 
        title('HPCpyra - Veh - SWR')
    %end       
end
saveas(gcf,'HPCpyra - Veh - SWR.jpg')
close all

%% Complex SWR
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(data_complex_swr)
    i
    v=data_complex_swr{i,1}(1,:);
    x=[x;v];
end

% bandpass filter
fn=600;
Wn1=[100/(fn/2) 299/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
x=filtfilt(b1,a1,x);

% plot
HPCpyra_veh_complex_swr_noise_idx=[];
for i=1:size(x,1)  
 
   %else
        plot(diff(x(i,:)),'b-')
        hold on
         ylim([-1000 1000]) 
        title('HPCpyra - Veh - Complex SWR')
    %end       
end
saveas(gcf,'HPCpyra - Veh - Complex SWR.jpg')
close all

clearvars -except -regexp noise
save noiseHPC_idx_event_veh.mat


%%%%%%%%%
%% CBD %%
%%%%%%%%%
clear
load('detections_HPC_cbd.mat');
data_ripple=GC_detections_HPCpyra_ripple_cbd;
data_sw=GC_detections_HPCpyra_sw_cbd;
data_swr=GC_detections_HPCpyra_swr_cbd;
data_complex_swr=GC_detections_HPCpyra_complex_swr_cbd;

%% Ripple
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(data_ripple)
    i
    v=data_ripple{i,1}(1,:);
    x=[x;v];
end

% bandpass filter
fn=600;
Wn1=[100/(fn/2) 299/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
x=filtfilt(b1,a1,x);

% plot
HPCpyra_cbd_ripple_noise_idx=[];
for i=1:size(x,1)  
    %if max(diff(x(i,:)))>220 || min(diff(x(i,:)))<-215
       %HPCpyra_cbd_ripple_noise_idx=[HPCpyra_cbd_ripple_noise_idx;i];
   %else
        plot(diff(x(i,:)),'b-')
        hold on
         ylim([-1000 1000]) 
        title('HPCpyra - CBD - Ripple')
    %end       
end
saveas(gcf,'HPCpyra - CBD - Ripple.jpg')
close all

%% SW
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(data_sw)
    i
    v=data_sw{i,1}(1,:);
    x=[x;v];
end

% bandpass filter
fn=600;
Wn1=[100/(fn/2) 299/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
x=filtfilt(b1,a1,x);

% plot
HPCpyra_cbd_sw_noise_idx=[];
for i=1:size(x,1)  
    if max(diff(x(i,:)))>233 % || min(diff(x(i,:)))<-144
      HPCpyra_cbd_sw_noise_idx=[HPCpyra_cbd_sw_noise_idx;i];
   else
        plot(diff(x(i,:)),'b-')
        hold on
         ylim([-1000 1000]) 
        title('HPCpyra - CBD - SW')
    end       
end
saveas(gcf,'HPCpyra - CBD - SW.jpg')
close all

%% SWR
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(data_swr)
    i
    v=data_swr{i,1}(1,:);
    x=[x;v];
end

% bandpass filter
fn=600;
Wn1=[100/(fn/2) 299/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
x=filtfilt(b1,a1,x);

% plot
HPCpyra_cbd_swr_noise_idx=[];
for i=1:size(x,1)  
    %if max(diff(x(i,:)))>225 || min(diff(x(i,:)))<229
     %  HPCpyra_cbd_swr_noise_idx=[HPCpyra_cbd_swr_noise_idx;i];
   %else
        plot(diff(x(i,:)),'b-')
        hold on
         ylim([-1000 1000]) 
        title('HPCpyra - CBD - SWR')
    %end       
end
saveas(gcf,'HPCpyra - CBD - SWR.jpg')
close all

%% Complex SWR
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(data_complex_swr)
    i
    v=data_complex_swr{i,1}(1,:);
    x=[x;v];
end

% bandpass filter
fn=600;
Wn1=[100/(fn/2) 299/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
x=filtfilt(b1,a1,x);

% plot
HPCpyra_cbd_complex_swr_noise_idx=[];
for i=1:size(x,1)  
    %if max(diff(x(i,:)))>101 || min(diff(x(i,:)))<-88
       %HPCpyra_cbd_complex_swr_noise_idx=[HPCpyra_cbd_complex_swr_noise_idx;i];
   %else
        plot(diff(x(i,:)),'b-')
        hold on
         ylim([-1000 1000]) 
        title('HPCpyra - CBD - Complex SWR')
    %end       
end
saveas(gcf,'HPCpyra - CBD - Complex SWR.jpg')
close all

clearvars -except -regexp noise
save noiseHPC_idx_event_cbd.mat



%% REMOVE ARTIFACTS NOW %%

%% Vehicle %%
%
clear
load('noisePFC_idx_event_veh.mat');
load('noiseHPC_idx_event_veh');

%% PFCshal
load('detections_PFCshal_veh.mat');

GC_detections_PFCshal_ripple_veh(PFCshal_veh_ripple_noise_idx,:)=[];
GC_detections_PFCshal_sw_veh(PFCshal_veh_sw_noise_idx,:)=[];
GC_detections_PFCshal_swr_veh(PFCshal_veh_swr_noise_idx,:)=[];
GC_detections_PFCshal_complex_swr_veh(PFCshal_veh_complex_swr_noise_idx,:)=[];

ripple_grouped_oscil_table_PFCshal_veh(PFCshal_veh_ripple_noise_idx,:)=[];
sw_grouped_oscil_table_PFCshal_veh(PFCshal_veh_sw_noise_idx,:)=[];
swr_grouped_oscil_table_PFCshal_veh(PFCshal_veh_swr_noise_idx,:)=[];
complex_swr_grouped_oscil_table_PFCshal_veh(PFCshal_veh_complex_swr_noise_idx,:)=[];

clearvars -regexp noise
save detections_PFCshal_veh_wa.mat

%% PFCdeep
clear
load('noisePFC_idx_event_veh.mat');
load('noiseHPC_idx_event_veh');
load('detections_PFCdeep_veh.mat');

GC_detections_PFCdeep_ripple_veh(PFCshal_veh_ripple_noise_idx,:)=[];
GC_detections_PFCdeep_sw_veh(PFCshal_veh_sw_noise_idx,:)=[];
GC_detections_PFCdeep_swr_veh(PFCshal_veh_swr_noise_idx,:)=[];
GC_detections_PFCdeep_complex_swr_veh(PFCshal_veh_complex_swr_noise_idx,:)=[];

ripple_grouped_oscil_table_PFCdeep_veh(PFCshal_veh_ripple_noise_idx,:)=[];
sw_grouped_oscil_table_PFCdeep_veh(PFCshal_veh_sw_noise_idx,:)=[];
swr_grouped_oscil_table_PFCdeep_veh(PFCshal_veh_swr_noise_idx,:)=[];
complex_swr_grouped_oscil_table_PFCdeep_veh(PFCshal_veh_complex_swr_noise_idx,:)=[];

clearvars -regexp noise
save detections_PFCdeep_veh_wa.mat

%% HPCpyra
clear
load('noisePFC_idx_event_veh.mat');
load('noiseHPC_idx_event_veh');
load('detections_HPC_veh.mat');

GC_detections_HPCpyra_ripple_veh(PFCshal_veh_ripple_noise_idx,:)=[];
GC_detections_HPCpyra_sw_veh(PFCshal_veh_sw_noise_idx,:)=[];
GC_detections_HPCpyra_swr_veh(PFCshal_veh_swr_noise_idx,:)=[];
GC_detections_HPCpyra_complex_swr_veh(PFCshal_veh_complex_swr_noise_idx,:)=[];

ripple_grouped_oscil_table_HPCpyra_veh(PFCshal_veh_ripple_noise_idx,:)=[];
sw_grouped_oscil_table_HPCpyra_veh(PFCshal_veh_sw_noise_idx,:)=[];
swr_grouped_oscil_table_HPCpyra_veh(PFCshal_veh_swr_noise_idx,:)=[];
complex_swr_grouped_oscil_table_HPCpyra_veh(PFCshal_veh_complex_swr_noise_idx,:)=[];

clearvars -regexp noise HPCbelo
save detections_HPCpyra_veh_wa.mat

%% HPCbelo
clear
load('noisePFC_idx_event_veh.mat');
load('noiseHPC_idx_event_veh');
load('detections_HPC_veh.mat');

GC_detections_HPCbelo_ripple_veh(PFCshal_veh_ripple_noise_idx,:)=[];
GC_detections_HPCbelo_sw_veh(PFCshal_veh_sw_noise_idx,:)=[];
GC_detections_HPCbelo_swr_veh(PFCshal_veh_swr_noise_idx,:)=[];
GC_detections_HPCbelo_complex_swr_veh(PFCshal_veh_complex_swr_noise_idx,:)=[];

ripple_grouped_oscil_table_HPCbelo_veh(PFCshal_veh_ripple_noise_idx,:)=[];
sw_grouped_oscil_table_HPCbelo_veh(PFCshal_veh_sw_noise_idx,:)=[];
swr_grouped_oscil_table_HPCbelo_veh(PFCshal_veh_swr_noise_idx,:)=[];
complex_swr_grouped_oscil_table_HPCbelo_veh(PFCshal_veh_complex_swr_noise_idx,:)=[];

clearvars -regexp noise HPCpyra
save detections_HPCbelo_veh_wa.mat


%% CBD %%

%% PFCshal
clear
load('noisePFC_idx_event_cbd.mat');
load('noiseHPC_idx_event_cbd');
load('detections_PFCshal_cbd.mat');

% remove repetitive values/indeces for SW only
combined=[PFCshal_cbd_sw_noise_idx; HPCpyra_cbd_sw_noise_idx];
[b,m1,n1] = unique(combined,'first');
[c1,d1] =sort(m1);
rmv = b(d1);
idx=sort(rmv);

GC_detections_PFCshal_ripple_cbd(PFCshal_cbd_ripple_noise_idx,:)=[];
GC_detections_PFCshal_sw_cbd(idx,:)=[];
GC_detections_PFCshal_swr_cbd(PFCshal_cbd_swr_noise_idx,:)=[];
GC_detections_PFCshal_complex_swr_cbd(PFCshal_cbd_complex_swr_noise_idx,:)=[];

ripple_grouped_oscil_table_PFCshal_cbd(PFCshal_cbd_ripple_noise_idx,:)=[];
sw_grouped_oscil_table_PFCshal_cbd(idx,:)=[];
swr_grouped_oscil_table_PFCshal_cbd(PFCshal_cbd_swr_noise_idx,:)=[];
complex_swr_grouped_oscil_table_PFCshal_cbd(PFCshal_cbd_complex_swr_noise_idx,:)=[];

clearvars -except -regexp GC grouped
save detections_PFCshal_cbd_wa.mat

%% PFCdeep
clear
load('noisePFC_idx_event_cbd.mat');
load('noiseHPC_idx_event_cbd');
load('detections_PFCdeep_cbd.mat');

% remove repetitive values/indeces for SW only
combined=[PFCshal_cbd_sw_noise_idx; HPCpyra_cbd_sw_noise_idx];
[b,m1,n1] = unique(combined,'first');
[c1,d1] =sort(m1);
rmv = b(d1);
idx=sort(rmv);

GC_detections_PFCdeep_ripple_cbd(PFCshal_cbd_ripple_noise_idx,:)=[];
GC_detections_PFCdeep_sw_cbd(idx,:)=[];
GC_detections_PFCdeep_swr_cbd(PFCshal_cbd_swr_noise_idx,:)=[];
GC_detections_PFCdeep_complex_swr_cbd(PFCshal_cbd_complex_swr_noise_idx,:)=[];

ripple_grouped_oscil_table_PFCdeep_cbd(PFCshal_cbd_ripple_noise_idx,:)=[];
sw_grouped_oscil_table_PFCdeep_cbd(idx,:)=[];
swr_grouped_oscil_table_PFCdeep_cbd(PFCshal_cbd_swr_noise_idx,:)=[];
complex_swr_grouped_oscil_table_PFCdeep_cbd(PFCshal_cbd_complex_swr_noise_idx,:)=[];

clearvars -except -regexp GC grouped
save detections_PFCdeep_cbd_wa.mat

%% HPCpyra
clear
load('noisePFC_idx_event_cbd.mat');
load('noiseHPC_idx_event_cbd');
load('detections_HPC_cbd.mat');

% remove repetitive values/indeces for SW only
combined=[PFCshal_cbd_sw_noise_idx; HPCpyra_cbd_sw_noise_idx];
[b,m1,n1] = unique(combined,'first');
[c1,d1] =sort(m1);
rmv = b(d1);
idx=sort(rmv);

GC_detections_HPCpyra_ripple_cbd(PFCshal_cbd_ripple_noise_idx,:)=[];
GC_detections_HPCpyra_sw_cbd(idx,:)=[];
GC_detections_HPCpyra_swr_cbd(PFCshal_cbd_swr_noise_idx,:)=[];
GC_detections_HPCpyra_complex_swr_cbd(PFCshal_cbd_complex_swr_noise_idx,:)=[];

ripple_grouped_oscil_table_HPCpyra_cbd(PFCshal_cbd_ripple_noise_idx,:)=[];
sw_grouped_oscil_table_HPCpyra_cbd(idx,:)=[];
swr_grouped_oscil_table_HPCpyra_cbd(PFCshal_cbd_swr_noise_idx,:)=[];
complex_swr_grouped_oscil_table_HPCpyra_cbd(PFCshal_cbd_complex_swr_noise_idx,:)=[];


clearvars -except -regexp HPCpyra
clearvars -regexp idx
save detections_HPCpyra_cbd_wa.mat

%% HPCbelo
clear
load('noisePFC_idx_event_cbd.mat');
load('noiseHPC_idx_event_cbd');
load('detections_HPC_cbd.mat');

% remove repetitive values/indeces for SW only
combined=[PFCshal_cbd_sw_noise_idx; HPCpyra_cbd_sw_noise_idx];
[b,m1,n1] = unique(combined,'first');
[c1,d1] =sort(m1);
rmv = b(d1);
idx=sort(rmv);

GC_detections_HPCbelo_ripple_cbd(PFCshal_cbd_ripple_noise_idx,:)=[];
GC_detections_HPCbelo_sw_cbd(idx,:)=[];
GC_detections_HPCbelo_swr_cbd(PFCshal_cbd_swr_noise_idx,:)=[];
GC_detections_HPCbelo_complex_swr_cbd(PFCshal_cbd_complex_swr_noise_idx,:)=[];

ripple_grouped_oscil_table_HPCbelo_cbd(PFCshal_cbd_ripple_noise_idx,:)=[];
sw_grouped_oscil_table_HPCbelo_cbd(idx,:)=[];
swr_grouped_oscil_table_HPCbelo_cbd(PFCshal_cbd_swr_noise_idx,:)=[];
complex_swr_grouped_oscil_table_HPCbelo_cbd(PFCshal_cbd_complex_swr_noise_idx,:)=[];

clearvars -except -regexp HPCbelo
clearvars -regexp idx
save detections_HPCbelo_cbd_wa.mat












