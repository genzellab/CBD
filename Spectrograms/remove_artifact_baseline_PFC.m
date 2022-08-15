%% Pelin Ozsezer

%% Remove artifacts from the baseline data

clc
clear
load('baseline_2000_PFC.mat');
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/functions');

%%%%%%%%%%%%%
%% PFCshal %%
%%%%%%%%%%%%%

%% Vehicle
data=GC_baseline_PFCshal_veh;

% Detect artifact (overlay all ripples)
x=[];
for i=1:length(data)
    i
    v=data{i,1}(1,:);
    x=[x;v];
end

% bandpass filter
fn=600;
Wn1=[100/(fn/2) 299/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
x=filtfilt(b1,a1,x);

% plot
PFCshal_veh_noise_idx=[];
t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
    if max(diff(x(i,:)))>223 || min(diff(x(i,:)))<-166
       PFCshal_veh_noise_idx=[PFCshal_veh_noise_idx;i];
   else
        plot(t,diff(x(i,:)),'b-')
        hold on
         ylim([-2000 2000]) 
        title('PFCshal - Veh')
    end       
end
saveas(gcf,'PFCshal - Veh.jpg')
close all

%% CBD
data=GC_baseline_PFCshal_cbd;

% Detect artifact (overlay all ripples)
x=[];
for i=1:length(data)
    i
    v=data{i,1}(1,:);
    x=[x;v];
end

% bandpass filter
fn=600;
Wn1=[100/(fn/2) 299/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
x=filtfilt(b1,a1,x);

% plot
PFCshal_cbd_noise_idx=[];
t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
    if max(diff(x(i,:)))>149 || min(diff(x(i,:)))<-139 ...
            %|| max(diff(x(i,findclosest(t,-0.2):findclosest(t,-0.1))))>90 ...
            %|| min(diff(x(i,findclosest(t,-0.2):findclosest(t,-0.1))))<-40

       PFCshal_cbd_noise_idx=[PFCshal_cbd_noise_idx;i];
   else
       plot(t,diff(x(i,:)),'b-')
       hold on
       ylim([-2000 2000])
       title('PFCshal - CBD')
    end       
end
saveas(gcf,'PFCshal - CBD.jpg')
close all


%%%%%%%%%%%%%
%% PFCdeep %%
%%%%%%%%%%%%%

%% Vehicle
data=GC_baseline_PFCdeep_veh;

% Detect artifact (overlay all ripples)
x=[];
for i=1:length(data)
    i
    v=data{i,1}(1,:);
    x=[x;v];
end

% bandpass filter
fn=600;
Wn1=[100/(fn/2) 299/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
x=filtfilt(b1,a1,x);

% plot
PFCdeep_veh_noise_idx=[];
t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
    if max(diff(x(i,:)))>550 || min(diff(x(i,:)))<-200
       PFCdeep_veh_noise_idx=[PFCdeep_veh_noise_idx;i];
   else
       plot(t,diff(x(i,:)),'b-')
       hold on
       ylim([-2000 2000])
       xlim([-1 1])
       title('PFCdeep - Veh')
    end       
end
saveas(gcf,'PFCdeep - Veh.jpg')
close all


%% CBD
data=GC_baseline_PFCdeep_cbd;

% Detect artifact (overlay all ripples)
x=[];
for i=1:length(data)
    i
    v=data{i,1}(1,:);
    x=[x;v];
end

% bandpass filter
fn=600;
Wn1=[100/(fn/2) 299/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
x=filtfilt(b1,a1,x);

% plot
PFCdeep_cbd_noise_idx=[];
t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
    if max(diff(x(i,:)))>149 || min(diff(x(i,:)))<-204
       PFCdeep_cbd_noise_idx=[PFCdeep_cbd_noise_idx;i];
   else
       plot(t,diff(x(i,:)),'b-')
       hold on
       ylim([-2000 2000])
       xlim([-1 1])
       title('PFCdeep - CBD')
    end       
end
saveas(gcf,'PFCdeep - CBD.jpg')
close all


%% clean data now %%

combined=[PFCshal_veh_noise_idx' PFCshal_cbd_noise_idx' PFCdeep_veh_noise_idx' PFCdeep_cbd_noise_idx'];
% remove repetitive values
[b,m1,n1] = unique(combined,'first');
[c1,d1] =sort(m1);
rmv = b(d1);
rmv=sort(rmv);

    i=rmv;
    GC_baseline_PFCshal_veh(i,:)=[];
    GC_baseline_PFCshal_cbd(i,:)=[];
    GC_baseline_PFCdeep_veh(i,:)=[];
    GC_baseline_PFCdeep_cbd(i,:)=[];

clearvars -except -regexp GC
save baseline_PFC_wa.mat
