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
load('ratID210_PFCshal_veh.mat');
data_ripple=GC_ripple_waveforms_PFCshal_ratID210;
data_sw=GC_sw_waveforms_PFCshal_ratID210;
data_swr=GC_swr_waveforms_PFCshal_ratID210;
data_complex_swr=GC_complex_swr_waveforms_PFCshal_ratID210;

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
    if max(abs(diff(x(i,:))))>144
       PFCshal_veh_ripple_noise_idx=[PFCshal_veh_ripple_noise_idx;i];
   else
        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('PFCshal - veh - Ripple')
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
PFCshal_veh_sw_noise_idx=[];
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
    if max(abs(diff(x(i,:))))>135
       PFCshal_veh_sw_noise_idx=[PFCshal_veh_sw_noise_idx;i];
   else
        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('PFCshal - veh - SW')
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
PFCshal_veh_swr_noise_idx=[];
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
    if max(abs(diff(x(i,:))))>200
       PFCshal_veh_swr_noise_idx=[PFCshal_veh_swr_noise_idx;i];
   else
        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('PFCshal - veh - SWR')  
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
PFCshal_veh_complex_swr_noise_idx=[];
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
        if max(abs(diff(x(i,:))))>113
       PFCshal_veh_complex_swr_noise_idx=[PFCshal_veh_complex_swr_noise_idx;i];
   else
        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('PFCshal - veh - Complex SWR')     
        end
end



%% PFCdeep %%

%% CHECK ARTIFACT IN DATA
load('ratID210_PFCdeep_veh.mat');
data_ripple=GC_ripple_waveforms_PFCdeep_ratID210;
data_sw=GC_sw_waveforms_PFCdeep_ratID210;
data_swr=GC_swr_waveforms_PFCdeep_ratID210;
data_complex_swr=GC_complex_swr_waveforms_PFCdeep_ratID210;

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
PFCdeep_veh_ripple_noise_idx=[];
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
    if max(abs(diff(x(i,:))))>212
       PFCdeep_veh_ripple_noise_idx=[PFCdeep_veh_ripple_noise_idx;i];
   else
        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('PFCdeep - veh - Ripple')
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
PFCdeep_veh_sw_noise_idx=[];
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
    if max(abs(diff(x(i,:))))>152
       PFCdeep_veh_sw_noise_idx=[PFCdeep_veh_sw_noise_idx;i];
   else
        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('PFCdeep - veh - SW')
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
PFCdeep_veh_swr_noise_idx=[];
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1) 
    if max(abs(diff(x(i,:))))>162
       PFCdeep_veh_swr_noise_idx=[PFCdeep_veh_swr_noise_idx;i];
   else
        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('PFCdeep - veh - SWR') 
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
PFCdeep_veh_complex_swr_noise_idx=[];
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
            if max(abs(diff(x(i,:))))>114
       PFCdeep_veh_complex_swr_noise_idx=[PFCdeep_veh_complex_swr_noise_idx;i];
   else
        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('PFCdeep - veh - Complex SWR')  
            end
       
end

%%%%%%%%%
%% HPC %%
%%%%%%%%%
close all
cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/HPC

%% HPCpyra %%

%% CHECK ARTIFACT IN DATA
load('ratID210_HPC_veh.mat');
data_ripple=GC_ripple_waveforms_HPCpyra_ratID210;
data_sw=GC_sw_waveforms_HPCpyra_ratID210;
data_swr=GC_swr_waveforms_HPCpyra_ratID210;
data_complex_swr=GC_complex_swr_waveforms_HPCpyra_ratID210;

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
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
            if max(abs(diff(x(i,:))))>400
       HPCpyra_veh_ripple_noise_idx=[HPCpyra_veh_ripple_noise_idx;i];
        else

        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('HPCpyra - veh - Ripple')
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
HPCpyra_veh_sw_noise_idx=[];
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
                if max(abs(diff(x(i,:))))>2000
       HPCpyra_veh_sw_noise_idx=[HPCpyra_veh_sw_noise_idx;i];
        else


        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('HPCpyra - veh - SW')
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
HPCpyra_veh_swr_noise_idx=[];
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
                if max(abs(diff(x(i,:))))>500
       HPCpyra_veh_swr_noise_idx=[HPCpyra_veh_swr_noise_idx;i];
        else
        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('HPCpyra - veh - SWR')  
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
HPCpyra_veh_complex_swr_noise_idx=[];
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('HPCpyra - veh - Complex SWR')     
end



%% HPCbelo %%

%% CHECK ARTIFACT IN DATA
data_ripple=GC_ripple_waveforms_HPCbelo_ratID210;
data_sw=GC_sw_waveforms_HPCbelo_ratID210;
data_swr=GC_swr_waveforms_HPCbelo_ratID210;
data_complex_swr=GC_complex_swr_waveforms_HPCbelo_ratID210;

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
HPCbelo_veh_ripple_noise_idx=[];
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
                if max(abs(diff(x(i,:))))>500
       HPCbelo_veh_ripple_noise_idx=[HPCbelo_veh_ripple_noise_idx;i];
        else

        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('HPCbelo - veh - Ripple')
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
HPCbelo_veh_sw_noise_idx=[];
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
                    if max(abs(diff(x(i,:))))>500
       HPCbelo_veh_sw_noise_idx=[HPCbelo_veh_sw_noise_idx;i];
        else


        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-1500 1500]) 
        title('HPCbelo - veh - SW')
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
HPCbelo_veh_swr_noise_idx=[];
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
                        if max(abs(diff(x(i,:))))>121
       HPCbelo_veh_sw_noise_idx=[HPCbelo_veh_sw_noise_idx;i];
        else


        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('HPCbelo - veh - SWR')  
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
HPCbelo_veh_complex_swr_noise_idx=[];
%t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
                            if max(abs(diff(x(i,:))))>2150
       HPCbelo_veh_sw_noise_idx=[HPCbelo_veh_sw_noise_idx;i];
        else
        plot(abs(diff(x(i,:))),'b-')
        hold on
         ylim([-500 500]) 
        title('HPCbelo - veh - Complex SWR')     
                            end
end


%%%%%%%%%%%%%%%%%%
%% REMOVE NOISE %%
%%%%%%%%%%%%%%%%%%
close all
cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project
clearvars -except -regexp noise
cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/data_3by3601_per_rat
save noise_idx_ratID210.mat
%%
cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/PFC
load('ratID210_PFCshal_veh.mat');
load('ratID210_PFCdeep_veh.mat');

cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/HPC
load('ratID210_HPC_veh.mat');

cd /Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/data_3by3601_per_rat

%% Ripple
% remove repetitive values/indeces for Ripple only
combined=[PFCshal_veh_ripple_noise_idx; PFCdeep_veh_ripple_noise_idx; ...
    HPCpyra_veh_ripple_noise_idx;HPCbelo_veh_ripple_noise_idx];
[b,m1,n1] = unique(combined,'first');
[c1,d1] =sort(m1);
rmv = b(d1);
idx=sort(rmv);

% PFCshal
GC_ripple_waveforms_PFCshal_ratID210(idx,:)=[];
GC_ripple_waveforms_PFCdeep_ratID210(idx,:)=[];
GC_ripple_waveforms_HPCpyra_ratID210(idx,:)=[];
GC_ripple_waveforms_HPCbelo_ratID210(idx,:)=[];

ripple_grouped_oscil_table_PFCshal_ratID210(idx,:)=[];
ripple_grouped_oscil_table_veh=ripple_grouped_oscil_table_PFCshal_ratID210;

for i=1:size(GC_ripple_waveforms_PFCshal_ratID210,1)
    GC_ripple_ratID210_veh.waveforms{i,1}(1,:)=GC_ripple_waveforms_PFCshal_ratID210{i,1}(1,:);
    GC_ripple_ratID210_veh.waveforms{i,1}(2,:)=GC_ripple_waveforms_HPCpyra_ratID210{i,1}(1,:);
    GC_ripple_ratID210_veh.waveforms{i,1}(3,:)=GC_ripple_waveforms_HPCbelo_ratID210{i,1}(1,:);
    GC_ripple_ratID210_veh.waveforms{i,1}(4,:)=GC_ripple_waveforms_PFCdeep_ratID210{i,1}(1,:);
end

GC_ripple_ratID210_veh.grouped_oscil_table=ripple_grouped_oscil_table_veh;


%% SW
% remove repetitive values/indeces for SW only
combined=[PFCshal_veh_sw_noise_idx; PFCdeep_veh_sw_noise_idx; ...
    HPCpyra_veh_sw_noise_idx;HPCbelo_veh_sw_noise_idx];
[b,m1,n1] = unique(combined,'first');
[c1,d1] =sort(m1);
rmv = b(d1);
idx=sort(rmv);

% PFCshal
GC_sw_waveforms_PFCshal_ratID210(idx,:)=[];
GC_sw_waveforms_PFCdeep_ratID210(idx,:)=[];
GC_sw_waveforms_HPCpyra_ratID210(idx,:)=[];
GC_sw_waveforms_HPCbelo_ratID210(idx,:)=[];

sw_grouped_oscil_table_PFCshal_ratID210(idx,:)=[];
sw_grouped_oscil_table_veh=sw_grouped_oscil_table_PFCshal_ratID210;

for i=1:size(GC_sw_waveforms_PFCshal_ratID210,1)
    GC_sw_ratID210_veh.waveforms{i,1}(1,:)=GC_sw_waveforms_PFCshal_ratID210{i,1}(1,:);
    GC_sw_ratID210_veh.waveforms{i,1}(2,:)=GC_sw_waveforms_HPCpyra_ratID210{i,1}(1,:);
    GC_sw_ratID210_veh.waveforms{i,1}(3,:)=GC_sw_waveforms_HPCbelo_ratID210{i,1}(1,:);
    GC_sw_ratID210_veh.waveforms{i,1}(4,:)=GC_sw_waveforms_PFCdeep_ratID210{i,1}(1,:);
end

GC_sw_ratID210_veh.grouped_oscil_table=sw_grouped_oscil_table_veh;

%% SWR
% remove repetitive values/indeces for swr only
combined=[PFCshal_veh_swr_noise_idx; PFCdeep_veh_swr_noise_idx; ...
    HPCpyra_veh_swr_noise_idx;HPCbelo_veh_swr_noise_idx];
[b,m1,n1] = unique(combined,'first');
[c1,d1] =sort(m1);
rmv = b(d1);
idx=sort(rmv);

% PFCshal
GC_swr_waveforms_PFCshal_ratID210(idx,:)=[];
GC_swr_waveforms_PFCdeep_ratID210(idx,:)=[];
GC_swr_waveforms_HPCpyra_ratID210(idx,:)=[];
GC_swr_waveforms_HPCbelo_ratID210(idx,:)=[];

swr_grouped_oscil_table_PFCshal_ratID210(idx,:)=[];
swr_grouped_oscil_table_veh=swr_grouped_oscil_table_PFCshal_ratID210;

for i=1:size(GC_swr_waveforms_PFCshal_ratID210,1)
    GC_swr_ratID210_veh.waveforms{i,1}(1,:)=GC_swr_waveforms_PFCshal_ratID210{i,1}(1,:);
    GC_swr_ratID210_veh.waveforms{i,1}(2,:)=GC_swr_waveforms_HPCpyra_ratID210{i,1}(1,:);
    GC_swr_ratID210_veh.waveforms{i,1}(3,:)=GC_swr_waveforms_HPCbelo_ratID210{i,1}(1,:);
    GC_swr_ratID210_veh.waveforms{i,1}(4,:)=GC_swr_waveforms_PFCdeep_ratID210{i,1}(1,:);
end

GC_swr_ratID210_veh.grouped_oscil_table=swr_grouped_oscil_table_veh;

%% Complex SWR
% remove repetitive values/indeces for complex_swr only
combined=[PFCshal_veh_complex_swr_noise_idx; PFCdeep_veh_complex_swr_noise_idx; ...
    HPCpyra_veh_complex_swr_noise_idx;HPCbelo_veh_complex_swr_noise_idx];
[b,m1,n1] = unique(combined,'first');
[c1,d1] =sort(m1);
rmv = b(d1);
idx=sort(rmv);

% PFCshal
GC_complex_swr_waveforms_PFCshal_ratID210(idx,:)=[];
GC_complex_swr_waveforms_PFCdeep_ratID210(idx,:)=[];
GC_complex_swr_waveforms_HPCpyra_ratID210(idx,:)=[];
GC_complex_swr_waveforms_HPCbelo_ratID210(idx,:)=[];

complex_swr_grouped_oscil_table_PFCshal_ratID210(idx,:)=[];
complex_swr_grouped_oscil_table_veh=complex_swr_grouped_oscil_table_PFCshal_ratID210;

for i=1:size(GC_complex_swr_waveforms_PFCshal_ratID210,1)
    GC_complex_swr_ratID210_veh.waveforms{i,1}(1,:)=GC_complex_swr_waveforms_PFCshal_ratID210{i,1}(1,:);
    GC_complex_swr_ratID210_veh.waveforms{i,1}(2,:)=GC_complex_swr_waveforms_HPCpyra_ratID210{i,1}(1,:);
    GC_complex_swr_ratID210_veh.waveforms{i,1}(3,:)=GC_complex_swr_waveforms_HPCbelo_ratID210{i,1}(1,:);
    GC_complex_swr_ratID210_veh.waveforms{i,1}(4,:)=GC_complex_swr_waveforms_PFCdeep_ratID210{i,1}(1,:);
end

GC_complex_swr_ratID210_veh.grouped_oscil_table=complex_swr_grouped_oscil_table_veh;

%%%%%%%%%%
%% SAVE %%
%%%%%%%%%%
data_info=['1)PFCshal; 2)HPCpyra; 3)HPCbelo; 4)PFCdeep'];

clearvars -except data_info GC_ripple_ratID210_veh GC_sw_ratID210_veh ...
    GC_swr_ratID210_veh GC_complex_swr_ratID210_veh 

save GC_ratID210_veh.mat

