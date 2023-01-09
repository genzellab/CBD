# :sparkles: Data Processing for Slope Analysis :sparkles:
:pushpin: **Requirements**: [FOOOF - fitting oscillations & one over f](https://fooof-tools.github.io/fooof/), [numpy](https://github.com/numpy/numpy), [scipy](https://github.com/scipy/scipy), [FieldTrip](https://github.com/fieldtrip/fieldtrip), [N-dimensional histogram](https://www.mathworks.com/matlabcentral/fileexchange/23897-n-dimensional-histogram), [Image Processing Toolbox](https://www.mathworks.com/products/image.html), [Statistics and Machine Learning Toolbox](https://www.mathworks.com/products/statistics.html), [Signal Processing Toolbox](https://www.mathworks.com/products/signal.html), [Deep Learning HDL Toolbox](https://www.mathworks.com/products/deep-learning-hdl.html), [Wavelet Toolbox](https://www.mathworks.com/products/wavelet.html), [Symbolic Math Toolbox](https://www.mathworks.com/products/symbolic.html), [Computer Vision Toolbox](https://www.mathworks.com/products/computer-vision.html), [Bioinformatics Toolbox](https://www.mathworks.com/products/bioinfo.html).

:pushpin: Makes use of functions from [FieldTrip](https://github.com/fieldtrip/fieldtrip), [OpenEphys](https://github.com/open-ephys/analysis-tools), and 	[ADRITOOLS](https://github.com/Aleman-Z/ADRITOOLS). 

------------------------------------
## Pipeline (In Order)
<a href="url"><img src="https://github.com/pelinozsezer/CBD/blob/main/Chronic/Long%26Short_Ripples/Slope-Analysis/data-processing/pipeline.png" align="center" height="250" width="1000" ></a>

------------------------------------

- **dataprocessing_chronics_slope_analysis_ratIDX.m:** Processes downsampled chronics data for slope analysis. Extracts each ripple type (i.e., short & long) per trial, per condition (study day) and per rat. The output is, for example, rat4_SD7_HC_cbd_pt54 (which means study day 7 that is 'Home Cage' condition -  CBD - Rat 4).

- **merge_rats_chronics.m** Merge all of the data per ripple type and per treatment.

- **remove_nan_PFC/HPC.m** Removes missing data.

- **create_baselines.m** Randomly selects 400 baselines from the raw signal of NonREM sleep for PFC & HPC and Vehicle & CBD. Each baseline is 4 seconds long.


