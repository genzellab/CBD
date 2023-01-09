# **:sparkles: Spectrograms :sparkles:**

:pushpin: **Requirements:** [Image Processing Toolbox](https://www.mathworks.com/products/image.html) - [Signal Processing Toolbox](https://www.mathworks.com/products/signal.html) - [Wavelet Toolbox](https://www.mathworks.com/products/wavelet.html) - [Statistics and MAchine Learning Toolbox](https://www.mathworks.com/products/statistics.html) - [Deep Learning HDL Toolbox](https://www.mathworks.com/products/deep-learning-hdl.html).

:pushpin: Makes use of functions from [FieldTrip](https://github.com/fieldtrip/fieldtrip), [OpenEphys](https://github.com/open-ephys/analysis-tools), and 	[ADRITOOLS](https://github.com/Aleman-Z/ADRITOOLS). 

------------------------------------

## Pipeline (In Order)
<a href="url"><img src="https://github.com/pelinozsezer/CBD/blob/main/Acute/Spectrograms/pipeline.png" align="center" height="600" width="525" ></a>

------------------------------------

- **preprocessing_spec:** Removes artifacts in the data; Creates temporally aligned matrices of the data with bins of 45 minutes using functions **clean_dataset_spec.m** and **align_dataset_spec.m**

- **dataprocessing_signal2detections:** Extracts a 6-second long time window of the raw signal using the event’s peak timestamps of each rat event.
 
- **remove_events_with_nan:** Removes missing data.

- **dataprocessing_eventtype_rat_HPC/PFC.m:** Arranges data per event type and per rat. The output is, for example, ratID3_brainArea_veh.mat containing the separate data of event types (i.e., Ripple, SW, SWR, & Complex SWR)

- **dataprocessing_combine_eventtype_HPC/PFC.m:** Combines the data of all rats per event type (e.g., GC_detections_PFCshal_ripple_veh).

- **dataprocessing_median2000events_treatment_eventtype.m:** Select 2000 events closest to the median in amplitude per treatment and per event type.
%% per treatment & per event type

- **remove_artifact_event_median_data_PFC:** Removes the artifacts in the output data of _dataprocessing_median2000events_treatment_eventtype.m_

- **create_baseline_PFC.m:** Randomly select 2000 time windows of 6 seconds from the raw signal of NonREM sleep of PFC to be used as baselines data.

- **remove_artifact_baseline_PFC.m:** Removes the artifacts in the output data of _create_baseline_PFC.m_

- **spectrogram_baseline_vs_eventtype.m:** Computes spectrograms between baselines and each event type (i.e., Ripple, SW, SWR, & Complex SWR) per treatment; Creates contrast plots; Runs statistics on contrasts.

- **spectrogram_Veh_vs_CBD_4eachEventType.m:** Computes spectrograms between Vehicle and CBD for each event type (i.e., Ripple, SW, SWR, & Complex SWR); Creates contrast plots; Runs statistics on contrasts.

- **spectrogram_Veh_vs_CBD_baseline.m:** Computes spectrograms between the baselines of Vehicle and CBD; Creates contrast plot; Runs statistics on contrast.




