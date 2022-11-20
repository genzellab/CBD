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
T_SW = readtable('SWRChara.xls','Sheet','Form2');
%%
SW_Amp_Veh=T_SW(:,4); %AUC
SW_Dur_Veh=T_SW(:,5);

SW_Amp_Veh=table2array(SW_Amp_Veh);
SW_Dur_Veh=table2array(SW_Dur_Veh);

SW_Amp_Veh=SW_Amp_Veh(SW_Dur_Veh<=prctile(SW_Dur_Veh,95))
SW_Dur_Veh=SW_Dur_Veh(SW_Dur_Veh<=prctile(SW_Dur_Veh,95))

%% SharpWaves

% h(4)=scatter(SW_Dur_Veh,SW_Amp_Veh,'MarkerEdgeColor','r','MarkerEdgeAlpha',0.8)
% h(4)=errorbar(nanmedian(SW_Dur_Veh),nanmedian(SW_Amp_Veh),nanstd(SW_Dur_Veh)/2,nanstd(SW_Dur_Veh)/2,nanstd(SW_Amp_Veh)/2,nanstd(SW_Amp_Veh)/2,'o','Color','r','MarkerSize',20)

%h(1)=errorbar(nanmedian(SW_Dur_Veh),nanmedian(SW_Amp_Veh),sem(SW_Amp_Veh)*1.96,sem(SW_Amp_Veh)*1.96,sem(SW_Dur_Veh)*1.96,sem(SW_Dur_Veh)*1.96,'o','Color','r'); %,'MarkerSize',20

xlabel('Duration (ms)')
ylabel('AUC')
 set(gca,'xscale','log')
 set(gca,'yscale','log')

hold on
    if exist('x1','var')
        xlong=linspace(min(x1),max(x1),1000);
    else
        xlong=SW_Dur_Veh
    end
[p1,curvefit,gof,Yp2]=fitter(SW_Dur_Veh,SW_Amp_Veh,xlong);
 plot(xlong, Yp2, '-r' ,'DisplayName', 'Fit' );%'LineWidth',5
% text(max(SW_Dur_Veh),max(Yp2),' SW')
%%
%% Figure settings
% f=gcf;
% set(f,'Units','centimeters')
% % h.Position(1)=0;
% % h.Position(2)=0;
% f.Position(3)=3.5;
% f.Position(4)=3.5;
% f.PaperSize=[3.55 3.55]
% %xo
% ax=gca;
% ax.YColor=[0 0 0];
% ax.XColor=[0 0 0];
% ax.FontSize=2;
% 
% ax.Legend.Units='centimeters';
% ax.Legend.Position(1)=0
% ax.Legend.Position(2)=0
% ax.Legend.Position(3)=0.2
% ax.Legend.Position(4)=0.2
%xo
%%
filename='AUC_AUC_SWR&cSWR3';
% print('-painters',f,filename,'-dpdf');%'-r0'
%%
%set(gca, 'Children', flipud(get(gca, 'Children')) )
%%
% hLegend = findobj(gcf, 'Type', 'Legend');
% 
% addpath(genpath('/home/adrian/Downloads/github_repo(1)'))
% legendflex(gca,{'Fit all SW Veh','Fit all SW CBD','Fit all Ripple Veh','Fit all Ripple CBD'},'xscale',0.25)
% legendflex(gca,{'Fit SWR CBD','SWR CBD','Fit SWR Veh','SWR Veh'},'xscale',0.25)
% legendflex(gca,{'Fit SWR CBD','Fit SWR Veh'},'xscale',0.25)
% legendflex(gca,{'Fit cSWR Veh','Fit cSWR CBD'},'xscale',0.25)
% legendflex(gca,{'Fit Veh (SWR+cSWR)','Fit CBD (SWR+cSWR)'},'xscale',0.25)

 %% SWR Sharp wave

T_SWRSW = readtable('SWRChara.xls','Sheet','Form4');

SWRSW_Amp_Veh=T_SWRSW(:,4); %AUC
SWRSW_Dur_Veh=T_SWRSW(:,5);

SWRSW_Amp_Veh=table2array(SWRSW_Amp_Veh);
SWRSW_Dur_Veh=table2array(SWRSW_Dur_Veh);


SWRSW_Amp_Veh=SWRSW_Amp_Veh(SWRSW_Dur_Veh<=prctile(SWRSW_Dur_Veh,95))
SWRSW_Dur_Veh=SWRSW_Dur_Veh(SWRSW_Dur_Veh<=prctile(SWRSW_Dur_Veh,95))

%%
%scatter(SWRSW_Dur_Veh,SWRSW_Amp_Veh,'MarkerEdgeColor',"#7E2F8E",'MarkerEdgeAlpha',0.8)
%plot(nanmedian(SWRSW_Dur_Veh),nanmedian(SWRSW_Amp_Veh),'*','Color',"#7E2F8E",'LineWidth',30)
%h(2)=errorbar(nanmedian(SWRSW_Dur_Veh),nanmedian(SWRSW_Amp_Veh),sem(SWRSW_Amp_Veh)*1.96,sem(SWRSW_Amp_Veh)*1.96,sem(SWRSW_Dur_Veh)*1.96,sem(SWRSW_Dur_Veh)*1.96,'o','Color',"#7E2F8E")%,'MarkerSize',20

xlabel('Duration (ms)')
ylabel('AUC')
 set(gca,'xscale','log')
 set(gca,'yscale','log')

    if exist('x1','var')
        xlong=linspace(min(x1),max(x1),1000);
    else
        xlong=SWRSW_Dur_Veh
    end 
 
 [p2,curvefit,gof, Yp2]=fitter(SWRSW_Dur_Veh,SWRSW_Amp_Veh,xlong);
hold on
  plot(xlong, Yp2,'Color',"#7E2F8E",'DisplayName', 'Fit'); %,'LineWidth',5 

%   text(max(SWRSW_Dur_Veh),max(Yp2),' SWR SW')

 %% CSWR SW

T_cSWRSW = readtable('SWRChara.xls','Sheet','Form6');

cSWRSW_Amp_Veh=T_cSWRSW(:,4); %AUC
cSWRSW_Dur_Veh=T_cSWRSW(:,5);

cSWRSW_Amp_Veh=table2array(cSWRSW_Amp_Veh);
cSWRSW_Dur_Veh=table2array(cSWRSW_Dur_Veh);

cSWRSW_Amp_Veh=cSWRSW_Amp_Veh(cSWRSW_Dur_Veh<=prctile(cSWRSW_Dur_Veh,95))
cSWRSW_Dur_Veh=cSWRSW_Dur_Veh(cSWRSW_Dur_Veh<=prctile(cSWRSW_Dur_Veh,95))

%%
%scatter(cSWRSW_Dur_Veh,cSWRSW_Amp_Veh,'MarkerEdgeColor',"#EDB120",'MarkerEdgeAlpha',0.8)
%h(3)=errorbar(nanmedian(cSWRSW_Dur_Veh),nanmedian(cSWRSW_Amp_Veh),sem(cSWRSW_Amp_Veh)*1.96,sem(cSWRSW_Amp_Veh)*1.96,sem(cSWRSW_Dur_Veh)*1.96,sem(cSWRSW_Dur_Veh)*1.96,'o','Color',"#EDB120")%,'MarkerSize',20

xlabel('Duration (ms)')
ylabel('AUC')
 set(gca,'xscale','log')
 set(gca,'yscale','log')

    if exist('x1','var')
        xlong=linspace(min(x1),max(x1),1000);
    else
        xlong=cSWRSW_Dur_Veh
    end
 
 [p3,curvefit,gof,Yp2]=fitter(cSWRSW_Dur_Veh,cSWRSW_Amp_Veh,xlong);
hold on
  plot(xlong, Yp2,'Color',"#EDB120",'DisplayName', 'Fit'); %,'LineWidth',5 
% text(max(cSWRSW_Dur_Veh),max(Yp2),' cSWR SW')
%%
% 
% uistack(h(1),'top');
% uistack(h(2),'top');
% uistack(h(3),'top');
% uistack(h(4),'top');

%%
 xo

xlim([0 1000])
ylim( [0.7575 14.8992])  
% legend('SW','Ripples','SWR SW', 'SWR Ripples','CSWR SW','CSWR Ripples' )
%%

% x1=[SW_Dur_Veh;ripples_Dur_Veh;SWRSW_Dur_Veh;SWRripples_Dur_Veh;cSWRSW_Dur_Veh;cSWRripples_Dur_Veh];
% y1=[SW_Amp_Veh;ripples_Amp_Veh;SWRSW_Amp_Veh;SWRripples_Amp_Veh;cSWRSW_Amp_Veh;cSWRripples_Amp_Veh];

%Sharp waves 
x1=[SW_Dur_Veh;SWRSW_Dur_Veh;cSWRSW_Dur_Veh];
y1=[SW_Amp_Veh;SWRSW_Amp_Veh;cSWRSW_Amp_Veh];


x1=x1(~isnan(x1));
y1=y1(~isnan(y1));

[curvefit,gof,output] = fit(log10(x1),log10(y1),'poly1','normalize','off')
%figure();plot(curvefit,log10(x1),log10(y1))

[p, S] = polyfit(log10(x1),log10(y1),1);
disp(['Equation is y = ' num2str(p(1)) '*x + ' num2str(p(2))])


[y_est,delta] = polyval(p,log10(x1),S);
Yp2 = 10.^(y_est);

% Add trend line to plot
% hold on
% plot(log10(x1),y_est,'r--','LineWidth',2)
% hold off


%
plot(x1, Yp2, '-k', 'DisplayName', 'Fit');
% legend('SW','SWR SW','CSWR SW','Fit')
% title('Vehicle SWs')
xo

xlong1=x1;
x1=linspace(min(length(vertcat(xlong1,xlong2))),max(length(vertcat(xlong1,xlong2))),1000);
%%
legend('SW','Ripples','SWR SW', 'SWR Ripples','CSWR SW','CSWR Ripples','Fit SW','Fit Ripples' )
%%
%% Ripples

T_ripples = readtable('SWRChara.xls','Sheet','Form2');

ripples_Amp_Veh=T_ripples(:,3);
ripples_Dur_Veh=T_ripples(:,5);

ripples_Amp_Veh=table2array(ripples_Amp_Veh);
ripples_Dur_Veh=table2array(ripples_Dur_Veh);
%%
scatter(ripples_Dur_Veh,ripples_Amp_Veh,'filled')
xlabel('Duration (ms)')
ylabel('Amplitude (mV)')
 set(gca,'xscale','log')
 set(gca,'yscale','log')
 hold on
%%
 %% SWR Ripples

T_SWRripples = readtable('SWRChara.xls','Sheet','Form4');

SWRripples_Amp_Veh=T_SWRripples(:,3);
SWRripples_Dur_Veh=T_SWRripples(:,5);

SWRripples_Amp_Veh=table2array(SWRripples_Amp_Veh);
SWRripples_Dur_Veh=table2array(SWRripples_Dur_Veh);
 
%%
scatter(SWRripples_Dur_Veh,SWRripples_Amp_Veh,'filled')
xlabel('Duration (ms)')
ylabel('Amplitude (mV)')
 set(gca,'xscale','log')
 set(gca,'yscale','log')
%%
 %% CSWR Ripples

T_cSWRripples = readtable('SWRChara.xls','Sheet','Form6');

cSWRripples_Amp_Veh=T_cSWRripples(:,3);
cSWRripples_Dur_Veh=T_cSWRripples(:,5);

cSWRripples_Amp_Veh=table2array(cSWRripples_Amp_Veh);
cSWRripples_Dur_Veh=table2array(cSWRripples_Dur_Veh);
%%
scatter(cSWRripples_Dur_Veh,cSWRripples_Amp_Veh,'filled')
xlabel('Duration (ms)')
ylabel('Amplitude (mV)')
 set(gca,'xscale','log')
 set(gca,'yscale','log')

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
%Ripples 
x1=[ripples_Dur_Veh;SWRripples_Dur_Veh;cSWRripples_Dur_Veh];
y1=[ripples_Amp_Veh;SWRripples_Amp_Veh;cSWRripples_Amp_Veh];


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

