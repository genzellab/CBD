T_SW = readtable('SWRChara.xls','Sheet','Form1');
%%
SW_Amp_CBD=T_SW(:,9);
SW_Dur_CBD=T_SW(:,11);

SW_Amp_CBD=table2array(SW_Amp_CBD);
SW_Dur_CBD=table2array(SW_Dur_CBD);

%% SharpWaves

%scatter(SW_Dur_CBD,SW_Amp_CBD,'filled')
plot(nanmean(SW_Dur_CBD),nanmean(SW_Amp_CBD),'*','MarkerSize',20)

xlabel('Duration (ms)')
ylabel('Amplitude (mV)')
 set(gca,'xscale','log')
 set(gca,'yscale','log')

hold on
%% Ripples

T_ripples = readtable('SWRChara.xls','Sheet','Form2');

ripples_Amp_CBD=T_ripples(:,9);
ripples_Dur_CBD=T_ripples(:,11);

ripples_Amp_CBD=table2array(ripples_Amp_CBD);
ripples_Dur_CBD=table2array(ripples_Dur_CBD);
%%
scatter(ripples_Dur_CBD,ripples_Amp_CBD,'filled')
xlabel('Duration (ms)')
ylabel('Amplitude (mV)')
 set(gca,'xscale','log')
 set(gca,'yscale','log')
 %%
 %% SWR Sharp wave

T_SWRSW = readtable('SWRChara.xls','Sheet','Form3');

SWRSW_Amp_CBD=T_SWRSW(:,9);
SWRSW_Dur_CBD=T_SWRSW(:,11);

SWRSW_Amp_CBD=table2array(SWRSW_Amp_CBD);
SWRSW_Dur_CBD=table2array(SWRSW_Dur_CBD);
%%
%scatter(SWRSW_Dur_CBD,SWRSW_Amp_CBD,'filled')
plot(nanmean(SWRSW_Dur_CBD),nanmean(SWRSW_Amp_CBD),'*','MarkerSize',20)

xlabel('Duration (ms)')
ylabel('Amplitude (mV)')
 set(gca,'xscale','log')
 set(gca,'yscale','log')
 
 
 
 %% SWR Ripples

T_SWRripples = readtable('SWRChara.xls','Sheet','Form4');

SWRripples_Amp_CBD=T_SWRripples(:,9);
SWRripples_Dur_CBD=T_SWRripples(:,11);

SWRripples_Amp_CBD=table2array(SWRripples_Amp_CBD);
SWRripples_Dur_CBD=table2array(SWRripples_Dur_CBD);
 
%%
scatter(SWRripples_Dur_CBD,SWRripples_Amp_CBD,'filled')
xlabel('Duration (ms)')
ylabel('Amplitude (mV)')
 set(gca,'xscale','log')
 set(gca,'yscale','log')
%%

 %% CSWR SW

T_cSWRSW = readtable('SWRChara.xls','Sheet','Form5');

cSWRSW_Amp_CBD=T_cSWRSW(:,9);
cSWRSW_Dur_CBD=T_cSWRSW(:,11);

cSWRSW_Amp_CBD=table2array(cSWRSW_Amp_CBD);
cSWRSW_Dur_CBD=table2array(cSWRSW_Dur_CBD);

%%
% scatter(cSWRSW_Dur_CBD,cSWRSW_Amp_CBD,'filled')
plot(nanmean(cSWRSW_Dur_CBD),nanmean(cSWRSW_Amp_CBD),'*','MarkerSize',20)

xlabel('Duration (ms)')
ylabel('Amplitude (mV)')
 set(gca,'xscale','log')
 set(gca,'yscale','log')




 %% CSWR Ripples

T_cSWRripples = readtable('SWRChara.xls','Sheet','Form6');

cSWRripples_Amp_CBD=T_cSWRripples(:,9);
cSWRripples_Dur_CBD=T_cSWRripples(:,11);

cSWRripples_Amp_CBD=table2array(cSWRripples_Amp_CBD);
cSWRripples_Dur_CBD=table2array(cSWRripples_Dur_CBD);
%%
scatter(cSWRripples_Dur_CBD,cSWRripples_Amp_CBD,'filled')
xlabel('Duration (ms)')
ylabel('Amplitude (mV)')
 set(gca,'xscale','log')
 set(gca,'yscale','log')
%%

legend('SW','Ripples','SWR SW', 'SWR Ripples','CSWR SW','CSWR Ripples' )
%%

% x1=[SW_Dur_CBD;ripples_Dur_CBD;SWRSW_Dur_CBD;SWRripples_Dur_CBD;cSWRSW_Dur_CBD;cSWRripples_Dur_CBD];
% y1=[SW_Amp_CBD;ripples_Amp_CBD;SWRSW_Amp_CBD;SWRripples_Amp_CBD;cSWRSW_Amp_CBD;cSWRripples_Amp_CBD];

%Sharp waves 
x1=[SW_Dur_CBD;SWRSW_Dur_CBD;cSWRSW_Dur_CBD];
y1=[SW_Amp_CBD;SWRSW_Amp_CBD;cSWRSW_Amp_CBD];


x1=x1(~isnan(x1));
y1=y1(~isnan(y1));


%p = polyfit(x1,y1,1);

% 
% [x1,I]=sort(x1);
% y1=y1(I);
X=min(x1):max(x1);

[slope, intercept] = logfit(x1,y1,'logy');
yApprox = (10^intercept)*(10^slope).^X;
%%
plot(X,yApprox,'LineWidth',3,'Color',[0 1 0])

%%
legend('SW','SWR SW','CSWR SW','CBD SW','CBD SWR SW','CBD CSWR SW','Fit VEH SW types', 'Fit CBD SW types')

%%
% figure()
y2 = polyval(p,x1);


% plot(x1,y2)
%  set(gca,'xscale','log')
%  set(gca,'yscale','log')
loglog(x1,y2)
%%
%Ripples 
x1=[ripples_Dur_CBD;SWRripples_Dur_CBD;cSWRripples_Dur_CBD];
y1=[ripples_Amp_CBD;SWRripples_Amp_CBD;cSWRripples_Amp_CBD];


x1=x1(~isnan(x1));
y1=y1(~isnan(y1));


[slope, intercept] = logfit(x1,y1,'logy');
yApprox = (10^intercept)*(10^slope).^X;


plot(X,yApprox,'LineWidth',3,'Color',[0 1 0])
%%
legend('Ripple','SWR Ripple','CSWR Ripple','CBD Ripple','CBD SWR Ripple','CBD CSWR Ripple','Fit VEH Ripple types', 'Fit CBD Ripple types')

% 
% p = polyfit(x1,y1,1);
% y2 = polyval(p,x1);
% 
% loglog(x1,y2)
%%
legend('SW','Ripples','SWR SW', 'SWR Ripples','CSWR SW','CSWR Ripples','Fit SW','Fit Ripples' )
%%

legend('SW','SWR SW', 'CSWR SW','Fit SW', 'CBD SW','CBD SWR SW', 'CBD CSWR SW','CBD Fit SW'  )
%%

legend('Ripple','SWR Ripple', 'CSWR Ripple','Fit Ripple', 'CBD Ripple','CBD SWR Ripple', 'CBD CSWR Ripple','CBD Fit Ripple'  )
%%
Duration_sharpwaves=[SW_Dur_CBD;SWRSW_Dur_CBD;cSWRSW_Dur_CBD;SW_Dur_Veh;SWRSW_Dur_Veh;cSWRSW_Dur_Veh];

Duration_ripples=[ripples_Dur_CBD;SWRripples_Dur_CBD;cSWRripples_Dur_CBD;ripples_Dur_Veh;SWRripples_Dur_Veh;cSWRripples_Dur_Veh];

x=sort(Duration_sharpwaves);

y=sort(Duration_ripples);
