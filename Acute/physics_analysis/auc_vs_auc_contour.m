% cd('/home/adrian/Downloads')
cd('/home/adrian/Documents/CBD_acutes/Chara')
close all
clear variables
%Forms
% Form1: Sharp-wave.
% Form2: Ripple.
% Form3: Sharp-wave of SWR.
% Form4: Ripple of SWR.
% Form5: Sharp-wave of cSWR.
% Form6: Ripple of cSWR.

%Suggestion: For SW, it is better to use AUC with respect to the ripple
%duration. 
clear x1
T_SWSWR = readtable('SWRChara.xls','Sheet','Form3');
%%
SWSWR_Amp_Veh=T_SWSWR(:,4); %AUC
SWSWR_Amp_Veh=table2array(SWSWR_Amp_Veh);

T_SWR = readtable('SWRChara.xls','Sheet','Form4');

SWR_Amp_Veh=T_SWR(:,4); %AUC
SWR_Amp_Veh=table2array(SWR_Amp_Veh);
% 
%%

%scatter((SWSWR_Amp_Veh),(SWR_Amp_Veh),'o','MarkerFaceColor',"#7E2F8E",'MarkerEdgeColor',"#7E2F8E");
%errorbar(nanmedian(SWSWR_Amp_Veh),nanmedian(SWR_Amp_Veh),sem(SWR_Amp_Veh)*1.96,sem(SWR_Amp_Veh)*1.96,sem(SWSWR_Amp_Veh)*1.96,sem(SWSWR_Amp_Veh)*1.96,'o','Color',"#7E2F8E",'MarkerSize',20);
% 
% 
% 
% xlabel('AUC SW')
% ylabel('AUC Ripple')
%  set(gca,'xscale','log')
%  set(gca,'yscale','log')
%  
% hold on
%     if exist('x1','var')
%         xlong=linspace(min(x1),max(x1),1000);
%     else
%         xlong=SWSWR_Amp_Veh;
%     end
% [p,curvefit,gof,Yp2]=fitter(SWSWR_Amp_Veh,SWR_Amp_Veh,xlong);
%  plot(xlong, Yp2, 'DisplayName', 'Fit','LineWidth',5 ,'Color',"#7E2F8E");
 
%%
% %%
T_SWcSWR = readtable('SWRChara.xls','Sheet','Form5');
%%
SWcSWR_Amp_Veh=T_SWcSWR(:,4); %AUC
SWcSWR_Amp_Veh=table2array(SWcSWR_Amp_Veh);

T_cSWR = readtable('SWRChara.xls','Sheet','Form6');

cSWR_Amp_Veh=T_cSWR(:,4); %AUC
cSWR_Amp_Veh=table2array(cSWR_Amp_Veh);

%%
% errorbar(nanmedian(SWcSWR_Amp_Veh),nanmedian(cSWR_Amp_Veh),sem(cSWR_Amp_Veh)*1.96,sem(cSWR_Amp_Veh)*1.96,sem(SWcSWR_Amp_Veh)*1.96,sem(SWcSWR_Amp_Veh)*1.96,'o','Color',"#EDB120",'MarkerSize',20);
% 
% 
% xlabel('AUC SW')
% ylabel('AUC Ripple')
%  set(gca,'xscale','log')
%  set(gca,'yscale','log')
%  
% hold on
%     if exist('x1','var')
%         xlong=linspace(min(x1),max(x1),1000);
%     else
%         xlong=SWcSWR_Amp_Veh;
%     end
% [p,curvefit,gof,Yp2]=fitter(SWcSWR_Amp_Veh,cSWR_Amp_Veh,xlong);
%  plot(xlong, Yp2, 'DisplayName', 'Fit','LineWidth',5 ,'Color',"#EDB120");

%xo
%% CBD

T_SWSWR = readtable('SWRChara.xls','Sheet','Form3');
%%
SWSWR_Amp_CBD=T_SWSWR(:,12); %AUC
SWSWR_Amp_CBD=table2array(SWSWR_Amp_CBD);

T_SWR = readtable('SWRChara.xls','Sheet','Form4');

SWR_Amp_CBD=T_SWR(:,12); %AUC
SWR_Amp_CBD=table2array(SWR_Amp_CBD);
% 
%%
% scatter((SWSWR_Amp_CBD),(SWR_Amp_CBD),'o','MarkerFaceColor',"#7E2F8E",'MarkerEdgeColor',"#7E2F8E");
% 
% %  errorbar(nanmedian(SWSWR_Amp_CBD),nanmedian(SWR_Amp_CBD),sem(SWR_Amp_CBD)*1.96,sem(SWR_Amp_CBD)*1.96,sem(SWSWR_Amp_CBD)*1.96,sem(SWSWR_Amp_CBD)*1.96,'o','Color',"#7E2F8E",'MarkerSize',20,'MarkerFaceColor','g');
% % 
% % 
% % 
% xlabel('AUC SW')
% ylabel('AUC Ripple')
%  set(gca,'xscale','log')
%  set(gca,'yscale','log')
%  
% hold on
%     if exist('x1','var')
%         xlong=linspace(min(x1),max(x1),1000);
%     else
%         xlong=SWSWR_Amp_CBD;
%     end
% [p,curvefit,gof,Yp2]=fitter(SWSWR_Amp_CBD,SWR_Amp_CBD,xlong);
%  plot(xlong, Yp2, 'DisplayName', 'Fit','LineWidth',5 ,'Color',"#7E2F8E");
 
%%
%%
T_SWcSWR = readtable('SWRChara.xls','Sheet','Form5');
%%
SWcSWR_Amp_CBD=T_SWcSWR(:,12); %AUC
SWcSWR_Amp_CBD=table2array(SWcSWR_Amp_CBD);

T_cSWR = readtable('SWRChara.xls','Sheet','Form6');

cSWR_Amp_CBD=T_cSWR(:,12); %AUC
cSWR_Amp_CBD=table2array(cSWR_Amp_CBD);

%%
% errorbar(nanmedian(SWcSWR_Amp_CBD),nanmedian(cSWR_Amp_CBD),sem(cSWR_Amp_CBD)*1.96,sem(cSWR_Amp_CBD)*1.96,sem(SWcSWR_Amp_CBD)*1.96,sem(SWcSWR_Amp_CBD)*1.96,'o','Color',"#EDB120",'MarkerSize',20,'MarkerFaceColor','g');
% 
% 
% xlabel('AUC SW')
% ylabel('AUC Ripple')
%  set(gca,'xscale','log')
%  set(gca,'yscale','log')
%  
% hold on
%     if exist('x1','var')
%         xlong=linspace(min(x1),max(x1),1000);
%     else
%         xlong=SWcSWR_Amp_CBD;
%     end
% [p,curvefit,gof,Yp2]=fitter(SWcSWR_Amp_CBD,cSWR_Amp_CBD,xlong);
%  plot(xlong, Yp2, 'DisplayName', 'Fit','LineWidth',5 ,'Color',"#EDB120");
% 
%%

%xo 
%%
% SWcSWR_Amp_Veh
% cSWR_Amp_Veh

x1=[SWcSWR_Amp_Veh;SWSWR_Amp_Veh];
y1=[cSWR_Amp_Veh; SWR_Amp_Veh];


x1=x1(~isnan(x1));
y1=y1(~isnan(y1));

p=gkde2_contour([x1 y1]);
[M,c]=contour(p.x,p.y,p.pdf,3);
c.LineColor="k";

% scatter(x1,y1)
% Add trend line to plot
% hold on
% plot(log10(x1),y_est,'r--','LineWidth',2)
% hold off


%
% plot(x1, Yp2, '-k', 'DisplayName', 'Fit');
xlabel('AUC Radiatum')
ylabel('AUC Pyramidale')
 set(gca,'xscale','log')
 set(gca,'yscale','log')
 
hold on

%% CBD
x1=[SWcSWR_Amp_CBD;SWSWR_Amp_CBD];
y1=[cSWR_Amp_CBD; SWR_Amp_CBD];


x1=x1(~isnan(x1));
y1=y1(~isnan(y1));


% Add trend line to plot
% hold on
% plot(log10(x1),y_est,'r--','LineWidth',2)
% hold off


%
% scatter(x1, y1, 'g');

p=gkde2_contour([x1 y1]);
[M,c]=contour(p.x,p.y,p.pdf,3);
c.LineColor="g";

xlabel('AUC Radiatum')
ylabel('AUC Pyramidale')
 set(gca,'xscale','log')
 set(gca,'yscale','log')
