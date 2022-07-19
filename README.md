Dependencies: To-add. 


# CBD
Repository for CBD project. 

## Main scripts: :file_folder: 

_**Data preprocessing:**_ 
  * AdrianDownsampleFiles.m : Downsamples channels to 600 Hz.

  * Downsampling_script_2022.m

_**Data processing:**_ 

 * dataprocessing_eventtype_rat_HPC.m
 
 * dataprocessing_eventtype_rat_PFC.m
 
 * dataprocessing_concat_eventtype_HPC.m
 
 * dataprocessing_concat_eventtype_PFC.m
 
 * dataprocessing_median2000events_treatment_eventtype.m
 
 * create_baseline.m


_**Sleep stages analysis:**_ 
  
  * PCA_sleep_scorer.m : Uses raw data as input. Performs downsampling itself. We didn't use the silhouette analysis that Tuk suggested. It doesn't remove the first 15 minutes of the signal. Hence 'states' files will need their first 15 minutes to be discarded in following scripts. 
  
  * SleepStagesAnalysis2022.m

_**Data alignment:**_ 
* align_dataset.m : Cuts first 15 minutes. Aligns in Relation to rat 214. Checks for the maximum (N) number of 45 minute bins possible. Trims to have only those N bins
 
_**Event detection:**_ 
  
  * Swat_Delta_Script.m 

  * FindDeltaWaves.m
