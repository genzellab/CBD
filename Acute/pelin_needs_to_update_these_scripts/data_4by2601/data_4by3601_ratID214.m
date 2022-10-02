%% Pelin Ozsezer

%%
clc
clear
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/functions');

%%%%%%%%%
%% PFC %%
%%%%%%%%%
cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/PFC
% /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/PFC

%% PFCshal %%

%% CHECK ARTIFACT IN DATA
load('ratID214_PFCshal_cbd.mat');
data_ripple=GC_ripple_waveforms_PFCshal_ratID214;
data_sw=GC_sw_waveforms_PFCshal_ratID214;
data_swr=GC_swr_waveforms_PFCshal_ratID214;
data_complex_swr=GC_complex_swr_waveforms_PFCshal_ratID214;

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
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
    if max(abs(diff(x(i,:))))>153
       PFCshal_cbd_ripple_noise_idx=[PFCshal_cbd_ripple_noise_idx;i];
   else
        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('PFCshal - cbd - Ripple')
    end       
end

%% SW
% Detect artifact (overlay all)
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
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
    if max(abs(diff(x(i,:))))>144
       PFCshal_cbd_sw_noise_idx=[PFCshal_cbd_sw_noise_idx;i];
   else
        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('PFCshal - cbd - SW')
    end       
end

%% SWR
% Detect artifact (overlay all)
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
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
    if max(abs(diff(x(i,:))))>1174
       PFCshal_cbd_swr_noise_idx=[PFCshal_cbd_swr_noise_idx;i];
   else
        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('PFCshal - cbd - SWR')  
    end
end

%% Complex SWR
% Detect artifact (overlay all)
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
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
        if max(abs(diff(x(i,:))))>500
       PFCshal_cbd_complex_swr_noise_idx=[PFCshal_cbd_complex_swr_noise_idx;i];
   else
        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('PFCshal - cbd - Complex SWR')     
        end
end



%% PFCdeep %%

%% CHECK ARTIFACT IN DATA
load('ratID214_PFCdeep_cbd.mat');
data_ripple=GC_ripple_waveforms_PFCdeep_ratID214;
data_sw=GC_sw_waveforms_PFCdeep_ratID214;
data_swr=GC_swr_waveforms_PFCdeep_ratID214;
data_complex_swr=GC_complex_swr_waveforms_PFCdeep_ratID214;

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
PFCdeep_cbd_ripple_noise_idx=[];
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
    if max(abs(diff(x(i,:))))>874
       PFCdeep_cbd_ripple_noise_idx=[PFCdeep_cbd_ripple_noise_idx;i];
   else
        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('PFCdeep - cbd - Ripple')
    end       
end

%% SW
% Detect artifact (overlay all)
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
PFCdeep_cbd_sw_noise_idx=[];
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
    if max(abs(diff(x(i,:))))>91
       PFCdeep_cbd_sw_noise_idx=[PFCdeep_cbd_sw_noise_idx;i];
   else
        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('PFCdeep - cbd - SW')
    end       
end

%% SWR
% Detect artifact (overlay all)
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
PFCdeep_cbd_swr_noise_idx=[];
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1) 
    if max(abs(diff(x(i,:))))>1540
       PFCdeep_cbd_swr_noise_idx=[PFCdeep_cbd_swr_noise_idx;i];
   else
        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('PFCdeep - cbd - SWR') 
    end
end

%% Complex SWR
% Detect artifact (overlay all)
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
PFCdeep_cbd_complex_swr_noise_idx=[];
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
            if max(abs(diff(x(i,:))))>1550
       PFCdeep_cbd_complex_swr_noise_idx=[PFCdeep_cbd_complex_swr_noise_idx;i];
   else
        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('PFCdeep - cbd - Complex SWR')  
            end
       
end

%%%%%%%%%
%% HPC %%
%%%%%%%%%
close all
cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/HPC

%% HPCpyra %%

%% CHECK ARTIFACT IN DATA
load('ratID214_HPC_cbd.mat');
data_ripple=GC_ripple_waveforms_HPCpyra_ratID214;
data_sw=GC_sw_waveforms_HPCpyra_ratID214;
data_swr=GC_swr_waveforms_HPCpyra_ratID214;
data_complex_swr=GC_complex_swr_waveforms_HPCpyra_ratID214;

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
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
            if max(abs(diff(x(i,:))))>400
       HPCpyra_cbd_ripple_noise_idx=[HPCpyra_cbd_ripple_noise_idx;i];
        else

        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('HPCpyra - cbd - Ripple')
            end
   
end

%% SW
% Detect artifact (overlay all)
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
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
                if max(abs(diff(x(i,:))))>137
       HPCpyra_cbd_sw_noise_idx=[HPCpyra_cbd_sw_noise_idx;i];
        else


        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('HPCpyra - cbd - SW')
                end
end

%% SWR
% Detect artifact (overlay all)
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
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
                if max(abs(diff(x(i,:))))>500
       HPCpyra_cbd_swr_noise_idx=[HPCpyra_cbd_swr_noise_idx;i];
        else
        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('HPCpyra - cbd - SWR')  
                end
end

%% Complex SWR
% Detect artifact (overlay all)
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
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('HPCpyra - cbd - Complex SWR')     
end



%% HPCbelo %%

%% CHECK ARTIFACT IN DATA
data_ripple=GC_ripple_waveforms_HPCbelo_ratID214;
data_sw=GC_sw_waveforms_HPCbelo_ratID214;
data_swr=GC_swr_waveforms_HPCbelo_ratID214;
data_complex_swr=GC_complex_swr_waveforms_HPCbelo_ratID214;

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
HPCbelo_cbd_ripple_noise_idx=[];
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
                if max(abs(diff(x(i,:))))>500
       HPCbelo_cbd_ripple_noise_idx=[HPCbelo_cbd_ripple_noise_idx;i];
        else

        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('HPCbelo - cbd - Ripple')
                end
end

%% SW
% Detect artifact (overlay all)
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
HPCbelo_cbd_sw_noise_idx=[];
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
                    if max(abs(diff(x(i,:))))>137
       HPCbelo_cbd_sw_noise_idx=[HPCbelo_cbd_sw_noise_idx;i];
        else


        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('HPCbelo - cbd - SW')
                    end
   
end

%% SWR
% Detect artifact (overlay all)
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
HPCbelo_cbd_swr_noise_idx=[];
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('HPCbelo - cbd - SWR')  
end

%% Complex SWR
% Detect artifact (overlay all)
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
HPCbelo_cbd_complex_swr_noise_idx=[];
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('HPCbelo - cbd - Complex SWR')     
end


%%%%%%%%%%%%%%%%%%
%% REMOVE NOISE %%
%%%%%%%%%%%%%%%%%%
close all
cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project
clearvars -except -regexp noise
cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/data_3by3601_per_rat
save noise_idx_ratID214.mat
%%
cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/PFC
load('ratID214_PFCshal_cbd.mat');
load('ratID214_PFCdeep_cbd.mat');

cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/HPC
load('ratID214_HPC_cbd.mat');

cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/data_3by3601_per_rat

%% Ripple
% remove repetitive values/indeces for Ripple only
combined=[PFCshal_cbd_ripple_noise_idx; PFCdeep_cbd_ripple_noise_idx; ...
    HPCpyra_cbd_ripple_noise_idx;HPCbelo_cbd_ripple_noise_idx];
[b,m1,n1] = unique(combined,'first');
[c1,d1] =sort(m1);
rmv = b(d1);
idx=sort(rmv);

% PFCshal
GC_ripple_waveforms_PFCshal_ratID214(idx,:)=[];
GC_ripple_waveforms_PFCdeep_ratID214(idx,:)=[];
GC_ripple_waveforms_HPCpyra_ratID214(idx,:)=[];
GC_ripple_waveforms_HPCbelo_ratID214(idx,:)=[];

ripple_grouped_oscil_table_PFCshal_ratID214(idx,:)=[];
ripple_grouped_oscil_table_veh=ripple_grouped_oscil_table_PFCshal_ratID214;

for i=1:size(GC_ripple_waveforms_PFCshal_ratID214,1)
    GC_ripple_ratID214_cbd.waveforms{i,1}(1,:)=GC_ripple_waveforms_PFCshal_ratID214{i,1}(1,:);
    GC_ripple_ratID214_cbd.waveforms{i,1}(2,:)=GC_ripple_waveforms_HPCpyra_ratID214{i,1}(1,:);
    GC_ripple_ratID214_cbd.waveforms{i,1}(3,:)=GC_ripple_waveforms_HPCbelo_ratID214{i,1}(1,:);
    GC_ripple_ratID214_cbd.waveforms{i,1}(4,:)=GC_ripple_waveforms_PFCdeep_ratID214{i,1}(1,:);
end

GC_ripple_ratID214_cbd.grouped_oscil_table=ripple_grouped_oscil_table_veh;


%% SW
% remove repetitive values/indeces for SW only
combined=[PFCshal_cbd_sw_noise_idx; PFCdeep_cbd_sw_noise_idx; ...
    HPCpyra_cbd_sw_noise_idx;HPCbelo_cbd_sw_noise_idx];
[b,m1,n1] = unique(combined,'first');
[c1,d1] =sort(m1);
rmv = b(d1);
idx=sort(rmv);

% PFCshal
GC_sw_waveforms_PFCshal_ratID214(idx,:)=[];
GC_sw_waveforms_PFCdeep_ratID214(idx,:)=[];
GC_sw_waveforms_HPCpyra_ratID214(idx,:)=[];
GC_sw_waveforms_HPCbelo_ratID214(idx,:)=[];

sw_grouped_oscil_table_PFCshal_ratID214(idx,:)=[];
sw_grouped_oscil_table_veh=sw_grouped_oscil_table_PFCshal_ratID214;

for i=1:size(GC_sw_waveforms_PFCshal_ratID214,1)
    GC_sw_ratID214_cbd.waveforms{i,1}(1,:)=GC_sw_waveforms_PFCshal_ratID214{i,1}(1,:);
    GC_sw_ratID214_cbd.waveforms{i,1}(2,:)=GC_sw_waveforms_HPCpyra_ratID214{i,1}(1,:);
    GC_sw_ratID214_cbd.waveforms{i,1}(3,:)=GC_sw_waveforms_HPCbelo_ratID214{i,1}(1,:);
    GC_sw_ratID214_cbd.waveforms{i,1}(4,:)=GC_sw_waveforms_PFCdeep_ratID214{i,1}(1,:);
end

GC_sw_ratID214_cbd.grouped_oscil_table=sw_grouped_oscil_table_veh;

%% SWR
% remove repetitive values/indeces for swr only
combined=[PFCshal_cbd_swr_noise_idx; PFCdeep_cbd_swr_noise_idx; ...
    HPCpyra_cbd_swr_noise_idx;HPCbelo_cbd_swr_noise_idx];
[b,m1,n1] = unique(combined,'first');
[c1,d1] =sort(m1);
rmv = b(d1);
idx=sort(rmv);

% PFCshal
GC_swr_waveforms_PFCshal_ratID214(idx,:)=[];
GC_swr_waveforms_PFCdeep_ratID214(idx,:)=[];
GC_swr_waveforms_HPCpyra_ratID214(idx,:)=[];
GC_swr_waveforms_HPCbelo_ratID214(idx,:)=[];

swr_grouped_oscil_table_PFCshal_ratID214(idx,:)=[];
swr_grouped_oscil_table_veh=swr_grouped_oscil_table_PFCshal_ratID214;

for i=1:size(GC_swr_waveforms_PFCshal_ratID214,1)
    GC_swr_ratID214_cbd.waveforms{i,1}(1,:)=GC_swr_waveforms_PFCshal_ratID214{i,1}(1,:);
    GC_swr_ratID214_cbd.waveforms{i,1}(2,:)=GC_swr_waveforms_HPCpyra_ratID214{i,1}(1,:);
    GC_swr_ratID214_cbd.waveforms{i,1}(3,:)=GC_swr_waveforms_HPCbelo_ratID214{i,1}(1,:);
    GC_swr_ratID214_cbd.waveforms{i,1}(4,:)=GC_swr_waveforms_PFCdeep_ratID214{i,1}(1,:);
end

GC_swr_ratID214_cbd.grouped_oscil_table=swr_grouped_oscil_table_veh;

%% Complex SWR
% remove repetitive values/indeces for complex_swr only
combined=[PFCshal_cbd_complex_swr_noise_idx; PFCdeep_cbd_complex_swr_noise_idx; ...
    HPCpyra_cbd_complex_swr_noise_idx;HPCbelo_cbd_complex_swr_noise_idx];
[b,m1,n1] = unique(combined,'first');
[c1,d1] =sort(m1);
rmv = b(d1);
idx=sort(rmv);

% PFCshal
GC_complex_swr_waveforms_PFCshal_ratID214(idx,:)=[];
GC_complex_swr_waveforms_PFCdeep_ratID214(idx,:)=[];
GC_complex_swr_waveforms_HPCpyra_ratID214(idx,:)=[];
GC_complex_swr_waveforms_HPCbelo_ratID214(idx,:)=[];

complex_swr_grouped_oscil_table_PFCshal_ratID214(idx,:)=[];
complex_swr_grouped_oscil_table_veh=complex_swr_grouped_oscil_table_PFCshal_ratID214;

for i=1:size(GC_complex_swr_waveforms_PFCshal_ratID214,1)
    GC_complex_swr_ratID214_cbd.waveforms{i,1}(1,:)=GC_complex_swr_waveforms_PFCshal_ratID214{i,1}(1,:);
    GC_complex_swr_ratID214_cbd.waveforms{i,1}(2,:)=GC_complex_swr_waveforms_HPCpyra_ratID214{i,1}(1,:);
    GC_complex_swr_ratID214_cbd.waveforms{i,1}(3,:)=GC_complex_swr_waveforms_HPCbelo_ratID214{i,1}(1,:);
    GC_complex_swr_ratID214_cbd.waveforms{i,1}(4,:)=GC_complex_swr_waveforms_PFCdeep_ratID214{i,1}(1,:);
end

GC_complex_swr_ratID214_cbd.grouped_oscil_table=complex_swr_grouped_oscil_table_veh;

%%%%%%%%%%
%% SAVE %%
%%%%%%%%%%
data_info=['1)PFCshal; 2)HPCpyra; 3)HPCbelo; 4)PFCdeep'];

clearvars -except data_info GC_ripple_ratID214_cbd GC_sw_ratID214_cbd ...
    GC_swr_ratID214_cbd GC_complex_swr_ratID214_cbd 

save GC_ratID214_cbd.mat

