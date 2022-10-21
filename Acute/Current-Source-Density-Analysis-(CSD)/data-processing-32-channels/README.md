:exclamation: **Requirements**: Matlab Signal Processing Toolbox.









![Pipeline](https://github.com/pelinozsezer/CBD/blob/main/Acute/Current-Source-Density-Analysis-(CSD)/data-processing-32-channels/pipeline.png)

- **downsampling_script.m**: Downsamples the data from 30000 Hz to 600 Hz.
- **arranging.m**: Arranges the data into the required folder structure. Each channel must have its own folder name as channel number (e.g., 1, 23, etc.). These channel folders contain the data of every rat named as rat number (e.g., 3, 201, etc.).
- **preprocessing_32channel.m**:
- **dataprocessing_signal2detections_32channel.m**:
- **remove_events_with_nan32.m**:
- **dataprocessing_eventtype_rat_HPC32.m**:
- **data_32by3601.m**:
