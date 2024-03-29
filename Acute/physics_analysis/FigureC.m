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
%% SW and empty PYR
T_SW = readtable('SWRChara.xls','Sheet','Form1');
%%
SW_Amp_Veh=T_SW(:,4); %AUC (Should be 4 in Veh, 12 in CBD)
SW_Amp_Veh=table2array(SW_Amp_Veh);

T_SW_emptyPyr = readtable('SWRChara.xls','Sheet','Form1 pyr.');

SW_emptyPyr_Amp_Veh=T_SW_emptyPyr(:,4); %AUC
SW_emptyPyr_Amp_Veh=table2array(SW_emptyPyr_Amp_Veh);
%%
%scatter((SW_Amp_Veh),(SW_emptyPyr_Amp_Veh),'o','MarkerFaceColor',"red",'MarkerEdgeColor',"red");
p=gkde2_contour([remove_nan(SW_Amp_Veh) remove_nan(SW_emptyPyr_Amp_Veh)]);
[M,c]=contour(p.x,p.y,p.pdf,3);
c.LineColor="red"

%errorbar(nanmedian(SWSWR_Amp_Veh),nanmedian(SWR_Amp_Veh),sem(SWR_Amp_Veh)*1.96,sem(SWR_Amp_Veh)*1.96,sem(SWSWR_Amp_Veh)*1.96,sem(SWSWR_Amp_Veh)*1.96,'o','Color',"#7E2F8E",'MarkerSize',20);
% 
% 
% 
xlabel('AUC SW')
ylabel('AUC Ripple')
 set(gca,'xscale','log')
 set(gca,'yscale','log')
  
 hold on
    if exist('x1','var')
        xlong=linspace(min(x1),max(x1),1000);
    else
        xlong=SW_Amp_Veh;
    end
[p,curvefit,gof,Yp2]=fitter(SW_Amp_Veh,SW_emptyPyr_Amp_Veh,xlong);
 %plot(xlong, Yp2, 'DisplayName', 'Fit','LineWidth',5 ,'Color',"red");
%% Ripples alone and empty Radiatum

T_Ripple_emptyRad = readtable('SWRChara.xls','Sheet','Form2 bel.');
%%
Ripple_emptyRad_Amp_Veh=T_Ripple_emptyRad(:,4); %AUC
Ripple_emptyRad_Amp_Veh=table2array(Ripple_emptyRad_Amp_Veh);

T_Ripple = readtable('SWRChara.xls','Sheet','Form2');

Ripple_Amp_Veh=T_Ripple(:,4); %AUC
Ripple_Amp_Veh=table2array(Ripple_Amp_Veh);
%%
%scatter((SW_Amp_Veh),(SW_emptyPyr_Amp_Veh),'o','MarkerFaceColor',"red",'MarkerEdgeColor',"red");
% p=[];
% p.xylim= [xmin -Inf Inf Inf]
p=gkde2_contour([Ripple_emptyRad_Amp_Veh(~isnan(Ripple_emptyRad_Amp_Veh)) Ripple_Amp_Veh(~isnan(Ripple_emptyRad_Amp_Veh))]);
[M,c]=contour(p.x,p.y,p.pdf,3);
c.LineColor="blue"

%errorbar(nanmedian(SWSWR_Amp_Veh),nanmedian(SWR_Amp_Veh),sem(SWR_Amp_Veh)*1.96,sem(SWR_Amp_Veh)*1.96,sem(SWSWR_Amp_Veh)*1.96,sem(SWSWR_Amp_Veh)*1.96,'o','Color',"#7E2F8E",'MarkerSize',20);
% 
% 
% 
xlabel('AUC SW')
ylabel('AUC Ripple')
 set(gca,'xscale','log')
 set(gca,'yscale','log')
  
 hold on
    if exist('x1','var')
        xlong=linspace(min(x1),max(x1),1000);
    else
        xlong=Ripple_emptyRad_Amp_Veh;
    end
[p,curvefit,gof,Yp2]=fitter(Ripple_emptyRad_Amp_Veh,Ripple_Amp_Veh,xlong);
 %plot(xlong, Yp2, 'DisplayName', 'Fit','LineWidth',5 ,'Color',"blue");



%%
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
p=gkde2_contour([remove_nan(SWSWR_Amp_Veh) remove_nan(SWR_Amp_Veh)]);
[M,c]=contour(p.x,p.y,p.pdf,3);
c.LineColor="#7E2F8E"

%errorbar(nanmedian(SWSWR_Amp_Veh),nanmedian(SWR_Amp_Veh),sem(SWR_Amp_Veh)*1.96,sem(SWR_Amp_Veh)*1.96,sem(SWSWR_Amp_Veh)*1.96,sem(SWSWR_Amp_Veh)*1.96,'o','Color',"#7E2F8E",'MarkerSize',20);
% 
% 
% 
xlabel('AUC SW')
ylabel('AUC Ripple')
 set(gca,'xscale','log')
 set(gca,'yscale','log')
  
 hold on
    if exist('x1','var')
        xlong=linspace(min(x1),max(x1),1000);
    else
        xlong=SWSWR_Amp_Veh;
    end
[p,curvefit,gof,Yp2]=fitter(SWSWR_Amp_Veh,SWR_Amp_Veh,xlong);
 %plot(xlong, Yp2, 'DisplayName', 'Fit','LineWidth',5 ,'Color',"#7E2F8E");
%xo 
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
% scatter((SWcSWR_Amp_Veh),(cSWR_Amp_Veh),'o','MarkerFaceColor',"#EDB120",'MarkerEdgeColor',"#EDB120");
% errorbar(nanmedian(SWcSWR_Amp_Veh),nanmedian(cSWR_Amp_Veh),sem(cSWR_Amp_Veh)*1.96,sem(cSWR_Amp_Veh)*1.96,sem(SWcSWR_Amp_Veh)*1.96,sem(SWcSWR_Amp_Veh)*1.96,'o','Color',"#EDB120",'MarkerSize',20);
p=gkde2_contour([remove_nan(SWcSWR_Amp_Veh) remove_nan(cSWR_Amp_Veh)]);
[M,c]=contour(p.x,p.y,p.pdf,3);
c.LineColor="#EDB120"

% 
% 
xlabel('AUC Radiatum')
ylabel('AUC Pyramidale')
 set(gca,'xscale','log')
 set(gca,'yscale','log')
 
hold on
    if exist('x1','var')
        xlong=linspace(min(x1),max(x1),1000);
    else
        xlong=SWcSWR_Amp_Veh;
    end
[p,curvefit,gof,Yp2]=fitter(SWcSWR_Amp_Veh,cSWR_Amp_Veh,xlong);
 %plot(xlong, Yp2, 'DisplayName', 'Fit','LineWidth',5 ,'Color',"#EDB120");

xo
%% CBD

T_SWSWR = readtable('SWRChara.xls','Sheet','Form3');
%%
SWSWR_Amp_CBD=T_SWSWR(:,4); %AUC
SWSWR_Amp_CBD=table2array(SWSWR_Amp_CBD);

T_SWR = readtable('SWRChara.xls','Sheet','Form4');

SWR_Amp_CBD=T_SWR(:,4); %AUC
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
SWcSWR_Amp_CBD=T_SWcSWR(:,4); %AUC
SWcSWR_Amp_CBD=table2array(SWcSWR_Amp_CBD);

T_cSWR = readtable('SWRChara.xls','Sheet','Form6');

cSWR_Amp_CBD=T_cSWR(:,4); %AUC
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

xo 
%%
% SWcSWR_Amp_Veh
% cSWR_Amp_Veh

x1=[SWcSWR_Amp_Veh;SWSWR_Amp_Veh];
y1=[cSWR_Amp_Veh; SWR_Amp_Veh];


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
xlabel('AUC SW')
ylabel('AUC Ripple')
 set(gca,'xscale','log')
 set(gca,'yscale','log')
 
hold on

%% CBD
x1=[SWcSWR_Amp_CBD;SWSWR_Amp_CBD];
y1=[cSWR_Amp_CBD; SWR_Amp_CBD];


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
plot(x1, Yp2, 'g', 'DisplayName', 'Fit');
xlabel('AUC SW')
ylabel('AUC Ripple')
 set(gca,'xscale','log')
 set(gca,'yscale','log')
