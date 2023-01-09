# :sparkles: Slope Analysis - Sleep Stages :sparkles:
:pushpin: **Requirements**: [FOOOF - fitting oscillations & one over f](https://fooof-tools.github.io/fooof/), [numpy](https://github.com/numpy/numpy), [scipy](https://github.com/scipy/scipy), [boundedline](https://www.mathworks.com/matlabcentral/fileexchange/27485-boundedline-m), [FieldTrip](https://github.com/fieldtrip/fieldtrip), [N-dimensional histogram](https://www.mathworks.com/matlabcentral/fileexchange/23897-n-dimensional-histogram), [Image Processing Toolbox](https://www.mathworks.com/products/image.html), [Statistics and Machine Learning Toolbox](https://www.mathworks.com/products/statistics.html), [Signal Processing Toolbox](https://www.mathworks.com/products/signal.html), [Deep Learning HDL Toolbox](https://www.mathworks.com/products/deep-learning-hdl.html), [Wavelet Toolbox](https://www.mathworks.com/products/wavelet.html), [Symbolic Math Toolbox](https://www.mathworks.com/products/symbolic.html), [Computer Vision Toolbox](https://www.mathworks.com/products/computer-vision.html), [Bioinformatics Toolbox](https://www.mathworks.com/products/bioinfo.html).

:pushpin: Makes use of functions from [FieldTrip](https://github.com/fieldtrip/fieldtrip), [OpenEphys](https://github.com/open-ephys/analysis-tools), and 	[ADRITOOLS](https://github.com/Aleman-Z/ADRITOOLS). 

------------------------------------
## Pipeline (In Order)
<a href="url"><img src="https://github.com/pelinozsezer/CBD/blob/main/Chronic/Slope-Analysis-Sleep-Stages/pipeline.png" height="300" width="400" ></a>

------------------------------------

- **powspctrm_all_chronics.m:** Computes power spectrum of REM and NonREM sleep stages.

- **save_slope_chronics.m:** Outputs and saves power spectrum values to be used for slope analysis.

- **slope-analysis-chronics.py:** Runs slope analysis on power spectrum.

- **stats_chronics.m:** Arranges the data (i.e., slopes and offset) for SPSS to run statistics.


