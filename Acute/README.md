
## Main scripts for Acute data: :file_folder: 

_**Data preprocessing:**_ 
  * DownsampleFiles.m : Downsamples channels to 600 Hz. Formerly called 'AdrianDownsampleFiles.m'

  * ~~Downsampling_script_2022.m~~ (Outdated, not used)

_**Sleep stages analysis:**_ 
  
  * PCA_sleep_scorer.m : Uses raw data as input. Performs downsampling itself. We didn't use the silhouette analysis that Tuk suggested. It doesn't remove the first 15 minutes of the signal. Hence 'states' files will need their first 15 minutes to be discarded in following scripts. 
  
  * SleepStagesAnalysis2022.m : Adaptation of Tuk's thesis script.
  
  
_**Sharp wave ripple types analysis**_ 

The data was rearranged by Victor and can be found in the Sri Lanka computer:F:/OSF/swr_analysys
 
 Folders:
- _brain_regions_ : Not bandpassed. Just downsampled to 600 Hz. The downsampled data was added to this folder and renamed with the Rat ID number to allow use of for-loops. Important: These channels contain artifacts which are removed later in the pipeline. So they are not "clean". 
- _sleepstates_ : This folder contains the sleep stages labels from the PCA scorer. The files were renamed with the Rat ID. 
- _detections_ : Created by Victor. Results from running ```detection_sw_r_swr_cswr.m``` which is explained below. 
- _processed_data_ : Contains the aligned matrices per brain region. Note: The HPC data was filtered. HPC pyra (90-200Hz) and HPCbelow (2-20Hz).

Scripts:

For aligning the data:

preprocessing_r_sw: "Cleans" the data by removing artefacts. Filters channel with the frequency band of the event to detect. Example. For HPCpyra it filters between 90-200 Hz. For HPCbelow it filters between 2 and 20 Hz. The data is cleaned by using the ```clean_dataset``` script. It is aligned by using the ```align_dataset``` script. 


- clean_dataset(regions, selected_region, results_dir, b, a, rats, thresholds): Creates aligned matrices for a brain region for multiple rodents, as well as sleep states matrices and indices to access unpadded individual signals per rodent.
Example: ```clean_dataset('F:\OSF\swr_analysys\brain_regions', 'hpc_pyra', 'results_dir', b, a)```

- detection_sw_r_swr_cswr.m: Name is self-explainatory. Requires knowing the ripple_threshold and sharpwave_thresholds, which were selected visually using the GUI.  


The sharp wave ripples (SWRs) that has been saved for each rat, as ```oscil_table``` and ```grouped_oscil_table```, can be analysed by running the script ```swr_traces.m```. The script loads the detections and extracts the corresponding traces from the necessary HPC signal. The characteristics of each form of swr is stored as "SWRChara.xls" on separated sheets.
(Note: The ```p_hpc.mat``` and ```b_hpc.mat``` files can be created by following steps similar to that used to prepare the signals for spindle/delta detection, with the necessary changes. For the ```p_hpc.mat``` dataset, use a bandpass of 90 to 200 Hz, and for ```b_hpc.mat```, use a bandpass of 2 to 20 Hz, on the corresponding HPC datasets.)
    
  
_**Data alignment:**_ 

For running the next script some file renaming is needed in the data. More details to come.
* align_dataset.m : Cuts first 15 minutes. Aligns in Relation to rat 214. Checks for the maximum (N) number of 45 minute bins possible. Trims to have only those N bins
 
  
_**Delta and Spindle event analysis:**_ 

The following steps may be implemented to prepare the data for detecting delta events from the signal recorded from the hippocampal (HPC) region:

  1. Compute filter parameters ```b ``` (transfer coefficients in the numerator) and ```a``` (transfer coefficients in the denominator), for filtering with a butterworth filter with a cut-off frequency of 1 to 6  Hz.
  2. Use ```clean_dataset.m ```, with the necessary inputs, to filter the raw signal data and store in the folder, as specified by ```results_dir```.  Example: ```  clean_dataset('F:\OSF\swr_analysys\brain_regions', 'hpc_pyra', 'results_dir', b, a)``` 
  3. Use ```align_dataset.m ``` (with inputs as obtained from the previous step), to compute the variables: ```signals``` (the aligned LFP data), ```sleep_states``` (the aligned sleep states), ```signals_indexes``` (the indices corresponding to the signal recording, along time) and ```bins_num``` (the number of bins possible based on the bin size specified). Export the output variables  as ```forDelta.mat```.
  
 The following steps may be implemented to prepare the data for detecting spindle events from the signal recorded from the prefrontal cortex (PFC) region:
 
  1. Compute filter parameters ```b``` (transfer coefficients in the numerator) and ```a``` (transfer coefficients in the denominator), for filtering with a butterworth filter with a cut-off frequency of 9 to 20  Hz.
  2. Use ```clean_dataset.m ```, with the necessary inputs, to filter the raw signal data and store in the folder, as specified by ```results_dir```.
  3. Use ```align_dataset.m ``` (with inputs as obtained from the previous step), to compute the variables: ```signals``` (the aligned LFP data), ```sleep_states``` (the aligned sleep states), ```signals_indexes``` (the indices corresponding to the signal recording, along time) and ```bins_num``` (the number of bins possible based on the bin size specified). Export the output variables, together, as ```forSpindles.mat```.

The script ```DeltaSpindleDetection.m``` can be run to detect delta and spindle events from the ```.mat``` data. The events detected is then saved, as specified in the script.

The script ```DeltaSpindleExtract.m``` should be run next to export the charateristics of the delta events and the spindle events as the excel sheets "DeltaChara.xls" and "SpindleChara.xls", respectively.

Additionally, data regarding time-bins & NREM bouts durations will be exported as "Recording_duration.xls", and the delta event counts will be exported as "DeltaCount_split.xls", when the ```DeltaSpindleDetection.m``` script is run.


# Coding system:

_Sleep stages:_

 1 corresponds to REM-like and 2 to NREM-like.

_Event types:_
- 1 single sw
- 2 single r
- 3 simple sw-swr
- 4 simple r-swr
- 5 complex sw-swr
- 6 complex r-swr

## Pipeline description by Pelin

[specs-flowchart (To generate spectrograms)](https://docs.google.com/document/d/1KkYj9pP0HtkzjQ-p-1WWALFDSossGnD021djwIOCWSg/edit?usp=sharing)

[slope-analysis-flowchart](https://docs.google.com/document/d/1O0E73VSSKm39skcDfJgUjIiksfCIa07FEhLNptUxXCQ/edit?usp=sharing)

[HPC-data-flowchart (For generating unfiltered HPC data)](https://docs.google.com/document/d/1KkYj9pP0HtkzjQ-p-1WWALFDSossGnD021djwIOCWSg/edit?usp=sharing)

[32-channel-flowchart (For CSD analysis)](https://docs.google.com/document/d/1tSe1NFQGqByXRL5D9U-cSSFL-1GHQvqjHtUqIXY5mqI/edit)
