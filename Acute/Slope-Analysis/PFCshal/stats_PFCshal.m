
%% Statistics for PFCshal All  Events & event Types
clear
cd /home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data

%% All Events %%

% Vehicle
slopes_PFCshal_all_events_veh = readmatrix("slopes_PFCshal_all_events_veh.csv");
slopes_PFCshal_all_events_veh=-1*slopes_PFCshal_all_events_veh(2:end,2);
% CBD
slopes_PFCshal_all_events_cbd = readmatrix("slopes_PFCshal_all_events_cbd.csv");
slopes_PFCshal_all_events_cbd=-1*slopes_PFCshal_all_events_cbd(2:end,2);

% [h,p]=ttest2(slopes_PFCshal_all_events_veh,slopes_PFCshal_all_events_cbd)

% Baseline - Vehicle
slopes_PFCshal_baseline_veh = readmatrix("slopes_PFCshal_baseline_veh.csv");
slopes_PFCshal_baseline_veh=-1*slopes_PFCshal_baseline_veh(2:end,2);

% Baseline - CBD
slopes_PFCshal_baseline_cbd = readmatrix("slopes_PFCshal_baseline_cbd.csv");
slopes_PFCshal_baseline_cbd=-1*slopes_PFCshal_baseline_cbd(2:end,2);

%% Plotting
avg_all_veh=mean(slopes_PFCshal_all_events_veh);
sd_all_veh=std(slopes_PFCshal_all_events_veh);

avg_all_cbd=mean(slopes_PFCshal_all_events_cbd);
sd_all_cbd=std(slopes_PFCshal_all_events_cbd);

avg_baseline_veh=mean(slopes_PFCshal_baseline_veh);
sd_baseline_veh=std(slopes_PFCshal_baseline_veh);

avg_baseline_cbd=mean(slopes_PFCshal_baseline_cbd);
sd_baseline_cbd=std(slopes_PFCshal_baseline_cbd);

% plot
figure;
errorbar(1,avg_baseline_veh, sd_baseline_veh ,'square',...
    'MarkerSize',15,'CapSize',15,'LineWidth',2,'Color','k')
hold on

errorbar(2,avg_baseline_cbd, sd_baseline_cbd ,'square',...
    'MarkerSize',15,'CapSize',15,'LineWidth',2,'Color','g')

errorbar(3,avg_all_veh, sd_all_veh ,'o',...
    'MarkerSize',15,'CapSize',15,'LineWidth',2,'Color','k')

errorbar(4,avg_all_cbd, sd_all_cbd ,'o',...
    'MarkerSize',15,'CapSize',15,'LineWidth',2,'Color','g')



title('Slope Comparison - PFCshal')
xlabel('Pair Type')
ylabel('Slope')
xlim([0 5])
xticklabels({'','base-veh','base-cbd','all-veh','all-cbd',''})

saveas(gcf,'slopeComparison_visual_PFCshal.pdf');
saveas(gcf,'slopeComparison_visual_PFCshal.jpg');
saveas(gcf,'slopeComparison_visual_PFCshal.fig');
close all

%% data preparation
x1=ones(1200,1);
x2=2*ones(1200,1);

data=[x2 x1 slopes_PFCshal_all_events_veh;...
    x2 x2 slopes_PFCshal_all_events_cbd;...
    x1 x1 slopes_PFCshal_baseline_veh;...
    x1 x2 slopes_PFCshal_baseline_cbd];

save data.mat data 

clearvars -except -regexp slope
FileData = load('data.mat');
csvwrite('data.csv', FileData.data);


% v2-4groups
clear FileData
x1=ones(1200,1);
x2=2*ones(1200,1);
x3=3*ones(1200,1);
x4=4*ones(1200,1);

datav2=[x1 slopes_PFCshal_all_events_veh;...
    x2 slopes_PFCshal_all_events_cbd;...
    x3 slopes_PFCshal_baseline_veh;...
    x4 slopes_PFCshal_baseline_cbd];

save datav2.mat datav2 

FileData = load('datav2.mat');
csvwrite('datav2.csv', FileData.datav2);

%% Event Types %%

%% Vehicle
clc
clear

% Baseline - Vehicle
slopes_PFCshal_baseline_veh = readmatrix("slopes_PFCshal_baseline_veh.csv");
slopes_PFCshal_baseline_veh=-1*slopes_PFCshal_baseline_veh(2:end,2);

% Ripple
slopes_PFCshal_ripple_veh = readmatrix("slopes_PFCshal_ripple_veh.csv");
slopes_PFCshal_ripple_veh=-1*slopes_PFCshal_ripple_veh(2:end,2);

% SW
slopes_PFCshal_sw_veh = readmatrix("slopes_PFCshal_sw_veh.csv");
slopes_PFCshal_sw_veh=-1*slopes_PFCshal_sw_veh(2:end,2);

% SWR
slopes_PFCshal_swr_veh = readmatrix("slopes_PFCshal_swr_veh.csv");
slopes_PFCshal_swr_veh=-1*slopes_PFCshal_swr_veh(2:end,2);

% Complex SWR
slopes_PFCshal_complex_swr_veh = readmatrix("slopes_PFCshal_complex_swr_veh.csv");
slopes_PFCshal_complex_swr_veh=-1*slopes_PFCshal_complex_swr_veh(2:end,2);

%% Plotting
avg_baseline_veh=mean(slopes_PFCshal_baseline_veh);
sd_baseline_veh=std(slopes_PFCshal_baseline_veh);

avg_ripple_veh=mean(slopes_PFCshal_ripple_veh);
sd_ripple_veh=std(slopes_PFCshal_ripple_veh);

avg_sw_veh=mean(slopes_PFCshal_sw_veh);
sd_sw_veh=std(slopes_PFCshal_sw_veh);

avg_swr_veh=mean(slopes_PFCshal_swr_veh);
sd_swr_veh=std(slopes_PFCshal_swr_veh);

avg_complex_swr_veh=mean(slopes_PFCshal_complex_swr_veh);
sd_complex_swr_veh=std(slopes_PFCshal_complex_swr_veh);


% plot
figure;
errorbar(1,avg_baseline_veh, sd_baseline_veh ,'square',...
    'MarkerSize',15,'CapSize',15,'LineWidth',2,'Color','k')
hold on

errorbar(2,avg_ripple_veh, sd_ripple_veh ,'^',...
    'MarkerSize',15,'CapSize',15,'LineWidth',2,'Color','k')

errorbar(3,avg_sw_veh, sd_sw_veh ,'v',...
    'MarkerSize',15,'CapSize',15,'LineWidth',2,'Color','k')

errorbar(4,avg_swr_veh, sd_swr_veh ,'diamond',...
    'MarkerSize',15,'CapSize',15,'LineWidth',2,'Color','k')

errorbar(5,avg_complex_swr_veh, sd_complex_swr_veh ,'hexagram',...
    'MarkerSize',15,'CapSize',15,'LineWidth',2,'Color','k')


title('Slope Comparison - PFCshal - Vehicle')
xlabel('Event type')
ylabel('Slope')
xlim([0 6])
ylim([-2.8 -1.59])
xticklabels({'','Base','Ripple','SW','SWR','cSWR'})

saveas(gcf,'slopeComparison_visual_PFCshal_veh.pdf');
saveas(gcf,'slopeComparison_visual_PFCshal_veh.jpg');
saveas(gcf,'slopeComparison_visual_PFCshal_veh.fig');
close all

%% data preparation
x1=ones(1200,1);
x2=2*ones(1200,1);
x3=3*ones(1200,1);
x4=4*ones(1200,1);
x5=5*ones(1200,1);

data_veh=[x1 slopes_PFCshal_baseline_veh;...
    x2 slopes_PFCshal_ripple_veh;...
    x3 slopes_PFCshal_sw_veh;...
    x4 slopes_PFCshal_swr_veh;...
    x5 slopes_PFCshal_complex_swr_veh];

save data_veh.mat data_veh 

clear
FileData = load('data_veh.mat');
csvwrite('data_veh.csv', FileData.data_veh);



%% CBD
clc
clear

% Baseline - cbdicle
slopes_PFCshal_baseline_cbd = readmatrix("slopes_PFCshal_baseline_cbd.csv");
slopes_PFCshal_baseline_cbd=-1*slopes_PFCshal_baseline_cbd(2:end,2);

% Ripple
slopes_PFCshal_ripple_cbd = readmatrix("slopes_PFCshal_ripple_cbd.csv");
slopes_PFCshal_ripple_cbd=-1*slopes_PFCshal_ripple_cbd(2:end,2);

% SW
slopes_PFCshal_sw_cbd = readmatrix("slopes_PFCshal_sw_cbd.csv");
slopes_PFCshal_sw_cbd=-1*slopes_PFCshal_sw_cbd(2:end,2);

% SWR
slopes_PFCshal_swr_cbd = readmatrix("slopes_PFCshal_swr_cbd.csv");
slopes_PFCshal_swr_cbd=-1*slopes_PFCshal_swr_cbd(2:end,2);

% Complex SWR
slopes_PFCshal_complex_swr_cbd = readmatrix("slopes_PFCshal_complex_swr_cbd.csv");
slopes_PFCshal_complex_swr_cbd=-1*slopes_PFCshal_complex_swr_cbd(2:end,2);

%% Plotting
avg_baseline_cbd=mean(slopes_PFCshal_baseline_cbd);
sd_baseline_cbd=std(slopes_PFCshal_baseline_cbd);

avg_ripple_cbd=mean(slopes_PFCshal_ripple_cbd);
sd_ripple_cbd=std(slopes_PFCshal_ripple_cbd);

avg_sw_cbd=mean(slopes_PFCshal_sw_cbd);
sd_sw_cbd=std(slopes_PFCshal_sw_cbd);

avg_swr_cbd=mean(slopes_PFCshal_swr_cbd);
sd_swr_cbd=std(slopes_PFCshal_swr_cbd);

avg_complex_swr_cbd=mean(slopes_PFCshal_complex_swr_cbd);
sd_complex_swr_cbd=std(slopes_PFCshal_complex_swr_cbd);


% plot
figure;
errorbar(1,avg_baseline_cbd, sd_baseline_cbd ,'square',...
    'MarkerSize',15,'CapSize',15,'LineWidth',2,'Color','g')
hold on

errorbar(2,avg_ripple_cbd, sd_ripple_cbd ,'^',...
    'MarkerSize',15,'CapSize',15,'LineWidth',2,'Color','g')

errorbar(3,avg_sw_cbd, sd_sw_cbd ,'v',...
    'MarkerSize',15,'CapSize',15,'LineWidth',2,'Color','g')

errorbar(4,avg_swr_cbd, sd_swr_cbd ,'diamond',...
    'MarkerSize',15,'CapSize',15,'LineWidth',2,'Color','g')

errorbar(5,avg_complex_swr_cbd, sd_complex_swr_cbd ,'hexagram',...
    'MarkerSize',15,'CapSize',15,'LineWidth',2,'Color','g')


title('Slope Comparison - PFCshal - CBD')
xlabel('Event type')
ylabel('Slope')
xlim([0 6])
ylim([-2.8 -1.59])

xticklabels({'','Base','Ripple','SW','SWR','cSWR'})
saveas(gcf,'slopeComparison_visual_PFCshal_cbd.pdf');
saveas(gcf,'slopeComparison_visual_PFCshal_cbd.jpg');
saveas(gcf,'slopeComparison_visual_PFCshal_cbd.fig');
close all

%% data preparation
x1=ones(1200,1);
x2=2*ones(1200,1);
x3=3*ones(1200,1);
x4=4*ones(1200,1);
x5=5*ones(1200,1);

data_cbd=[x1 slopes_PFCshal_baseline_cbd;...
    x2 slopes_PFCshal_ripple_cbd;...
    x3 slopes_PFCshal_sw_cbd;...
    x4 slopes_PFCshal_swr_cbd;...
    x5 slopes_PFCshal_complex_swr_cbd];

save data_cbd.mat data_cbd 

clear
FileData = load('data_cbd.mat');
csvwrite('data_cbd.csv', FileData.data_cbd);

