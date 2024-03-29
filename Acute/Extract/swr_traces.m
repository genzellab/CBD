clear all
clc
ratIDs = [2 3 4 5 9 10 11 201 203 204 205 206 207 209 210 211 212 213 214];  %Rat IDs
fn=600;
% Filtered signals

cd '/mnt/genzel/Rat/OS_CBD_analysis/acutes/characteristics/PFC'
% Load following signals
load('p_hpc.mat') % HPC signal from the pyramidal layer
load('b_hpc.mat') % HPC signal from the below layer

timevector= (0:(size(b_signals,2)-1))/fn; % to set a variable for time

% Defining bins
bin_sz = fn*(60*45); % sampling frequency*(bin duration in seconds)
i=1;t=0; % Initialisation

while i~=12
    binB{i,1} = t;
    t = t+bin_sz;
    binB{i,2} = t;
    i = i+1;
end
binBound = (cell2mat(binB))/fn;

%% Loading detections (Timestamps and types)
    detect = {};
    
    cd '/mnt/genzel/Rat/OS_CBD_analysis/acutes/detections';%'F:\OSF\swr_analysys\detections'
    for i = 1:length(ratIDs)
        tmp = load(strcat(string(ratIDs(i)),'.mat')); %Load rat's detections.
        tm_sleepstate= table2array(tmp.oscil_table(:,7));
        tm_sleepstate=tm_sleepstate==2; %Only NREM events.
        tmp2 = table2array(tmp.oscil_table(tm_sleepstate,2:4)); %Start, Peak and End.
        tmp3 = (table2array(tmp.oscil_table(tm_sleepstate,1))); %Type (1 to 6)
        detect{i,1} = [tmp2,tmp3];
        clear tmp tmp2 tmp3 tmp4 tmp5
    end
    %%
for k=6 % For each form
    %Note: For SWs the amplitude needs to be replaced with AUC defined by
    %ripple duration.
    %%
        cd '/mnt/genzel/Rat/OS_CBD_analysis/acutes/detections';%'F:\OSF\swr_analysys\detections'
    'New Iteration: Types'
    Veh = [0 1 1 0 1 0 0 1 1 0 0 1 0 0 1 1 0 1 0];  % Vector logical IDs
    i_c=1;i_v=1;  i_c1=1;i_v1=1;   i_c2=1;i_v2=1;  % These are indexes/counters.  C: CBD, V: VEH
    d_c={};d_v={};  d_c_1={};d_v_1={};  d_c_2={};d_v_2={}; % v_1: Type 1, v_2: Type 2: For storing traces of absent events. 
    for i = 1:length(Veh) % Iterate across rats
            'New Iteration: Rats'
        %tmp = find(sleep_states(i,:)==2); % Find specific sleep stage. 
        if Veh(i)==1  %In case of Vehicle Rat
            for j = 1:length(detect{i,1}) %Iterate across detections of given rat.
                                [j/length(detect{i,1})*100 ]
                if rem(k,2)==0 %k is the index of the event form. This is TRUE when k is an even number, aka. Ripple event 
                    if detect{i,1}(j,4)==k %In case given type was found. 
                        t1 = (detect{i}(j,1))/600;
                        tp1=myFind(timevector(:)>=t1);
                        t2 = (detect{i}(j,3))/600;
                        tp2 = myFind(timevector(:)>=t2);
                        if (t1>=(binBound(5,1)+1))||(t2<=binBound(9,2))
                            d_v{i_v} = p_signals(i,tp1(1):tp2(1));
                            if k==2
                                d_v_2{i_v2} = b_signals(i,tp1(1):tp2(1));
                                i_v2=i_v2+1;
                            end
                            i_v = i_v+1;
                        end
                        clear tp1 tp2
                    end
                else
                    if detect{i,1}(j,4)==k
                            if k==5 % In case of cSWR SW
                              % Find closest Ripple of cSWR
                            alldetect=detect{i,1}(:,4);
                            alldetect(alldetect~=6)=0;
                            alldetect(alldetect==6)=1;
                            alldetect_crip= myFind(alldetect);
                            % Find Ripple from CSWR which peak is closest to the SW peak.     
                            i_v5=findclosest( (detect{i}(alldetect_crip,2)), (detect{i}(j,2)));
                            %
                            if  length(i_v5)>1
                                continue
                            end
                            t1 = (detect{i}(alldetect_crip(i_v5),1))/600;
                            tp1=myFind(timevector(:)>=t1);
                            t2 = (detect{i}(alldetect_crip(i_v5),3))/600;
                            tp2 = myFind(timevector(:)>=t2);
                                                else
                        t1 = (detect{i}(j,1))/600;
                        tp1=myFind(timevector(:)>=t1);
                        t2 = (detect{i}(j,3))/600;
                        tp2 = myFind(timevector(:)>=t2);
                                                end
                        if (t1>=(binBound(5,1)+1))||(t2<=binBound(9,2))
                            d_v{i_v} = b_signals(i,tp1(1):tp2(1));
                            if k==1
                                d_v_1{i_v1} = p_signals(i,tp1(1):tp2(1));
                                i_v1=i_v1+1;
                            end
                            i_v = i_v+1;
                        end
                        clear tp1 tp2
                    end
                end
            end
        elseif Veh(i)==0
            %tmp = find(sleep_states(i,:)==2);
            for j = 1:length(detect{i}) % Iterate across detections
                                [j/length(detect{i,1})*100 ]
                if rem(k,2)==0
                    if detect{i,1}(j,4)==k
                        t1 = (detect{i}(j,1))/600;
                        tp1=myFind(timevector(:)>=t1);
                        t2 = (detect{i}(j,3))/600;
                        tp2=myFind(timevector(:)>=t2);
                        if (t1>=(binBound(5,1)+1))||(t2<=binBound(9,2))
                            d_c{i_c} = p_signals(i,tp1(1):tp2(1));
                            if k==2
                                d_c_2{i_c2} = b_signals(i,tp1(1):tp2(1));
                                i_c2=i_c2+1;
                            end
                            i_c = i_c+1;
                        end
                        clear tp1 tp2
                    end
                else
                    if detect{i,1}(j,4)==k
                        %xo
                        if k==5 % In case of cSWR SW
                              % Find closest Ripple of cSWR
                            alldetect=detect{i,1}(:,4);
                            alldetect(alldetect~=6)=0;
                            alldetect(alldetect==6)=1;
                            alldetect_crip= myFind(alldetect);
                            % Find Ripple from CSWR which peak is closest to the SW peak.     
                            i_c5=findclosest( (detect{i}(alldetect_crip,2)), (detect{i}(j,2)));
                            %
                            if  length(i_c5)>1
                                continue
                            end
                            t1 = (detect{i}(alldetect_crip(i_c5),1))/600;
                            tp1=myFind(timevector(:)>=t1);
                            t2 = (detect{i}(alldetect_crip(i_c5),3))/600;
                            tp2 = myFind(timevector(:)>=t2);
                        else
                            t1 = (detect{i}(j,1))/600;
                            tp1=myFind(timevector(:)>=t1);
                            t2 = (detect{i}(j,3))/600;
                            tp2 = myFind(timevector(:)>=t2);
                        end
                        if (t1>=(binBound(5,1)+1))||(t2<=binBound(9,2))
                            d_c{i_c} = b_signals(i,tp1(1):tp2(1));
                            if k==1
                                d_c_1{i_c1} = p_signals(i,tp1(1):tp2(1));
                                i_c1=i_c1+1;
                            end
                            i_c = i_c+1;
                        end
                        clear tp1 tp2
                    end
                end
            end
        end
    end
%Output:
%d_v
%d_c
if k==5 % For SW in cSWR. Remove repetitions.
    dc =cellfun('length',d_c).';
    for it=2:length(dc)
        if dc(it)-dc(it-1) ==0 %Repeated
            d_c{it}=[];
        end
    end
    d_c=d_c(~cellfun ('isempty', d_c));


    dv =cellfun('length',d_v).';
    for it=2:length(dv)
        if dv(it)-dv(it-1) ==0 %Repeated
            d_v{it}=[];
        end
    end
    d_v=d_v(~cellfun ('isempty', d_v));
    
end

    
    %%
    
    %Variables declared to store characteristics
    xd={};yd={};zd={};qd={};ld={};pd={};
    xcd={};ycd={};zcd={};qcd={};lcd={};pcd={};
    
    figure
    [xd{k},yd{k},zd{k},~,~,qd{k},ld{k},pd{k},~,~,~,...
        xcd{k},ycd{k},zcd{k},~,~,qcd{k},lcd{k},pcd{k},~]...
        =specsHist(d_v,d_c,0,1); % Compares histograms per features between treatments. Per event type.
    sgtitle(['Form ',num2str(k)])
    
    if (k==1)  % For Form 1 (Check characteristics in Pyramidal, even if there is no event.)
        figure
        [xd1{k},yd1{k},zd1{k},~,~,qd1{k},ld1{k},pd1{k},~,~,~,...
            xcd1{k},ycd1{k},zcd1{k},~,~,qcd1{k},lcd1{k},pcd1{k},~]...
            =specsHist(d_v_1,d_c_1,0,1);
        sgtitle(['Form ',num2str(k),' Pyramidal'])
        fxd1={};
        %VEH
        fxd1{1} = xd1{k}';
        fxd1{2} = yd1{k}';
        fxd1{3} = zd1{k}';
        fxd1{4} = ld1{k}';
        fxd1{5} = qd1{k}';
        fxd1{6} = pd1{k}';
        %CBD
        fxd1{7} = xcd1{k}';
        fxd1{8} = ycd1{k}';
        fxd1{9} = zcd1{k}';
        fxd1{10} = lcd1{k}';
        fxd1{11} = qcd1{k}';
        fxd1{12} = pcd1{k}';
        
        maximum = max(cellfun(@length, fxd1));
        for i=1:12
            fxd1{i} = [fxd1{i};zeros(maximum-length(fxd1{i}),1)*nan];  % add nans at the end
        end
        
        cd '/home/adrian/Documents/CBD_acutes/Chara'
        
        TT=table(fxd1{1},fxd1{2},fxd1{3},fxd1{4},fxd1{5},fxd1{6},...
            fxd1{7},fxd1{8},fxd1{9},fxd1{10},fxd1{11},fxd1{12});
        TT.Properties.VariableNames={'Instantaneous Frequencies (Veh)','Average Frequencies (Veh)',...
            'Amplitude (\muV) (Veh)','Area under the curve (Veh)','Duration(ms) (Veh)',...
            'Peak-to-peak amplitude (\muV) (Veh)',...
            'Instantaneous Frequencies (CBD)','Average Frequencies (CBD)',...
            'Amplitude(\muV) (CBD)','Area under the curve (CBD)','Duration(ms) (CBD)'...
            'Peak-to-peak amplitude(\muV) (CBD)'};
        writetable(TT,'SWRChara.xls','Sheet',['Form',num2str(k),' pyr.'])
        
    elseif (k==2)
        figure
        [xd2{k},yd2{k},zd2{k},~,~,qd2{k},ld2{k},pd2{k},~,~,~,...
            xcd2{k},ycd2{k},zcd2{k},~,~,qcd2{k},lcd2{k},pcd2{k},~]...
            =specsHist(d_v_2,d_c_2,0,1);
        sgtitle(['Form ',num2str(k),' Below'])
        fxd2={};
        fxd2{1} = xd2{k}';
        fxd2{2} = yd2{k}';
        fxd2{3} = zd2{k}';
        fxd2{4} = ld2{k}';
        fxd2{5} = qd2{k}';
        fxd2{6} = pd2{k}';
        fxd2{7} = xcd2{k}';
        fxd2{8} = ycd2{k}';
        fxd2{9} = zcd2{k}';
        fxd2{10} = lcd2{k}';
        fxd2{11} = qcd2{k}';
        fxd2{12} = pcd2{k}';
        
        maximum = max(cellfun(@length, fxd2));
        for i=1:12
            fxd2{i} = [fxd2{i};zeros(maximum-length(fxd2{i}),1)*nan];  % add nans at the end
        end
        
        cd '/home/adrian/Documents/CBD_acutes/Chara'
        
        TT=table(fxd2{1},fxd2{2},fxd2{3},fxd2{4},fxd2{5},fxd2{6},...
            fxd2{7},fxd2{8},fxd2{9},fxd2{10},fxd2{11},fxd2{12});
        TT.Properties.VariableNames={'Instantaneous Frequencies (Veh)','Average Frequencies (Veh)',...
            'Amplitude (\muV) (Veh)','Area under the curve (Veh)','Duration(ms) (Veh)',...
            'Peak-to-peak amplitude (\muV) (Veh)',...
            'Instantaneous Frequencies (CBD)','Average Frequencies (CBD)',...
            'Amplitude(\muV) (CBD)','Area under the curve (CBD)','Duration(ms) (CBD)'...
            'Peak-to-peak amplitude(\muV) (CBD)'};
        writetable(TT,'SWRChara.xls','Sheet',['Form',num2str(k),' bel.'])
        
        
    end
    
    fxd={};
    fxd{1} = xd{k}';
    fxd{2} = yd{k}';
    fxd{3} = zd{k}';
    fxd{4} = ld{k}';
    fxd{5} = qd{k}';
    fxd{6} = pd{k}';
    
    fxd{7} = xcd{k}';
    fxd{8} = ycd{k}';
    fxd{9} = zcd{k}';
    fxd{10} = lcd{k}';
    fxd{11} = qcd{k}';
    fxd{12} = pcd{k}';
    % x,xc - Instantaneous Frequencies
    % y,yc - Average frequency
    % z,zc - Amplitude
    % l,lc - Area under the curve
    % q,qc - Duration
    % p,pc - Peak-to-peak distance
    maximum = max(cellfun(@length, fxd));
    for i=1:12
        fxd{i} = [fxd{i};zeros(maximum-length(fxd{i}),1)*nan];  % add nans at the end
    end
    
    cd '/home/adrian/Documents/CBD_acutes/Chara'
    
    TT=table(fxd{1},fxd{2},fxd{3},fxd{4},fxd{5},fxd{6},...
        fxd{7},fxd{8},fxd{9},fxd{10},fxd{11},fxd{12});
    TT.Properties.VariableNames={'Instantaneous Frequencies (Veh)','Average Frequencies (Veh)',...
        'Amplitude (\muV) (Veh)','Area under the curve (Veh)','Duration(ms) (Veh)',...
        'Peak-to-peak amplitude (\muV) (Veh)',...
        'Instantaneous Frequencies (CBD)','Average Frequencies (CBD)',...
        'Amplitude(\muV) (CBD)','Area under the curve (CBD)','Duration(ms) (CBD)'...
        'Peak-to-peak amplitude(\muV) (CBD)'};
    writetable(TT,'SWRChara.xls','Sheet',['Form',num2str(k)]) 
end
