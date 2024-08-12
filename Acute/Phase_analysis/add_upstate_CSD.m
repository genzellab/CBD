cd /media/adrian/6aa1794c-0320-4096-a7df-00ab0ba946dc/CSD
% ratID = '11_cbd'; % Adjust the ratID if needed
%ratID = '212_cbd'; % Adjust the ratID if needed
%ratID = '210_veh'; % Adjust the ratID if needed
%ratID = '213_veh'; % Adjust the ratID if needed
ratID = '10_cbd'; % Adjust the ratID if needed


gc_file = ['GC_ratID' ratID '.mat'];
load(gc_file);
%%
sw_grouped = eval(['GC_sw_ratID' ratID '.grouped_oscil_table']);
ripple_grouped = eval(['GC_ripple_ratID' ratID '.grouped_oscil_table']);
swr_grouped = eval(['GC_swr_ratID' ratID '.grouped_oscil_table']);
cswr_grouped = eval(['GC_complex_swr_ratID' ratID '.grouped_oscil_table']);

sw_waveform = eval(['GC_sw_ratID' ratID '.waveforms']);
ripple_waveform = eval(['GC_ripple_ratID' ratID '.waveforms']);
swr_waveform = eval(['GC_swr_ratID' ratID '.waveforms']);
cswr_waveform = eval(['GC_complex_swr_ratID' ratID '.waveforms']);

%%

% Define the variables to iterate over
signal_vars = {'GC_complex_swr', 'GC_ripple', 'GC_sw', 'GC_swr'};

for var_idx = 1:length(signal_vars)
    signal_var = signal_vars{var_idx};

   switch signal_var
        case 'GC_ripple'
            grouped=ripple_grouped;
            waveform=ripple_waveform;
        case 'GC_complex_swr'
            grouped=cswr_grouped;
            waveform=cswr_waveform;
        case 'GC_sw'
            grouped=sw_grouped;
            waveform=sw_waveform;
        case 'GC_swr'
            grouped=swr_grouped;
            waveform=swr_waveform;
        otherwise
            error('Unknown signal variable: %s', signal_var);
    end
    
    
    
   load(['CommonInd_' signal_var '_ratID' ratID '.mat'])
   load(['IND180_' signal_var '_ratID' ratID '.mat'])
 
   newgrouped=grouped(common_ind,:);
   newwaveform=waveform(common_ind,:);
  
   if length(newwaveform) ~= length(IND180)
               error('something is wrong')
   end
  newgrouped.Six_Upstate = IND180.';
    
% Use eval to create and assign new variables
eval(['New_' signal_var '_ratID' ratID '.grouped_oscil_table = newgrouped;']);
eval(['New_' signal_var '_ratID' ratID '.waveforms = newwaveform;']);

   
end
% gc_file and data_info
% Construct the filename
filename = ['New_' signal_var '_ratID' ratID '.mat'];
xo
%%
% List of variables to keep
keepVars = {'filename', 'data_info'};

% Get the list of all variables in the workspace
allVars = who;

% Identify variables starting with 'NEW_GC'
newGcVars = allVars(startsWith(allVars, 'New_GC'));

% Combine all variables to keep
keepVars = [keepVars, newGcVars'];

% Identify variables to delete
delVars = setdiff(allVars, keepVars);

% Delete the identified variables
clear(delVars{:});
%%
% Save the variable into the file
save(filename)
