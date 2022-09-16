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
% j = 12;
for j = 1:length(SD_folders) % Study Day Index
   del_spinwrip_total = [];  
   del_spinwrip_count = [];
%        load(strcat('spindles_total_data_',SD_folders{j},'.mat'))
       load(strcat('delta_timestamps_',SD_folders{j},'.mat'))
       load(strcat('CO_',SD_folders{j},'.mat'))

       delta_total_data = delta_timestamps_SD;
    for i = 1:9 % Post Trial Index
        
%         spindles =  spindles_total_data{i};
        deltas =  delta_total_data{i};
        spindles =  CO_spindles_TS{i}; % Timestamps of spindles cooccurring with ripples
%         ripwspin = CO_ripples_TS{i};
        
        %% Delta-spindle sequence detection
         del_spinwrip = []; 
          if ~isnan(deltas) & deltas ~= 0
               if ~isnan(spindles) & spindles ~= 0
                   co=[];
                   v = 0;
                   seq_indices =  find(co);   
                    win=0.1;
                    min_diff=100; %milliseconds
                    max_diff=1300; %milliseconds
                
                    for c = 1:size(deltas,1)
                        co = (spindles(:,2)>(deltas(c,2)+min_diff/1000)) & (spindles(:,2)<(deltas(c,2)+max_diff/1000));    % The divison by 1000 is to convert miliseconds into seconds         
                        if sum(co)~=0
                        seq_indices =  find(co);   
                              for f = 1 :length(seq_indices)
                                  v = v+1;
                                  del_spinwrip(v,1) = deltas(c,1); 
                                  del_spinwrip(v,2) = deltas(c,2);
                                  del_spinwrip(v,3) = deltas(c,3);
                                  del_spinwrip(v,4) = spindles(seq_indices(f),1);
                                  del_spinwrip(v,5) = spindles(seq_indices(f),2);
                                  del_spinwrip(v,6) = spindles(seq_indices(f),3);
%                                   if v>=2
%                                      if del_spinwrip(v,1)-del_spinwrip(v-1,1)==0 & del_spinwrip(v,4)- del_spinwrip(v-1,4) ==0
%                                          error
%                                      end   
%                                   end
                              end                         
                        end
                    end
               else 
                   del_spinwrip = NaN;
               end
          else 
               del_spinwrip = NaN;
         end
  %% Delta followed by a spindle cooccurring with a ripple 
% if ~isnan(del_spinwrip)
% [~,IA,~]= unique(del_spinwrip(:,4:6),'rows');
% del_spinwrip = del_spinwrip(IA,:);
%     for f = 1:size(del_spinwrip,1)
%         rip_1 = find(del_spinwrip(f,4)<= ripwspin(:,1));
%         rip_2 = find(del_spinwrip(f,6)>ripwspin(:,1));  
%         co_rip = ripwspin(ismember(rip_2,rip_1(1)),:);
%         del_spinwrip(f,7:9) = co_rip;
%     end
% end
 %% Formatting Variable and getting the counts 
  del_spinwrip_total{i} = del_spinwrip;          % del_spindwrip is N*6, where columns 1-3 are delta timestamps in order SME and 
                                                 % columns 4-6 are timestamps of spindles co-occurring with ripples in the same order.
  del_spinwrip_count{i} = size(del_spinwrip,1);  
   
           if isnan(del_spinwrip) 
              del_spinwrip_count{i} = 0;
           end

    end
    save (strcat('del_spinwrip_',SD_folders{j},'.mat'),'del_spinwrip_total','del_spinwrip_count') 
end 


