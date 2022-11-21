%ripple phases must be there!!!
% gc windows ripples leave it as it is.
% GC_window_ripples_broadband_total , 5th column: difference between end -
% start

clear variables
clc
close all
addpath(genpath('F:\OSF\CorticoHippocampal-master\CorticoHippocampal-master'))
% addpath(genpath('/home/genzel/Documents/UMAP_Basic_OS/huseyin'))
addpath('F:\OSF\ADRITOOLS-master\ADRITOOLS-master')
addpath('F:\OSF\chronic')
cd('F:\OSF\chronic\UMAP - All study days')
% cd('/Volumes/Samsung_T5/Milan_DA/RGS14_Ephys_da/Data_RGS14_Downsampled')
%       yy = {'HPC'};       
%       xx = {'PFC'};
      ss = 3;   %NREM
%% Threshold Offset
% prompt = {'Select a threshold offset from 5SD for HPC'};
% dlgtitle = 'Threshold offset HPC';
% definput = {'5'};
% offset1 = inputdlg(prompt,dlgtitle,[1 40],definput);

%prompt = {'Select a threshold offset from 5SD for Cortex'};
%dlgtitle = 'Threshold Cortex';
%definput = {'5'};
%offset2 = inputdlg(prompt,dlgtitle,[1 40],definput);
% offset2 = {'0'};
% 
% nr_swr_HPC = [];
% nr_swr_Cortex = [];
% D_all = [];
% nr_cohfos_pt_animal = [];    
fn = 2500;

% nr_cohfos_pt = [];
rat_folder = getfolder;
rat_folder=rat_folder(2:end);
% for k=1:length(rat_folder)-1
% k = 3;
 for k=1:length(rat_folder) % find the end
    %rat index 
    cd(rat_folder{k})    
    g=getfolder;
    g(1)=[  ];
%     total_swrs=[];
%     total_hfos=[]; 
%     total_swrs_minute=[];
%     total_hfos_minute=[];
%xo
%     ripple_phases_comp = [];
%     ripple_waveform_comp = [];
%     ripple_waveform_broadband_comp = [];
    GC_window_ripples_comp = [];
    GC_window_ripples_broadband_comp = [];
    
% j= 8;
      for j = 1:length(g) %study day index 
%      for j = 7:8  %677
           
%         nr_cohfos_pt=zeros(1,9);
        cd(g{j})
%end
        %G=getfolder;
        G=checksequence;
                
%%        
%Get presleep
cfold3=[];
cfold=G(or(cellfun(@(x) ~isempty(strfind(x,'pre')),G),cellfun(@(x) ~isempty(strfind(x,'Pre')),G)));
for q=1:length(cfold)
    if (~contains(cfold{q}, 'test') && ~contains(cfold{q}, 'Test'))
        cfold3=[cfold3; cfold{q}];
    end
end
if ~isempty(cfold3)
    cfold=cellstr(cfold3)';
end

% Get post trials
cfold3=[];
cfold2=G(or(cellfun(@(x) ~isempty(strfind(x,'post')),G),cellfun(@(x) ~isempty(strfind(x,'Post')),G)));
for q=1:length(cfold2)
    if (~contains(cfold2{q}, 'test') && ~contains(cfold2{q}, 'Test'))
% try
    cfold3=[cfold3; cfold2{q}]; 
%         catch
%             jk=1;
% end
    end
end
cfold2=cellstr(cfold3)';
jk={'2021-07-14_11-33-17_presleep'};
if strcmpi(cfold,jk)
    jk=1;
end
%%
%Ignore trial 6
for ind=1:length(cfold2)
  if  ~(contains(cfold2{ind},'trial1') ||contains(cfold2{ind},'trial2')||contains(cfold2{ind},'trial3')||contains(cfold2{ind},'trial4')||contains(cfold2{ind},'trial5')...
        ||contains(cfold2{ind},'Trial1')||contains(cfold2{ind},'Trial2')||contains(cfold2{ind},'Trial3')||contains(cfold2{ind},'Trial4')||contains(cfold2{ind},'Trial5')  )
      
      cfold2{ind}=[];    
  end
end

cfold2=cfold2(~cellfun('isempty',cfold2));

G=[cfold cfold2];

        
              
        if isempty(G) %276
            no_folder=1;
            %g=NaN;
        else
            no_folder=0;
V_pfc=[];
V_hpc=[];


            for i=1:length(G); %273
%              for i = 3 
                clear states
%
%                 for i=3
%                  xo
                cd(G{i})
                A = dir('*states*.mat');
                A={A.name};
                
                if sum(contains(A, 'states')) > 0 %More than 2 sleep scoring files
                    A=A(cellfun(@(x) ~isempty(strfind(x,'states')),A));
                    A=A(~(cellfun(@(x) ~isempty(strfind(x,'eeg')),A)));
                    
                    if sum(contains(A, 'states')) > 0
                    cellfun(@load,A);


HPC=dir('*HPC_*.mat');
HPC=HPC.name;
HPC=load(HPC);
HPC=HPC.HPC;
HPC=HPC.*(0.195);

Cortex=dir(strcat('*','PFC','*.mat'));
Cortex=Cortex.name;
Cortex=load(Cortex);
Cortex=getfield(Cortex,'PFC');
Cortex=Cortex.*(0.195);



                                      

                    if and(~contains(G{i},'trial5'),~contains(G{i},'Trial5')) %Whenever it is not PostTrial 5 
                        
                        % Sleep Scoring data
                        if length(states)<45*60
                            states=[states nan(1,45*60-length(states))]; %Fill with NaNs.
                        else
                            states=states(1:45*60); %Take only 45 min.
                        end
                        
                 
                        
                        %Ephys data
                        if length(HPC)<45*60*fn
                            HPC=[HPC.' (nan(45*60*fn-length(HPC),1).')]; %Fill with NaNs.
                        else
                            HPC=HPC(1:45*60*fn).'; %Take only 45 min.
                        end
                        
                        if length(Cortex)<45*60*fn
                            Cortex=[Cortex.' (nan(45*60*fn-length(Cortex),1).')]; %Fill with NaNs.
                        else
                            Cortex=Cortex(1:45*60*fn).'; %Takeripple_timestamp only 45 min.
                        end
                                              
        
        %Find SD values
%         try
%Convert signal to 1 sec epochs.
    e_t=1;
    e_samples=e_t*(fn); %fs=1kHz
    ch=length(HPC);
    nc=floor(ch/e_samples); %Number of epochs
    NC=[]; 
    NC2=[];
    
    for kk=1:nc    
          NC(:,kk)= HPC(1+e_samples*(kk-1):e_samples*kk);
          NC2(:,kk)= Cortex(1+e_samples*(kk-1):e_samples*kk); % cortex
    end
    
    vec_bin=states;
    vec_bin(vec_bin~=ss)=0;
    vec_bin(vec_bin==ss)=1;
    
    if sum(vec_bin)==0  % In the absence of NREM.
        vec_bin=vec_bin+1;
        'No NREM found'
        signal2_hpc=[];
        signal2_pfc=[];
        
        sd_swr.sd2_hpc_co=NaN;
        sd_swr.sd5_hpc_co=NaN;
        sd_swr.sd2_pfc_co=NaN;
        sd_swr.sd5_pfc_co=NaN;
        sd_swr.sd2_hpc_long=NaN;
        sd_swr.sd5_hpc_long=NaN;
        sd_swr.sd2_pfc_long=NaN;
        sd_swr.sd5_pfc_long=NaN;
%         return
        cd ..
        continue
    end
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


V_pfc=[V_pfc; v_pfc];
V_hpc=[V_hpc; v_hpc];

%% STOP
        
%         catch
%             jk=1;
%         end

      if  sum(states==3)<180
          
            cd ..
            continue
      end
%       else
%           
% %         Sd_Swr.sd2_hpc_co(i)=sd_swr.sd2_hpc_co;
% %         Sd_Swr.sd5_hpc_co(i)=sd_swr.sd5_hpc_co;
% %         Sd_Swr.sd2_pfc_co(i)=sd_swr.sd2_pfc_co;
% %         Sd_Swr.sd5_pfc_co(i)=sd_swr.sd5_pfc_co;
% %         Sd_Swr.sd2_hpc_long(i)=sd_swr.sd2_hpc_long;
% %         Sd_Swr.sd5_hpc_long(i)=sd_swr.sd5_hpc_long;
% %         Sd_Swr.sd2_pfc_long(i)=sd_swr.sd2_pfc_long;
% %         Sd_Swr.sd5_pfc_long(i)=sd_swr.sd5_pfc_long;          
%           
%           
%       end

   
    
                    elseif contains(G{i}, 'rial5') % PostTrial 5 case 
%                         xo
                        %Sleep scoring data
                        if length(states)<45*60*4
                            states=[states nan(1,45*60*4-length(states))]; %Fill with NaNs.
                        else
                            states=states(1:45*60*4); %Take only 45 min.
                        end
                        
                        
                        %Ephys
                        if length(HPC)<45*60*fn*4
                            HPC=[HPC.' (nan(45*60*fn*4-length(HPC),1).')]; %Fill with NaNs.
                        else
                            HPC=HPC(1:45*60*fn*4).'; %Take only 45 min.
                        end
                        
                        if length(Cortex)<45*60*fn*4
                            Cortex=[Cortex.' (nan(45*60*fn*4-length(Cortex),1).')]; %Fill with NaNs.
                        else
                            Cortex=Cortex(1:45*60*fn*4).'; %Take only 45 min.
                        end
% 
                          %Convert signal to 1 sec epochs.
                            e_t=1;
                            e_samples=e_t*(fn); %fs=1kHz
                            ch=length(HPC);
                            nc=floor(ch/e_samples); %Number of epochs
                            NC=[]; 
                            NC2=[];

                            for kk=1:nc    
                                  NC(:,kk)= HPC(1+e_samples*(kk-1):e_samples*kk);
                                  NC2(:,kk)= Cortex(1+e_samples*(kk-1):e_samples*kk); % cortex
                            end

                            vec_bin=states;
                            vec_bin(vec_bin~=ss)=0;
                            vec_bin(vec_bin==ss)=1;

                            if sum(vec_bin)==0  % In the absence of NREM.
                                vec_bin=vec_bin+1;
                                'No NREM found'
                                signal2_hpc=[];
                                signal2_pfc=[];

                                sd_swr.sd2_hpc_co=NaN;
                                sd_swr.sd5_hpc_co=NaN;
                                sd_swr.sd2_pfc_co=NaN;
                                sd_swr.sd5_pfc_co=NaN;
                                sd_swr.sd2_hpc_long=NaN;
                                sd_swr.sd5_hpc_long=NaN;
                                sd_swr.sd2_pfc_long=NaN;
                                sd_swr.sd5_pfc_long=NaN;
%                                 return
                                    cd ..
                                    continue
                            end
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


                        V_pfc=[V_pfc; v_pfc];
                        V_hpc=[V_hpc; v_hpc];                      
%                         %Chunk in 4
%                         states1=states(1:2700);
%                         states2=states(2700+1:2700*2);
%                         states3=states(1+2700*2:2700*3);
%                         states4=states(1+2700*3:2700*4);
%                         
%                         HPC_1=HPC(1:2700*fn);
%                         HPC_2=HPC(2700*fn+1:2700*2*fn);
%                         HPC_3=HPC(1+2700*2*fn:2700*3*fn);
%                         HPC_4=HPC(1+2700*3*fn:2700*4*fn);
%                         
%                         Cortex_1=Cortex(1:2700*fn);
%                         Cortex_2=Cortex(2700*fn+1:2700*2*fn);
%                         Cortex_3=Cortex(1+2700*2*fn:2700*3*fn);
%                         Cortex_4=Cortex(1+2700*3*fn:2700*4*fn);
                                    %Find SD values
                                    
                                    
%                                     [sd_swr]=find_stdPFC(HPC_1,Cortex_1,states1,ss,fn);
%                                     if sum(states1==3)>=180
% %                                         Sd_Swr.sd2_hpc_co(6)=sd_swr.sd2_hpc_co;
% %                                         Sd_Swr.sd5_hpc_co(6)=sd_swr.sd5_hpc_co;
% %                                         Sd_Swr.sd2_pfc_co(6)=sd_swr.sd2_pfc_co;
% %                                         Sd_Swr.sd5_pfc_co(6)=sd_swr.sd5_pfc_co;
% %                                         Sd_Swr.sd2_hpc_long(6)=sd_swr.sd2_hpc_long;
% %                                         Sd_Swr.sd5_hpc_long(6)=sd_swr.sd5_hpc_long;
% %                                         Sd_Swr.sd2_pfc_long(6)=sd_swr.sd2_pfc_long;
% %                                         Sd_Swr.sd5_pfc_long(6)=sd_swr.sd5_pfc_long;
%                                     else
%                                         Sd_Swr.sd2_hpc_co(6)=NaN;
%                                         Sd_Swr.sd5_hpc_co(6)=NaN;
%                                         Sd_Swr.sd2_pfc_co(6)=NaN;
%                                         Sd_Swr.sd5_pfc_co(6)=NaN;
%                                         Sd_Swr.sd2_hpc_long(6)=NaN;
%                                         Sd_Swr.sd5_hpc_long(6)=NaN;
%                                         Sd_Swr.sd2_pfc_long(6)=NaN;
%                                         Sd_Swr.sd5_pfc_long(6)=NaN;                                        
%                                     end
                                    
                                    
%                                     [sd_swr]=find_stdPFC(HPC_2,Cortex_2,states2,ss,fn);
%                                     if sum(states2==3)>=180
%                                         Sd_Swr.sd2_hpc_co(7)=sd_swr.sd2_hpc_co;
%                                         Sd_Swr.sd5_hpc_co(7)=sd_swr.sd5_hpc_co;
%                                         Sd_Swr.sd2_pfc_co(7)=sd_swr.sd2_pfc_co;
%                                         Sd_Swr.sd5_pfc_co(7)=sd_swr.sd5_pfc_co;
%                                         Sd_Swr.sd2_hpc_long(7)=sd_swr.sd2_hpc_long;
%                                         Sd_Swr.sd5_hpc_long(7)=sd_swr.sd5_hpc_long;
%                                         Sd_Swr.sd2_pfc_long(7)=sd_swr.sd2_pfc_long;
%                                         Sd_Swr.sd5_pfc_long(7)=sd_swr.sd5_pfc_long;
%                                     else
%                                         Sd_Swr.sd2_hpc_co(7)=NaN;
%                                         Sd_Swr.sd5_hpc_co(7)=NaN;
%                                         Sd_Swr.sd2_pfc_co(7)=NaN;
%                                         Sd_Swr.sd5_pfc_co(7)=NaN;
%                                         Sd_Swr.sd2_hpc_long(7)=NaN;
%                                         Sd_Swr.sd5_hpc_long(7)=NaN;
%                                         Sd_Swr.sd2_pfc_long(7)=NaN;
%                                         Sd_Swr.sd5_pfc_long(7)=NaN;                                                          
%                                     end
                                    
%                                     [sd_swr]=find_stdPFC(HPC_3,Cortex_3,states3,ss,fn);
%                                     if sum(states3==3)>=180                                    
%                                         Sd_Swr.sd2_hpc_co(8)=sd_swr.sd2_hpc_co;
%                                         Sd_Swr.sd5_hpc_co(8)=sd_swr.sd5_hpc_co;
%                                         Sd_Swr.sd2_pfc_co(8)=sd_swr.sd2_pfc_co;
%                                         Sd_Swr.sd5_pfc_co(8)=sd_swr.sd5_pfc_co;
%                                         Sd_Swr.sd2_hpc_long(8)=sd_swr.sd2_hpc_long;
%                                         Sd_Swr.sd5_hpc_long(8)=sd_swr.sd5_hpc_long;
%                                         Sd_Swr.sd2_pfc_long(8)=sd_swr.sd2_pfc_long;
%                                         Sd_Swr.sd5_pfc_long(8)=sd_swr.sd5_pfc_long;    
%                                     else
%                                         Sd_Swr.sd2_hpc_co(8)=NaN;
%                                         Sd_Swr.sd5_hpc_co(8)=NaN;
%                                         Sd_Swr.sd2_pfc_co(8)=NaN;
%                                         Sd_Swr.sd5_pfc_co(8)=NaN;
%                                         Sd_Swr.sd2_hpc_long(8)=NaN;
%                                         Sd_Swr.sd5_hpc_long(8)=NaN;
%                                         Sd_Swr.sd2_pfc_long(8)=NaN;
%                                         Sd_Swr.sd5_pfc_long(8)=NaN;                                            
%                                     end
%                                     
%                                     [sd_swr]=find_stdPFC(HPC_4,Cortex_4,states4,ss,fn);
%                                     if sum(states4==3)>=180                                    
%                                         Sd_Swr.sd2_hpc_co(9)=sd_swr.sd2_hpc_co;
%                                         Sd_Swr.sd5_hpc_co(9)=sd_swr.sd5_hpc_co;
%                                         Sd_Swr.sd2_pfc_co(9)=sd_swr.sd2_pfc_co;
%                                         Sd_Swr.sd5_pfc_co(9)=sd_swr.sd5_pfc_co;
%                                         Sd_Swr.sd2_hpc_long(9)=sd_swr.sd2_hpc_long;
%                                         Sd_Swr.sd5_hpc_long(9)=sd_swr.sd5_hpc_long;
%                                         Sd_Swr.sd2_pfc_long(9)=sd_swr.sd2_pfc_long;
%                                         Sd_Swr.sd5_pfc_long(9)=sd_swr.sd5_pfc_long;
%                                     else
%                                         Sd_Swr.sd2_hpc_co(9)=NaN;
%                                         Sd_Swr.sd5_hpc_co(9)=NaN;
%                                         Sd_Swr.sd2_pfc_co(9)=NaN;
%                                         Sd_Swr.sd5_pfc_co(9)=NaN;
%                                         Sd_Swr.sd2_hpc_long(9)=NaN;
%                                         Sd_Swr.sd5_hpc_long(9)=NaN;
%                                         Sd_Swr.sd2_pfc_long(9)=NaN;
%                                         Sd_Swr.sd5_pfc_long(9)=NaN;                                         
%                                     end
    
                    end



%%

                    cd ..
                else
                    cd .. %Means there is no sleep scoring file.
                    'No states file found'
                    end
                else
                    'No states file found'
                    cd ..
                end
           
            end
                cd ..

        end
        

       %Sd_Swr
%     TT=table;
%     TT.Variables=...
%         [
%                 [{g{j}};{'x'};{'x'};{'x'};{'x'};{'x'};{'x'};{'x'}] ...
%         [{'HPC_2SD_Concatenated'};{'HPC_2SD_Longest'};{'HPC_5SD_Concatenated'};{'HPC_5SD_Longest'};{'PFC_2SD_Concatenated'};{'PFC_2SD_Longest'};{'PFC_5SD_Concatenated'};{'PFC_5SD_Longest'}] ...
%     num2cell([ Sd_Swr.sd2_hpc_co;Sd_Swr.sd2_hpc_long;Sd_Swr.sd5_hpc_co;Sd_Swr.sd5_hpc_long ...
%         ;Sd_Swr.sd2_pfc_co;Sd_Swr.sd2_pfc_long;Sd_Swr.sd5_pfc_co;Sd_Swr.sd5_pfc_long ...
%       ]) ...
%     num2cell([ nanmean(Sd_Swr.sd2_hpc_co); nanmean(Sd_Swr.sd2_hpc_long); nanmean(Sd_Swr.sd5_hpc_co);nanmean(Sd_Swr.sd5_hpc_long) ...
%         ;nanmean(Sd_Swr.sd2_pfc_co);nanmean(Sd_Swr.sd2_pfc_long);nanmean(Sd_Swr.sd5_pfc_co);nanmean(Sd_Swr.sd5_pfc_long) ...
%       ])...
%       ];

% TT=table;
%     TT.Variables=...
%         [
%                 [{g{j}};{'x'};{'x'};{'x'}] ...
%         [{'HPC_2SD_Concatenated'};{'HPC_2SD_Longest'};{'HPC_5SD_Concatenated'};{'HPC_5SD_Longest'}] ...
%     num2cell([ Sd_Swr.sd2_hpc_co;Sd_Swr.sd2_hpc_long;Sd_Swr.sd5_hpc_co;Sd_Swr.sd5_hpc_long ...
%         ;...
%       ]) ...
%     num2cell([ mean(Sd_Swr.sd2_hpc_co); mean(Sd_Swr.sd2_hpc_long); mean(Sd_Swr.sd5_hpc_co);mean(Sd_Swr.sd5_hpc_long) ...
%         ; ...
%       ])...
%       ];
% 
% corrected_means = []; 
%  TT2=cell2mat(TT{:,3:end-1});
%  for m=1:size(TT2,1)
%     corrected_means = [corrected_means; nanmean(rmoutliers(nonzeros(TT2(m,3:end))))];
%  end
%  TT.corrected_means = num2cell(corrected_means);


save(strcat('NREM_bout_signals_',g{j},'.mat'),'V_pfc','V_hpc','-v7.3')


clear V_pfc V_hpc v_pfc v_hpc
                    end

         


    cd ..
    
 end  
% k=k+1        
% end
%         zsinglet_total=[];
%         zdoublet_total=[];
%         ztriplet_total=[];
%         zquadruplet_total=[];
%         zquintuplet_total=[];
%         zsextuplet_total=[];
%         zseptuplet_total=[];
%         zoctuplet_total=[];
%         znonuplet_total=[];
% 
% for r=1:size(multiplet_count_total,2)
%     for e=1:size(multiplet_count_total,1)
%         if ~isempty(multiplet_count_total{e,r})
%             zsinglet_total(e,r)=cell2mat(multiplet_count_total{e,r}(1,1));
%             zdoublet_total(e,r)=cell2mat(multiplet_count_total{e,r}(1,2));
%             ztriplet_total(e,r)=cell2mat(multiplet_count_total{e,r}(1,3));
%             zquadruplet_total(e,r)=cell2mat(multiplet_count_total{e,r}(1,4));
%             zquintuplet_total(e,r)=cell2mat(multiplet_count_total{e,r}(1,5));
%             zsextuplet_total(e,r)=cell2mat(multiplet_count_total{e,r}(1,6));
%             zseptuplet_total(e,r)=cell2mat(multiplet_count_total{e,r}(1,7));
%             zoctuplet_total(e,r)=cell2mat(multiplet_count_total{e,r}(1,8));
%             znonuplet_total(e,r)=cell2mat(multiplet_count_total{e,r}(1,9));
%         end
%     end
% end