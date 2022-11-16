cd('/mnt/genzel/Rat/OS_CBD_analysis/acutes/unfiltered_data/processed_data_unfiltered')

load('processed_HPCpyra.mat')
hpc=signals;
hpc_indexes=signals_indexes;
cd('/mnt/genzel/Rat/OS_CBD_analysis/acutes/processed_data')

load('processed_pfc_shal.mat')
pfc=signals;
pfc_indexes=signals_indexes;

ss=sleep_states(:,1:600:end);
%%
area([0:length(ss(14,:))-1]/60,ss(14,:)); %1Hz
bintick=[45:45:length(ss(1,:))/60];
hold on
stem(bintick,ones(size(bintick))*2)
%%
% sigs_len = length(pfc);
% bins_num = 11;
% % Bin = ceil(Peak /(sigs_len / bins_num));
% bins=(sigs_len / bins_num):(sigs_len / bins_num):sigs_len;

%%
imagesc(ss); colorbar()
%%
n=14; %rat
%sleep_period=sleep_states(n,signals_indexes(n,1):signals_indexes(n,2) );
sleep_period=sleep_states(n,bintick(3)*60*600:bintick(4)*60*600 );

ss_period=sleep_period(1:600:end);

% hpc_period=hpc(n,signals_indexes(n,1):signals_indexes(n,2) );
% pfc_period=pfc(n,signals_indexes(n,1):signals_indexes(n,2) );
hpc_period=hpc(n,bintick(3)*60*600:bintick(4)*60*600);
pfc_period=pfc(n,bintick(3)*60*600:bintick(4)*60*600);


% 
% rem=sleep_period==1;
% nrem=not(rem);
% 
% c_rem=ConsecutiveOnes(rem);
% c_nrem=ConsecutiveOnes(nrem);

% ss1=find(sleep_period==1,1);
% ss2=find(diff(sleep_period)==ss1,1);
% [ ' Stage ' num2str(ss1) ' ,  1 is REM, 2 is NREM']
%
%%
fn=600;
%Convert signal to 1 sec epochs.
    e_t=1;
    e_samples=e_t*(fn); %fs=1kHz
    ch=length(hpc_period);
    nc=floor(ch/e_samples); %Number of epochs
    NC=[];
    NC2=[];
    
    for kk=1:nc    
          NC(:,kk)= hpc_period(1+e_samples*(kk-1):e_samples*kk);
          NC2(:,kk)= pfc_period(1+e_samples*(kk-1):e_samples*kk);
    end
    
    vec_bin=ss_period(1:end-1);
    vec_bin(vec_bin~=2)=0; %2, NREM.  1, REM
    vec_bin(vec_bin==2)=1;
    
    %Cluster one values:
    v2=ConsecutiveOnes(vec_bin);
    
    v_index=find(v2~=0);
    v_values=v2(v2~=0);

%     
%     ver=NC(:, v_index(1):v_index(1)+(v_values(1,1)-1));
%     v{1}=reshape(A, numel(A), 1);
for epoch_count=1:length(v_index)
    v_hpc{epoch_count,1}=reshape(NC(:, v_index(epoch_count):(v_index(epoch_count)+(v_values(1,epoch_count)-1))), [], 1);
    v_pfc{epoch_count,1}=reshape(NC2(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);
end 
cellfun(@(x) length(x)/600/60,v_hpc)
%xo
%% NREM
k=2;% epoch
% t=[0:length(v_hpc{k}(end-600*60*6:end))-1]/600;
% plot(t,zscore(v_hpc{k}(end-600*60*6:end)),'Color','k')
% hold on
% plot(t,zscore(v_pfc{k}(end-600*60*6:end))+10,'Color','k')
% t=[0:length(v_hpc{k}(1:1+600*60*3))-1]/600;
% plot(t,zscore(v_hpc{k}(1:1+600*60*3)),'Color','k')
% hold on
% plot(t,zscore(v_pfc{k}(1:1+600*60*3))+10,'Color','k')
ax1=subplot(6,2,1)

t=[0:length(v_hpc{k}(end-600*60*6:end-600*60*3))-1]/600/60;
plot(t,zscore(v_hpc{k}(end-600*60*6:end-600*60*3)),'Color','k')
hold on
plot(t,zscore(v_pfc{k}(end-600*60*6:end-600*60*3))+10,'Color','k')

%xlim([0 max(t)])
% xlim([0 60*3])
% xlim([60*4 60*10])
xlim([0 360/2])
% xlim([t(end) t(end)])
title('NREM acute')
ylim([-8 14])

%xlabel('sec')
xlim([0 3])
ax=gca;
ax.YTick=[0 10]
ax.YTickLabel=[{'HPC'};{'PFC'}]
xlabel('Time (min)')
%%
    %%
% f=gcf;
% set(f,'Units','centimeters')
% % h.Position(1)=0;
% % h.Position(2)=0;
% f.Position(3)=3;
% f.Position(4)=3;
% f.PaperSize=[3.05 3.05]
% % f.Position(3)=3.5;
% % f.Position(4)=3.5;
% % f.PaperSize=[3.55 3.55]
% %xo
% ax=gca;
% ax.YColor=[0 0 0];
% ax.XColor=[0 0 0];
% ax.FontSize=8;
% ax.FontName='Arial';
%%
% cd('/home/adrian/Documents/CBD_acutes')
% filename='NREM_epoch_acute2_big';
% printing_image(filename)
% print('-painters',f,filename,'-dpdf');%'-r0'

%close all
%% REM
    vec_bin=ss_period(1:end-1);
    vec_bin(vec_bin~=1)=0; %2, NREM.  1, REM
    vec_bin(vec_bin==1)=1;
    
    %Cluster one values:
    v2=ConsecutiveOnes(vec_bin);
    
    v_index=find(v2~=0);
    v_values=v2(v2~=0);

%     
%     ver=NC(:, v_index(1):v_index(1)+(v_values(1,1)-1));
%     v{1}=reshape(A, numel(A), 1);
for epoch_count=1:length(v_index)
    v_hpc{epoch_count,1}=reshape(NC(:, v_index(epoch_count):(v_index(epoch_count)+(v_values(1,epoch_count)-1))), [], 1);
    v_pfc{epoch_count,1}=reshape(NC2(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);
end 



k=3;% epoch
ax2=subplot(6,2,2)

t=[0:length(v_hpc{k}(600*60*1:600*60*4))-1]/600/60;
plot(t,zscore(v_hpc{k}(600*60*1:600*60*4)),'Color','k')
hold on
plot(t,zscore(v_pfc{k}(600*60*1:600*60*4))+10,'Color','k')

title('REM acute')
ylim([-8 20])

xlabel('Time (min)')
xlim([0 3])
ax=gca;
ax.YTick=[0 10]
ax.YTickLabel=[{'HPC'};{'PFC'}]
xo
%%
    %%
f=gcf;
set(f,'Units','centimeters')
% h.Position(1)=0;
% h.Position(2)=0;
% f.Position(3)=3;
% f.Position(4)=3;
f.Position(3)=25;
f.Position(4)=12.5;

% f.PaperSize=[3.05 3.05]
%xo
ax=gca;
ax.YColor=[0 0 0];
ax.XColor=[0 0 0];
ax.FontSize=8;
ax.FontName='Arial';
%%
cd('/home/adrian/Documents/CBD_acutes')
filename='3D_AUCvsAUC3';
printing_image(filename)
print('-painters',f,filename,'-dpdf');%'-r0'
