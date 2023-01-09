# :sparkles: Slope Analysis - PFCshal :sparkles:
:pushpin: **Requirements**: [FOOOF - fitting oscillations & one over f](https://fooof-tools.github.io/fooof/), [numpy](https://github.com/numpy/numpy), [scipy](https://github.com/scipy/scipy), [FieldTrip](https://github.com/fieldtrip/fieldtrip), [N-dimensional histogram](https://www.mathworks.com/matlabcentral/fileexchange/23897-n-dimensional-histogram), [Image Processing Toolbox](https://www.mathworks.com/products/image.html), [Statistics and Machine Learning Toolbox](https://www.mathworks.com/products/statistics.html), [Signal Processing Toolbox](https://www.mathworks.com/products/signal.html), [Deep Learning HDL Toolbox](https://www.mathworks.com/products/deep-learning-hdl.html), [Wavelet Toolbox](https://www.mathworks.com/products/wavelet.html), [Symbolic Math Toolbox](https://www.mathworks.com/products/symbolic.html), [Computer Vision Toolbox](https://www.mathworks.com/products/computer-vision.html), [Bioinformatics Toolbox](https://www.mathworks.com/products/bioinfo.html).


------------------------------------
## Pipeline 
<a href="url"><img src="https://github.com/pelinozsezer/CBD/blob/main/Acute/Slope-Analysis/HPCpyra/pipeline.png" align="center" height="500" width="525" ></a>

------------------------------------

- **create_baseline_HPCpyra.m:** Randomly select 2000 time windows of 6 seconds from the raw signal of NonREM sleep to be used as baselines data.

- **spectra_all_events_HPCpyra.m/spectra_event_types_HPCpyra.m:** Computes power spectrum with x and y axes in logarithms with a base of 10.

- **spectra_all_events_nonloggedx_HPCpyra.m/spectra_event_types_nonloggedx_HPCpyra.m:** Computes power spectrum with only y axis in logarithm with a base of 10.

- **save_slope_HPCpyra.m:** Outputs and saves power spectrum values to be used for slope analysis. 

- **slope-analysis-all-events.py/slope-analysis-event-types.py:** Runs slope analysis on power spectrum.

- **stats_HPCpyra.m:** Arranges the data (i.e., slopes and offset) for SPSS to run statistics.

