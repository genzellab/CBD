clear variables
cd('/media/adrian/6aa1794c-0320-4096-a7df-00ab0ba946dc/cbd_revision/renamed')
load('FTx_ratID2_cbd.mat')
%%
close all
% 5)HPCpyra-unfiltered; 6)HPCbelo-unfiltered'
%ripple=GC_ripple_ratID2_cbd;
ripple=GC_sw_ratID2_cbd;
ripple=ripple.waveforms;

n=116;
x=ripple{n}(5,:);
y=ripple{n}(6,:);

fn=600;
fs=fn;

Wn1=[50/(fn/2) 250/(fn/2)]; % Cutoff=100-300 Hz
% Wn1=[50/(fn/2) 80/(fn/2)]; 
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
filtered=filtfilt(b1,a1,x);

t=[0:length(x)-1]/600;



figure;

% First subplot
subplot(3,1,1);
plot(t, x, 'Color', 'k', 'LineWidth', 1);
title('SP');
xlim([2.5 3.5]);
ax1 = gca;
ax1.XTick = linspace(2.5, 3.5, 5);
ax1.XTickLabels = [0; 0.25; 0.5; 0.75; 1];
%ax1.YTick = 6;
% ax1.YTickLabels = {'SP'};
ax1.YColor = [0 0 0];
ax1.XColor = [0 0 0];
ax1.FontSize = 8;
ax1.FontName = 'Arial';

% Second subplot
subplot(3,1,2);
plot(t, filtered, 'Color', 'k', 'LineWidth', 1);
title('Filtered SP');
xlim([2.5 3.5]);
ax2 = gca;
ax2.XTick = linspace(2.5, 3.5, 5);
ax2.XTickLabels = [0; 0.25; 0.5; 0.75; 1];
ax2.YColor = [0 0 0];
ax2.XColor = [0 0 0];
ax2.FontSize = 8;
ax2.FontName = 'Arial';

% Third subplot
subplot(3,1,3);
plot(t, y, 'Color', 'k', 'LineWidth', 1);
title('SR');
xlabel('Time (seconds)');
xlim([2.5 3.5]);
ax3 = gca;
ax3.XTick = linspace(2.5, 3.5, 5);
ax3.XTickLabels = [0; 0.25; 0.5; 0.75; 1];
ax3.YColor = [0 0 0];
ax3.XColor = [0 0 0];
ax3.FontSize = 8;
ax3.FontName = 'Arial';

% Adjust the figure properties
f = gcf;
set(f, 'Units', 'centimeters');
% f.Position(3) = 3;
% f.Position(4) = 3;
% f.PaperSize = [3.05 3.05];
% Link the x-axes
linkaxes([ax1, ax2, ax3], 'x');

%% IGNORE THE REST OF THE CODE
plot(t,(x)+6,'Color','k','LineWidth',1)
hold on
plot(t,(filtered)+3,'Color','k','LineWidth',1)

plot(t,(y),'Color','k','LineWidth',1)
xlabel('Time (seconds)')

xlim([2.5 3.5])

ax=gca;
ax.XTick=linspace(2.5,3.5,5)
ax.XTickLabels=[{0};{0.25};{0.5};{0.75};{1}]
ax.YTick=[0 6]
ax.YTickLabels=[{'SR'} {'SP'}];
f=gcf;
set(f,'Units','centimeters')
% f.Position(3)=3;
% f.Position(4)=3;
% f.PaperSize=[3.05 3.05]

ax=gca;
ax.YColor=[0 0 0];
ax.XColor=[0 0 0];
ax.FontSize=8;
ax.FontName='Arial';

