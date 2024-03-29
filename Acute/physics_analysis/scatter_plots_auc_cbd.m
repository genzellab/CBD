% cd('/home/adrian/Downloads')
cd('/home/adrian/Documents/CBD_acutes/Chara')
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
T_SW = readtable('SWRChara.xls','Sheet','Form1');
%%
SW_Amp_CBD=T_SW(:,12); %AUC
SW_Dur_CBD=T_SW(:,13);

SW_Amp_CBD=table2array(SW_Amp_CBD);
SW_Dur_CBD=table2array(SW_Dur_CBD);

SW_Amp_CBD=SW_Amp_CBD(SW_Dur_CBD<=prctile(SW_Dur_CBD,95))
SW_Dur_CBD=SW_Dur_CBD(SW_Dur_CBD<=prctile(SW_Dur_CBD,95))

%% SharpWaves

%scatter(SW_Dur_CBD,SW_Amp_CBD,'MarkerEdgeColor','r','MarkerEdgeAlpha',0.8)
% h(4)=errorbar(nanmedian(SW_Dur_CBD),nanmedian(SW_Amp_CBD),sem(SW_Amp_CBD)*1.96,sem(SW_Amp_CBD)*1.96,sem(SW_Dur_CBD)*1.96,sem(SW_Dur_CBD)*1.96,'o','Color','r','MarkerSize',20,"MarkerFaceColor",[0 1 0]);
% 
% xlabel('Duration (ms)')
% ylabel('AUC')
%  set(gca,'xscale','log')
%  set(gca,'yscale','log')
% 
% hold on
%     if exist('x1','var')
%         xlong=linspace(min(x1),max(x1),1000);
%     else
%         xlong=SW_Dur_CBD;
%     end
% [p,curvefit,gof,Yp2]=fitter(SW_Dur_CBD,SW_Amp_CBD,xlong);
%  plot(xlong, Yp2, '-r' ,'DisplayName', 'Fit','LineWidth',5 );

 %%
 %% SWR Sharp wave

T_SWRSW = readtable('SWRChara.xls','Sheet','Form3');

SWRSW_Amp_CBD=T_SWRSW(:,12); %AUC
SWRSW_Dur_CBD=T_SWRSW(:,13);

SWRSW_Amp_CBD=table2array(SWRSW_Amp_CBD);
SWRSW_Dur_CBD=table2array(SWRSW_Dur_CBD);

SWRSW_Amp_CBD=SWRSW_Amp_CBD(SWRSW_Dur_CBD<=prctile(SWRSW_Dur_CBD,95))
SWRSW_Dur_CBD=SWRSW_Dur_CBD(SWRSW_Dur_CBD<=prctile(SWRSW_Dur_CBD,95))

%%
%scatter(SWRSW_Dur_CBD,SWRSW_Amp_CBD,'MarkerEdgeColor',"#7E2F8E",'MarkerEdgeAlpha',0.8)
% h(5)=errorbar(nanmedian(SWRSW_Dur_CBD),nanmedian(SWRSW_Amp_CBD),sem(SWRSW_Amp_CBD)*1.96,sem(SWRSW_Amp_CBD)*1.96,sem(SWRSW_Dur_CBD)*1.96,sem(SWRSW_Dur_CBD)*1.96,'o','Color',"#7E2F8E",'MarkerSize',20,"MarkerFaceColor",[0 1 0])
% 
% xlabel('Duration (ms)')
% ylabel('AUC')
%  set(gca,'xscale','log')
%  set(gca,'yscale','log')
%  
%     if exist('x1','var')
%         xlong=linspace(min(x1),max(x1),1000);
%     else
%         xlong=SWRSW_Dur_CBD;
%     end 
%  
%  [p,curvefit,gof, Yp2]=fitter(SWRSW_Dur_CBD,SWRSW_Amp_CBD,xlong);
% hold on
%   plot(xlong, Yp2,'Color',"#7E2F8E",'DisplayName', 'Fit','LineWidth',5 );
 
 
%%

 %% CSWR SW

T_cSWRSW = readtable('SWRChara.xls','Sheet','Form5');

cSWRSW_Amp_CBD=T_cSWRSW(:,12); %AUC
cSWRSW_Dur_CBD=T_cSWRSW(:,13);

cSWRSW_Amp_CBD=table2array(cSWRSW_Amp_CBD);
cSWRSW_Dur_CBD=table2array(cSWRSW_Dur_CBD);

cSWRSW_Amp_CBD=cSWRSW_Amp_CBD(cSWRSW_Dur_CBD<=prctile(cSWRSW_Dur_CBD,95))
cSWRSW_Dur_CBD=cSWRSW_Dur_CBD(cSWRSW_Dur_CBD<=prctile(cSWRSW_Dur_CBD,95))

%%
%scatter(cSWRSW_Dur_CBD,cSWRSW_Amp_CBD,'MarkerEdgeColor',"#EDB120",'MarkerEdgeAlpha',0.8)
% h(6)=errorbar(nanmedian(cSWRSW_Dur_CBD),nanmedian(cSWRSW_Amp_CBD),sem(cSWRSW_Amp_CBD)*1.96,sem(cSWRSW_Amp_CBD)*1.96,sem(cSWRSW_Dur_CBD)*1.96,sem(cSWRSW_Dur_CBD)*1.96,'o','Color',"#EDB120",'MarkerSize',20,"MarkerFaceColor",[0 1 0])
% 
% xlabel('Duration (ms)')
% ylabel('AUC')
%  set(gca,'xscale','log')
%  set(gca,'yscale','log')
% 
% 
%     if exist('x1','var')
%         xlong=linspace(min(x1),max(x1),1000);
%     else
%         xlong=cSWRSW_Dur_CBD
%     end
%  
%  [p,curvefit,gof,Yp2]=fitter(cSWRSW_Dur_CBD,cSWRSW_Amp_CBD,xlong);
% hold on
%   plot(xlong, Yp2,'Color',"#EDB120",'DisplayName', 'Fit','LineWidth',5 );
% text(max(cSWRSW_Dur_Veh),max(Yp2),' cSWR SW')
%%

% uistack(h(4),'top');
%xo
%%
%xo
%legend('SW','Ripples','SWR SW', 'SWR Ripples','CSWR SW','CSWR Ripples' )
%%

% x1=[SW_Dur_CBD;ripples_Dur_CBD;SWRSW_Dur_CBD;SWRripples_Dur_CBD;cSWRSW_Dur_CBD;cSWRripples_Dur_CBD];
% y1=[SW_Amp_CBD;ripples_Amp_CBD;SWRSW_Amp_CBD;SWRripples_Amp_CBD;cSWRSW_Amp_CBD;cSWRripples_Amp_CBD];

%Sharp waves 
x1=[SW_Dur_CBD;SWRSW_Dur_CBD;cSWRSW_Dur_CBD];
y1=[SW_Amp_CBD;SWRSW_Amp_CBD;cSWRSW_Amp_CBD];


x1=x1(~isnan(x1));
y1=y1(~isnan(y1));

[curvefit,gof,output] = fit(log10(x1),log10(y1),'poly1','normalize','off')
% figure();plot(curvefit)

[p, S] = polyfit(log10(x1),log10(y1),1);
disp(['Equation is y = ' num2str(p(1)) '*x + ' num2str(p(2))])
%xo

[y_est,delta] = polyval(p,log10(x1),S);
Yp2 = 10.^(y_est);

% Add trend line to plot
% hold on
% plot(log10(x1),y_est,'r--','LineWidth',2)
% hold off



%
plot(x1, Yp2, '-g', 'DisplayName', 'Fit');

xlabel('Duration (ms)')
ylabel('AUC')
 set(gca,'xscale','log')
 set(gca,'yscale','log')
xo
uistack(h(1),'top');
uistack(h(2),'top');
uistack(h(3),'top');
uistack(h(4),'top');
uistack(h(5),'top');
uistack(h(6),'top');

xlong2=x1;
xo
%%
X=min(x1):max(x1);

[slope, intercept] = logfit(x1,y1,'logy');
yApprox = (10^intercept)*(10^slope).^X;


plot(X,yApprox,'LineWidth',3,'Color',[0 0 0])
%%
% figure()
y2 = polyval(p,x1);


% plot(x1,y2)
%  set(gca,'xscale','log')
%  set(gca,'yscale','log')
loglog(x1,y2)
%%
%% Ripples

T_ripples = readtable('SWRChara.xls','Sheet','Form2');

ripples_Amp_CBD=T_ripples(:,11);
ripples_Dur_CBD=T_ripples(:,13);

ripples_Amp_CBD=table2array(ripples_Amp_CBD);
ripples_Dur_CBD=table2array(ripples_Dur_CBD);
%%
scatter(ripples_Dur_CBD,ripples_Amp_CBD,'filled')
xlabel('Duration (ms)')
ylabel('Amplitude (mV)')
 set(gca,'xscale','log')
 set(gca,'yscale','log')
 hold on
%%
  %% SWR Ripples

T_SWRripples = readtable('SWRChara.xls','Sheet','Form4');

SWRripples_Amp_CBD=T_SWRripples(:,11);
SWRripples_Dur_CBD=T_SWRripples(:,13);

SWRripples_Amp_CBD=table2array(SWRripples_Amp_CBD);
SWRripples_Dur_CBD=table2array(SWRripples_Dur_CBD);
 
%%
scatter(SWRripples_Dur_CBD,SWRripples_Amp_CBD,'filled')
xlabel('Duration (ms)')
ylabel('Amplitude (mV)')
 set(gca,'xscale','log')
 set(gca,'yscale','log')

%%
 %% CSWR Ripples

T_cSWRripples = readtable('SWRChara.xls','Sheet','Form6');

cSWRripples_Amp_CBD=T_cSWRripples(:,11);
cSWRripples_Dur_CBD=T_cSWRripples(:,13);

cSWRripples_Amp_CBD=table2array(cSWRripples_Amp_CBD);
cSWRripples_Dur_CBD=table2array(cSWRripples_Dur_CBD);
%%
scatter(cSWRripples_Dur_CBD,cSWRripples_Amp_CBD,'filled')
xlabel('Duration (ms)')
ylabel('Amplitude (mV)')
 set(gca,'xscale','log')
 set(gca,'yscale','log')

%%
%Ripples 
x1=[ripples_Dur_CBD;SWRripples_Dur_CBD;cSWRripples_Dur_CBD];
y1=[ripples_Amp_CBD;SWRripples_Amp_CBD;cSWRripples_Amp_CBD];


x1=x1(~isnan(x1));
y1=y1(~isnan(y1));

X=min(x1):max(x1);

[slope, intercept] = logfit(x1,y1,'logy');
yApprox = (10^intercept)*(10^slope).^X;


plot(X,yApprox,'LineWidth',3,'Color',[0 0 0])

% 
% p = polyfit(x1,y1,1);
% y2 = polyval(p,x1);
% 
% loglog(x1,y2)
%%
legend('SW','Ripples','SWR SW', 'SWR Ripples','CSWR SW','CSWR Ripples','Fit SW','Fit Ripples' )
%%

