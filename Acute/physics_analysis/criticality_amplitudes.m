 %% RIPPLES
 cd('/home/adrian/Documents/cbd_criticality')
 close all
 norm_type='cdf';
 ripples_Amp_Veh=ripples_Amp_Veh(~isnan(ripples_Amp_Veh)); 
 ripples_Amp_CBD=ripples_Amp_CBD(~isnan(ripples_Amp_CBD)); 
 
 criticality_plot(ripples_Amp_Veh,norm_type,0)
 hold on
 criticality_plot(ripples_Amp_CBD,norm_type,1)
 legend('Ripples-Veh','Ripples-CBD','Location','southeast')
 title('cdf histogram of Ripples Amplitudes')
% ylim([1 10000])
% ylim([0 1])
ylim([.0010 1])
 printing_image('Amplitudes_cdf_Ripples')
%%
 figure()
 norm_type='cdf';
 SWRripples_Amp_Veh=SWRripples_Amp_Veh(~isnan(SWRripples_Amp_Veh)); 
 SWRripples_Amp_CBD=SWRripples_Amp_CBD(~isnan(SWRripples_Amp_CBD)); 
 
 
 criticality_plot(SWRripples_Amp_Veh,norm_type,0)
 hold on
 criticality_plot(SWRripples_Amp_CBD,norm_type,1)
 legend('SWR-Veh','SWR-CBD','Location','southeast')
 title('cdf histogram of SWR Amplitudes')
% ylim([1 10000])
% ylim([0 1])
ylim([.0010 1])

 printing_image('Amplitudes_cdf_SWR')

 %%
 figure()
 norm_type='cdf';
 cSWRripples_Amp_Veh=cSWRripples_Amp_Veh(~isnan(cSWRripples_Amp_Veh)); 
 cSWRripples_Amp_CBD=cSWRripples_Amp_CBD(~isnan(cSWRripples_Amp_CBD)); 
 
 criticality_plot(cSWRripples_Amp_Veh,norm_type,0)
 hold on
 criticality_plot(cSWRripples_Amp_CBD,norm_type,1)
 legend('cSWR-Veh','cSWR-CBD','Location','southeast')
 title('cdf histogram of cSWR Amplitudes')
% ylim([1 10000])
% ylim([0 1])
ylim([.0010 1])

 printing_image('Amplitudes_cdf_cSWR')
