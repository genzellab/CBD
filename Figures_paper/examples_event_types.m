 x=GC_ripple_ratID2_cbd.waveforms;
 %%
 k=12;
 X=x{k}(2,:);% HPC pyra
 Y=x{k}(3,:);% HPC below
 t=[0:length(X)-1]/600;
 
 a1=subplot(2,1,1)
 plot(t,X)
 a2=subplot(2,1,2)
 plot(t,Y)
 
 linkaxes([a1,a2],'x')
 
 xlim([2.6 3.4])
 %xlim([1800-10 1800+10])
 %%
 cd('/mnt/genzel/Rat/OS_CBD_analysis/acutes/unfiltered_data/processed_data_unfiltered')
 load('processed_HPCbelo.mat')
 HPCbelo=signals;
 load('processed_HPCpyra.mat')
 HPCpyra=signals;
 %% Start here
 
 cd('/mnt/genzel/Rat/OS_CBD_analysis/acutes/unfiltered_data/detections_only_unfiltered')
 load('detection2.mat')
 %%
 HPCpyra=detection_ratID2_HPCpyra_cbd;
 HPCbelo=detection_ratID2_HPCbelo_cbd;
%  
%  single=cellfun('length',grouped_oscil_table.Form);
%  single(single~=1)=0;
 
 index=cellfun(@(x) x==1,grouped_oscil_table.Form,'UniformOutput',false);
% index=cell2mat(index);
 
 for i=1:length(index)
     if  length(index{i})>1
         index{i}=logical(0);
     end
 end
 index=cell2mat(index);
 
x=HPCpyra(index,:);
y=HPCbelo(index,:);
  %%
close all
k=92;
t=[0:length(x(k,:))-1]/600;
plot(t,zscore(x(k,:))+6,'Color','k','LineWidth',1)
hold on
plot(t,zscore(y(k,:)),'Color','k','LineWidth',1)
xlabel('Time (seconds)')

xlim([2.5 3.5])

ax=gca;
ax.XTick=linspace(2.5,3.5,5)
ax.XTickLabels=[{0};{0.25};{0.5};{0.75};{1}]
ax.YTick=[0 6]
ax.YTickLabels=[{'SP'} {'SR'}];

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
%%
filename=['SW_' num2str(k)];
printing_image(filename)
print('-painters',f,filename,'-dpdf');%'-r0'


%%
% printing_image(num2str(k))
 