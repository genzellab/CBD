function [swr_hpc,swr_pfc,s_hpc,s_pfc,V_hpc,V_pfc,signal2_hpc,signal2_pfc,sd_swr, M_multiplets, Mx_multiplets, multiplets, ripples, Mono_hpc, Mono_pfc,total_swrs,total_NREM_min, S_r, M_r, E_r] = ripple_detectionPFC(HPC,Cortex,states,ss,offset1,offset2,TT,fn) 
                        if length(states)<45*60
                            states = [states nan(1,45*60-length(states))]; %Fill with NaNs.
                        else
                            states = states(1:45*60); %Take only 45 min.
                        end
                        
                        %Ephys data
                        if length(HPC)<45*60*fn
                            HPC = [HPC.' (nan(45*60*fn-length(HPC),1).')]; %Fill with NaNs.
                        else
                            HPC = HPC(1:45*60*fn).'; %Take only 45 min.
                        end
                        
                        if length(Cortex)<45*60*fn
                            Cortex = [Cortex.' (nan(45*60*fn-length(Cortex),1).')]; %Fill with NaNs.
                        else
                            Cortex = Cortex(1:45*60*fn).'; %Take only 45 min.
                        end
                        
D1 = round(cell2mat(TT{3,end}) + str2num(cell2mat(offset1)));
D2 = round(cell2mat(TT{7,end}) + str2num(cell2mat(offset2)));
[swr_hpc,swr_pfc,s_hpc,s_pfc,V_hpc,V_pfc,signal2_hpc,signal2_pfc,sd_swr, M_multiplets, Mx_multiplets, multiplets, Mono_hpc,Mono_pfc] = swr_check_thrPFC(HPC,Cortex,states,ss,D1,D2,fn);
multiplet_count = {};

    continuous_timestamps = [(0:length(HPC)-1)/fn];
    e_t = 1;
    e_samples = e_t*(fn); %fs=1kHz
    ch = length(HPC);
    nc = floor(ch/e_samples); %Number of epochs
    NC2 = [];
    NC3 = [];
    v_timestamps = {};
    for kk = 1:nc
      NC3(:,kk) = continuous_timestamps(1+e_samples*(kk-1):e_samples*kk);
    end
    vec_bin = ismember(states,ss);
    v2 = ConsecutiveOnes(vec_bin);
    v_index = find(v2~=0);
    v_values = v2(v2~=0);
    for epoch_count = 1:length(v_index)
            v_timestamps{epoch_count,1} = reshape(NC3(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);
    end
   if ~isempty(v_timestamps)
    VV_timestamps = [];
    for b = 1:size(v_timestamps,1) % Number of bouts 
        VV_timestamps = [VV_timestamps;v_timestamps{b}];
    end 
VV_timestamps_NREM = (0:length(VV_timestamps)-1).'/fn;
%                         D1 = round(cell2mat(TT{3,end}) + str2num(cell2mat(offset1)));
%                         D2 = round(cell2mat(TT{7,end}) + str2num(cell2mat(offset2)));
%                         [swr_hpc,swr_pfc,s_hpc,s_pfc,V_hpc,V_pfc,signal2_hpc,signal2_pfc,sd_swr, M_multiplets, Mx_multiplets, multiplets]=swr_check_thr(HPC,Cortex,states,ss,D1,D2);
%                         [nr_swr_HPC(i,:), nr_swr_Cortex(i,:),nr_cohfos(i,:)]=bin_swr_detection(HPC,Cortex,states,ss,D1,D2,xx,yy,fn); 
%                             multiplet_count={};
                            S = [];
                            M = [];
                            E = [];
                            epoch_r = [];
                            for m = 1:length(v_timestamps)
                                ripples_s = cell2mat(swr_hpc(m,1));
                                ripples_m = cell2mat(swr_hpc(m,3));
                                ripples_e = cell2mat(swr_hpc(m,2));
                                epoch_number(1:length(ripples_s)) = m;
                                epoch_r =[ epoch_r,epoch_number];
                                epoch_number=[];
                                S = [S,ripples_s];
                                M = [M,ripples_m];
                                E = [E,ripples_e];
                            end
                            ripples = [S.', M.',E.',epoch_r.'];
                            ripples(:,5) = VV_timestamps_NREM(find(ismember(VV_timestamps,ripples(:,1))));
                            ripples(:,6) = VV_timestamps_NREM(find(ismember(VV_timestamps,ripples(:,2))));
                            ripples(:,7) = VV_timestamps_NREM(find(ismember(VV_timestamps,ripples(:,3))));

                            S_r = swr_hpc(:,1);
                            M_r = swr_hpc(:,3);
                            E_r = swr_hpc(:,2);
   else 
     ripples = NaN;  
     S_r = NaN;
     M_r = NaN;
     E_r = NaN;
  end 
                            for l = 1:length(multiplets)
                                multiplet_count{l} =sum(cellfun('length', Mx_multiplets.(multiplets{l}).m_1));

                            end
%                             total_swrs(j,i) = sum(s_hpc);
%                             total_hfos(j,i) = sum(s_pfc);
%                             multiplet_count_total{j,i} = multiplet_count;
%                             total_swrs_minute(j,i) = (total_swrs(j,i)/stage_count*60);
%                             total_hfos_minute(j,i) = (total_hfos(j,i)/stage_count*60);
                            stage_count = sum(states(:)==ss);
                            total_swrs = sum(s_hpc);
                            total_NREM_min =  stage_count/60;