cd('/home/adrian/Downloads')
T_SW = readtable('SWRChara.xls','Sheet','Form1');
%%
SW_Amp_Veh=T_SW(:,3);
SW_Dur_Veh=T_SW(:,5);

SW_Amp_Veh=table2array(SW_Amp_Veh);
SW_Dur_Veh=table2array(SW_Dur_Veh);

%% SharpWaves

scatter(SW_Dur_Veh,SW_Amp_Veh,'filled')
xlabel('Duration (ms)')
ylabel('Amplitude (mV)')
 set(gca,'xscale','log')
 set(gca,'yscale','log')

hold on
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
 %% SWR Sharp wave

T_SWRSW = readtable('SWRChara.xls','Sheet','Form3');

SWRSW_Amp_Veh=T_SWRSW(:,3);
SWRSW_Dur_Veh=T_SWRSW(:,5);

SWRSW_Amp_Veh=table2array(SWRSW_Amp_Veh);
SWRSW_Dur_Veh=table2array(SWRSW_Dur_Veh);
%%
scatter(SWRSW_Dur_Veh,SWRSW_Amp_Veh,'filled')
xlabel('Duration (ms)')
ylabel('Amplitude (mV)')
 set(gca,'xscale','log')
 set(gca,'yscale','log')
 
 
 
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

 %% CSWR SW

T_cSWRSW = readtable('SWRChara.xls','Sheet','Form5');

cSWRSW_Amp_Veh=T_cSWRSW(:,3);
cSWRSW_Dur_Veh=T_cSWRSW(:,5);

cSWRSW_Amp_Veh=table2array(cSWRSW_Amp_Veh);
cSWRSW_Dur_Veh=table2array(cSWRSW_Dur_Veh);

%%
scatter(cSWRSW_Dur_Veh,cSWRSW_Amp_Veh,'filled')
xlabel('Duration (ms)')
ylabel('Amplitude (mV)')
 set(gca,'xscale','log')
 set(gca,'yscale','log')




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

legend('SW','Ripples','SWR SW', 'SWR Ripples','CSWR SW','CSWR Ripples' )
%%

% x1=[SW_Dur_Veh;ripples_Dur_Veh;SWRSW_Dur_Veh;SWRripples_Dur_Veh;cSWRSW_Dur_Veh;cSWRripples_Dur_Veh];
% y1=[SW_Amp_Veh;ripples_Amp_Veh;SWRSW_Amp_Veh;SWRripples_Amp_Veh;cSWRSW_Amp_Veh;cSWRripples_Amp_Veh];

%Sharp waves 
x1=[SW_Dur_Veh;SWRSW_Dur_Veh;cSWRSW_Dur_Veh];
y1=[SW_Amp_Veh;SWRSW_Amp_Veh;cSWRSW_Amp_Veh];


x1=x1(~isnan(x1));
y1=y1(~isnan(y1));


p = polyfit(x1,y1,1);

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

