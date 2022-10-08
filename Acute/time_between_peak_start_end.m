cd('/home/adrian/Documents/SWR_classifier/wetransfer_per_rat/Data_for_Ripple_Classifier/veh/new_GC_features_entropy')

rat=[3,4,9,201,203,206,210,211,213];
% rat=[2,5,10,11,204,205,207,209,212,214];
all=[3,4,9,201,203,206,210,211,213,2,5,10,11,204,205,207,209,212,214];
all=sort(all);

for i=1: length(rat)

load(['GC_ratID' num2str(rat(i)) '_veh.mat'])


% complex=GC_complex_swr_ratID3_veh;
complex=eval( ['GC_complex_swr_ratID' num2str(rat(i)) '_veh']);
complex=complex.grouped_oscil_table;

% swr=GC_swr_ratID3_veh;
swr=eval( ['GC_swr_ratID' num2str(rat(i)) '_veh']);
swr=swr.grouped_oscil_table;

% ripple=GC_ripple_ratID3_veh;
ripple=eval( ['GC_ripple_ratID' num2str(rat(i)) '_veh']);
ripple=ripple.grouped_oscil_table;



% peak-start
complex_ps=(complex.Peak-complex.Start)/600;
swr_ps=(swr.Peak-swr.Start)/600;
ripple_ps=(ripple.Peak-ripple.Start)/600;

% end-peak
complex_ep=(complex.End-complex.Peak)/600;
swr_ep=(swr.End-swr.Peak)/600;
ripple_ep=(ripple.End-ripple.Peak)/600;

Complex_ps{i}=complex_ps;
Complex_ep{i}=complex_ep;

SWR_ps{i}=swr_ps;
SWR_ep{i}=swr_ep;

Ripple_ps{i}=ripple_ps;
Ripple_ep{i}=ripple_ep;

end
xo
%%
Ripple_ps=vertcat(Ripple_ps{:});
Ripple_ep=vertcat(Ripple_ep{:});

SWR_ps=vertcat(SWR_ps{:});
SWR_ep=vertcat(SWR_ep{:});

Complex_ps=vertcat(Complex_ps{:});
Complex_ep=vertcat(Complex_ep{:});
%% Median values
[
median(Ripple_ps)
median(Ripple_ep)

median(SWR_ps)
median(SWR_ep)


median(Complex_ps)
median(Complex_ep)
]

%% 
[
prctile(Ripple_ps,95)
prctile(Ripple_ep,95)

prctile(SWR_ps,95)
prctile(SWR_ep,95)


prctile(Complex_ps,95)
prctile(Complex_ep,95)
]

%%
 
edges=0:.01:1;
subplot(2,1,1)
histogram(Complex_ps*1000,edges*1000,'Normalization','probability','FaceColor','g')
% hold on
% histogram(Complex_ep*1000,edges*1000,'Normalization','probability')
xlim([0:1]*500)
ylim([0 0.15])
xlabel('Time (ms)')
title('Complex SWR (Start-to-Peak delay)')
% printing('Complex_SWR_SP')
% close all

subplot(2,1,2)

%histogram(Complex_ps*1000,edges*1000,'Normalization','probability','FaceColor','g')
% hold on
histogram(Complex_ep*1000,edges*1000,'Normalization','probability','FaceColor','g')
xlim([0:1]*500)
ylim([0 0.15])

xlabel('Time (ms)')
title('Complex SWR (Peak-to-End delay)')
printing('Complex_veh')
printing_image('Complex_veh')
%%   Ripples
edges=0:.01:1;
subplot(2,1,1)
histogram(Ripple_ps*1000,edges*1000,'Normalization','probability','FaceColor','g')
% hold on
% histogram(Ripple_ep*1000,edges*1000,'Normalization','probability')
xlim([0:1]*500)
ylim([0 0.2])
xlabel('Time (ms)')
title('Ripple (Start-to-Peak delay)')
% printing('Ripple_SWR_SP')
% close all

subplot(2,1,2)

%histogram(Ripple_ps*1000,edges*1000,'Normalization','probability','FaceColor','g')
% hold on
histogram(Ripple_ep*1000,edges*1000,'Normalization','probability','FaceColor','g')
xlim([0:1]*500)
ylim([0 0.2])

xlabel('Time (ms)')
title('Ripple (Peak-to-End delay)')
printing('Ripple_veh')
printing_image('Ripple_veh')

%% SWR
edges=0:.01:1;
subplot(2,1,1)
histogram(SWR_ps*1000,edges*1000,'Normalization','probability','FaceColor','g')
% hold on
% histogram(SWR_ep*1000,edges*1000,'Normalization','probability')
xlim([0:1]*500)
ylim([0 0.2])
xlabel('Time (ms)')
title('SWR (Start-to-Peak delay)')
% printing('SWR_SWR_SP')
% close all

subplot(2,1,2)

%histogram(SWR_ps*1000,edges*1000,'Normalization','probability','FaceColor','g')
% hold on
histogram(SWR_ep*1000,edges*1000,'Normalization','probability','FaceColor','g')
xlim([0:1]*500)
ylim([0 0.2])

xlabel('Time (ms)')
title('SWR (Peak-to-End delay)')
printing('SWR_veh')

printing_image('SWR_veh')





