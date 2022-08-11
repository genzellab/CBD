Dependencies: To-add. 


# CBD
Repository for CBD project. 

## Main scripts for Acute data: :file_folder: 

_**Data preprocessing:**_ 
  * AdrianDownsampleFiles.m : Downsamples channels to 600 Hz.

  * Downsampling_script_2022.m (Outdated, not used)

_**Sleep stages analysis:**_ 
  
  * PCA_sleep_scorer.m : Uses raw data as input. Performs downsampling itself. We didn't use the silhouette analysis that Tuk suggested. It doesn't remove the first 15 minutes of the signal. Hence 'states' files will need their first 15 minutes to be discarded in following scripts. 
  
  * SleepStagesAnalysis2022.m

_**Data alignment:**_ 
* align_dataset.m : Cuts first 15 minutes. Aligns in Relation to rat 214. Checks for the maximum (N) number of 45 minute bins possible. Trims to have only those N bins
 
_**Event detection:**_ 
  
  * Swat_Delta_Script.m 

  * FindDeltaWaves.m
  
_**Data alignment:**_ 
* align_dataset.m : Cuts first 15 minutes. Aligns in Relation to rat 214. Checks for the maximum (N) number of 45 minute bins possible. Trims to have only those N bins
 
_**Event detection:**_ 
  
  * Swat_Delta_Script.m 

  * FindDeltaWaves.m
  
_**Delta and Spindle event analysis:**_ 

The following steps may be implemented to prepare the data for detecting delta events from the signal recorded from the hippocampal (HPC) region:

  1. Compute filter parameters ```b ``` (transfer coefficients in the numerator) and ```a``` (transfer coefficients in the denominator), for filtering with a butterworth filter with a cut-off frequency of 1 to 6  Hz.
  2. Use ```clean_dataset.m ```, with the necessary inputs, to filter the raw signal data and store in the folder, as specified by ```results_dir```.
  3. Use ```align_dataset.m ``` (with inputs as obtained from the previous step), to compute the variables: ```signals``` (the aligned EEG data), ```sleep_states``` (the aligned sleep states), ```signals_indexes``` (the indices corresponding to the signal recording, along time) and ```bins_num``` (the number of bins possible based on the bin size specified). Export the output variables  as ```forDelta.mat```.
  
 The following steps may be implemented to prepare the data for detecting spindle events from the signal recorded from the prefrontal cortex (PFC) region:
 
  1. Compute filter parameters ```b``` (transfer coefficients in the numerator) and ```a``` (transfer coefficients in the denominator), for filtering with a butterworth filter with a cut-off frequency of 9 to 20  Hz.
  2. Use ```clean_dataset.m ```, with the necessary inputs, to filter the raw signal data and store in the folder, as specified by ```results_dir```.
  3. Use ```align_dataset.m ``` (with inputs as obtained from the previous step), to compute the variables: ```signals``` (the aligned EEG data), ```sleep_states``` (the aligned sleep states), ```signals_indexes``` (the indices corresponding to the signal recording, along time) and ```bins_num``` (the number of bins possible based on the bin size specified). Export the output variables, together, as ```forSpindles.mat```.

The script ```DeltaSpindleDetection.m``` can be run to detect delta and spindle events from the ```.mat``` data. The events detected is then saved, as specified in the script.

The script ```delta_spindle_extract.m``` should be run next to export the charateristics of the delta events and the spindle events as the excel sheets "DeltaChara.xls" and "SpindleChara.xls", respectively.

Additionally, data regarding time-bins & NREM bouts durations will be exported as "Recording_duration.xls", and the delta event counts will be exported as "DeltaCount_split.xls", when the ```DeltaSpindleDetection.m``` script is run.
