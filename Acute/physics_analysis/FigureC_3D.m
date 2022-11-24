% p=gkde2_contour([SW_Amp_Veh SW_emptyPyr_Amp_Veh]);

% t = tiledlayout(2,1);
% ax1 = nexttile;
% ax1 = subplot(4,1,1);
tiledlayout(2,2);
ax1 = nexttile;
clear p
p.N=200;
p=gkde2_contour([SW_Amp_Veh SW_emptyPyr_Amp_Veh],p);
%[M,c]=contour(p.x,p.y,p.pdf,3);
surf(p.x,p.y,p.pdf./( max(max(p.pdf))));
xlabel('AUC SW')
ylabel('AUC Ripple')
zlabel('Density Probability') 

 set(gca,'xscale','log')
 set(gca,'yscale','log')
 
map=[1:256];
map=[  map.' zeros(length(map),1) zeros(length(map),1)]; 
ax1.Colormap=map./256;
title('SW')
 
%ax2 = subplot(4,1,2);
ax2 = nexttile;

% ax2 = nexttile;
p.N=100;
p=gkde2_contour([Ripple_emptyRad_Amp_Veh(~isnan(Ripple_emptyRad_Amp_Veh)) Ripple_Amp_Veh(~isnan(Ripple_emptyRad_Amp_Veh))],p);
surf(p.x,p.y,p.pdf./( max(max(p.pdf))));
xlabel('AUC SW')
ylabel('AUC Ripple')
zlabel('Density Probability') 

 set(gca,'xscale','log')
 set(gca,'yscale','log')

map=[1:256];
map=[  zeros(length(map),1) zeros(length(map),1)  map.']; 
ax2.Colormap=map./256;
title('R')
 
 
ax3 = nexttile;
p.N=100;
p=gkde2_contour([SWSWR_Amp_Veh SWR_Amp_Veh],p);

surf(p.x,p.y,p.pdf./( max(max(p.pdf))));
xlabel('AUC SW')
ylabel('AUC Ripple')
zlabel('Density Probability') 

 set(gca,'xscale','log')
 set(gca,'yscale','log')
 
 

map=[1:256];
map=[   map.' zeros(length(map),1)   map.']; 
ax3.Colormap=map./256; 
title('SWR')


ax4 = nexttile;
p.N=100;
p=gkde2_contour([SWcSWR_Amp_Veh cSWR_Amp_Veh],p);

surf(p.x,p.y,p.pdf./( max(max(p.pdf))));
xlabel('AUC SW')
ylabel('AUC Ripple')
zlabel('Density Probability') 

 set(gca,'xscale','log')
 set(gca,'yscale','log')

map=[1:256];
map=[     map.'  map.' zeros(length(map),1)]; 
ax4.Colormap=map./256; 
title('cSWR') 
 
%  linkaxes([ax1,ax2])
Link = linkprop([ax1, ax2,ax3,ax4],{'CameraUpVector', 'CameraPosition', 'CameraTarget', 'XLim', 'YLim','Zlim'});
setappdata(gcf, 'StoreTheLink', Link);
xlim([2 140])
ylim([0.1 10])
%% Overlayed
clear p
p.N=200;
p=gkde2_contour([SW_Amp_Veh SW_emptyPyr_Amp_Veh],p);
%[M,c]=contour(p.x,p.y,p.pdf,3);
clear CO
CO(:,:,1) = p.pdf./( max(max(p.pdf))).*linspace(0,256,200); % red
CO(:,:,2) =  zeros(200);% green
CO(:,:,3) =  zeros(200); % blue

% 
% map=[linspace(0,256,200); linspace(0,256,200)];
% map=[  map.' zeros(length(map),1) zeros(length(map),1)]; 

s(1)=surf(p.x,p.y,p.pdf./( max(max(p.pdf))),CO,'FaceAlpha',0.2,'edgecolor', 'none');
%s(1)=surf(p.x,p.y,p.pdf,CO,'FaceAlpha',0.2,'edgecolor', 'none');
xlabel('AUC SW')
ylabel('AUC Ripple')
zlabel('Density Probability') 

 set(gca,'xscale','log')
 set(gca,'yscale','log')
 
% ax1.Colormap=map./256;
% title('SW')
hold on
%xo



%ax2 = subplot(4,1,2);

% ax2 = nexttile;
p.N=100;
p=gkde2_contour([Ripple_emptyRad_Amp_Veh(~isnan(Ripple_emptyRad_Amp_Veh)) Ripple_Amp_Veh(~isnan(Ripple_emptyRad_Amp_Veh))],p);
clear CO
CO(:,:,1) = zeros(p.N); % red
CO(:,:,2) =  zeros(p.N);% green
CO(:,:,3) =  p.pdf./( max(max(p.pdf))).*linspace(0,256,p.N); % blue


s(2)=surf(p.x,p.y,p.pdf./( max(max(p.pdf))),CO,'FaceAlpha',0.2,'edgecolor', 'none');
%s(2)=surf(p.x,p.y,p.pdf,CO,'FaceAlpha',0.2,'edgecolor', 'none');

xlabel('AUC SW')
ylabel('AUC Ripple')
zlabel('Density Probability') 

 set(gca,'xscale','log')
 set(gca,'yscale','log')

% title('R')

 
p.N=100;
p=gkde2_contour([SWSWR_Amp_Veh SWR_Amp_Veh],p);
clear CO
CO(:,:,1) =  p.pdf./( max(max(p.pdf))).*linspace(0,256,p.N); % red
CO(:,:,2) =  zeros(p.N);% green
CO(:,:,3) =  p.pdf./( max(max(p.pdf))).*linspace(0,256,p.N); % blue


s(3)=surf(p.x,p.y,p.pdf./( max(max(p.pdf))),CO,'FaceAlpha',0.2,'edgecolor', 'none');
%s(3)=surf(p.x,p.y,p.pdf,CO,'FaceAlpha',0.2,'edgecolor', 'none');

xlabel('AUC SW')
ylabel('AUC Ripple')
zlabel('Density Probability') 

 set(gca,'xscale','log')
 set(gca,'yscale','log')
 
% title('SWR')

p.N=100;
p=gkde2_contour([SWcSWR_Amp_Veh cSWR_Amp_Veh],p);
clear CO
CO(:,:,1) =  p.pdf./( max(max(p.pdf))).*linspace(0,256,p.N); % red
CO(:,:,2) =  p.pdf./( max(max(p.pdf))).*linspace(0,256,p.N); % green
CO(:,:,3) =  zeros(p.N);% blue

s(4)=surf(p.x,p.y,p.pdf./( max(max(p.pdf))),CO,'FaceAlpha',0.2,'edgecolor', 'none');
%s(4)=surf(p.x,p.y,p.pdf,CO,'FaceAlpha',0.2,'edgecolor', 'none');

xlabel('AUC SW')
ylabel('AUC Ripple')
zlabel('Density Probability') 

 set(gca,'xscale','log')
 set(gca,'yscale','log')

% title('cSWR') 
 
%  linkaxes([ax1,ax2])
% Link = linkprop([ax1, ax2,ax3,ax4],{'CameraUpVector', 'CameraPosition', 'CameraTarget', 'XLim', 'YLim','Zlim'});
% setappdata(gcf, 'StoreTheLink', Link);


xo
xlim([2 140])
ylim([0.1 10])



%% Set up recording parameters (optional), and record
OptionZ.FrameRate=15;OptionZ.Duration=20;OptionZ.Periodic=true;
CaptureFigVid([-20,10;-110,10;-190,10;-290,10;-380,10], '3D_AUC_vs_AUC_notnormalized_compressed',OptionZ)
