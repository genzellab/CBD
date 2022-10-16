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
SW_Amp_Veh=T_SW(:,4); %AUC
SW_Dur_Veh=T_SW(:,5);

SW_Amp_Veh=table2array(SW_Amp_Veh);
SW_Dur_Veh=table2array(SW_Dur_Veh);

%% SharpWaves

h(4)=scatter(SW_Dur_Veh,SW_Amp_Veh,'MarkerEdgeColor','r','MarkerEdgeAlpha',0.8)
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
[p,curvefit,gof,Yp2]=fitter(SW_Dur_Veh,SW_Amp_Veh,xlong);
 h(1)=plot(xlong, Yp2, '-r' ,'DisplayName', 'Fit','LineWidth',5 );
% text(max(SW_Dur_Veh),max(Yp2),' SW')

 %%
 %% SWR Sharp wave

T_SWRSW = readtable('SWRChara.xls','Sheet','Form3');

SWRSW_Amp_Veh=T_SWRSW(:,4); %AUC
SWRSW_Dur_Veh=T_SWRSW(:,5);

SWRSW_Amp_Veh=table2array(SWRSW_Amp_Veh);
SWRSW_Dur_Veh=table2array(SWRSW_Dur_Veh);
%%
scatter(SWRSW_Dur_Veh,SWRSW_Amp_Veh,'MarkerEdgeColor',"#7E2F8E",'MarkerEdgeAlpha',0.8)
xlabel('Duration (ms)')
ylabel('AUC')
 set(gca,'xscale','log')
 set(gca,'yscale','log')

    if exist('x1','var')
        xlong=linspace(min(x1),max(x1),1000);
    else
        xlong=SWRSW_Dur_Veh
    end 
 
 [p,curvefit,gof, Yp2]=fitter(SWRSW_Dur_Veh,SWRSW_Amp_Veh,xlong);
hold on
  h(2)=plot(xlong, Yp2,'Color',"#7E2F8E",'DisplayName', 'Fit','LineWidth',5 );

%   text(max(SWRSW_Dur_Veh),max(Yp2),' SWR SW')

 %% CSWR SW

T_cSWRSW = readtable('SWRChara.xls','Sheet','Form5');

cSWRSW_Amp_Veh=T_cSWRSW(:,4); %AUC
cSWRSW_Dur_Veh=T_cSWRSW(:,5);

cSWRSW_Amp_Veh=table2array(cSWRSW_Amp_Veh);
cSWRSW_Dur_Veh=table2array(cSWRSW_Dur_Veh);

%%
scatter(cSWRSW_Dur_Veh,cSWRSW_Amp_Veh,'MarkerEdgeColor',"#EDB120",'MarkerEdgeAlpha',0.8)
xlabel('Duration (ms)')
ylabel('AUC')
 set(gca,'xscale','log')
 set(gca,'yscale','log')

    if exist('x1','var')
        xlong=linspace(min(x1),max(x1),1000);
    else
        xlong=cSWRSW_Dur_Veh
    end
 
 [p,curvefit,gof,Yp2]=fitter(cSWRSW_Dur_Veh,cSWRSW_Amp_Veh,xlong);
hold on
  h(3)=plot(xlong, Yp2,'Color',"#EDB120",'DisplayName', 'Fit','LineWidth',5 );
% text(max(cSWRSW_Dur_Veh),max(Yp2),' cSWR SW')

uistack(h(1),'top');
uistack(h(2),'top');
uistack(h(3),'top');
uistack(h(4),'top');

%%
xo
legend('SW','Ripples','SWR SW', 'SWR Ripples','CSWR SW','CSWR Ripples' )
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

