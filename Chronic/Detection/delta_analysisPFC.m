clear variables
clc
close all

addpath(genpath('F:\OSF\CorticoHippocampal-master\CorticoHippocampal-master'))
addpath(genpath('F:\OSF\chronic\UMAP - All study days'))
addpath('F:\OSF\ADRITOOLS-master\ADRITOOLS-master')
% cd('/home/genzel/Documents/UMAP_Basic_OS/huseyin')
cd('F:\OSF\chronic\UMAP - All study days')
% cd('/media/genzel/genzel1/UMAP_NSD/')
% cd('/media/genzel/genzel1/RGS14_NSD/RGS_Rats/')

% cd('/media/genzel/Data/Milan_DA/RGS14_Ephys_da/Data_RGS14_Downsampled')
% cd('/home/adrian/Documents/new_OS_downsampled_2020')

%Select sleep stage or use all.
% list = {'Wake','NREM','Transitional','REM','All'};
% [indx1] = listdlg('SelectionMode','single','ListString',list,'InitialValue',2);
% 
% switch indx1
%     case 1
%         ss = 1; 
%         stage='Wake';
%     case 2
%         ss = 3; 
%         stage='NREM';
%     case 3
%         ss = 4; %Transitional
%         stage='Trans';
%     case 4
%         ss = 5; %REM
%         stage='REM';
%     case 5
%         ss = 6; %ALL
%         stage='ALL';
%         
% end

ss=3; 
fn=2500;

total_delta=[];
total_delta_minute=[];
delta_total_data={};
rat_folder=getfolder;
% rat_folder=rat_folder(1:end-1); %to get rid of 'huseyin'

%    for k = 1:length(rat_folder)
   k = 4;
    cd(rat_folder{k})    
    g=getfolder;
    
delta_waveform_broadband_comp = [];
delta_waveform_comp = [];
%   j = 12;
      for j=1:length(g)
    while j<=length(g)
%     for j=1:length(g)
    delta_waveform_broadband_total = {};
    delta_waveform_total = {};
    delta_waveform_broadband_total_visualization = {};
%      j=5

        cd(g{j})
%end
        G=checksequence;
                  %G=getfolder;
      
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
cfold2=cellstr(cfold3)';

%Get presleep
% cfold=G(or(cellfun(@(x) ~isempty(strfind(x,'pre')),G),cellfun(@(x) ~isempty(strfind(x,'Pre')),G)));
% cfold=cfold(and(~contains(cfold,'test'),~contains(cfold,'Test')));
% 
% % Get post trials
% cfold2=G(or(cellfun(@(x) ~isempty(strfind(x,'post')),G),cellfun(@(x) ~isempty(strfind(x,'Post')),G)));
% cfold2=cfold2(and(~contains(cfold2,'test'),~contains(cfold2,'Test')));
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

        
              
        if isempty(G)
            no_folder=1;
            %g=NaN;
        else
            no_folder=0;

            for i=1:length(G)
%             i = 2;
%          for i=1
                clear states
%             for i=1
%                  xo
                cd(G{i})
                A = dir('*states*.mat');
                A={A.name};
                
                if sum(contains(A, 'states')) > 0 %More than 2 sleep scoring files
                    A=A(cellfun(@(x) contains(x,'states'),A));
                    A=A(~(cellfun(@(x) ~isempty(strfind(x,'eeg')),A)));
                    
                    if sum(contains(A, 'states')) > 0
%                     st2=st(cellfun(@(x) ~isempty(strfind(x,barea)),st)); %Brain area.
                    cellfun(@load,A);



Cortex=dir(strcat('*','PFC','*.mat'));
Cortex=Cortex.name;
Cortex=load(Cortex);
% Cortex=Cortex.Cortex;
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
                
        
                        
                        if length(Cortex)<45*60*2500
                            Cortex=[Cortex.' (nan(45*60*2500-length(Cortex),1).')]; %Fill with NaNs.
                        else
                            Cortex=Cortex(1:45*60*2500).'; %Take only 45 min.
                        end
                        
                        %Ignore NaNs
                        PFC=Cortex;
    if sum(isnan(PFC))~=0 
        PFC(isnan(PFC)) = 0;
        states(isnan(states)) = 0;
    end



%LPF 300 Hz:
Wn1=[320/(fn/2)]; % Cutoff=320 Hz
[b2,a2] = butter(3,Wn1); %Filter coefficients


%Convert signal to 1 sec epochs.
    clear NC2 nc NC
    e_t=1;
    e_samples=e_t*(2500); %fs=2.5kHz
    ch=length(PFC);
    nc=floor(ch/e_samples); %Number of epochs
    NC=[];
    NC2=[];
    
    for kk=1:nc    

      NC2(:,kk)= PFC(1+e_samples*(kk-1):e_samples*kk);
    end
    
    vec_bin=states;
    vec_bin(vec_bin~=ss)=0;
    vec_bin(vec_bin==ss)=1;
    
    if sum(vec_bin)==0  %%All states
          delta_total_data{j,1}{i,1} = NaN;
        if ss==6  %Only continue if All states option was selected
        vec_bin=vec_bin+1;
        else  %When the sleep state was not found.


V_pfc=0;
         cd ..
         continue
        end
    end
    %Cluster one values:
    v2=ConsecutiveOnes(vec_bin);
    
    v_index=find(v2~=0);
    v_values=v2(v2~=0);

%     
%     ver=NC(:, v_index(1):v_index(1)+(v_values(1,1)-1));
%     v{1}=reshape(A, numel(A), 1);

for epoch_count = 1:length(v_index)
v_pfc{epoch_count,1}=reshape(NC2(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);
end 

%v_hpc and v_pfc: NREM epochs.


Wn1=[1/(fn/2) 6/(fn/2)]; 
[b2,a2] = butter(3,Wn1); %Filter coefficients
V_pfc = cellfun(@(equis)filtfilt(b2,a2,equis), v_pfc ,'UniformOutput',false);
%LPF 300 Hz:
VV_pfc=[];
for b=1:size(V_pfc,1)
    VV_pfc=[VV_pfc; V_pfc{b}];
end
V_pfc=VV_pfc;
V_pfc={V_pfc};
z=0;
for p=1:length(V_pfc)
    V_pfc_bp = V_pfc{p};
    V_pfc_bp2=[];
    for l=1:length(V_pfc_bp)
        V_pfc_bp2(l,1)=l/2500;
    end
    V_pfc_bp=horzcat(V_pfc_bp2, V_pfc_bp);
    if length(V_pfc_bp2)>10000
        delta = FindDeltaWavesChronic(V_pfc_bp);
        delta_total_data{j,1}{i,p} = delta;
        z=z+size(delta,1); 
     else
     delta_total_data{j,1}{i,p} = NaN;
    end
    
end

if iscell(v_pfc) && ~isempty(delta)
    concatenated_NREM_broadband_pfc = vertcat(v_pfc{:});
    waveforms_delta_broadband={};
    waveforms_delta_broadband_visualization={};
        for c=1:size(delta,1)

            waveforms_delta_broadband{c,1}= concatenated_NREM_broadband_pfc(int32(delta(c,1)*2500+1):int32(delta(c,3)*2500+1));
                if (int32(delta(c,1)*2500+1)>10000) && ((int32(delta(c,3)*2500+1)< (length(concatenated_NREM_broadband_pfc)-10001)))
                    waveforms_delta_broadband_visualization{c,1}= concatenated_NREM_broadband_pfc(int32(delta(c,1)*2500-10000):int32(delta(c,3)*2500+10000));
                else
                    waveforms_delta_broadband_visualization{c,1}= concatenated_NREM_broadband_pfc(int32(delta(c,1)*2500+1):int32(delta(c,3)*2500+1));
                end
        end
        
else
        waveforms_delta_broadband = NaN;
        waveforms_delta_broadband_visualization= NaN;
end
if iscell(V_pfc) && ~isempty(delta)
    concatenated_NREM_pfc = vertcat(V_pfc{:});
    waveforms_delta={};
        for c=1:size(delta,1)
                waveforms_delta{c,1}= concatenated_NREM_pfc(int32(delta(c,1)*2500+1):int32(delta(c,3)*2500+1));
            
        end
else
        waveforms_delta = NaN;
end
delta_waveform_broadband_total{i} = waveforms_delta_broadband;
delta_waveform_broadband_total_visualization{i} = waveforms_delta_broadband_visualization;
delta_waveform_total{i} = waveforms_delta;  
total_delta(j,i)=z;
stage_count = sum(states(:)==ss);
total_delta_minute(j,i)=(total_delta(j,i)/stage_count*60);

clear V_pfc v_pfc V_pfc_bp V_pfc_bp2 v_values vec_bin VV_pfc v2 v_index NC2 NC

                    elseif contains(G{i}, 'rial5') % PostTrial 5 case 
% %                         xo
                        %Sleep scoring data
                        if length(states)<45*60*4
                            states=[states nan(1,45*60*4-length(states))]; %Fill with NaNs.
                        else
                            states=states(1:45*60*4); %Take only 45 min.
                        end
                        
                        
                        %Ephys

                        
                        if length(Cortex)<45*60*2500*4
                            Cortex=[Cortex.' (nan(45*60*2500*4-length(Cortex),1).')]; %Fill with NaNs.
                        else
                            Cortex=Cortex(1:45*60*2500*4).'; %Take only 45 min.
                        end

                        
                        %Chunk in 4
                        states1=states(1:2700);
                        states2=states(2700+1:2700*2);
                        states3=states(1+2700*2:2700*3);
                        states4=states(1+2700*3:2700*4);
                    
                        
                        PFC_1=Cortex(1:2700*2500);
                        PFC_2=Cortex(2700*2500+1:2700*2*2500);
                        PFC_3=Cortex(1+2700*2*2500:2700*3*2500);
                        PFC_4=Cortex(1+2700*3*2500:2700*4*2500);
                        
                            if sum(isnan(PFC_1))~=0 
                                PFC_1(isnan(PFC_1)) = 0;
                                states1(isnan(states1)) = 0;
                            end
                                                        if sum(isnan(PFC_2))~=0 
                                PFC_2(isnan(PFC_2)) = 0;
                                states2(isnan(states2)) = 0;
                                                        end
                                                        if sum(isnan(PFC_3))~=0 
                                PFC_3(isnan(PFC_3)) = 0;
                                states3(isnan(states3)) = 0;
                                                        end
                                                        if sum(isnan(PFC_4))~=0 
                                PFC_4(isnan(PFC_4)) = 0;
                                states4(isnan(states4)) = 0;
                            end
                        
                            %LPF 300 Hz:
Wn1=[320/(fn/2)]; % Cutoff=320 Hz
[b2,a2] = butter(3,Wn1); %Filter coefficients


    e_t=1;
    e_samples=e_t*(2500); %fs=1kHz
    ch=length(PFC_1);
    nc=floor(ch/e_samples); %Number of epochs
    NC=[];
    NC2=[];
    
    for kk=1:nc    

      NC2(:,kk)= PFC_1(1+e_samples*(kk-1):e_samples*kk);
    end
    
    vec_bin=states1;
    vec_bin(vec_bin~=ss)=0;
    vec_bin(vec_bin==ss)=1;
    
    if sum(vec_bin)~=0  %%All states
%         if ss==6  %Only continue if All states option was selected
%         vec_bin=vec_bin+1;
%         else  %When the sleep state was not found.
% 
% 
% V_pfc=0;
%          cd ..
%          continue
%         end
%     end
    %Cluster one values:
    v2=ConsecutiveOnes(vec_bin);
    
    v_index=find(v2~=0);
    v_values=v2(v2~=0);

%     
%     ver=NC(:, v_index(1):v_index(1)+(v_values(1,1)-1));
%     v{1}=reshape(A, numel(A), 1);
for epoch_count=1:length(v_index)

v_pfc{epoch_count,1}=reshape(NC2(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);
end 

%v_hpc and v_pfc: NREM epochs.


Wn1=[1/(fn/2) 6/(fn/2)]; 
[b2,a2] = butter(3,Wn1); %Filter coefficients
V_pfc=cellfun(@(equis) filtfilt(b2,a2,equis), v_pfc ,'UniformOutput',false);
%LPF 300 Hz:
VV_pfc=[];
for b=1:size(V_pfc,1)
    VV_pfc=[VV_pfc; V_pfc{b}];
end
V_pfc=VV_pfc;
V_pfc={V_pfc};
z=0;
for p=1:length(V_pfc)
    V_pfc_bp = V_pfc{p};
    V_pfc_bp2=[];
    for l=1:length(V_pfc_bp)
        V_pfc_bp2(l,1)=l/2500;
    end
    V_pfc_bp=horzcat(V_pfc_bp2, V_pfc_bp);
    if length(V_pfc_bp2)>10000
        delta = FindDeltaWavesChronic(V_pfc_bp);
        delta_total_data{j,1}{i,p} = delta;
        z=z+size(delta,1); 
     else
     delta_total_data{j,1}{i,p} = NaN;
    end
    
end
if iscell(v_pfc) && ~isempty(delta)
    concatenated_NREM_broadband_pfc = vertcat(v_pfc{:});
    waveforms_delta_broadband={};
    waveforms_delta_broadband_visualization={};
        for c=1:size(delta,1)
            waveforms_delta_broadband{c,1}= concatenated_NREM_broadband_pfc(int32(delta(c,1)*2500+1):int32(delta(c,3)*2500+1));
            if (int32(delta(c,1)*2500+1)>10000) && ((int32(delta(c,3)*2500+1)< (length(concatenated_NREM_broadband_pfc)-10001)))
                waveforms_delta_broadband_visualization{c,1}= concatenated_NREM_broadband_pfc(int32(delta(c,1)*2500-10000):int32(delta(c,3)*2500+10000));
            else
                waveforms_delta_broadband_visualization{c,1}= concatenated_NREM_broadband_pfc(int32(delta(c,1)*2500+1):int32(delta(c,3)*2500+1));
            end
        end
        
else
        waveforms_delta_broadband = NaN;
        waveforms_delta_broadband_visualization= NaN;
end
if iscell(V_pfc) && ~isempty(delta)
    concatenated_NREM_pfc = vertcat(V_pfc{:});
    waveforms_delta={};
        for c=1:size(delta,1)
                waveforms_delta{c,1}= concatenated_NREM_pfc(int32(delta(c,1)*2500+1):int32(delta(c,3)*2500+1));
        end
else
        waveforms_delta = NaN;
end
delta_waveform_broadband_total{i} = waveforms_delta_broadband; 
delta_waveform_broadband_total_visualization{i} = waveforms_delta_broadband_visualization;
delta_waveform_total{i} = waveforms_delta;
total_delta(j,i) = z;
stage_count = sum(states1(:)==ss);
total_delta_minute(j,i) = (total_delta(j,i)/stage_count*60);
else 
      delta_total_data{j,1}{i,p} = NaN;
      delta_waveform_broadband_total{i} = [];
      delta_waveform_total{i} = [];
      delta_waveform_broadband_total_visualization{i} = [];
   end
    
clear V_pfc v_pfc V_pfc_bp V_pfc_bp2 v_values vec_bin VV_pfc v2 v_index NC2 NC

    e_t=1;
    e_samples=e_t*(2500); %fs=1kHz
    ch=length(PFC_2);
    nc=floor(ch/e_samples); %Number of epochs
    NC=[];
    NC2=[];
    
    for kk=1:nc    

      NC2(:,kk)= PFC_2(1+e_samples*(kk-1):e_samples*kk);
    end
    
    vec_bin=states2;
    vec_bin(vec_bin~=ss)=0;
    vec_bin(vec_bin==ss)=1;
    
    if sum(vec_bin)~=0  %%All states
%         if ss==6  %Only continue if All states option was selected
%         vec_bin=vec_bin+1;
%         else  %When the sleep state was not found.
% 
% 
% V_pfc=0;
%          cd ..
%          continue
%         end
%     end
    %Cluster one values:
    v2=ConsecutiveOnes(vec_bin);
    
    v_index=find(v2~=0);
    v_values=v2(v2~=0);

%     
%     ver=NC(:, v_index(1):v_index(1)+(v_values(1,1)-1));
%     v{1}=reshape(A, numel(A), 1);
for epoch_count=1:length(v_index)

v_pfc{epoch_count,1}=reshape(NC2(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);

end 

%v_hpc and v_pfc: NREM epochs.


Wn1=[1/(fn/2) 6/(fn/2)]; 
[b2,a2] = butter(3,Wn1); %Filter coefficients
V_pfc=cellfun(@(equis) filtfilt(b2,a2,equis), v_pfc ,'UniformOutput',false);
%LPF 300 Hz:
VV_pfc=[];
for b=1:size(V_pfc,1)
    VV_pfc=[VV_pfc; V_pfc{b}];
end
V_pfc=VV_pfc;
V_pfc={V_pfc};
z=0;
for p=1:length(V_pfc)
    V_pfc_bp = V_pfc{p};
    V_pfc_bp2=[];
    for l=1:length(V_pfc_bp)
        V_pfc_bp2(l,1)=l/2500;
    end
    V_pfc_bp=horzcat(V_pfc_bp2, V_pfc_bp);
    if length(V_pfc_bp2)>10000
        delta = FindDeltaWavesChronic(V_pfc_bp);
        delta_total_data{j,1}{i+1,p} = delta;
        z=z+size(delta,1);      
   else
         delta_total_data{j,1}{i+1,p} = NaN;
    end
    
end
if iscell(v_pfc) && ~isempty(delta)
    concatenated_NREM_broadband_pfc = vertcat(v_pfc{:});
    waveforms_delta_broadband={};
    waveforms_delta_broadband_visualization={};
        for c=1:size(delta,1)
            waveforms_delta_broadband{c,1}= concatenated_NREM_broadband_pfc(int32(delta(c,1)*2500+1):int32(delta(c,3)*2500+1));
            if (int32(delta(c,1)*2500+1)>10000) && ((int32(delta(c,3)*2500+1)< (length(concatenated_NREM_broadband_pfc)-10001)))
                waveforms_delta_broadband_visualization{c,1}= concatenated_NREM_broadband_pfc(int32(delta(c,1)*2500-10000):int32(delta(c,3)*2500+10000));
            else
                waveforms_delta_broadband_visualization{c,1}= concatenated_NREM_broadband_pfc(int32(delta(c,1)*2500+1):int32(delta(c,3)*2500+1));
            end
        end
        
else
        waveforms_delta_broadband = NaN;
        waveforms_delta_broadband_visualization= NaN;
end
if iscell(V_pfc) && ~isempty(delta)
    concatenated_NREM_pfc = vertcat(V_pfc{:});
    waveforms_delta={};
        for c=1:size(delta,1)
                waveforms_delta{c,1}= concatenated_NREM_pfc(int32(delta(c,1)*2500+1):int32(delta(c,3)*2500+1));
        end
else
        waveforms_delta = NaN;
end

delta_waveform_broadband_total{i+1} = waveforms_delta_broadband;
delta_waveform_broadband_total_visualization{i+1} = waveforms_delta_broadband_visualization;
delta_waveform_total{i+1}  = waveforms_delta;
total_delta(j,i+1)=z;
stage_count = sum(states2(:)==ss);
total_delta_minute(j,i+1)=(total_delta(j,i+1)/stage_count*60);
    else 
      delta_total_data{j,1}{i+1,p} = NaN;
      delta_waveform_broadband_total{i+1} = [];
      delta_waveform_total{i+1} = [];
      delta_waveform_broadband_total_visualization{i+1} = [];
    end
clear V_pfc v_pfc V_pfc_bp V_pfc_bp2 v_values vec_bin VV_pfc v2 v_index NC2 NC

    e_t=1;
    e_samples=e_t*(2500); %fs=1kHz
    ch=length(PFC_3);
    nc=floor(ch/e_samples); %Number of epochs
    NC=[];
    NC2=[];
    
    for kk=1:nc    

      NC2(:,kk)= PFC_3(1+e_samples*(kk-1):e_samples*kk);
    end
    
    vec_bin=states3;
    vec_bin(vec_bin~=ss)=0;
    vec_bin(vec_bin==ss)=1;
    
    if sum(vec_bin)~=0  %%All states
%         if ss==6  %Only continue if All states option was selected
%         vec_bin=vec_bin+1;
%         else  %When the sleep state was not found.
% 
% 
% V_pfc=0;
%          cd ..
%          continue
%         end
%     end
    %Cluster one values:
    v2=ConsecutiveOnes(vec_bin);
    
    v_index=find(v2~=0);
    v_values=v2(v2~=0);

%     
%     ver=NC(:, v_index(1):v_index(1)+(v_values(1,1)-1));
%     v{1}=reshape(A, numel(A), 1);
for epoch_count=1:length(v_index)

v_pfc{epoch_count,1}=reshape(NC2(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);
end 

%v_hpc and v_pfc: NREM epochs.


Wn1=[1/(fn/2) 6/(fn/2)]; 
[b2,a2] = butter(3,Wn1); %Filter coefficients
V_pfc=cellfun(@(equis) filtfilt(b2,a2,equis), v_pfc ,'UniformOutput',false);
%LPF 300 Hz:
VV_pfc=[];
for b=1:size(V_pfc,1)
    VV_pfc=[VV_pfc; V_pfc{b}];
end
V_pfc=VV_pfc;
V_pfc={V_pfc};
z=0;
for p=1:length(V_pfc)
    V_pfc_bp = V_pfc{p};
    V_pfc_bp2=[];
    for l=1:length(V_pfc_bp)
        V_pfc_bp2(l,1)=l/2500;
    end
    V_pfc_bp=horzcat(V_pfc_bp2, V_pfc_bp);
    if length(V_pfc_bp2)>10000
        delta = FindDeltaWavesChronic(V_pfc_bp);
        delta_total_data{j,1}{i+2,p} = delta;
        z=z+size(delta,1);
    else
         delta_total_data{j,1}{i+2,p} = NaN;
    end
    
end
if iscell(v_pfc) && ~isempty(delta)
    concatenated_NREM_broadband_pfc = vertcat(v_pfc{:});
    waveforms_delta_broadband={};
    waveforms_delta_broadband_visualization={};
        for c=1:size(delta,1)
            waveforms_delta_broadband{c,1}= concatenated_NREM_broadband_pfc(int32(delta(c,1)*2500+1):int32(delta(c,3)*2500+1));
            if (int32(delta(c,1)*2500+1)>10000) && ((int32(delta(c,3)*2500+1)< (length(concatenated_NREM_broadband_pfc)-10001)))
                waveforms_delta_broadband_visualization{c,1}= concatenated_NREM_broadband_pfc(int32(delta(c,1)*2500-10000):int32(delta(c,3)*2500+10000));
            else
                waveforms_delta_broadband_visualization{c,1}= concatenated_NREM_broadband_pfc(int32(delta(c,1)*2500+1):int32(delta(c,3)*2500+1));
            end
        end
        
else
        waveforms_delta_broadband = NaN;
        waveforms_delta_broadband_visualization= NaN;
end
if iscell(V_pfc) && ~isempty(delta)
    concatenated_NREM_pfc = vertcat(V_pfc{:});
    waveforms_delta={};
        for c=1:size(delta,1)
                waveforms_delta{c,1}= concatenated_NREM_pfc(int32(delta(c,1)*2500+1):int32(delta(c,3)*2500+1));
        end
else
        waveforms_delta = NaN;
end
delta_waveform_broadband_total{i+2} = waveforms_delta_broadband;
delta_waveform_broadband_total_visualization{i+2} = waveforms_delta_broadband_visualization;
delta_waveform_total{i+2} = waveforms_delta;
total_delta(j,i+2)=z;
stage_count = sum(states3(:)==ss);
total_delta_minute(j,i+2)=(total_delta(j,i+2)/stage_count*60);
    else 
      delta_total_data{j,1}{i+2,p} = NaN;
      delta_waveform_broadband_total{i+2} =[];
      delta_waveform_total{i+2} = [];
      delta_waveform_broadband_total_visualization{i+2} = [];
    end
clear V_pfc v_pfc V_pfc_bp V_pfc_bp2 v_values vec_bin VV_pfc v2 v_index NC2 NC

    e_t=1;
    e_samples=e_t*(2500); %fs=2.5kHz
    ch=length(PFC_4);
    nc=floor(ch/e_samples); %Number of epochs
    NC=[];
    NC2=[];
    
    for kk=1:nc    

      NC2(:,kk)= PFC_4(1+e_samples*(kk-1):e_samples*kk);
    end
    
    vec_bin=states4;
    vec_bin(vec_bin~=ss)=0;
    vec_bin(vec_bin==ss)=1;
    
    if sum(vec_bin)~=0  %%All states
%         if ss==6  %Only continue if All states option was selected
%         vec_bin=vec_bin+1;
%         else  %When the sleep state was not found.
% 
% 
% V_pfc=0;
%          cd ..
%          continue
%         end
%     end
    %Cluster one values:
    v2=ConsecutiveOnes(vec_bin);
    
    v_index=find(v2~=0);
    v_values=v2(v2~=0);

%     
%     ver=NC(:, v_index(1):v_index(1)+(v_values(1,1)-1));
%     v{1}=reshape(A, numel(A), 1);
for epoch_count=1:length(v_index)

v_pfc{epoch_count,1}=reshape(NC2(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);

end 

%v_hpc and v_pfc: NREM epochs.


Wn1=[1/(fn/2) 6/(fn/2)]; 
[b2,a2] = butter(3,Wn1); %Filter coefficients
V_pfc=cellfun(@(equis) filtfilt(b2,a2,equis), v_pfc ,'UniformOutput',false);
%LPF 300 Hz:
VV_pfc=[];
for b=1:size(V_pfc,1)
    VV_pfc=[VV_pfc; V_pfc{b}];
end
V_pfc=VV_pfc;
V_pfc={V_pfc};
z=0;
for p=1:length(V_pfc)
    V_pfc_bp = V_pfc{p};
    V_pfc_bp2=[];
    for l=1:length(V_pfc_bp)
        V_pfc_bp2(l,1)=l/2500;
    end
    V_pfc_bp=horzcat(V_pfc_bp2, V_pfc_bp);
    if length(V_pfc_bp2)>10000
        delta = FindDeltaWavesChronic(V_pfc_bp);
        delta_total_data{j,1}{i+3,p} = delta;
        z=z+size(delta,1); 
    else
         delta_total_data{j,1}{i+3,p} = NaN;     
    end
    
end
if iscell(v_pfc) && ~isempty(delta)
    concatenated_NREM_broadband_pfc = vertcat(v_pfc{:});
    waveforms_delta_broadband={};
    waveforms_delta_broadband_visualization={};
        for c=1:size(delta,1)
            waveforms_delta_broadband{c,1}= concatenated_NREM_broadband_pfc(int32(delta(c,1)*2500+1):int32(delta(c,3)*2500+1));
            if (int32(delta(c,1)*2500+1)>10000) && ((int32(delta(c,3)*2500+1)< (length(concatenated_NREM_broadband_pfc)-10001)))
                waveforms_delta_broadband_visualization{c,1}= concatenated_NREM_broadband_pfc(int32(delta(c,1)*2500-10000):int32(delta(c,3)*2500+10000));
            else
                waveforms_delta_broadband_visualization{c,1}= concatenated_NREM_broadband_pfc(int32(delta(c,1)*2500+1):int32(delta(c,3)*2500+1));
            end
        end
        
else
        waveforms_delta_broadband = NaN;
        waveforms_delta_broadband_visualization= NaN;
end
if iscell(V_pfc) && ~isempty(delta)
    concatenated_NREM_pfc = vertcat(V_pfc{:});
    waveforms_delta={};
        for c=1:size(delta,1)
                waveforms_delta{c,1}= concatenated_NREM_pfc(int32(delta(c,1)*2500+1):int32(delta(c,3)*2500+1));
        end
else
        waveforms_delta = NaN;
end
delta_waveform_broadband_total{i+3} = waveforms_delta_broadband; 
delta_waveform_broadband_total_visualization{i+3} = waveforms_delta_broadband_visualization;
delta_waveform_total{i+3} = waveforms_delta; 
total_delta(j,i+3)=z;
stage_count = sum(states4(:)==ss);
total_delta_minute(j,i+3)=(total_delta(j,i+3)/stage_count*60);
    else 
      delta_total_data{j,1}{i+3,p} = NaN;
      delta_waveform_broadband_total{i+3} = [];
      delta_waveform_total{i+3} =[];
      delta_waveform_broadband_total_visualization{i+3} = [];
    end
clear V_pfc v_pfc V_pfc_bp V_pfc_bp2 v_values vec_bin VV_pfc v2 v_index NC2 NC
                    end
                    else
                        continue
                    end
                else
                    cd ..
                    continue
                end
                cd ..
             end
        end
        cd ..
  save(strcat('delta_waveform_broadband_visualization_',g{j},'.mat'),'delta_waveform_broadband_total_visualization','-v7.3')
  save(strcat('delta_waveform_broadband_',g{j},'.mat'),'delta_waveform_broadband_total','-v7.3')
  save(strcat('delta_waveform_',g{j},'.mat'),'delta_waveform_total','-v7.3')
  delta_timestamps_SD =  delta_total_data{j}.';
  d_count = cellfun(@size,delta_timestamps_SD,'UniformOutput',false);
  for d = 1:length(d_count)
      delta_count(d) = d_count{d}(1);
      if isnan(delta_timestamps_SD{d})
          delta_count(d) = 0;
      end 
  end 
  save(strcat('delta_timestamps_',g{j},'.mat'),'delta_timestamps_SD','-v7.3')
  save(strcat('delta_count_',g{j},'.mat'),'delta_count','-v7.3')
  delta_waveform_broadband_comp = [delta_waveform_broadband_comp;delta_waveform_broadband_total];
  delta_waveform_comp = [delta_waveform_comp;delta_waveform_total];
  save(strcat('delta_waveform_broadband_compilation_Rat',rat_folder{k},'.mat'),'delta_waveform_broadband_comp','-v7.3')
  save(strcat('delta_waveform_compilation_Rat',rat_folder{k},'.mat'),'delta_waveform_comp','-v7.3')
    j=j+1;
    end
       end
    cd ..
%     end