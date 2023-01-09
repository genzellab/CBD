# :sparkles: Data Generation for CSD Analysis :sparkles:
:pushpin: **Requirements**: [Signal Processing Toolbox](https://www.mathworks.com/products/signal.html).

------------------------------------

![Pipeline](https://github.com/pelinozsezer/CBD/blob/main/Acute/Current-Source-Density-Analysis-(CSD)/data-processing-32-channels/pipeline.png)

- **downsampling_script.m**: Downsamples the data from 30 kHz to 600 Hz.

- **arranging.m**: Arranges the data into the particular folder structure. Each channel must have its own folder name as channel number (e.g., 1, 23, etc.). These channel folders contain the data of every rat named as rat number (e.g., 3, 201, etc.).

- **preprocessing_32channel.m**: Removes artifacts in the data; Creates temporally aligned matrices of the data with bins of 45 minutes.

- **dataprocessing_signal2detections_32channel.m**: Extracts a 6-second long time window of the raw signal using the event’s peak timestamps of each rat event. 

- **remove_events_with_nan32.m**: Removes missing data and events that 1) did not start after 3 seconds from the start of the recording 2) did not finish 3 seconds before the end of the recording.

- **dataprocessing_eventtype_rat_HPC32.m**: Arranges data per rat and per event type.

- **data_32by3601.m**: Arranges data of each event from 32 channels into one single cell. The output is a cell array.

------------------------------------
*Notes regarding the data of rats:* 
- Rat 4 has 2 recordings for each channel, except channel 6 which has 3 recordings.
- Rat 207, 201, 4!! Check these rats after downsampling because they will have more than one file for several channels.
