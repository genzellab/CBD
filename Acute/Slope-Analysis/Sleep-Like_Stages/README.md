# :sparkles: Slope Analysis - Sleep-Like Stages :sparkles:
:pushpin: **Requirements**: [FOOOF - fitting oscillations & one over f](https://fooof-tools.github.io/fooof/), [numpy](https://github.com/numpy/numpy), [scipy](https://github.com/scipy/scipy), [FieldTrip](https://github.com/fieldtrip/fieldtrip), [N-dimensional histogram](https://www.mathworks.com/matlabcentral/fileexchange/23897-n-dimensional-histogram), [Image Processing Toolbox](https://www.mathworks.com/products/image.html), [Statistics and Machine Learning Toolbox](https://www.mathworks.com/products/statistics.html), [Signal Processing Toolbox](https://www.mathworks.com/products/signal.html), [Deep Learning HDL Toolbox](https://www.mathworks.com/products/deep-learning-hdl.html), [Wavelet Toolbox](https://www.mathworks.com/products/wavelet.html), [Symbolic Math Toolbox](https://www.mathworks.com/products/symbolic.html), [Computer Vision Toolbox](https://www.mathworks.com/products/computer-vision.html), [Bioinformatics Toolbox](https://www.mathworks.com/products/bioinfo.html).

:pushpin: Makes use of functions from [FieldTrip](https://github.com/fieldtrip/fieldtrip), [OpenEphys](https://github.com/open-ephys/analysis-tools), and 	[ADRITOOLS](https://github.com/Aleman-Z/ADRITOOLS). 

------------------------------------
## Pipeline 
<a href="url"><img src="https://github.com/pelinozsezer/CBD/blob/main/Acute/Slope-Analysis/Sleep-Like_Stages/pipeline.png" height="600" width="750" ></a>

------------------------------------

**Event Types:** Baselines, Ripple, SW, SWR, & Complex SWR.

**All Events:** All event types were merged per treatment (Vehicle & CBD).

------------------------------------

- **spectra_all_events_PFCshal.m/spectra_event_types_PFCshal.m:** Computes power spectrum with x and y axes in logarithms with a base of 10.

- **spectra_all_events_nonloggedx_PFCshal.m/spectra_event_types_nonloggedx_PFCshal.m:** Computes power spectrum with only y axis in logarithm with a base of 10.

- **save_slope_PFCshal.m:** Outputs and saves power spectrum values to be used for slope analysis. 

- **slope-analysis-all-events.py/slope-analysis-event-types.py:** Runs slope analysis on power spectrum.

- **stats_PFCshal.m:** Arranges the data (i.e., slopes and offset) for SPSS to run statistics.

