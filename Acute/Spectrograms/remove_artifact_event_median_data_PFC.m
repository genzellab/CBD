%% Pelin OZsezer

% Remove artifacts from event data (median - PFC)

clc
clear
restoredefaultpath
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD-project/fieldtrip');
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/functions');
addpath('/Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/median');
file_dir= dir(string('/Users/pelinozsezer/Documents/Science/Radboud/CBD-Project/binned-data/median'));
for i=3:22
    load(file_dir(i).name);
end

%% DETEDCTED ARTIFACTS %%

%% PFCshal - CBD - Ripple 
data=GC_PFCshal_ripple_median2000_cbd;

% Detect artifact (overlay all ripples)
x=[];
for i=1:length(data)
    i
    v=data{i,1}(1,:);
    x=[x;v];
end

% bandpass filter
fn=600;
Wn1=[100/(fn/2) 299/(fn/2)]; % cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); % filter coefficients
x=filtfilt(b1,a1,x);

% plot
PFCshal_cbd_noise_idx=[];
t=linspace(-3,3,length(x)-1);
for i=1:size(x,1)  
    if max(diff(x(i,:)))>125 || min(diff(x(i,:)))<-106
       PFCshal_cbd_noise_idx=[PFCshal_cbd_noise_idx;i];
   else
        plot(t,diff(x(i,:)),'b-')
        hold on
         ylim([-2000 2000]) 
        title('PFCshal - Veh')
    end       
end
saveas(gcf,'PFCshal - Veh.jpg')
close all

%% clean data

combined=[ PFCshal_cbd_noise_idx'];
% remove repetitive values
[b,m1,n1] = unique(combined,'first');
[c1,d1] =sort(m1);
rmv = b(d1);
rmv=sort(rmv);

i=rmv;

GC_PFCdeep_ripple_median2000_cbd(i,:)=[];
GC_PFCdeep_ripple_median2000_veh(i,:)=[];
GC_PFCdeep_sw_median2000_cbd(i,:)=[];
GC_PFCdeep_sw_median2000_veh(i,:)=[];
GC_PFCdeep_swr_median2000_cbd(i,:)=[];
GC_PFCdeep_swr_median2000_veh(i,:)=[];
GC_PFCshal_ripple_median2000_cbd(i,:)=[];
GC_PFCshal_ripple_median2000_veh(i,:)=[];
GC_PFCshal_sw_median2000_cbd(i,:)=[];
GC_PFCshal_sw_median2000_veh(i,:)=[];
GC_PFCshal_swr_median2000_cbd(i,:)=[];
GC_PFCshal_swr_median2000_veh(i,:)=[];
    
GC_PFCdeep_swr_median1274_cbd(i>1275,:)=[];
GC_PFCdeep_swr_median1781_veh(i>1782,:)=[];
GC_PFCshal_swr_median1274_cbd(i>1275,:)=[];
GC_PFCshal_swr_median1781_veh(i>1782,:)=[];
GC_PFCshal_complex_swr_median1274_cbd(i>1275,:)=[];
GC_PFCshal_complex_swr_median1781_veh(i>1782,:)=[]; 
GC_PFCdeep_complex_swr_median1274_cbd(i>1275,:)=[];
GC_PFCdeep_complex_swr_median1781_veh(i>1782,:)=[];

clearvars -except -regexp GC
save GC_median_wa.mat
