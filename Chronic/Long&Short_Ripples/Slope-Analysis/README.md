# :sparkles: Slope Analysis :sparkles:
:pushpin: **Requirements**: [FOOOF - fitting oscillations & one over f](https://fooof-tools.github.io/fooof/), [numpy](https://github.com/numpy/numpy), [scipy](https://github.com/scipy/scipy), [FieldTrip](https://github.com/fieldtrip/fieldtrip), [N-dimensional histogram](https://www.mathworks.com/matlabcentral/fileexchange/23897-n-dimensional-histogram), [Image Processing Toolbox](https://www.mathworks.com/products/image.html), [Statistics and Machine Learning Toolbox](https://www.mathworks.com/products/statistics.html), [Signal Processing Toolbox](https://www.mathworks.com/products/signal.html), [Deep Learning HDL Toolbox](https://www.mathworks.com/products/deep-learning-hdl.html), [Wavelet Toolbox](https://www.mathworks.com/products/wavelet.html), [Symbolic Math Toolbox](https://www.mathworks.com/products/symbolic.html), [Computer Vision Toolbox](https://www.mathworks.com/products/computer-vision.html), [Bioinformatics Toolbox](https://www.mathworks.com/products/bioinfo.html).

:pushpin: Makes use of functions from [FieldTrip](https://github.com/fieldtrip/fieldtrip), [OpenEphys](https://github.com/open-ephys/analysis-tools), and 	[ADRITOOLS](https://github.com/Aleman-Z/ADRITOOLS). 

------------------------------------
## Pipeline (In Order)
<a href="url"><img src="https://github.com/pelinozsezer/CBD/blob/main/Chronic/Long%26Short_Ripples/Slope-Analysis/pipeline.png" align="center" height="150" width="350" ></a>
------------------------------------

- **spectra_PFC/HPC.m:** Computes power spectrum with x and y axes in logarithms with a base of 10. For _Short Ripples vs Long Ripples_ per treatment.

- **spectra_nonloggedx_PFC/HPC.m** Computes power spectrum with only y axis in logarithms with a base of 10. For _Short Ripples vs Long Ripples_ per treatment.

- **spectra_altogether_nonloggedx_PFC.m** Computes power spectrum with only y axis in logarithms with a base of 10. For _Baselines vs Ripples_ per treatment.

- **save_slope_PFC/HPC.m:** Outputs and saves power spectrum values to be used for slope analysis.

- **slope-analysis-PFC/HPC.py:** Runs slope analysis on power spectrum.

- **stats_PFC/HPC.m:** Arranges the data (i.e., slopes and offset) for SPSS to run statistics.



