
%% remove NaNs in the data

%% Short Ripples - Veh
clear
load('short_ripples_chronics_veh.mat');
short_ripples_chronics_veh(~cellfun('isempty',short_ripples_chronics_veh))
short_ripples_chronics_veh=ans;
save short_ripples_chronics_veh.mat -v7.3

%% Short Ripples - CBD
clear
load('short_ripples_chronics_cbd.mat');
short_ripples_chronics_cbd(~cellfun('isempty',short_ripples_chronics_cbd))
short_ripples_chronics_cbd=ans;
save short_ripples_chronics_cbd.mat -v7.3