
%% Pelin Ozsezer

%% CBD Project

% MANUAL - Run rat by rat

%% RatIDs of Veh: 3, 4, 9, 201, 203, 206, 210, 211, 213
%% RatIDs of CBD: 2, 5, 10, 11, 204, 205, 207, 209, 212, 214

%% Convert data into 32-by-3601
clc
clear
cd /home/genzellab/Desktop/Pelin/HPC_32channels

load("ratID214_HPC_cbd.mat")

%% Ripple
ripple_grouped_oscil_table_cbd=ripple_grouped_oscil_table_HPC1_ratID214;

for i=1:size(GC_ripple_waveforms_HPC1_ratID214,1)
    for ch=1:32
        temp_var = strcat( "GC_ripple_ratID214_cbd.waveforms{i,1}(",num2str(ch),",:)=GC_ripple_waveforms_HPC",...
            num2str(ch),"_ratID214{i,1}(1,:);");
        eval(sprintf('%s',temp_var));
    end
end

GC_ripple_ratID214_cbd.grouped_oscil_table=ripple_grouped_oscil_table_cbd;


%% SW
sw_grouped_oscil_table_cbd=sw_grouped_oscil_table_HPC1_ratID214;

for i=1:size(GC_sw_waveforms_HPC1_ratID214,1)
    for ch=1:32
        temp_var = strcat( "GC_sw_ratID214_cbd.waveforms{i,1}(",num2str(ch),",:)=GC_sw_waveforms_HPC",...
            num2str(ch),"_ratID214{i,1}(1,:);");
        eval(sprintf('%s',temp_var));
    end
end

GC_sw_ratID214_cbd.grouped_oscil_table=sw_grouped_oscil_table_cbd;

%% SWR
swr_grouped_oscil_table_cbd=swr_grouped_oscil_table_HPC1_ratID214;

for i=1:size(GC_swr_waveforms_HPC1_ratID214,1)
    for ch=1:32
        temp_var = strcat( "GC_swr_ratID214_cbd.waveforms{i,1}(",num2str(ch),",:)=GC_swr_waveforms_HPC",...
            num2str(ch),"_ratID214{i,1}(1,:);");
        eval(sprintf('%s',temp_var));
    end
end

GC_swr_ratID214_cbd.grouped_oscil_table=swr_grouped_oscil_table_cbd;

%% Complex SWR
complex_swr_grouped_oscil_table_cbd=complex_swr_grouped_oscil_table_HPC1_ratID214;

for i=1:size(GC_complex_swr_waveforms_HPC1_ratID214,1)
    for ch=1:32
        temp_var = strcat( "GC_complex_swr_ratID214_cbd.waveforms{i,1}(",num2str(ch),",:)=GC_complex_swr_waveforms_HPC",...
            num2str(ch),"_ratID214{i,1}(1,:);");
        eval(sprintf('%s',temp_var));
    end
end

GC_complex_swr_ratID214_cbd.grouped_oscil_table=complex_swr_grouped_oscil_table_cbd;



%%%%%%%%%%
%% SAVE %%
%%%%%%%%%%
data_info=['HPC1 to HPC32 = shallow to deep'];

clearvars -except data_info GC_ripple_ratID214_cbd GC_sw_ratID214_cbd ...
    GC_swr_ratID214_cbd GC_complex_swr_ratID214_cbd 

save('GC_ratID214_cbd.mat','-v7.3')


