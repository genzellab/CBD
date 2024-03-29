% p=gkde2_contour([SW_Amp_Veh SW_emptyPyr_Amp_Veh],p);
% p=gkde2_contour([Ripple_emptyRad_Amp_Veh(~isnan(Ripple_emptyRad_Amp_Veh)) Ripple_Amp_Veh(~isnan(Ripple_emptyRad_Amp_Veh))],p);
% p=gkde2_contour([SWSWR_Amp_Veh SWR_Amp_Veh],p);
% p=gkde2_contour([SWcSWR_Amp_Veh cSWR_Amp_Veh],p);
%%

x=vertcat(SW_Amp_Veh, Ripple_emptyRad_Amp_Veh(~isnan(Ripple_emptyRad_Amp_Veh)), SWSWR_Amp_Veh, SWcSWR_Amp_Veh);
%x=vertcat(  SWSWR_Amp_Veh, SWcSWR_Amp_Veh);

y=vertcat(SW_emptyPyr_Amp_Veh,  Ripple_Amp_Veh(~isnan(Ripple_emptyRad_Amp_Veh)), SWR_Amp_Veh, cSWR_Amp_Veh);
%y=vertcat(   SWR_Amp_Veh, cSWR_Amp_Veh);
%%
clear x
x{1}=SW_Amp_Veh;
x{2}=Ripple_emptyRad_Amp_Veh(~isnan(Ripple_emptyRad_Amp_Veh))
x{3}=SWSWR_Amp_Veh
x{4}=SWcSWR_Amp_Veh;
clear y
y{1}=SW_emptyPyr_Amp_Veh;
y{2}=Ripple_Amp_Veh(~isnan(Ripple_emptyRad_Amp_Veh));
y{3}=SWR_Amp_Veh;
y{4}=cSWR_Amp_Veh;


minval= min(cellfun('length',x));

r1=randperm(length(x{1}),minval); %Permute M and take N integers from shuffled M.
r2=randperm(length(x{2}),minval);
r3=randperm(length(x{3}),minval);
r4=randperm(length(x{4}),minval);

x{1}=x{1}(r1);
y{1}=y{1}(r1);

x{2}=x{2}(r2);
y{2}=y{2}(r2);

x{3}=x{3}(r3);
y{3}=y{3}(r3);

x{4}=x{4}(r4);
y{4}=y{4}(r4);
%%
% x=cellfun(@zscore,x,'UniformOutput',false)
% y=cellfun(@zscore,y,'UniformOutput',false)
%%

%%
x=[x{:}];
x=x(:);

y=[y{:}];
y=y(:);

%%

%x=vertcat(  SWSWR_Amp_Veh, SWcSWR_Amp_Veh);

%y=vertcat(SW_emptyPyr_Amp_Veh,  Ripple_Amp_Veh(~isnan(Ripple_emptyRad_Amp_Veh)), SWR_Amp_Veh, cSWR_Amp_Veh);

%%
scatter(x{1},y{1})
hold on
scatter(x{2},y{2})
scatter(x{3},y{3})
scatter(x{4},y{4})

xlabel('AUC SW')
ylabel('AUC Ripple')
zlabel('Density Probability') 

 set(gca,'xscale','log')
 set(gca,'yscale','log')
%%
nbins=[20 20];
hist3([x, y],'CDataMode','auto')
%contourf(C{1},C{2},N) 
set(gca,'xscale','log')
 set(gca,'yscale','log')
%%
clear p
p.N=100;
p=gkde2_contour([x y],p);
% contour(p.x,p.y,(p.pdf)./rot90(rot90(P)),3);%./( max(max(p.pdf)))
b=zscore(p.pdf);
%b=b./max(b);
%contour(p.x,p.y,b,6);%./( max(max(p.pdf)))
% c=colorbar();
% c.Limits=[min(b(:)) max(b(:))]
colormap(flipud(gray))
B=b+abs(min(b(:)));

CO(:,:,1) =  zeros(p.N); % red
CO(:,:,2) =  zeros(p.N); % green
CO(:,:,3) =  zeros(p.N);% blue

surf(p.x,p.y,B./max(B(:)),CO,'FaceAlpha',0.5);%./( max(max(p.pdf)))
set(gca,'xscale','log')
set(gca,'yscale','log')
%set(gca,'zscale','log')

xlabel('AUC Radiatum')
ylabel('AUC Pyramidale')
zlabel('Z-scored Density') 

% xlim([0.5586  445.0175])
% ylim([0.05461   24.1359])
xlim([2 140])
ylim([0.1 10])
%% 
OptionZ.FrameRate=15;OptionZ.Duration=20;OptionZ.Periodic=true;
CaptureFigVid([-20,10;-110,10;-190,10;-290,10;-380,10], '3D_AUC_vs_AUC_mixed_zscore_with_types_compressed',OptionZ)
%% Merge figures

fh1 = open('FigureC_contours_new_axes.fig');
fh2 = open('AUC_AUC_mixed.fig');
 ax1 = get(fh1, 'Children');
 ax2 = get(fh2, 'Children');
 ax2p = get(ax2(1),'Children');
 copyobj(ax2p, ax1(1));
 
%% Plot surface crossing contours.
clear pp

% R
% pp.N=100;
% pp=gkde2_contour([Ripple_emptyRad_Amp_Veh(~isnan(Ripple_emptyRad_Amp_Veh)) Ripple_Amp_Veh(~isnan(Ripple_emptyRad_Amp_Veh))],pp);
% contour(p.x,p.y,[B./max(B(:))]-[pp.pdf./( max(max(pp.pdf)))],[-0.0001:0.0001:0.0001],'Color','b')
% set(gca,'xscale','log')
% set(gca,'yscale','log')
% xlabel('AUC Radiatum')
% ylabel('AUC Pyramidale')
% zlabel('Normalized Density') 
% 
% xlim([0.5586  445.0175])
% ylim([0.05461   24.1359])
% xlim([2 140])
% ylim([0.1 10])
% hold on

% SWR
pp.N=100;
pp=gkde2_contour([SWSWR_Amp_Veh SWR_Amp_Veh],pp);
contour(p.x,p.y,[B./max(B(:))]-[pp.pdf./( max(max(pp.pdf)))],[-0.0001:0.0001:0.0001],'Color',"#7E2F8E")
set(gca,'xscale','log')
set(gca,'yscale','log')
xlabel('AUC Radiatum')
ylabel('AUC Pyramidale')
zlabel('Normalized Density') 

xlim([0.5586  445.0175])
ylim([0.05461   24.1359])
hold on

pp.N=100;
pp=gkde2_contour([SWcSWR_Amp_Veh cSWR_Amp_Veh],pp);
contour(p.x,p.y,[B./max(B(:))]-[pp.pdf./( max(max(pp.pdf)))],[-0.0001:0.0001:0.0001],'Color',"#EDB120")



set(gca,'xscale','log')
set(gca,'yscale','log')
xlabel('AUC Radiatum')
ylabel('AUC Pyramidale')
zlabel('Normalized Density') 

xlim([0.5586  445.0175])
ylim([0.05461   24.1359])