cd /media/adrian/6aa1794c-0320-4096-a7df-00ab0ba946dc/CSD/final

load('GC_swr_ratID210_veh.mat')
load('GC_swr_ratID213_veh.mat')
%%

sw1=GC_sw_ratID210_veh;
sw2=GC_sw_ratID213_veh;
sw1=sw1.grouped_oscil_table.Six_Upstate;
sw2=sw2.grouped_oscil_table.Six_Upstate;

ripple1=GC_ripple_ratID210_veh;
ripple2=GC_ripple_ratID213_veh;
ripple1=ripple1.grouped_oscil_table.Six_Upstate;
ripple2=ripple2.grouped_oscil_table.Six_Upstate;

swr1=GC_swr_ratID210_veh;
swr2=GC_swr_ratID213_veh;
swr1=swr1.grouped_oscil_table.Six_Upstate;
swr2=swr2.grouped_oscil_table.Six_Upstate;


complex_swr1=GC_complex_swr_ratID210_veh;
complex_swr2=GC_complex_swr_ratID213_veh;
complex_swr1=complex_swr1.grouped_oscil_table.Six_Upstate;
complex_swr2=complex_swr2.grouped_oscil_table.Six_Upstate;
%%
ripple=[ripple1(:); ripple2(:)];
sw=[sw1(:); sw2(:)];
swr=[swr1(:); swr2(:)];
complex_swr=[complex_swr1(:); complex_swr2(:)];

%%
histogram(ripple,'Normalization','probability');
hold on
histogram(sw,'Normalization','probability')
histogram(swr,'Normalization','probability')
histogram(complex_swr,'Normalization','probability')
%%
av=1801-[median(sw) median(ripple) median(swr) median(complex_swr)];
av=av/600; % Seconds
