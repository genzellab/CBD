function [spindles,phase_total,z,BST,V_pfc,v_pfc,Sx,Ex,Mx] = spindles_detection(vec_bin,NC3,NC2,fn,j,i,k)
if sum(vec_bin)~=0  %%All states
v2 = ConsecutiveOnes(vec_bin);

v_index = find(v2~=0);
v_values = v2(v2~=0);

    for epoch_count = 1:length(v_index)
        v_timestamps{epoch_count,1} = reshape(NC3(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);

        v_pfc{epoch_count,1} = reshape(NC2(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);
    end
    
%% Filters

Wn1 = [9/(fn/2) 20/(fn/2)]; % 9-20Hz
[b2,a2] = butter(3,Wn1); %Filter coefficients
Wn1 = [0.5/(fn/2) 4/(fn/2)]; % 0.5-4Hz
[b3,a3] = butter(3,Wn1); %Filter coefficients
artefact_threshold = 200; % For all study days except Rat 6 SD1 and SD 2
% artefact_threshold = 600; % For Rat 6 SD1 and SD 2
vv_pfc = vertcat(v_pfc{:});
abs_vv_pfc = abs(vv_pfc);
% bin_abs_vvpfc = abs_vv_pfc >200;
bin_abs_vvpfc = abs_vv_pfc >artefact_threshold;
art_period = ConsecutiveOnes(bin_abs_vvpfc);
art_period_index = find(art_period~=0);
art_period_values = art_period(art_period~=0)+2500;
% vv_test=vv_pfc;
% vv_test(art_period_index) = mean(vv_pfc);
% vv_test(art_period_index) = 0;
% for count= 1:length(art_period_index)-1
%         vv_test(art_period_index(count):art_period_index(count)+art_period_values(count))= 0;
% end


V_pfc = cellfun(@(equis) filtfilt(b2,a2,equis), v_pfc ,'UniformOutput',false); %spindles filtered 
v_pfc_phase = cellfun(@(equis) filtfilt(b3,a3,equis), v_pfc ,'UniformOutput',false); %SO Filtered
V_pfc_phase = cellfun(@(equis) mod(rad2deg(angle(hilbert(equis))),360) , v_pfc_phase,'UniformOutput',false); % Phases wrt SO
%LPF 300 Hz

%% Concatenation

VV_pfc = [];
VV_timestamps = [];
VV_pfc_phase = [];
    for b = 1:size(V_pfc,1) % Number of bouts 
        VV_pfc = [VV_pfc; V_pfc{b}];
        VV_timestamps = [VV_timestamps;v_timestamps{b}];
        VV_pfc_phase = [VV_pfc_phase; V_pfc_phase{b}];
    end
z = 0;
%% IMPORTANT -  Blanking of samples both before and after the peak of the artefact was only done for the following SDs -- 
% Rat 4 SD 3
% Rat 5 SD 4,2 & 6
% Rat 6 SD 1 & 2
 
for count= 1:length(art_period_index) 
    if art_period_index(count)<2500 % This IF-else statement blanks out samples before and after the artefact 
        VV_pfc(art_period_index(count):art_period_index(count)+art_period_values(count))= mean(VV_pfc); 
    else 
        VV_pfc(art_period_index(count)-2500:art_period_index(count)+art_period_values(count))= mean(VV_pfc);
    end
%% Run this line for all SDs except for the ones mentioned above after commenting out the if-else statement just above this line.
% This line is for blanking out samples only after the artefacts
% VV_pfc(art_period_index(count):art_period_index(count)+art_period_values(count))= mean(VV_pfc);
end

if length(VV_timestamps)~= length(VV_pfc)
    VV_pfc = VV_pfc(1:length(VV_timestamps));
end 

VV_timestamps_NREM = [0:length(VV_timestamps)-1].'/2500;
V_pfc_bp = horzcat(VV_timestamps,VV_pfc);
V_pfc_bp_NREM = horzcat(VV_timestamps_NREM,VV_pfc);
%% Spindles Detection; Timestamps and Phases
    
     if length(VV_timestamps) > 10000 
        spindles = FindSpindlesChronic(V_pfc_bp);
%         spindles_NREM = spindles(:,1:3);
   if ~isempty(spindles)
        spindles_NREM(:,1) = VV_timestamps_NREM(find(ismember(int32(VV_timestamps*2500),int32(spindles(:,1)*2500))));
        spindles_NREM(:,2) = VV_timestamps_NREM(find(ismember(int32(VV_timestamps*2500),int32(spindles(:,2)*2500))));
        spindles_NREM(:,3) = VV_timestamps_NREM(find(ismember(int32(VV_timestamps*2500),int32(spindles(:,3)*2500))));

%         spindles_NREM = FindSpindlesRGS14(V_pfc_bp_NREM,k);
        spindles_total_data{j,1}{i,1} = spindles;
        z = z+size(spindles,1);

        phase_index = find(ismember(int32(VV_timestamps*2500),int32(spindles(:,2)*2500)));
        phase_total = VV_pfc_phase(phase_index);

%% Conversion to Bout-Specific Timestamps

%         ti = cellfun(@(equis) reshape(linspace(0, length(equis)-1,length(equis))*(1/fn),[],1),v_pfc,'UniformOutput',false); % Timestamps of each NREM bout
%         duration_epoch = cellfun(@length, ti)/2500; 
        duration_epoch_cumsum = cumsum(v_values);

                 for f = 1:epoch_count % iterates per NREM bout
%                       if(f>1)
% %                      ti{f}=ti{f}+duration_epoch_cumsum(f);
%                       ti{f}=linspace(duration_epoch_cumsum(f-1), duration_epoch_cumsum(f),length(v_timestamps{f})).';
%                       end

%                     if(f==1)
%                         vec = find(spindles(:,1)>=0 & spindles(:,3)<=duration_epoch_cumsum(f));
%                     elseif(f>1)
%                         vec = find(spindles(:,1)>=duration_epoch_cumsum(f-1) & spindles(:,3)<=duration_epoch_cumsum(f));
%                     end
                   vec = find(spindles(:,1)>=v_timestamps{f}(1,1) & spindles(:,3)<=v_timestamps{f}(end,1));
%                    vec_NREM = find(spindles_NREM(:,1)>=ti{f}(1,1) & spindles_NREM(:,3)<=ti{f}(end,1));

                    spindle_per_epoch(f) = length(vec);
                    % assigning each spindle an epoch number
                    spindles(vec,5) = f;
                    %assigning each spindle a local start and stop time wrt the epoch
%                     if(f==1)
%                         spindles(vec, 6:8) = spindles(vec,1:3);
%                     elseif(f>1)
%                         spindles(vec, 6:8) = spindles(vec,1:3)-duration_epoch_cumsum(f-1);
%                     end
%                     spindles(vec, 6:8) = spindles_NREM(vec_NREM,1:3);
                    spindles(vec, 6:8) = spindles_NREM(vec,1:3);
                    Sx(f,1) = {spindles(vec,1).'};
                    Ex(f,1) = {spindles(vec,3).'};
                    Mx(f,1) = {spindles(vec,2).'};
                    BST = [Sx,Ex,Mx];
                 end
            else
            phase_total{1,i} = [];
            BST = [];

    end 
     end
     
total_spindles(j,i) = z;

else 
spindles = NaN;
spindles_total_data{j,1}{i,1} = NaN;
phase_total = NaN;
spindles_uncontinuous_timestamps{j,1}{i,1} = NaN;
total_spindles(j,i) = 0;
%        total_spindles_minute(j,i) = 0;
z = 0;
BST = NaN;
Sx = NaN;
Mx = NaN;
Ex= NaN;
V_pfc = 0;
v_pfc = 0;
end 
end  
