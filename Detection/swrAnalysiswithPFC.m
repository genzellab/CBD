%ripple phases must be there!!!
% gc windows ripples leave it as it is.
% GC_window_ripples_broadband_total , 5th column: difference between end -
% start

clear variables
clc
close all
% addpath(genpath('/home/genzel/Documents/CorticoHippocampal'))
% addpath(genpath('/home/genzel/Documents/UMAP_Basic_OS/huseyin'))
% addpath('/home/genzel/Documents/ADRITOOLS/')
cd('F:\OSF\chronic\UMAP\td')
% cd('/Volumes/Samsung_T5/Milan_DA/RGS14_Ephys_da/Data_RGS14_Downsampled')
      yy = {'HPC'};       
      xx = {'PFC'};
      ss = 3;   %NREM
%% Threshold Offset
prompt = {'Select a threshold offset from 5SD for HPC'};
dlgtitle = 'Threshold offset HPC';
definput = {'5'};
offset1 = inputdlg(prompt,dlgtitle,[1 40],definput);

prompt = {'Select a threshold offset from 5SD for Cortex'};
dlgtitle = 'Threshold Cortex';
definput = {'5'};
offset2 = inputdlg(prompt,dlgtitle,[1 40],definput);

nr_swr_HPC = [];
nr_swr_Cortex = [];
D_all = [];
nr_cohfos_pt_animal = [];    
fn = 2500;

nr_cohfos_pt = [];
rat_folder = getfolder;
rat_folder=rat_folder(1:end);
% for k=1:length(rat_folder)-1
% k=7
for k=1:length(rat_folder)
    %rat index 
    cd(rat_folder{k})    
    g=getfolder;
    total_swrs=[];
    total_hfos=[]; 
    total_swrs_minute=[];
    total_hfos_minute=[];
%xo
    ripple_phases_comp = [];
    ripple_waveform_comp = [];
    ripple_waveform_broadband_comp = [];
    GC_window_ripples_comp = [];
    GC_window_ripples_broadband_comp = [];
    

%     for j=1:length(g) %study day index 
    for j = 1:length(g)  %567
        
        
        nr_cohfos_pt=zeros(1,9);
        cd(g{j})
%end
        G=getfolder;
                
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

    cfold3=[cfold3; cfold2{q}]; 
end
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

Cortex=dir(strcat('*',xx{1},'*.mat'));
Cortex=Cortex.name;
Cortex=load(Cortex);
Cortex=getfield(Cortex,xx{1});
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
        [sd_swr,signal2_hpc,signal2_pfc]=find_stdPFC(HPC,Cortex,states,ss,fn);
        
%         catch
%             jk=1;
%         end
        Sd_Swr.sd2_hpc_co(i)=sd_swr.sd2_hpc_co;
        Sd_Swr.sd5_hpc_co(i)=sd_swr.sd5_hpc_co;
        Sd_Swr.sd2_pfc_co(i)=sd_swr.sd2_pfc_co;
        Sd_Swr.sd5_pfc_co(i)=sd_swr.sd5_pfc_co;
        Sd_Swr.sd2_hpc_long(i)=sd_swr.sd2_hpc_long;
        Sd_Swr.sd5_hpc_long(i)=sd_swr.sd5_hpc_long;
        Sd_Swr.sd2_pfc_long(i)=sd_swr.sd2_pfc_long;
        Sd_Swr.sd5_pfc_long(i)=sd_swr.sd5_pfc_long;
    
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
                        
                        %Chunk in 4
                        states1=states(1:2700);
                        states2=states(2700+1:2700*2);
                        states3=states(1+2700*2:2700*3);
                        states4=states(1+2700*3:2700*4);
                        
                        HPC_1=HPC(1:2700*fn);
                        HPC_2=HPC(2700*fn+1:2700*2*fn);
                        HPC_3=HPC(1+2700*2*fn:2700*3*fn);
                        HPC_4=HPC(1+2700*3*fn:2700*4*fn);
                        
                        Cortex_1=Cortex(1:2700*fn);
                        Cortex_2=Cortex(2700*fn+1:2700*2*fn);
                        Cortex_3=Cortex(1+2700*2*fn:2700*3*fn);
                        Cortex_4=Cortex(1+2700*3*fn:2700*4*fn);
                                    %Find SD values
                                    [sd_swr]=find_stdPFC(HPC_1,Cortex_1,states1,ss,fn);
                                    Sd_Swr.sd2_hpc_co(6)=sd_swr.sd2_hpc_co;
                                    Sd_Swr.sd5_hpc_co(6)=sd_swr.sd5_hpc_co;
                                    Sd_Swr.sd2_pfc_co(6)=sd_swr.sd2_pfc_co;
                                    Sd_Swr.sd5_pfc_co(6)=sd_swr.sd5_pfc_co;
                                    Sd_Swr.sd2_hpc_long(6)=sd_swr.sd2_hpc_long;
                                    Sd_Swr.sd5_hpc_long(6)=sd_swr.sd5_hpc_long;
                                    Sd_Swr.sd2_pfc_long(6)=sd_swr.sd2_pfc_long;
                                    Sd_Swr.sd5_pfc_long(6)=sd_swr.sd5_pfc_long;
                                    
                                    
                                    [sd_swr]=find_stdPFC(HPC_2,Cortex_2,states2,ss,fn);
                                    Sd_Swr.sd2_hpc_co(7)=sd_swr.sd2_hpc_co;
                                    Sd_Swr.sd5_hpc_co(7)=sd_swr.sd5_hpc_co;
                                    Sd_Swr.sd2_pfc_co(7)=sd_swr.sd2_pfc_co;
                                    Sd_Swr.sd5_pfc_co(7)=sd_swr.sd5_pfc_co;
                                    Sd_Swr.sd2_hpc_long(7)=sd_swr.sd2_hpc_long;
                                    Sd_Swr.sd5_hpc_long(7)=sd_swr.sd5_hpc_long;
                                    Sd_Swr.sd2_pfc_long(7)=sd_swr.sd2_pfc_long;
                                    Sd_Swr.sd5_pfc_long(7)=sd_swr.sd5_pfc_long;
                                    
                                    [sd_swr]=find_stdPFC(HPC_3,Cortex_3,states3,ss,fn);
                                    Sd_Swr.sd2_hpc_co(8)=sd_swr.sd2_hpc_co;
                                    Sd_Swr.sd5_hpc_co(8)=sd_swr.sd5_hpc_co;
                                    Sd_Swr.sd2_pfc_co(8)=sd_swr.sd2_pfc_co;
                                    Sd_Swr.sd5_pfc_co(8)=sd_swr.sd5_pfc_co;
                                    Sd_Swr.sd2_hpc_long(8)=sd_swr.sd2_hpc_long;
                                    Sd_Swr.sd5_hpc_long(8)=sd_swr.sd5_hpc_long;
                                    Sd_Swr.sd2_pfc_long(8)=sd_swr.sd2_pfc_long;
                                    Sd_Swr.sd5_pfc_long(8)=sd_swr.sd5_pfc_long;       
                                    
                                    [sd_swr]=find_stdPFC(HPC_4,Cortex_4,states4,ss,fn);
                                    Sd_Swr.sd2_hpc_co(9)=sd_swr.sd2_hpc_co;
                                    Sd_Swr.sd5_hpc_co(9)=sd_swr.sd5_hpc_co;
                                    Sd_Swr.sd2_pfc_co(9)=sd_swr.sd2_pfc_co;
                                    Sd_Swr.sd5_pfc_co(9)=sd_swr.sd5_pfc_co;
                                    Sd_Swr.sd2_hpc_long(9)=sd_swr.sd2_hpc_long;
                                    Sd_Swr.sd5_hpc_long(9)=sd_swr.sd5_hpc_long;
                                    Sd_Swr.sd2_pfc_long(9)=sd_swr.sd2_pfc_long;
                                    Sd_Swr.sd5_pfc_long(9)=sd_swr.sd5_pfc_long;                                      
    
                    end



%%

                    cd ..
                else
                    cd .. %Means there is no sleep scoring file.
                    end
                else
                    cd ..
                end
           
            end
                cd ..

        end
        

       %Sd_Swr
    TT=table;
    TT.Variables=...
        [
                [{g{j}};{'x'};{'x'};{'x'};{'x'};{'x'};{'x'};{'x'}] ...
        [{'HPC_2SD_Concatenated'};{'HPC_2SD_Longest'};{'HPC_5SD_Concatenated'};{'HPC_5SD_Longest'};{'PFC_2SD_Concatenated'};{'PFC_2SD_Longest'};{'PFC_5SD_Concatenated'};{'PFC_5SD_Longest'}] ...
    num2cell([ Sd_Swr.sd2_hpc_co;Sd_Swr.sd2_hpc_long;Sd_Swr.sd5_hpc_co;Sd_Swr.sd5_hpc_long ...
        ;Sd_Swr.sd2_pfc_co;Sd_Swr.sd2_pfc_long;Sd_Swr.sd5_pfc_co;Sd_Swr.sd5_pfc_long ...
      ]) ...
    num2cell([ mean(Sd_Swr.sd2_hpc_co); mean(Sd_Swr.sd2_hpc_long); mean(Sd_Swr.sd5_hpc_co);mean(Sd_Swr.sd5_hpc_long) ...
        ;mean(Sd_Swr.sd2_pfc_co);mean(Sd_Swr.sd2_pfc_long);mean(Sd_Swr.sd5_pfc_co);mean(Sd_Swr.sd5_pfc_long) ...
      ])...
      ];

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
corrected_means = []; 
 TT2=cell2mat(TT{:,3:end-1});
 for m=1:size(TT2,1)
    corrected_means = [corrected_means; mean(rmoutliers(nonzeros(TT2(m,3:end))))];
 end
 TT.corrected_means = num2cell(corrected_means);

       cd(g{j})
   ripple_timestamps={};
   ripple_phases={};
   ripple_count =[];
   NREM_min = [];
               for i=1:length(G) % Trial Index
%        for i = 2
%                  xo
                cd(G{i})
                clear states
                clear HPC Cortex
                clear HPC
                A = dir('*states*.mat');
                A={A.name};
                
                if sum(contains(A, 'states')) > 0 %More than 2 sleep scoring files
                    A=A(cellfun(@(x) ~isempty(strfind(x,'states')),A));
                    A=A(~(cellfun(@(x) ~isempty(strfind(x,'eeg')),A)));
                    if sum(contains(A, 'states')) > 0
                    
%                     st2=st(cellfun(@(x) ~isempty(strfind(x,barea)),st)); %Brain area.
                    cellfun(@load,A);


                   
                    HPC=dir('*HPC_*.mat');
                    HPC=HPC.name;
                    HPC=load(HPC);
                    HPC=HPC.HPC;
                    HPC=HPC.*(0.195);
                    
                    Cortex=dir(strcat('*',xx{1},'*.mat'));
                    Cortex=Cortex.name;
                    Cortex=load(Cortex);
                    % Cortex=Cortex.Cortex;
                    Cortex=getfield(Cortex,xx{1});
                    Cortex=Cortex.*(0.195);



                                      

                    if and(~contains(G{i},'trial5'),~contains(G{i},'Trial5')) %Whenever it is not PostTrial 5 
                        
                        % Sleep Scoring data
% [swr_hpc,s_hpc,V_hpc,signal2_hpc,sd_swr, M_multiplets, Mx_multiplets, multiplets, ripples, Mono_hpc,total_swrs,total_NREM_min ]=ripple_detection2022(HPC,states,ss,offset1,TT);                    
[swr_hpc,swr_pfc,s_hpc,s_pfc,V_hpc,V_pfc,signal2_hpc,signal2_pfc,sd_swr, M_multiplets, Mx_multiplets, multiplets, ripples, Mono_hpc, Mono_pfc,total_swrs,total_NREM_min ]=ripple_detectionPFC(HPC,Cortex,states,ss,offset1,offset2,TT,fn);
%% Waveforms and GC Windows
if iscell(Mono_hpc)
concatenated_NREM_hpc = vertcat(Mono_hpc{:});
concatenated_NREM_pfc = vertcat(Mono_pfc{:});
waveforms_ripples={};
GC_window_ripples = {};
GC_phase=cat(1,swr_pfc{:});

    for c=1:size(ripples,1)
       waveforms_ripples{c,1}= concatenated_NREM_hpc(int32(ripples(c,5)*fn+1):int32(ripples(c,7)*fn+1));
        if ripples(c,6)*fn+1 < (fn*3) || ripples(c,6)*fn+1+(3*fn) > length(concatenated_NREM_hpc)
          continue     
       else
       GC_window_ripples{c,1} = [concatenated_NREM_pfc(int32(ripples(c,6)*fn+1-(3*fn)) : int32(ripples(c,6)*fn+1+(3*fn)))].';
       GC_window_ripples{c,1}(2,:) = concatenated_NREM_hpc(int32(ripples(c,6)*fn+1-(3*fn)) : int32(ripples(c,6)*fn+1+(3*fn)));
%        GC_window_ripples{c,1} = concatenated_NREM_hpc(int32(ripples(c,6)*fn+1-(3*fn)) : int32(ripples(c,6)*fn+1+(3*fn)));
       GC_window_ripples{c,2} = ripples(c,1);
       GC_window_ripples{c,3} = ripples(c,2);
       GC_window_ripples{c,4} = ripples(c,3);
       end
    end

else
    waveforms_ripples = {NaN};
    GC_window_ripples = {NaN};
end 

if iscell(V_hpc)
concatenated_NREM_hpc_broadband = vertcat(V_hpc{:});
concatenated_NREM_pfc_broadband = vertcat(V_pfc{:});
waveforms_ripples_broadband = {};
GC_window_ripples_broadband = {};
    for c=1:size(ripples,1)  
       waveforms_ripples_broadband{c,1} = concatenated_NREM_hpc_broadband(int32(ripples(c,5)*fn+1):int32(ripples(c,7)*fn+1));
       if ripples(c,6)*fn+1 < (3*fn)  || ripples(c,6)*fn+1+(3*fn) > length(concatenated_NREM_hpc_broadband)
          continue     
       else
       GC_window_ripples_broadband{c,1} = [concatenated_NREM_pfc_broadband(int32(ripples(c,6)*fn+1-(3*fn)) : int32(ripples(c,6)*fn+1+(3*fn)))].';
%        GC_window_ripples_broadband{c,1} = concatenated_NREM_hpc_broadband(int32(ripples(c,6)*fn+1-(3*fn)) : int32(ripples(c,6)*fn+1+(3*fn)));
       GC_window_ripples_broadband{c,1}(2,:) = concatenated_NREM_hpc_broadband(int32(ripples(c,6)*fn+1-(3*fn)) : int32(ripples(c,6)*fn+1+(3*fn)));      
       GC_window_ripples_broadband{c,2} = ripples(c,1);
       GC_window_ripples_broadband{c,3} = ripples(c,2);
       GC_window_ripples_broadband{c,4} = ripples(c,3);
       GC_window_ripples_broadband{c,5} = ripples(c,3)-ripples(c,1);
       GC_window_ripples_broadband{c,6} = GC_phase(c,1);
 
       end
    end
else
    waveforms_ripples_broadband = {NaN};
    GC_window_ripples_broadband = {NaN};
end

% if length(waveforms_ripples_broadband)~=1
%     for c =  1:length(waveforms_ripples_broadband)
%     temp_waveform =  waveforms_ripples_broadband{c};
%     GC_window_ripples{c,1} = [temp_waveform(int32(ripples(c,6)*fn+1) : int32(ripples(c,6)*fn+1+(1.2*fn)))];
%     end 
% end 
ripple_waveform_total{i} = waveforms_ripples;
ripple_waveform_broadband_total{i} = waveforms_ripples_broadband;
GC_window_ripples_total{i} = GC_window_ripples;
GC_window_ripples_broadband_total{i} = GC_window_ripples_broadband;
ripple_timestamps{i} = swr_hpc;
ripple_phases{i} = swr_pfc;
% ripplecont=cat(1,ripple_phases{1,i});
% GC_window_ripples_broadband{c,6}=vertcat(ripplecont{:});

ripple_total_data{i} = ripples;
ripple_count(i) = total_swrs;
NREM_min(i)  = total_NREM_min;               
                    end

                   if contains(G{i}, 'rial5')
                       clear HPC_1 HPC_2 HPC_3 HPC_4 Cortex_1 Cortex_2 Cortex_3 Cortex_4
%                        clear HPC_1 HPC_2 HPC_3 HPC_4                                                     
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
                        
                           for jj = 1:4
                           pfc = Cortex((2700*fn*(jj-1))+1:2700*fn*jj); 
                           hpc = HPC((2700*fn*(jj-1))+1:2700*fn*jj);
                           states_chunk= states(2700*(jj-1)+1:2700*jj);
                          [swr_hpc, swr_pfc, s_hpc, s_pfc, V_hpc, V_pfc, signal2_hpc, signal2_pfc, sd_swr, M_multiplets, Mx_multiplets, multiplets, ripples, Mono_hpc, Mono_pfc,total_swrs,total_NREM_min]=ripple_detectionPFC(hpc,pfc,states_chunk,ss,offset1,offset2,TT,fn); 
%                           [swr_hpc, s_hpc,  V_hpc, signal2_hpc, sd_swr, M_multiplets, Mx_multiplets, multiplets, ripples, Mono_hpc, total_swrs,total_NREM_min]=ripple_detection2022(hpc,states_chunk,ss,offset1,TT); 

                           if iscell(Mono_hpc)
                            GC_phase=cat(1,swr_pfc{:});
                            concatenated_NREM_hpc = vertcat(Mono_hpc{:});
                            concatenated_NREM_pfc = vertcat(Mono_pfc{:});
                            waveforms_ripples = {};
                            GC_window_ripples = {};
                                for c=1:size(ripples,1)
                                   waveforms_ripples{c,1} = concatenated_NREM_hpc(int32(ripples(c,5)*fn+1):int32(ripples(c,7)*fn+1));
                                   if ripples(c,6)*fn+1 < (3*fn)  || ripples(c,6)*fn+1+(3*fn) > length(concatenated_NREM_hpc)
                                      continue     
                                   else
                                       GC_window_ripples{c,1} = [concatenated_NREM_pfc(int32(ripples(c,6)*fn+1-(3*fn)) : int32(ripples(c,6)*fn+1+(3*fn)))].';
                                       GC_window_ripples{c,1}(2,:) = concatenated_NREM_hpc(int32(ripples(c,6)*fn+1-(3*fn)) : int32(ripples(c,6)*fn+1+(3*fn)));
%                                        GC_window_ripples{c,1} = concatenated_NREM_hpc(int32(ripples(c,6)*fn+1-(3*fn)) : int32(ripples(c,6)*fn+1+(3*fn)));
                                       GC_window_ripples{c,2} = ripples(c,1);
                                       GC_window_ripples{c,3} = ripples(c,2);
                                       GC_window_ripples{c,4} = ripples(c,3);
                                   end 
                                end
                            else
                                waveforms_ripples = {NaN};
                                GC_window_ripples = {NaN};
                           end 
                           
                            if iscell(V_hpc)
                            concatenated_NREM_hpc_broadband = vertcat(V_hpc{:});
                            concatenated_NREM_pfc_broadband = vertcat(V_pfc{:});
                            waveforms_ripples_broadband = {};
                            GC_window_ripples_broadband = {};
                            
                                for c=1:size(ripples,1)
                                    
                                   waveforms_ripples_broadband{c,1}= concatenated_NREM_hpc_broadband(int32(ripples(c,5)*fn+1):int32(ripples(c,7)*fn+1));
%                                    GC_window_ripples{c,1} = [concatenated_NREM_hpc_broadband(int32(ripples(c,6)*fn+1-(1.2*fn)) : int32(ripples(c,6)*fn));concatenated_NREM_hpc_broadband(int32(ripples(c,6)*fn+1) : int32(ripples(c,6)*fn+1+(1.2*fn)))];
%                                    GC_window_ripples{c,1}(:,2) = [concatenated_NREM_pfc_broadband(int32(ripples(c,6)*fn+1-(1.2*fn)) : int32(ripples(c,6)*fn));concatenated_NREM_pfc_broadband(int32(ripples(c,6)*fn+1) : int32(ripples(c,6)*fn+1+(1.2*fn)))];
                                   if ripples(c,6)*fn+1 < (3*fn)  || ripples(c,6)*fn+1+(3*fn) > length(concatenated_NREM_hpc_broadband)
                                      continue     
                                   else
                                       GC_window_ripples_broadband{c,1} = [concatenated_NREM_pfc_broadband(int32(ripples(c,6)*fn+1-(3*fn)) : int32(ripples(c,6)*fn+1+(3*fn)))].';
                                       GC_window_ripples_broadband{c,1}(2,:) = concatenated_NREM_hpc_broadband(int32(ripples(c,6)*fn+1-(3*fn)) : int32(ripples(c,6)*fn+1+(3*fn)));
                                       GC_window_ripples_broadband{c,2} = ripples(c,1);
                                       GC_window_ripples_broadband{c,3} = ripples(c,2);
                                       GC_window_ripples_broadband{c,4} = ripples(c,3);    
                                       GC_window_ripples_broadband{c,5} = ripples(c,3)-ripples(c,1);
                                       GC_window_ripples_broadband{c,6} = GC_phase(c,1);

                                   end 
                                end
                            else
                                waveforms_ripples_broadband = {NaN};
                                GC_window_ripples_broadband = {NaN};
                            end 

                          ripple_waveform_total{i+jj-1} = waveforms_ripples;
                          ripple_waveform_broadband_total{i+jj-1} = waveforms_ripples_broadband;                         
                          GC_window_ripples_total{i+jj-1} = GC_window_ripples;
                          GC_window_ripples_broadband_total{i+jj-1} = GC_window_ripples_broadband;
                          ripple_timestamps{i+jj-1} = swr_hpc; 
                          ripple_phases{i+jj-1} = swr_pfc;
                          ripple_total_data{i+jj-1} = ripples;
                          ripple_count(i+jj-1) = total_swrs;
                          NREM_min(i+jj-1)  = total_NREM_min;               

                           end                                 
                   end
                   end
                    
                end
                        
                cd ..
for r = 1:length(ripple_timestamps)
if isnumeric(ripple_timestamps{r})
ripple_timestamps{r} = NaN;
ripple_phases{r} = NaN;
end
end 
               end
                cd ..

try
ripple_phases_comp = [ripple_phases_comp;ripple_phases];

        catch
            ripple_phases=[ripple_phases,{nan}];
            ripple_phases_comp = [ripple_phases_comp;ripple_phases];
            jk=1;
end
ripple_waveform_comp = [ripple_waveform_comp; ripple_waveform_total];
ripple_waveform_broadband_comp = [ripple_waveform_broadband_comp; ripple_waveform_broadband_total];
GC_window_ripples_comp = [GC_window_ripples_comp; GC_window_ripples_total];
% try
GC_window_ripples_broadband_comp = [GC_window_ripples_broadband_comp; GC_window_ripples_broadband_total];

%         catch
%             jk=1;
%         end

save(strcat('ripple_timestamps_',g{j},'.mat'),'ripple_timestamps','-v7.3')
save(strcat('ripple_total_data_',g{j},'.mat'),'ripple_total_data','-v7.3')
save(strcat('ripple_counts_',g{j},'.mat'),'ripple_count','NREM_min','-v7.3')

save(strcat('ripple_waveforms_',g{j},'.mat'),'ripple_waveform_total','-v7.3')
save(strcat('ripple_waveforms_broadband_',g{j},'.mat'),'ripple_waveform_broadband_total','-v7.3')
save(strcat('GC_window_ripples_',g{j},'.mat'),'GC_window_ripples_total','-v7.3')
save(strcat('GC_window_ripples_broadband_',g{j},'.mat'),'GC_window_ripples_broadband_total','-v7.3')

save(strcat('ripple_waveforms_compilation_Rat',rat_folder{k},'.mat'),'ripple_waveform_comp','-v7.3')
save(strcat('ripple_waveforms_broadband_compilation_Rat',rat_folder{k},'.mat'),'ripple_waveform_broadband_comp','-v7.3')
save(strcat('GC_window_ripples_compilation_Rat',rat_folder{k},'.mat'),'GC_window_ripples_comp','-v7.3')
save(strcat('GC_window_ripples_broadband_compilation_Rat',rat_folder{k},'.mat'),'GC_window_ripples_broadband_comp','-v7.3')

save(strcat('ripple_phases_',g{j},'.mat'),'ripple_phases','-v7.3')
save(strcat('ripple_phases_compilation_Rat',rat_folder{k},'.mat'),'ripple_phases_comp','-v7.3')

    end

    cd ..
% k=k+1        
end
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
