
%% Create baselines for PFC & HPC and Vehicle & CBD

%%%%%%%%%%%%%%%
%% Section 1 %%
%%%%%%%%%%%%%%%
clc
clear variables
close all
addpath(genpath('F:\OSF\CorticoHippocampal-master\CorticoHippocampal-master'))
addpath('F:\OSF\ADRITOOLS-master\ADRITOOLS-master')
addpath('F:\OSF\chronic')
cd('F:\OSF\chronic\UMAP - All study days')

ss = 3;   %NREM 
fn = 2500;

rat_folder = getfolder;
rat_folder=rat_folder(2:end);

for k=1:length(rat_folder) % rat loop
     
    % rat index 
    cd(rat_folder{k})    
    g=getfolder;
    g(1)=[]; % remove 'Long_short...' folder

    GC_window_ripples_comp = [];
    GC_window_ripples_broadband_comp = [];
    
    for j = 1:length(g) % SD loop
        cd(g{j})
        G=checksequence;
                     
        % get presleep
        cfold3=[];
        cfold=G(or(cellfun(@(x) ~isempty(strfind(x,'pre')),G),cellfun(@(x) ~isempty(strfind(x,'Pre')),G)));
        for q=1:length(cfold) % how many presleep?
            if (~contains(cfold{q}, 'test') && ~contains(cfold{q}, 'Test'))
                cfold3=[cfold3; cfold{q}]; % presleep folder
            end
        end
        if ~isempty(cfold3)
            cfold=cellstr(cfold3)';
        end

        % get post trials
        cfold3=[];
        cfold2=G(or(cellfun(@(x) ~isempty(strfind(x,'post')),G),cellfun(@(x) ~isempty(strfind(x,'Post')),G)));
        for q=1:length(cfold2)
            if (~contains(cfold2{q}, 'test') && ~contains(cfold2{q}, 'Test'))
                cfold3=[cfold3; cfold2{q}]; 
            end
        end
        cfold2=cellstr(cfold3)';
        
        jk={'2021-07-14_11-33-17_presleep'}; % why this one?
        if strcmpi(cfold,jk)
            jk=1;
        end

        % ignore trial 6
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
        else
            no_folder=0;
            V_pfc=[];
            V_hpc=[];
            for i=1:length(G)
                clear states
                cd(G{i})
                A = dir('*states*.mat');
                A={A.name};
                
                if sum(contains(A, 'states')) > 0 % more than 2 sleep scoring files
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
                                 
                        if and(~contains(G{i},'trial5'),~contains(G{i},'Trial5')) % whenever it is not posttrial 5
                        
                            % Sleep Scoring data
                            if length(states)<45*60
                                states=[states nan(1,45*60-length(states))]; %Fill with NaNs.
                            else
                                states=states(1:45*60); %Take only 45 min.
                            end

                            % Ephys data
                            if length(HPC)<45*60*fn
                                HPC=[HPC.' (nan(45*60*fn-length(HPC),1).')]; % fill with NaNs
                            else
                                HPC=HPC(1:45*60*fn).'; % take only 45 mins
                            end
                        
                            if length(Cortex)<45*60*fn
                                Cortex=[Cortex.' (nan(45*60*fn-length(Cortex),1).')]; % fill with NaNs
                            else
                                Cortex=Cortex(1:45*60*fn).'; % take ripple_timestamp only 45 mins
                            end
                              
                            % find SD values

                            % convert signal to 1 sec epochs.
                            e_t=1;
                            e_samples=e_t*(fn); % fs=1kHz
                            ch=length(HPC);
                            nc=floor(ch/e_samples); % number of epochs
                            NC=[]; % hpc
                            NC2=[]; % pfc

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
                                cd ..
                                continue
                            end
                            % cluster one values
                            v2=ConsecutiveOnes(vec_bin);
    
                            v_index=find(v2~=0);
                            v_values=v2(v2~=0);

                            for epoch_count=1:length(v_index)
                                v_hpc{epoch_count,1}=reshape(NC(:, v_index(epoch_count):(v_index(epoch_count)+(v_values(1,epoch_count)-1))), [], 1);
                                v_pfc{epoch_count,1}=reshape(NC2(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);
                            end 

                            V_pfc=[V_pfc; v_pfc];
                            V_hpc=[V_hpc; v_hpc];

                           if  sum(states==3)<180
                               cd ..
                               continue
                           end
                           
                       elseif contains(G{i}, 'rial5') % postTrial 5 case 

                            % sleep scoring data
                            if length(states)<45*60*4
                                states=[states nan(1,45*60*4-length(states))]; %Fill with NaNs.
                            else
                                states=states(1:45*60*4); %Take only 45 min.
                            end

                            % Ephys
                            if length(HPC)<45*60*fn*4
                                HPC=[HPC.' (nan(45*60*fn*4-length(HPC),1).')]; %Fill with NaNs.
                            else
                                HPC=HPC(1:45*60*fn*4).'; %Take only 45 min.
                            end
                            
                            %
                            if length(Cortex)<45*60*fn*4
                                Cortex=[Cortex.' (nan(45*60*fn*4-length(Cortex),1).')]; %Fill with NaNs.
                            else
                                Cortex=Cortex(1:45*60*fn*4).'; %Take only 45 min.
                            end

                            % convert signal to 1 sec epochs
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

                            if sum(vec_bin)==0  % In the absence of NREM
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
                                
                                cd ..
                                continue
                            end
                            % cluster one values
                            v2=ConsecutiveOnes(vec_bin);

                            v_index=find(v2~=0);
                            v_values=v2(v2~=0);

                            for epoch_count=1:length(v_index)
                                v_hpc{epoch_count,1}=reshape(NC(:, v_index(epoch_count):(v_index(epoch_count)+(v_values(1,epoch_count)-1))), [], 1);
                                v_pfc{epoch_count,1}=reshape(NC2(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);
                            end 
                        end
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
        save(strcat('NREM_bout_signals_',g{j},'.mat'),'V_pfc','V_hpc','-v7.3')
        clear V_pfc V_hpc v_pfc v_hpc
    end % SD loop end
    cd ..   
 end  % rat loop end
 
 
 
%%%%%%%%%%%%%%%
%% Section 2 %%
%%%%%%%%%%%%%%%

%% combine all NREM data within each rat,
%% then for rats (filter out the data less than 4 sec)
clc

    %% Vehicle
    clear variables
    cd('F:\OSF\chronic\UMAP - All study days')
    rat_folder = getfolder;
    rat_folder=rat_folder(2:end);% Ignore rat 3. 
    numFilesProcessed = 0;
    rat4_HPC_veh=[]; rat5_HPC_veh=[]; rat6_HPC_veh=[];
    rat4_PFC_veh=[]; rat5_PFC_veh=[]; rat6_PFC_veh=[];
    for i=1:length(rat_folder) % rats
            cd('F:\OSF\chronic\UMAP - All study days')
            cd(rat_folder{i})  

            % rat4
            if i==4-3
                directory = pwd;      
                filesAndFolders = dir(directory);     
                filesInDir = filesAndFolders(~([filesAndFolders.isdir]));    
                allFileNames = {filesInDir.name};
                % Define what pattern you will need in your filenames.
                pattern = 'NREM_bout_signals';
                % rat 4 SDs: 1,2,6
                pattern2 = 'SD1_';pattern3 = 'SD2';pattern4 = 'SD6';
                
                %Find variables that contain the patterns we search.
                somevariable=cell2mat(cellfun(@(x) contains(x, pattern, 'IgnoreCase', true) && ...
                                            (contains(x, pattern2, 'IgnoreCase', true) ||...
                                            contains(x, pattern3, 'IgnoreCase', true) || ...
                                            contains(x, pattern4, 'IgnoreCase', true))  , allFileNames,'UniformOutput', false));
                NREMboutsignals=allFileNames(somevariable);
                for k = 1 : length(NREMboutsignals)
                    thisFileName=NREMboutsignals{k};
                    fprintf('Now processing %s\n', thisFileName);
                    load(thisFileName);
                    rat4_HPC_veh=[rat4_HPC_veh;V_hpc];
                    rat4_PFC_veh=[rat4_PFC_veh;V_pfc];
                    clear V_hpc V_pfc
                    numFilesProcessed = numFilesProcessed + 1;   
                end

            % rat 5
            elseif i==5-3
                directory = pwd;      
                filesAndFolders = dir(directory);     
                filesInDir = filesAndFolders(~([filesAndFolders.isdir]));    
                allFileNames = {filesInDir.name};
                % Define what pattern you will need in your filenames.
                pattern = 'NREM_bout_signals';
                % rat 5 SDs: 2,3,4
                pattern2 = 'SD2';pattern3 = 'SD3';pattern4 = 'SD4';
%                 for k = 1 : length(allFileNames)
%                     % Get this filename.
%                     thisFileName = fullfile(filesInDir(k).folder, allFileNames{k});
%                     % See if it contains our required pattern.
%                     if contains(thisFileName, pattern, 'IgnoreCase', true) && ...
%                             (contains(thisFileName, pattern2, 'IgnoreCase', true) ||...
%                             contains(thisFileName, pattern3, 'IgnoreCase', true) || ...
%                             contains(thisFileName, pattern4, 'IgnoreCase', true))
%                         % The pattern is in the filename if you get here, so do something with it.
%                         fprintf('Now processing %s\n', thisFileName);
%                         load(thisFileName);
%                         rat5_HPC_veh=[rat5_HPC_veh;V_hpc];
%                         rat5_PFC_veh=[rat5_PFC_veh;V_pfc];
%                         clear V_hpc V_pfc
%                         numFilesProcessed = numFilesProcessed + 1;	
%                     end
%                 end
                %Find variables that contain the patterns we search.
                somevariable=cell2mat(cellfun(@(x) contains(x, pattern, 'IgnoreCase', true) && ...
                                            (contains(x, pattern2, 'IgnoreCase', true) ||...
                                            contains(x, pattern3, 'IgnoreCase', true) || ...
                                            contains(x, pattern4, 'IgnoreCase', true))  , allFileNames,'UniformOutput', false));
                NREMboutsignals=allFileNames(somevariable);
                for k = 1 : length(NREMboutsignals)
                    thisFileName=NREMboutsignals{k};
                    fprintf('Now processing %s\n', thisFileName);
                    load(thisFileName);
                    rat5_HPC_veh=[rat5_HPC_veh;V_hpc];
                    rat5_PFC_veh=[rat5_PFC_veh;V_pfc];
                    clear V_hpc V_pfc
                    numFilesProcessed = numFilesProcessed + 1;   
                end

            % rat 6    
            elseif i==6-3
                  directory = pwd;      
                filesAndFolders = dir(directory);     
                filesInDir = filesAndFolders(~([filesAndFolders.isdir]));    
                allFileNames = {filesInDir.name};
                % Define what pattern you will need in your filenames.
                pattern = 'NREM_bout_signals';
                % rat 6 SDs: 1,4,5
                pattern2 = 'SD1_';pattern3 = 'SD4';pattern4 = 'SD5';
%                 for k = 1 : length(allFileNames)
%                     % Get this filename.
%                     thisFileName = fullfile(filesInDir(k).folder, allFileNames{k});
%                     % See if it contains our required pattern.
%                     if contains(thisFileName, pattern, 'IgnoreCase', true) && ...
%                             (contains(thisFileName, pattern2, 'IgnoreCase', true) ||...
%                             contains(thisFileName, pattern3, 'IgnoreCase', true) || ...
%                             contains(thisFileName, pattern4, 'IgnoreCase', true))
%                         % The pattern is in the filename if you get here, so do something with it.
%                         fprintf('Now processing %s\n', thisFileName);
%                         load(thisFileName);
%                         rat6_HPC_veh=[rat6_HPC_veh;V_hpc];
%                         rat6_PFC_veh=[rat6_PFC_veh;V_pfc];
%                         clear V_hpc V_pfc                        
%                         numFilesProcessed = numFilesProcessed + 1;	
%                     end
%                 end
%             end
                %Find variables that contain the patterns we search.
                somevariable=cell2mat(cellfun(@(x) contains(x, pattern, 'IgnoreCase', true) && ...
                                            (contains(x, pattern2, 'IgnoreCase', true) ||...
                                            contains(x, pattern3, 'IgnoreCase', true) || ...
                                            contains(x, pattern4, 'IgnoreCase', true))  , allFileNames,'UniformOutput', false));
                NREMboutsignals=allFileNames(somevariable);
                for k = 1 : length(NREMboutsignals)
                    thisFileName=NREMboutsignals{k};
                    fprintf('Now processing %s\n', thisFileName);
                    load(thisFileName);
                    rat6_HPC_veh=[rat6_HPC_veh;V_hpc];
                    rat6_PFC_veh=[rat6_PFC_veh;V_pfc];
                    clear V_hpc V_pfc
                    numFilesProcessed = numFilesProcessed + 1;   
                end
            end
    end
    nrem_PFC_veh=[rat4_PFC_veh; rat5_PFC_veh; rat6_PFC_veh];
    nrem_HPC_veh=[rat4_HPC_veh; rat5_HPC_veh; rat6_HPC_veh];
    cd('C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\baselines');
    save nrem_veh.mat nrem_PFC_veh nrem_HPC_veh -v7.3

   
    %% CBD
    clear variables
    cd('F:\OSF\chronic\UMAP - All study days')
    rat_folder = getfolder;
    rat_folder=rat_folder(2:end);
    numFilesProcessed = 0;
    rat4_HPC_cbd=[]; rat5_HPC_cbd=[]; rat6_HPC_cbd=[];
    rat4_PFC_cbd=[]; rat5_PFC_cbd=[]; rat6_PFC_cbd=[];
    for i=1:length(rat_folder) % rats
            cd('F:\OSF\chronic\UMAP - All study days')
            cd(rat_folder{i})  

            % rat4
            if i==4-3
                directory = pwd;      
                filesAndFolders = dir(directory);     
                filesInDir = filesAndFolders(~([filesAndFolders.isdir]));    
                allFileNames = {filesInDir.name};
                % Define what pattern you will need in your filenames.
                pattern = 'NREM_bout_signals';
                % rat 4 SDs: 3,4,7
                pattern2 = 'SD3';pattern3 = 'SD4';pattern4 = 'SD7';
%                 for k = 1 : length(allFileNames)
%                     % Get this filename.
%                     thisFileName = fullfile(filesInDir(k).folder, allFileNames{k});
%                     % See if it contains our required pattern.
%                     if contains(thisFileName, pattern, 'IgnoreCase', true) && ...
%                             (contains(thisFileName, pattern2, 'IgnoreCase', true) ||...
%                             contains(thisFileName, pattern3, 'IgnoreCase', true) || ...
%                             contains(thisFileName, pattern4, 'IgnoreCase', true))
%                         % The pattern is in the filename if you get here, so do something with it.
%                         fprintf('Now processing %s\n', thisFileName);
%                         load(thisFileName);
%                         rat4_HPC_cbd=[rat4_HPC_cbd;V_hpc];
%                         rat4_PFC_cbd=[rat4_PFC_cbd;V_pfc];
%                         clear V_hpc V_pfc                        
%                         numFilesProcessed = numFilesProcessed + 1;	
%                     end
%                 end 
                %Find variables that contain the patterns we search.
                somevariable=cell2mat(cellfun(@(x) contains(x, pattern, 'IgnoreCase', true) && ...
                                            (contains(x, pattern2, 'IgnoreCase', true) ||...
                                            contains(x, pattern3, 'IgnoreCase', true) || ...
                                            contains(x, pattern4, 'IgnoreCase', true))  , allFileNames,'UniformOutput', false));
                NREMboutsignals=allFileNames(somevariable);
                for k = 1 : length(NREMboutsignals)
                    thisFileName=NREMboutsignals{k};
                    fprintf('Now processing %s\n', thisFileName);
                    load(thisFileName);
                    rat4_HPC_cbd=[rat4_HPC_cbd;V_hpc];
                    rat4_PFC_cbd=[rat4_PFC_cbd;V_pfc];
                    clear V_hpc V_pfc
                    numFilesProcessed = numFilesProcessed + 1;   
                end

            % rat 5
            elseif i==5-3
                directory = pwd;      
                filesAndFolders = dir(directory);     
                filesInDir = filesAndFolders(~([filesAndFolders.isdir]));    
                allFileNames = {filesInDir.name};
                % Define what pattern you will need in your filenames.
                pattern = 'NREM_bout_signals';
                % rat 5 SDs: 1,5,6
                pattern2 = 'SD1_';pattern3 = 'SD5';pattern4 = 'SD6';
%                 for k = 1 : length(allFileNames)
%                     % Get this filename.
%                     thisFileName = fullfile(filesInDir(k).folder, allFileNames{k});
%                     % See if it contains our required pattern.
%                     if contains(thisFileName, pattern, 'IgnoreCase', true) && ...
%                             (contains(thisFileName, pattern2, 'IgnoreCase', true) ||...
%                             contains(thisFileName, pattern3, 'IgnoreCase', true) || ...
%                             contains(thisFileName, pattern4, 'IgnoreCase', true))
%                         % The pattern is in the filename if you get here, so do something with it.
%                         fprintf('Now processing %s\n', thisFileName);
%                         load(thisFileName);
%                         rat5_HPC_cbd=[rat5_HPC_cbd;V_hpc];
%                         rat5_PFC_cbd=[rat5_PFC_cbd;V_pfc];
%                         clear V_hpc V_pfc                        
%                         numFilesProcessed = numFilesProcessed + 1;	
%                     end
%                 end
                somevariable=cell2mat(cellfun(@(x) contains(x, pattern, 'IgnoreCase', true) && ...
                                            (contains(x, pattern2, 'IgnoreCase', true) ||...
                                            contains(x, pattern3, 'IgnoreCase', true) || ...
                                            contains(x, pattern4, 'IgnoreCase', true))  , allFileNames,'UniformOutput', false));
                NREMboutsignals=allFileNames(somevariable);
                for k = 1 : length(NREMboutsignals)
                    thisFileName=NREMboutsignals{k};
                    fprintf('Now processing %s\n', thisFileName);
                    load(thisFileName);
                    rat5_HPC_cbd=[rat5_HPC_cbd;V_hpc];
                    rat5_PFC_cbd=[rat5_PFC_cbd;V_pfc];
                    clear V_hpc V_pfc
                    numFilesProcessed = numFilesProcessed + 1;   
                end
                

            % rat 6    
            elseif i==6-3
                directory = pwd;      
                filesAndFolders = dir(directory);     
                filesInDir = filesAndFolders(~([filesAndFolders.isdir]));    
                allFileNames = {filesInDir.name};
                % Define what pattern you will need in your filenames.
                pattern = 'NREM_bout_signals';
                % rat 6 SDs: 2,3,6
                pattern2 = 'SD2';pattern3 = 'SD3';pattern4 = 'SD6';
%                 for k = 1 : length(allFileNames)
%                     % Get this filename.
%                     thisFileName = fullfile(filesInDir(k).folder, allFileNames{k});
%                     % See if it contains our required pattern.
%                     if contains(thisFileName, pattern, 'IgnoreCase', true) && ...
%                             (contains(thisFileName, pattern2, 'IgnoreCase', true) ||...
%                             contains(thisFileName, pattern3, 'IgnoreCase', true) || ...
%                             contains(thisFileName, pattern4, 'IgnoreCase', true))
%                         % The pattern is in the filename if you get here, so do something with it.
%                         fprintf('Now processing %s\n', thisFileName);
%                         load(thisFileName);
%                         rat6_HPC_cbd=[rat6_HPC_cbd;V_hpc];
%                         rat6_PFC_cbd=[rat6_PFC_cbd;V_pfc];
%                         clear V_hpc V_pfc                        
%                         numFilesProcessed = numFilesProcessed + 1;	
%                     end
%                 end
                somevariable=cell2mat(cellfun(@(x) contains(x, pattern, 'IgnoreCase', true) && ...
                                            (contains(x, pattern2, 'IgnoreCase', true) ||...
                                            contains(x, pattern3, 'IgnoreCase', true) || ...
                                            contains(x, pattern4, 'IgnoreCase', true))  , allFileNames,'UniformOutput', false));
                NREMboutsignals=allFileNames(somevariable);
                for k = 1 : length(NREMboutsignals)
                    thisFileName=NREMboutsignals{k};
                    fprintf('Now processing %s\n', thisFileName);
                    load(thisFileName);
                    rat6_HPC_cbd=[rat6_HPC_cbd;V_hpc];
                    rat6_PFC_cbd=[rat6_PFC_cbd;V_pfc];
                    clear V_hpc V_pfc
                    numFilesProcessed = numFilesProcessed + 1;   
                end
            end
    end
    nrem_PFC_cbd=[rat4_PFC_cbd; rat5_PFC_cbd; rat6_PFC_cbd];
    nrem_HPC_cbd=[rat4_HPC_cbd; rat5_HPC_cbd; rat6_HPC_cbd];
    cd('C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\baselines');
    save nrem_cbd.mat nrem_PFC_cbd nrem_HPC_cbd -v7.3

%% filter out if less than 4 seconds - 10001 samples

% Vehicle
clear variables
load('nrem_veh');
x=cellfun(@length,nrem_PFC_veh,'UniformOutput',false);
rows= find(cell2mat(x)>10001);
nrem_PFC_veh=nrem_PFC_veh(rows);
nrem_HPC_veh=nrem_HPC_veh(rows);
save nrem_veh.mat nrem_PFC_veh nrem_HPC_veh -v7.3

% CBD
clear variables
load('nrem_cbd');
x=cellfun(@length,nrem_PFC_cbd,'UniformOutput',false);
rows= find(cell2mat(x)>10001);
nrem_PFC_cbd=nrem_PFC_cbd(rows);
nrem_HPC_cbd=nrem_HPC_cbd(rows);
save nrem_cbd.mat nrem_PFC_cbd nrem_HPC_cbd -v7.3



%%%%%%%%%%%%%%%
%% Section 3 %%
%%%%%%%%%%%%%%%
% first randomly select 400 nrem bouts
% second randomly select 4 sec time window within each nrem bout and then extract
clc
clear variables
rng(30)
%% Vehicle 
load('nrem_veh.mat');
rand_bouts=randperm(length(nrem_HPC_veh));
nrem_HPC_veh=nrem_HPC_veh(rand_bouts,1);
nrem_HPC_veh=nrem_HPC_veh(1:400,1);
nrem_PFC_veh=nrem_PFC_veh(rand_bouts,1);
nrem_PFC_veh=nrem_PFC_veh(1:400,1);

baselines_veh_PFC=[];
baselines_veh_HPC=[];
for i=1:size(nrem_PFC_veh,1)
    i
    leng=size(nrem_PFC_veh{i},1);
    leng=1:leng;
    vec=leng(5001:length(leng)-5000);
    cntr=vec(randperm(length(vec)));
    cntr=cntr(1);
    baselines_veh_PFC{i,1}=nrem_PFC_veh{i}(cntr-5000:cntr+5000)';
    baselines_veh_HPC{i,1}=nrem_HPC_veh{i}(cntr-5000:cntr+5000)';
end
cd('C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\baselines');
save baselines_PFC_veh.mat baselines_veh_PFC -v7.3
save baselines_HPC_veh.mat baselines_veh_HPC -v7.3

%% CBD
clear variables
load('nrem_cbd.mat');
rand_bouts=randperm(length(nrem_HPC_cbd));
nrem_HPC_cbd=nrem_HPC_cbd(rand_bouts,1);
nrem_HPC_cbd=nrem_HPC_cbd(1:400,1);
nrem_PFC_cbd=nrem_PFC_cbd(rand_bouts,1);
nrem_PFC_cbd=nrem_PFC_cbd(1:400,1);

baselines_cbd_PFC=[];
baselines_cbd_HPC=[];
for i=1:size(nrem_PFC_cbd,1)
    i
    leng=size(nrem_PFC_cbd{i},1);
    leng=1:leng;
    vec=leng(5001:length(leng)-5000);
    cntr=vec(randperm(length(vec)));
    cntr=cntr(1);
    baselines_cbd_PFC{i,1}=nrem_PFC_cbd{i}(cntr-5000:cntr+5000)';
    baselines_cbd_HPC{i,1}=nrem_HPC_cbd{i}(cntr-5000:cntr+5000)';
end
cd('C:\Users\students\Desktop\Pelin\slope-analysis\data_chronics\baselines');
save baselines_PFC_cbd.mat baselines_cbd_PFC -v7.3
save baselines_HPC_cbd.mat baselines_cbd_HPC -v7.3
clear variables



 
