%% Plots
y_long = max(max([rt_long_cbd;rt_long_veh]));
y_short = max(max([rt_short_cbd;rt_short_veh]));

% Long Ripples CBD
figure
% patch([1.5 2.5 2.5 1.5], [0 0  1.1*max(max([rt_long_cbd;rt_long_veh])) 1.1*max(max([rt_long_cbd;rt_long_veh]))], [0.8784    0.8902    0.6745], 'LineStyle', 'none', 'FaceAlpha', 0.7)
patch([1.5 2.5 2.5 1.5], [0 0  1.1*y_long 1.1*y_long], [0.8784    0.8902    0.6745], 'LineStyle', 'none', 'FaceAlpha', 0.7)
hold on
for i = 1:size(rt_long_cbd,1)
        ripbouts =  rt_long_cbd(i,:);
        COL = [0.4667    0.7804    0.3529];
    for jj = 1:size(ripbouts,1)
        h1 = plot([1 2], ripbouts(jj,:), '-o', 'MarkerSize', 1 , 'color', COL);
        set(h1, 'markerfacecolor', get(h1, 'color'));
   
    end 
end 
xlim([0.7 2.3])
ylim([0 1.1*y_long])

xticks([1 2])
title('Long CBD')
% title(strcat('Normalized amount of sharpwave at the beginning and end of long NREM bouts',{'( '},num2str(limit),' min)'))
f = gcf;
set(f,'Units','centimeters')
f.Position(3) = 3;
f.Position(4) = 3;
f.PaperSize = [3.05 3.05];
ax = gca;
ax.YColor = [0 0 0];
ax.XColor = [0 0 0];
ax.FontSize = 8;
ax.FontName = 'Arial';
ax.XTickLabel = [{'0-10%'};{'90-100%'}];

saveas(gcf, 'Long_ripples_rates_cbd.pdf')
close all

% Long Ripples Vehicle
figure
patch([1.5 2.5 2.5 1.5], [0 0  1.1*y_long 1.1*y_long], [0.8784    0.8902    0.6745], 'LineStyle', 'none', 'FaceAlpha', 0.7)
hold on
for i = 1:size(rt_long_veh,1)
        ripbouts =  rt_long_veh(i,:);
        COL = [0.502 0.502 0.502];
    for jj = 1:size(ripbouts,1)
        h1 = plot([1 2], ripbouts(jj,:), '-o', 'MarkerSize', 1 , 'color', COL);
        set(h1, 'markerfacecolor', get(h1, 'color'));
   
    end 
end 
xlim([0.7 2.3])
ylim([0 1.1*y_long])

xticks([1 2])
title('Long Veh')
% title(strcat('Normalized amount of sharpwave at the beginning and end of long NREM bouts',{'( '},num2str(limit),' min)'))
f = gcf;
set(f,'Units','centimeters')
f.Position(3) = 3;
f.Position(4) = 3;
f.PaperSize = [3.05 3.05];
ax = gca;
ax.YColor = [0 0 0];
ax.XColor = [0 0 0];
ax.FontSize = 8;
ax.FontName = 'Arial';
ax.XTickLabel = [{'0-10%'};{'90-100%'}];

saveas(gcf, 'Long_ripples_rates_veh.pdf')
close all

% Short Ripples CBD
figure
% patch([1.5 2.5 2.5 1.5], [0 0  1.1*max(max([rt_short_cbd;rt_short_veh])) 1.1*max(max([rt_short_cbd;rt_short_veh]))], [0.8784    0.8902    0.6745], 'LineStyle', 'none', 'FaceAlpha', 0.7)
patch([1.5 2.5 2.5 1.5], [0 0  1.1*y_short 1.1*y_short], [0.8784    0.8902    0.6745], 'LineStyle', 'none', 'FaceAlpha', 0.7)
hold on
for i = 1:size(rt_short_cbd,1)
        ripbouts =  rt_short_cbd(i,:);
        COL = [0.4667    0.7804    0.3529];
    for jj = 1:size(ripbouts,1)
        h1 = plot([1 2], ripbouts(jj,:), '-o', 'MarkerSize', 1 , 'color', COL);
        set(h1, 'markerfacecolor', get(h1, 'color'));
   
    end 
end 
xlim([0.7 2.3])
ylim([0 1.1*y_short])

xticks([1 2])
title('Short CBD')
% title(strcat('Normalized amount of sharpwave at the beginning and end of short NREM bouts',{'( '},num2str(limit),' min)'))
f = gcf;
set(f,'Units','centimeters')
f.Position(3) = 3;
f.Position(4) = 3;
f.PaperSize = [3.05 3.05];
ax = gca;
ax.YColor = [0 0 0];
ax.XColor = [0 0 0];
ax.FontSize = 8;
ax.FontName = 'Arial';
ax.XTickLabel = [{'0-10%'};{'90-100%'}];

saveas(gcf, 'Short_ripples_rates_cbd.pdf')
close all

% Short Ripples Veh
figure
% patch([1.5 2.5 2.5 1.5], [0 0  1.1*max(max([rt_short_veh;rt_short_veh])) 1.1*max(max([rt_short_veh;rt_short_veh]))], [0.8784    0.8902    0.6745], 'LineStyle', 'none', 'FaceAlpha', 0.7)
patch([1.5 2.5 2.5 1.5], [0 0  1.1*y_short 1.1*y_short], [0.8784    0.8902    0.6745], 'LineStyle', 'none', 'FaceAlpha', 0.7)
hold on
for i = 1:size(rt_short_veh,1)
        ripbouts =  rt_short_veh(i,:);
        COL = [0.502 0.502 0.502];
    for jj = 1:size(ripbouts,1)
        h1 = plot([1 2], ripbouts(jj,:), '-o', 'MarkerSize', 1 , 'color', COL);
        set(h1, 'markerfacecolor', get(h1, 'color'));
   
    end 
end 
xlim([0.7 2.3])
ylim([0 1.1*y_short])

xticks([1 2])
title('Short Veh')
% title(strcat('Normalized amount of sharpwave at the beginning and end of short NREM bouts',{'( '},num2str(limit),' min)'))
f = gcf;
set(f,'Units','centimeters')
f.Position(3) = 3;
f.Position(4) = 3;
f.PaperSize = [3.05 3.05];
ax = gca;
ax.YColor = [0 0 0];
ax.XColor = [0 0 0];
ax.FontSize = 8;
ax.FontName = 'Arial';
ax.XTickLabel = [{'0-10%'};{'90-100%'}];

saveas(gcf, 'Short_ripples_rates_veh.pdf')
close all

%% Stats

rt_cbd = [rt_long_cbd;rt_short_cbd];
rt_veh = [rt_long_veh;rt_short_veh];

[~,ttest_long_cbd] = ttest(rt_long_cbd(:,1), rt_long_cbd(:,2));
[~,ttest_short_cbd] = ttest(rt_short_cbd(:,1), rt_short_cbd(:,2));

[~,ttest_long_veh] = ttest(rt_long_veh(:,1), rt_long_veh(:,2));
[~,ttest_short_veh] = ttest(rt_short_veh(:,1), rt_short_veh(:,2));

% Modulation index
rt_cbd(rt_cbd==0) = 1;
rt_veh(rt_veh==0) = 1;
mi_cbd = rt_cbd(:,1) ./ rt_cbd(:,2);
mi_veh = rt_veh(:,1) ./ rt_veh(:,2);

mean_mi_cbd = mean(mi_cbd);
mean_mi_veh = mean(mi_veh);
sem_mi_cbd= std(mi_cbd) / sqrt(length(mi_cbd));
sem_mi_veh= std(mi_veh) / sqrt(length(mi_veh));

%% Plotting scatter plot
errorbar(1.02,mean_mi_cbd,sem_mi_cbd, 'd','Markersize',8,'Color', [0.4667    0.7804    0.3529],'LineWidth',1)
hold on
errorbar(1,mean_mi_veh,sem_mi_veh, 'd','Markersize',8, 'Color', [0.502 0.502 0.502] ,'LineWidth',1)
hold on 
scatter(1.02,mean_mi_cbd, 8,'filled','MarkerFaceColor',[0.4667    0.7804    0.3529])
hold on 
scatter(1,mean_mi_veh, 8, 'filled','MarkerFaceColor',[0.502 0.502 0.502])
ylim([1.15 1.45])
xlim([0.99 1.03])
xticks([1 1.02])
ax = gca;
ax.FontSize=8;
ax.FontName='Arial';
ax.XTickLabel=[{'Veh'};{'CBD'}];
f=gcf;
set(f,'Units','centimeters')
f.Position(3)=3;
f.Position(4)=3;
f.PaperSize=[3.05 3.05];
saveas(gcf,'Scatter_plot_ModI_mean&SEM.pdf')
close all
