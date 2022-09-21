clear variables
cd('F:\OSF\chronic\UMAP - All study days')
addpath('F:\OSF\ADRITOOLS-master\ADRITOOLS-master')
% addpath('/Users/kopalagarwal/Samsung_T5/Milan_DA/OS_ephys_da/ADRITOOLS')

rat_folder=getfolder;
prompt = {'Enter the rat index'};
dlgtitle = 'Rat Index';
k = str2double(inputdlg(prompt,dlgtitle));
cd(rat_folder{k}) 

SD_folders  = getfolder;
%   j = 12;
for j = 1:length(SD_folders) % Study Day Index
       load(strcat('ripple_total_data_',SD_folders{j},'.mat'))
       load(strcat('spindles_total_data_',SD_folders{j},'.mat'))
       load(strcat('delta_timestamps_',SD_folders{j},'.mat'))
       load(strcat('CO_',SD_folders{j},'.mat'))

       delta_total_data = delta_timestamps_SD;
    for i = 1:9 % Post Trial Index
        
        spindles =  spindles_total_data{i};
        deltas =  delta_total_data{i};
        ripples = ripple_total_data{i};
        spinwrip =  CO_spindles_TS{i};
        ripwspin = CO_ripples_TS{i};
        
        %% Delta-spindle sequence detection
         seq_del_spin = [];
           if ~isnan(deltas) & deltas ~= 0
               if ~isnan(spindles) & spindles ~= 0
                   co=[];
                   v = 0;
                    win=0.1;
                    min_diff=100; %milliseconds
                    max_diff=1300; %milliseconds
                
                    for c = 1:size(deltas,1)
                        co = (spindles(:,7)>(deltas(c,2)+min_diff/1000)) & (spindles(:,7)<(deltas(c,2)+max_diff/1000));   % The divison by 1000 is to convert miliseconds into seconds         
                        if sum(co)~=0
                        seq_indices =  find(co);   
                              for f = 1 :length(seq_indices)
                                  v = v+1;
                                  seq_del_spin(v,1) = deltas(c,1);
                                  seq_del_spin(v,2) = deltas(c,2);
                                  seq_del_spin(v,3) = deltas(c,3);
                                  seq_del_spin(v,4) = spindles(seq_indices(f),6);
                                  seq_del_spin(v,5) = spindles(seq_indices(f),7);
                                  seq_del_spin(v,6) = spindles(seq_indices(f),8);
                              end                         
                        end
                    end
               else 
                   seq_del_spin = NaN;
               end
          else 
               seq_del_spin = NaN;
          end
  %% Delta followed by a spindle cooccurring with a ripple 
% if ~isnan(seq_del_spin)
% del_spinwrip = []; 
% spinwrip_i = find( ismember(seq_del_spin(:,4:6), spinwrip,'rows'));
% del_spinwrip = seq_del_spin(spinwrip_i,:);
% [~,IA,~]= unique(del_spinwrip(:,4:6),'rows');
% del_spinwrip = del_spinwrip(IA,:);
%     for f = 1:size(del_spinwrip,1)
%         rip_1 = find(del_spinwrip(f,4)<= ripwspin(:,1));
%         rip_2 = find(del_spinwrip(f,6)>ripwspin(:,1));  
%         co_rip = ripwspin(ismember(rip_2,rip_1(1)),:);
%         del_spinwrip(f,7:9) = co_rip;
%     end
% else 
% del_spinwrip = NaN;
% end
  %% Delta-ripple and ripple-delta sequence detection
      if ~isnan(ripples) & ripples ~= 0
          if ~isnan(deltas) & deltas ~= 0
        co = [];
        co2 = [];
        v = 0;
        v2=0;
        min_dif = 50; %milliseconds
        max_dif = 400; %milliseconds
        min_differ2=50; %milliseconds
        max_differ2=250; %milliseconds      
        seq_del_rip = [];
        seq_rip_del = [];
            for c=1:size(deltas,1)
                co = (ripples(:,6)>deltas(c,2)+min_dif/1000) & (ripples(:,6)<deltas(c,2)+max_dif/1000);
                co2=(ripples(:,6)<deltas(c,2)-min_differ2/1000) & (ripples(:,6)>deltas(c,2)-max_differ2/1000);
               if sum(co)~=0
                   seq_indices = find(co,1);
                    for f=1:length(seq_indices)
                    v=v+1;
                    seq_del_rip(v,1)=deltas(c,1);
                    seq_del_rip(v,2)=deltas(c,2);
                    seq_del_rip(v,3)=deltas(c,3);
                    seq_del_rip(v,4)=ripples(seq_indices(f),5);
                    seq_del_rip(v,5)=ripples(seq_indices(f),6);
                    seq_del_rip(v,6)=ripples(seq_indices(f),7);
                    end
               end
               if sum(co2)~=0
                   seq_indices2 = find(co2,1);
                    for f=1:length(seq_indices2)
                    v2=v2+1;
                    seq_rip_del(v2,1)=ripples(seq_indices2(f),5);
                    seq_rip_del(v2,2)=ripples(seq_indices2(f),6);
                    seq_rip_del(v2,3)=ripples(seq_indices2(f),7);
                    seq_rip_del(v2,4)=deltas(c,1);
                    seq_rip_del(v2,5)=deltas(c,2);
                    seq_rip_del(v2,6)=deltas(c,3);
                    end
               end
            end
          else 
          seq_del_rip = NaN;
          seq_rip_del = NaN;
          end 
      else 
      seq_del_rip = NaN;
      seq_rip_del = NaN;
      end
 %% Ripple-spindle sequence detection
         seq_rip_spin = [];
           if ~isnan(ripples) && ripples ~= 0
               if ~isnan(spindles) & spindles ~= 0
                   co=[];
                   v = 0;   
                    win=0.1;
                    min_diff = 2; %milliseconds
                    max_diff = 1000; %milliseconds
                
                    for c = 1:size(ripples,1)
                        co = (spindles(:,6)>(ripples(c,7)+min_diff/1000)) & (spindles(:,6)<(ripples(c,7)+max_diff/1000));    % The divison by 1000 is to convert miliseconds into seconds         
                        if sum(co)~=0
                        seq_indices =  find(co);   
                              for f = 1 :length(seq_indices)
                                  v = v+1;
                                 seq_rip_spin(v,1) = ripples(c,5);
                                 seq_rip_spin(v,2) = ripples(c,6);
                                 seq_rip_spin(v,3) = ripples(c,7);
                                 seq_rip_spin(v,4) = spindles(seq_indices(f),6);
                                 seq_rip_spin(v,5) = spindles(seq_indices(f),7);
                                 seq_rip_spin(v,6) = spindles(seq_indices(f),8);
                              end                         
                        end
                    end
               else 
                  seq_rip_spin = NaN;
               end
          else 
              seq_rip_spin = NaN;
          end
 %% Ripple-delta-spindle sequence detection
if ~isnan(seq_del_spin)
  if ~isnan(seq_rip_del)
     if ~isempty(seq_rip_del)
        v=0;
        coo = [];
        seq_rip_del_spin = [];
            for c = 1:size(seq_del_spin,1)
                coo = seq_del_spin(c,1)==seq_rip_del(:,4);
                if sum(coo)~=0
                    seq_indices = find(coo);
                    for f = 1:length(seq_indices)
                    v = v+1;
                    seq_rip_del_spin(v,1) = seq_rip_del(seq_indices(f),1);
                    seq_rip_del_spin(v,2) = seq_rip_del(seq_indices(f),2);
                    seq_rip_del_spin(v,3) = seq_rip_del(seq_indices(f),3);
                    seq_rip_del_spin(v,4) = seq_rip_del(seq_indices(f),4);
                    seq_rip_del_spin(v,5) = seq_rip_del(seq_indices(f),5);
                    seq_rip_del_spin(v,6) = seq_rip_del(seq_indices(f),6);
                    seq_rip_del_spin(v,7) = seq_del_spin(c,4);
                    seq_rip_del_spin(v,8) = seq_del_spin(c,5);
                    seq_rip_del_spin(v,9) = seq_del_spin(c,6);
                    end
                end
            end
          else 
          seq_rip_del_spin = NaN;
      end
else 
     seq_rip_del_spin = NaN;
  end
else 
     seq_rip_del_spin = NaN;
end 

%% Delta-ripple-spindle sequence detection
if ~isnan(seq_del_rip)
  if ~isnan(seq_rip_spin)
     if ~isempty(seq_rip_spin)
        v=0;
        coo = [];
        seq_del_rip_spin = [];
            for c = 1:size(seq_del_rip,1)
                coo = seq_del_rip(c,4)==seq_rip_spin(:,1);
                if sum(coo)~=0
                    seq_indices = find(coo);
                    for f = 1:length(seq_indices)
                    v = v+1;
                    seq_del_rip_spin(v,1) = seq_del_rip(c,1);
                    seq_del_rip_spin(v,2) = seq_del_rip(c,2);
                    seq_del_rip_spin(v,3) = seq_del_rip(c,3);
                    seq_del_rip_spin(v,4) = seq_rip_spin(seq_indices(f),1);
                    seq_del_rip_spin(v,5) = seq_rip_spin(seq_indices(f),2);
                    seq_del_rip_spin(v,6) = seq_rip_spin(seq_indices(f),3);
                    seq_del_rip_spin(v,7) = seq_rip_spin(seq_indices(f),4);
                    seq_del_rip_spin(v,8) = seq_rip_spin(seq_indices(f),5);
                    seq_del_rip_spin(v,9) = seq_rip_spin(seq_indices(f),6);
                    end
                end
            end
          else 
          seq_del_rip_spin = NaN;
      end
else 
     seq_del_rip_spin = NaN;
  end
else 
     seq_del_rip_spin = NaN;
end 

 %% Formatting Variables
 
    seq_del_spin_total{i} = seq_del_spin;
    seq_del_spin_count{i} = size(seq_del_spin,1);
    
    seq_del_rip_total{i}  = seq_del_rip;
    seq_del_rip_count{i}  = size(seq_del_rip,1);

    seq_rip_spin_total{i} = seq_rip_spin;
    seq_rip_spin_count{i}  = size(seq_rip_spin,1);
    
    seq_rip_del_total{i}  = seq_rip_del;
    seq_rip_del_count{i}  = size(seq_rip_del,1);
    
    seq_rip_del_spin_total{i} = seq_rip_del_spin;
    seq_rip_del_spin_count{i} = size(seq_rip_del_spin,1);

    seq_del_rip_spin_total{i} =  seq_del_rip_spin;
    seq_del_rip_spin_count{i} = size(seq_del_rip_spin,1);
    
        if isnan(seq_del_spin) 
           seq_del_spin_count{i} = 0;
        end
        if isnan(seq_del_rip) 
            seq_del_rip_count{i} = 0;
        end
        if isnan(seq_rip_del) 
            seq_rip_del_count{i} = 0;
        end
        if isnan(seq_rip_spin) 
            seq_rip_spin_count{i} = 0;
        end
        if isnan(seq_rip_del_spin) 
            seq_rip_del_spin_count{i} = 0;
        end
        if isnan(seq_del_rip_spin)
           seq_del_rip_spin_count{i} = 0;
        end
    end 
       save(strcat('Seq_Del_CS_',SD_folders{j},'.mat'),'seq_del_spin_total','seq_del_spin_count')
       save(strcat('Seq_Del_SWR_',SD_folders{j},'.mat'),'seq_del_rip_total','seq_del_rip_count')
       save(strcat('Seq_SWR_Del_',SD_folders{j},'.mat'),'seq_rip_del_total','seq_rip_del_count')
       save(strcat('Seq_SWR_CS_',SD_folders{j},'.mat'),'seq_rip_spin_total','seq_rip_spin_count')
       save(strcat('Seq_SWR_Del_CS_',SD_folders{j},'.mat'),'seq_rip_del_spin_total','seq_rip_del_spin_count') 
       save(strcat('Seq_Del_SWR_CS_',SD_folders{j},'.mat'),'seq_del_rip_spin_total','seq_del_rip_spin_count') 
end