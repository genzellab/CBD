clear variables 
load('Phase_AllRats_form_1.mat')
load('Phase_AllRats_form_2.mat')
load('Phase_AllRats_form_4.mat')
load('Phase_AllRats_form_6.mat')
addpath('/Volumes/Samsung_T5/Milan_DA/RGS14_Ephys_da/Data_RGS14_Downsampled_First_Session/circstat-matlab-master')
addpath('/Volumes/Samsung_T5/Milan_DA/OS_ephys_da/ADRITOOLS')
cbd_rats = [2 5 10 11 204 205 207 209 212 214];
veh_rats = [3 4 9 201 203 206 210 211 213];
ratIDs = [2 3 4 5 9 10 11 201 203 204 205 206 207 209 210 211 212 213 214]; %Rat IDs
%% Animal wise plots
c = 0;
v = 0;
 for j =  1:size(SO_phase_f1_total,1)
   
SO_phase_f1 = SO_phase_f1_total{j};
circmean_f1 = 360+(rad2deg(circ_mean(deg2rad(SO_phase_f1))));

SO_phase_f2 = SO_phase_f2_total{j};
circmean_f2 = 360+(rad2deg(circ_mean(deg2rad(SO_phase_f2))));

SO_phase_f4 = SO_phase_f4_total{j};
circmean_f4 = 360+(rad2deg(circ_mean(deg2rad(SO_phase_f4))));

SO_phase_f6 = SO_phase_f6_total{j};
circmean_f6 = 360+(rad2deg(circ_mean(deg2rad(SO_phase_f6))));

ratno  = ratIDs(j);

    if  ismember(ratno,cbd_rats)
        c = c+1;
       CBD_f1{c,1} = SO_phase_f1;
       CBD_f2{c,1} = SO_phase_f2;
       CBD_f4{c,1} = SO_phase_f4;
       CBD_f6{c,1} = SO_phase_f6;
       circmean_f1_cbdrats(c,1) = circmean_f1;
       circmean_f2_cbdrats(c,1) = circmean_f2;
       circmean_f4_cbdrats(c,1) = circmean_f4;
       circmean_f6_cbdrats(c,1) = circmean_f6;
       
subplot(2,2,1)
polarhistogram(deg2rad(SO_phase_f1),18,'Normalization','probability','FaceColor','#77AC30')
hold on
polarplot(deg2rad([circmean_f1,circmean_f1]), [0,1],'LineWidth',1)
rlim([0 0.15])
title(strcat('Rat',num2str(ratno),' Sharp wave'))

subplot(2,2,2)
polarhistogram(deg2rad(SO_phase_f2),18,'Normalization','probability','FaceColor','#77AC30')
hold on
polarplot(deg2rad([circmean_f2,circmean_f2]), [0,1],'LineWidth',1)
rlim([0 0.15])
title(strcat('Rat',num2str(ratno),' Ripple'))

subplot(2,2,3)
polarhistogram(deg2rad(SO_phase_f4),18,'Normalization','probability','FaceColor','#77AC30')
hold on
polarplot(deg2rad([circmean_f4,circmean_f4]), [0,1],'LineWidth',1)
rlim([0 0.15])
title(strcat('Rat',num2str(ratno),' SWR'))

subplot(2,2,4)
polarhistogram(deg2rad(SO_phase_f6),18,'Normalization','probability','FaceColor','#77AC30')
title(strcat('Rat',num2str(ratno),' cSWR'))
hold on
polarplot(deg2rad([circmean_f6,circmean_f6]), [0,1],'LineWidth',1)
rlim([0 0.15])

saveas(gcf, strcat('PolarHist_Rat',num2str(ratno),'.png'))
printing(strcat('PolarHistpdf_Rat',num2str(ratno)))
close all

     else 
   v = v+1;
   Veh_f1{v,1} = SO_phase_f1;
   Veh_f2{v,1} = SO_phase_f2;
   Veh_f4{v,1} = SO_phase_f4;
   Veh_f6{v,1} = SO_phase_f6;
   circmean_f1_vehrats(v,1) = circmean_f1;
   circmean_f2_vehrats(v,1) = circmean_f2;
   circmean_f4_vehrats(v,1) = circmean_f4;
   circmean_f6_vehrats(v,1) = circmean_f6;
   
subplot(2,2,1)
polarhistogram(deg2rad(SO_phase_f1),18,'Normalization','probability','FaceColor','black','FaceAlpha',0.3)
hold on
polarplot(deg2rad([circmean_f1,circmean_f1]), [0,1],'LineWidth',1)
rlim([0 0.15])
title(strcat('Rat',num2str(ratno),' Sharp wave'))

subplot(2,2,2)
polarhistogram(deg2rad(SO_phase_f2),18,'Normalization','probability','FaceColor','black','FaceAlpha',0.3)
hold on
polarplot(deg2rad([circmean_f2,circmean_f2]), [0,1],'LineWidth',1)
rlim([0 0.15])
title(strcat('Rat',num2str(ratno),' Ripple'))

subplot(2,2,3)
polarhistogram(deg2rad(SO_phase_f4),18,'Normalization','probability','FaceColor','black','FaceAlpha',0.3)
hold on
polarplot(deg2rad([circmean_f4,circmean_f4]), [0,1],'LineWidth',1)
rlim([0 0.15])
title(strcat('Rat',num2str(ratno),' SWR'))

subplot(2,2,4)
polarhistogram(deg2rad(SO_phase_f6),18,'Normalization','probability','FaceColor','black','FaceAlpha',0.3)
title(strcat('Rat',num2str(ratno),' cSWR'))
hold on
polarplot(deg2rad([circmean_f6,circmean_f6]), [0,1],'LineWidth',1)
rlim([0 0.15])

saveas(gcf, strcat('PolarHist_Rat',num2str(ratno),'.png'))
printing(strcat('PolarHistpdf_Rat',num2str(ratno)))
close all
     end 
%% Preparing variables for treatment plots
% if  ismember(ratno,cbd_rats)
%     c = c+1;
%    CBD_f1{c,1} = SO_phase_f1;
%    CBD_f2{c,1} = SO_phase_f2;
%    CBD_f4{c,1} = SO_phase_f4;
%    CBD_f6{c,1} = SO_phase_f6;
%    
% else 
%     v = v+1;
%    Veh_f1{v,1} = SO_phase_f1;
%    Veh_f2{v,1} = SO_phase_f2;
%    Veh_f4{v,1} = SO_phase_f4;
%    Veh_f6{v,1} = SO_phase_f6;
% 
% end 
 end 
 %% Treatment overlap plots
 
 CBD_f1 = horzcat(CBD_f1{:});
 CBD_f2 = horzcat(CBD_f2{:});
 CBD_f4 = horzcat(CBD_f4{:});
 CBD_f6 = horzcat(CBD_f6{:});
circmean_cbd_f1 = 360+(rad2deg(circ_mean(deg2rad(CBD_f1))));
circmean_cbd_f2 = 360+(rad2deg(circ_mean(deg2rad(CBD_f2))));
circmean_cbd_f4 = 360+(rad2deg(circ_mean(deg2rad(CBD_f4))));
circmean_cbd_f6 = 360+(rad2deg(circ_mean(deg2rad(CBD_f6))));
 Veh_f1 = horzcat(Veh_f1{:});
 Veh_f2 = horzcat(Veh_f2{:});
 Veh_f4 = horzcat(Veh_f4{:});
 Veh_f6 = horzcat(Veh_f6{:});
circmean_veh_f1 = 360+(rad2deg(circ_mean(deg2rad(Veh_f1))));
circmean_veh_f2 = 360+(rad2deg(circ_mean(deg2rad(Veh_f2))));
circmean_veh_f4 = 360+(rad2deg(circ_mean(deg2rad(Veh_f4))));
circmean_veh_f6 = 360+(rad2deg(circ_mean(deg2rad(Veh_f6))));

 %SW
polarhistogram(deg2rad(CBD_f1),18,'Normalization','probability','FaceColor','#77AC30')
hold on 
polarhistogram(deg2rad(Veh_f1),18,'Normalization','probability','FaceColor','black','FaceAlpha',0.3)
hold on
polarplot(deg2rad([circmean_veh_f1,circmean_veh_f1]), [0,1],'LineWidth',1.5,'Color','#000000')
hold on
polarplot(deg2rad([circmean_cbd_f1,circmean_cbd_f1]), [0,1],'LineWidth',1.5,'Color','#77AC30')
rlim([0 0.15])
legend('CBD','Veh','Circular mean Veh','Circular mean CBD')
title('Normalised Phase Sharp Wave')

saveas(gcf,'PolarHist_CBDvsVEH_SW.png')
printing('PolarHistpdf_CBDvsVEH_SW')
close all

 %Ripple
polarhistogram(deg2rad(CBD_f2),18,'Normalization','probability','FaceColor','#77AC30')
hold on 
polarhistogram(deg2rad(Veh_f2),18,'Normalization','probability','FaceColor','black','FaceAlpha',0.3)
hold on
polarplot(deg2rad([circmean_veh_f2,circmean_veh_f2]), [0,1],'LineWidth',1.5,'Color','#000000')
hold on
polarplot(deg2rad([circmean_cbd_f2,circmean_cbd_f2]), [0,1],'LineWidth',1.5,'Color','#77AC30')
rlim([0 0.15])
legend('CBD','Veh','Circular mean Veh','Circular mean CBD')
title('Normalised Phase Ripple')

saveas(gcf,'PolarHist_CBDvsVEH_Ripple.png')
printing('PolarHistpdf_CBDvsVEH_Ripple')
close all

% SWR
polarhistogram(deg2rad(CBD_f4),18,'Normalization','probability','FaceColor','#77AC30')
hold on 
polarhistogram(deg2rad(Veh_f4),18,'Normalization','probability','FaceColor','black','FaceAlpha',0.3)
hold on
polarplot(deg2rad([circmean_veh_f4,circmean_veh_f4]), [0,1],'LineWidth',1.5,'Color','#000000')
hold on
polarplot(deg2rad([circmean_cbd_f4,circmean_cbd_f4]), [0,1],'LineWidth',1.5,'Color','#77AC30')
rlim([0 0.15])
legend('CBD','Veh','Circular mean Veh','Circular mean CBD')
title('Normalised Phase SWR')

saveas(gcf,'PolarHist_CBDvsVEH_SWR.png')
printing('PolarHist_CBDvsVEH_SWR')
close all

% cSWR
polarhistogram(deg2rad(CBD_f6),18,'Normalization','probability','FaceColor','#77AC30')
hold on 
polarhistogram(deg2rad(Veh_f6),18,'Normalization','probability','FaceColor','black','FaceAlpha',0.3)
hold on
polarplot(deg2rad([circmean_veh_f6,circmean_veh_f6]), [0,1],'LineWidth',1.5,'Color','#000000')
hold on
polarplot(deg2rad([circmean_cbd_f6,circmean_cbd_f6]), [0,1],'LineWidth',1.5,'Color','#77AC30')
rlim([0 0.15])
legend('CBD','Veh','Circular mean Veh','Circular mean CBD')
title('Normalised Phase cSWR')

saveas(gcf,'PolarHist_CBDvsVEH_cSWR.png')
printing('PolarHist_CBDvsVEH_cSWR')
close all

%% Combined vehicle plots 

subplot(2,2,1)
polarhistogram(deg2rad(Veh_f1),18,'Normalization','probability','FaceColor','black','FaceAlpha',0.3);
hold on
polarplot(deg2rad([circmean_veh_f1,circmean_veh_f1]), [0,1],'LineWidth',1)
rlim([0 0.15])
title('Normalised Phase Sharp Wave')

subplot(2,2,2)
polarhistogram(deg2rad(Veh_f2),18,'Normalization','probability','FaceColor','black','FaceAlpha',0.3)
hold on
polarplot(deg2rad([circmean_veh_f2,circmean_veh_f2]), [0,1],'LineWidth',1)
rlim([0 0.15])
% legend('Veh','Circular mean')
title('Normalised Phase Ripple')

subplot(2,2,3)
polarhistogram(deg2rad(Veh_f4),18,'Normalization','probability','FaceColor','black','FaceAlpha',0.3)
hold on
polarplot(deg2rad([circmean_veh_f4,circmean_veh_f4]), [0,1],'LineWidth',1)
rlim([0 0.15])
title('Normalised Phase SWR')

subplot(2,2,4)
polarhistogram(deg2rad(Veh_f6),18,'Normalization','probability','FaceColor','black','FaceAlpha',0.3)
hold on
polarplot(deg2rad([circmean_veh_f6,circmean_veh_f6]), [0,1],'LineWidth',1)
rlim([0 0.15])
title('Normalised Phase cSWR')

saveas(gcf,'PolarHist_CombinedVEH_Allforms.png')
printing('PolarHist_CombinedVEH_Allforms')
close all

% circmean_veh_f1 = 360+(rad2deg(circ_mean(deg2rad(Veh_f1))));
% circmean_veh_f2 = 360+(rad2deg(circ_mean(deg2rad(Veh_f2))));
% circmean_veh_f4 = 360+(rad2deg(circ_mean(deg2rad(Veh_f4))));
% circmean_veh_f6 = 360+(rad2deg(circ_mean(deg2rad(Veh_f6))));
%% Combined CBD plots

subplot(2,2,1)
polarhistogram(deg2rad(CBD_f1),18,'Normalization','probability','FaceColor','#77AC30');
hold on
polarplot(deg2rad([circmean_cbd_f1,circmean_cbd_f1]), [0,1],'LineWidth',1)
rlim([0 0.15])
title('Normalised Phase Sharp Wave')

subplot(2,2,2)
polarhistogram(deg2rad(CBD_f2),18,'Normalization','probability','FaceColor','#77AC30')
hold on
polarplot(deg2rad([circmean_cbd_f2,circmean_cbd_f2]), [0,1],'LineWidth',1)
rlim([0 0.15])
% legend('Veh','Circular mean')
title('Normalised Phase Ripple')

subplot(2,2,3)
polarhistogram(deg2rad(CBD_f4),18,'Normalization','probability','FaceColor','#77AC30')
hold on
polarplot(deg2rad([circmean_cbd_f4,circmean_cbd_f4]), [0,1],'LineWidth',1)
rlim([0 0.15])
title('Normalised Phase SWR')

subplot(2,2,4)
polarhistogram(deg2rad(CBD_f6),18,'Normalization','probability','FaceColor','#77AC30')
hold on
polarplot(deg2rad([circmean_cbd_f6,circmean_cbd_f6]), [0,1],'LineWidth',1)
rlim([0 0.15])
title('Normalised Phase cSWR')

saveas(gcf,'PolarHist_CombinedCBD_Allforms.png')
printing('PolarHist_CombinedCBD_Allforms')
close all

%% Dot plots
% SharpWave
subplot(2,2,1)
polarplot(deg2rad([circmean_cbd_f1,circmean_cbd_f1]), [0,1],'LineWidth',1.5,'Color','#77AC30')
title('CBD')
subplot(2,2,2)
polarscatter(circmean_f1_cbdrats,ones(size(circmean_f1_cbdrats)),30,'filled','MarkerFaceColor','#77AC30')
title('CBD')
subplot(2,2,3)
polarplot(deg2rad([circmean_veh_f1,circmean_veh_f1]), [0,1],'LineWidth',2,'Color','#808080')
title('Veh')
subplot(2,2,4)
polarscatter(circmean_f1_vehrats,ones(size(circmean_f1_vehrats)),30,'filled','MarkerFaceColor','#808080')
title('Veh')

saveas(gcf,'PolarDot_CBD&Veh_SW.png')
printing('PolarDotpdf_CBD&Veh_SW')
close all 

% Ripple
subplot(2,2,1)
polarplot(deg2rad([circmean_cbd_f2,circmean_cbd_f2]), [0,1],'LineWidth',1.5,'Color','#77AC30')
title('CBD')
subplot(2,2,2)
polarscatter(circmean_f2_cbdrats,ones(size(circmean_f2_cbdrats)),30,'filled','MarkerFaceColor','#77AC30')
title('CBD')
subplot(2,2,3)
polarplot(deg2rad([circmean_veh_f2,circmean_veh_f2]), [0,1],'LineWidth',2,'Color','#808080')
title('Veh')
subplot(2,2,4)
polarscatter(circmean_f2_vehrats,ones(size(circmean_f2_vehrats)),30,'filled','MarkerFaceColor','#808080')
title('Veh')

saveas(gcf,'PolarDot_CBD&Veh_Ripple.png')
printing('PolarDotpdf_CBD&Veh_Ripple')
close all 

% SWR
subplot(2,2,1)
polarplot(deg2rad([circmean_cbd_f4,circmean_cbd_f4]), [0,1],'LineWidth',1.5,'Color','#77AC30')
title('CBD')
subplot(2,2,2)
polarscatter(circmean_f4_cbdrats,ones(size(circmean_f4_cbdrats)),30,'filled','MarkerFaceColor','#77AC30')
title('CBD')
subplot(2,2,3)
polarplot(deg2rad([circmean_veh_f4,circmean_veh_f4]), [0,1],'LineWidth',2,'Color','#808080')
title('Veh')
subplot(2,2,4)
polarscatter(circmean_f4_vehrats,ones(size(circmean_f4_vehrats)),30,'filled','MarkerFaceColor','#808080')
title('Veh')

saveas(gcf,'PolarDot_CBD&Veh_SWR.png')
printing('PolarDotpdf_CBD&Veh_SWR')
close all 

% cSWR
subplot(2,2,1)
polarplot(deg2rad([circmean_cbd_f6,circmean_cbd_f6]), [0,1],'LineWidth',1.5,'Color','#77AC30')
title('CBD')
subplot(2,2,2)
polarscatter(circmean_f6_cbdrats,ones(size(circmean_f6_cbdrats)),30,'filled','MarkerFaceColor','#77AC30')
title('CBD')
subplot(2,2,3)
polarplot(deg2rad([circmean_veh_f6,circmean_veh_f6]), [0,1],'LineWidth',2,'Color','#000000')
title('Veh')
subplot(2,2,4)
polarscatter(circmean_f6_vehrats,ones(size(circmean_f6_vehrats)),30,'filled','MarkerFaceColor','#808080')
title('Veh')

saveas(gcf,'PolarDot_CBD_Veh_cSWR.png')
printing('PolarDotpdf_CBD_Veh_cSWR')
close all 


%% Event pair plots CBD

% SW v Ripple
polarhistogram(deg2rad(CBD_f1),18,'Normalization','probability', 'FaceColor','red','FaceAlpha',0.5);
hold on
polarhistogram(deg2rad(CBD_f2),18,'Normalization','probability','FaceColor','blue','FaceAlpha',0.5);
hold on
polarplot(deg2rad([circmean_cbd_f1,circmean_cbd_f1]), [0,1],'LineWidth',1.5,'Color', '#FF0000')
hold on 
polarplot(deg2rad([circmean_cbd_f2,circmean_cbd_f2]), [0,1],'LineWidth',1.5,'Color','#000080')
rlim([0 0.15])
legend('SW','Ripple','Circular mean SW','Circular mean R')
title('CBD SW v Ripple')

saveas(gcf,'PolarHist_CBD_SWvRipple.png')
printing('PolarHistpdf_CBD_SWvRipple')
close all 

%SW v SWR 
polarhistogram(deg2rad(CBD_f1),18,'Normalization','probability', 'FaceColor','red','FaceAlpha',0.5);
hold on
polarhistogram(deg2rad(CBD_f4),18,'Normalization','probability','FaceColor','yellow','FaceAlpha',0.3);
hold on
polarplot(deg2rad([circmean_cbd_f1,circmean_cbd_f1]), [0,1],'LineWidth',2,'Color', '#FF0000')
hold on 
polarplot(deg2rad([circmean_cbd_f4,circmean_cbd_f4]), [0,1],'LineWidth',2,'Color','#FFFF00')
rlim([0 0.15])
legend('SW','SWR','Circular mean SW','Circular mean SWR')
title('CBD SW v SWR')

saveas(gcf,'PolarHist_CBD_SWvSWR.png')
printing('PolarHistpdf_CBD_SWvSWR')
close all

%SW v cSWR
polarhistogram(deg2rad(CBD_f1),18,'Normalization','probability', 'FaceColor','red','FaceAlpha',0.5);
hold on
polarhistogram(deg2rad(CBD_f6),18,'Normalization','probability','FaceColor','#7E2F8E','FaceAlpha',0.5);
hold on
polarplot(deg2rad([circmean_cbd_f1,circmean_cbd_f1]), [0,1],'LineWidth',2,'Color', '#FF0000')
hold on 
polarplot(deg2rad([circmean_cbd_f6,circmean_cbd_f6]), [0,1],'LineWidth',2,'Color','#7E2F8E')
rlim([0 0.15])
legend('SW','cSWR','Circular mean SW','Circular mean cSWR')
title('CBD SW v cSWR')
saveas(gcf,'PolarHist_CBD_SWvCSWR.png')
printing('PolarHistpdf_CBD_SWvCSWR')
close all

%Ripple v SWR
polarhistogram(deg2rad(CBD_f2),18,'Normalization','probability','FaceColor','blue','FaceAlpha',0.5);
hold on
polarhistogram(deg2rad(CBD_f4),18,'Normalization','probability','FaceColor','yellow','FaceAlpha',0.3);
hold on
polarplot(deg2rad([circmean_cbd_f2,circmean_cbd_f2]), [0,1],'LineWidth',1.5,'Color','#000080')
hold on 
polarplot(deg2rad([circmean_cbd_f4,circmean_cbd_f4]), [0,1],'LineWidth',2,'Color','#FFFF00')
rlim([0 0.15])
legend('Ripple','SWR','Circular mean R','Circular mean SWR')
title('CBD Ripple v SWR')

saveas(gcf,'PolarHist_CBD_RipplevSWR.png')
printing('PolarHistpdf_CBD_RipplevSWR')
close all

% Ripple v cSWR
polarhistogram(deg2rad(CBD_f2),18,'Normalization','probability','FaceColor','blue','FaceAlpha',0.5);
hold on
polarhistogram(deg2rad(CBD_f6),18,'Normalization','probability','FaceColor','#7E2F8E','FaceAlpha',0.5);
hold on
polarplot(deg2rad([circmean_cbd_f2,circmean_cbd_f2]), [0,1],'LineWidth',1.5,'Color','#000080')
hold on 
polarplot(deg2rad([circmean_cbd_f6,circmean_cbd_f6]), [0,1],'LineWidth',2,'Color','#7E2F8E')
rlim([0 0.15])
legend('Ripple','cSWR','Circular mean Ripple','Circular mean cSWR')
title('CBD Ripple v cSWR')

saveas(gcf,'PolarHist_CBD_RipplevCSWR.png')
printing('PolarHistpdf_CBD_RipplevCSWR')
close all

% cSWR v SWR
polarhistogram(deg2rad(CBD_f6),18,'Normalization','probability','FaceColor','#7E2F8E','FaceAlpha',0.5);
hold on
polarhistogram(deg2rad(CBD_f4),18,'Normalization','probability','FaceColor','yellow','FaceAlpha',0.3);
hold on
polarplot(deg2rad([circmean_cbd_f6,circmean_cbd_f6]), [0,1],'LineWidth',2,'Color','#7E2F8E')
hold on 
polarplot(deg2rad([circmean_cbd_f4,circmean_cbd_f4]), [0,1],'LineWidth',2,'Color','#FFFF00')
rlim([0 0.15])
legend('cSWR','SWR','Circular mean cSWR','Circular mean SWR')
title('CBD cSWR v SWR')
saveas(gcf,'PolarHist_CBD_CSWRvSWR.png')
printing('PolarHistpdf_CBD_CSWRvSWR')
close all

%% Event pair plots Vehicle 

% SW v Ripple
polarhistogram(deg2rad(Veh_f1),18,'Normalization','probability', 'FaceColor','red','FaceAlpha',0.5);
hold on
polarhistogram(deg2rad(Veh_f2),18,'Normalization','probability','FaceColor','blue','FaceAlpha',0.5);
hold on
polarplot(deg2rad([circmean_veh_f1,circmean_veh_f1]), [0,1],'LineWidth',1.5,'Color', '#FF0000')
hold on 
polarplot(deg2rad([circmean_veh_f2,circmean_veh_f2]), [0,1],'LineWidth',1.5,'Color','#000080')
rlim([0 0.15])
legend('SW','Ripple','Circular mean SW','Circular mean R')
title('VEH SW v Ripple')

saveas(gcf,'PolarHist_VEH_SWvRipple.png')
printing('PolarHistpdf_VEH_SWvRipple')
close all 

%SW v SWR 
polarhistogram(deg2rad(Veh_f1),18,'Normalization','probability', 'FaceColor','red','FaceAlpha',0.5);
hold on
polarhistogram(deg2rad(Veh_f4),18,'Normalization','probability','FaceColor','yellow','FaceAlpha',0.3);
hold on
polarplot(deg2rad([circmean_veh_f1,circmean_veh_f1]), [0,1],'LineWidth',2,'Color', '#FF0000')
hold on 
polarplot(deg2rad([circmean_veh_f4,circmean_veh_f4]), [0,1],'LineWidth',2,'Color','#FFFF00')
rlim([0 0.15])
legend('SW','SWR','Circular mean SW','Circular mean SWR')
title('VEH SW v SWR')

saveas(gcf,'PolarHist_Veh_SWvSWR.png')
printing('PolarHistpdf_Veh_SWvSWR')
close all

%SW v cSWR
polarhistogram(deg2rad(Veh_f1),18,'Normalization','probability', 'FaceColor','red','FaceAlpha',0.5);
hold on
polarhistogram(deg2rad(Veh_f6),18,'Normalization','probability','FaceColor','#7E2F8E','FaceAlpha',0.5);
hold on
polarplot(deg2rad([circmean_veh_f1,circmean_veh_f1]), [0,1],'LineWidth',2,'Color', '#FF0000')
hold on 
polarplot(deg2rad([circmean_veh_f6,circmean_veh_f6]), [0,1],'LineWidth',2,'Color','#7E2F8E')
rlim([0 0.15])
legend('SW','cSWR','Circular mean SW','Circular mean cSWR')
title('VEH SW v cSWR')

saveas(gcf,'PolarHist_VEH_SWvCSWR.png')
printing('PolarHistpdf_VEH_SWvCSWR')
close all

%Ripple v SWR
polarhistogram(deg2rad(Veh_f2),18,'Normalization','probability','FaceColor','blue','FaceAlpha',0.5);
hold on
polarhistogram(deg2rad(Veh_f4),18,'Normalization','probability','FaceColor','yellow','FaceAlpha',0.3);
hold on
polarplot(deg2rad([circmean_veh_f2,circmean_veh_f2]), [0,1],'LineWidth',1.5,'Color','#000080')
hold on 
polarplot(deg2rad([circmean_veh_f4,circmean_veh_f4]), [0,1],'LineWidth',2,'Color','#FFFF00')
rlim([0 0.15])
legend('Ripple','SWR','Circular mean R','Circular mean SWR')
title('Veh Ripple v SWR')

saveas(gcf,'PolarHist_Veh_RipplevSWR.png')
printing('PolarHistpdf_Veh_RipplevSWR')
close all

% Ripple v cSWR
polarhistogram(deg2rad(Veh_f2),18,'Normalization','probability','FaceColor','blue','FaceAlpha',0.5);
hold on
polarhistogram(deg2rad(Veh_f6),18,'Normalization','probability','FaceColor','#7E2F8E','FaceAlpha',0.5);
hold on
polarplot(deg2rad([circmean_veh_f2,circmean_veh_f2]), [0,1],'LineWidth',1.5,'Color','#000080')
hold on 
polarplot(deg2rad([circmean_veh_f6,circmean_veh_f6]), [0,1],'LineWidth',2,'Color','#7E2F8E')
rlim([0 0.15])
legend('Ripple','cSWR','Circular mean Ripple','Circular mean cSWR')
title('VEH Ripple v cSWR')

saveas(gcf,'PolarHist_VEH_RipplevCSWR.png')
printing('PolarHist_VEH_RipplevCSWR')
close all

% cSWR v SWR
polarhistogram(deg2rad(Veh_f6),18,'Normalization','probability','FaceColor','#7E2F8E','FaceAlpha',0.5);
hold on
polarhistogram(deg2rad(Veh_f4),18,'Normalization','probability','FaceColor','yellow','FaceAlpha',0.3);
hold on
polarplot(deg2rad([circmean_veh_f6,circmean_veh_f6]), [0,1],'LineWidth',2,'Color','#7E2F8E')
hold on 
polarplot(deg2rad([circmean_veh_f4,circmean_veh_f4]), [0,1],'LineWidth',2,'Color','#FFFF00')
rlim([0 0.15])
legend('cSWR','SWR','Circular mean cSWR','Circular mean SWR')
title('VEH cSWR v SWR')
saveas(gcf,'PolarHist_VEH_CSWRvSWR.png')
printing('PolarHist_VEH_CSWRvSWR')
close all
