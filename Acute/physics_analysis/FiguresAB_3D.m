% Overlayed
clear p
p.N=100;
p=gkde2_contour([SW_Dur_Veh SW_Amp_Veh],p);
%[M,c]=contour(p.x,p.y,p.pdf,3);
clear CO
% CO(:,:,1) = p.pdf./( max(max(p.pdf))).*linspace(0,256,p.N); % red
% CO(:,:,2) =  zeros(p.N);% green
% CO(:,:,3) =  zeros(p.N); % blue

CO(:,:,1) =  zeros(p.N); % red
CO(:,:,2) =  zeros(p.N);% green
CO(:,:,3) = p.pdf./( max(max(p.pdf))).*linspace(0,256,p.N); % blue

% 
% map=[linspace(0,256,200); linspace(0,256,200)];
% map=[  map.' zeros(length(map),1) zeros(length(map),1)]; 

s(1)=surf(p.x,p.y,p.pdf./( max(max(p.pdf))),CO,'FaceAlpha',0.4);

xlabel('Duration')
ylabel('AUC')
zlabel('Density Probability') 

 set(gca,'xscale','log')
 set(gca,'yscale','log')
 
% ax1.Colormap=map./256;
% title('SW')
hold on
% xo



%ax2 = subplot(4,1,2);

% ax2 = nexttile;
p.N=100;
p=gkde2_contour([SWRSW_Dur_Veh SWRSW_Amp_Veh],p);
clear CO
CO(:,:,1) =  p.pdf./( max(max(p.pdf))).*linspace(0,256,p.N); % red
CO(:,:,2) =  zeros(p.N);% green
CO(:,:,3) =  p.pdf./( max(max(p.pdf))).*linspace(0,256,p.N); % blue


s(2)=surf(p.x,p.y,p.pdf./( max(max(p.pdf))),CO,'FaceAlpha',0.4);

 set(gca,'xscale','log')
 set(gca,'yscale','log')

% title('R')

%  xo

p.N=50;
p=gkde2_contour([cSWRSW_Dur_Veh cSWRSW_Amp_Veh],p);
clear CO
CO(:,:,1) =  p.pdf./( max(max(p.pdf))).*linspace(0,256,p.N); % red
CO(:,:,2) =  p.pdf./( max(max(p.pdf))).*linspace(0,256,p.N); % green
CO(:,:,3) =  zeros(p.N);% blue

s(4)=surf(p.x,p.y,p.pdf./( max(max(p.pdf))),CO,'FaceAlpha',0.4);


 set(gca,'xscale','log')
 set(gca,'yscale','log')

% title('cSWR') 
%  xo
%  linkaxes([ax1,ax2])
% Link = linkprop([ax1, ax2,ax3,ax4],{'CameraUpVector', 'CameraPosition', 'CameraTarget', 'XLim', 'YLim','Zlim'});
% setappdata(gcf, 'StoreTheLink', Link);

%FOR Ripple
xlim([10 629])
ylim([0.021 28])

xo
f=gcf;
set(f,'Units','centimeters')
% h.Position(1)=0;
% h.Position(2)=0;
% f.Position(3)=3;
% f.Position(4)=3;
% f.Position(3)=25;
% f.Position(4)=12.5;

% f.PaperSize=[3.05 3.05]
%xo
ax=gca;
ax.YColor=[0 0 0];
ax.XColor=[0 0 0];
ax.FontSize=8;
ax.FontName='Arial';
cd('/home/adrian/Documents/CBD_acutes')
%% Set up recording parameters (optional), and record
OptionZ.FrameRate=15;OptionZ.Duration=20;OptionZ.Periodic=true;
CaptureFigVid([-20,10;-110,10;-190,10;-290,10;-380,10], 'Duration_AUC_Ripple',OptionZ)
