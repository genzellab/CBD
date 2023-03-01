# Pelin Ozsezer
 
# FOOOF SLOPE ANLAYSIS

# import required libraries
import numpy as np
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
# pip install fooof

from fooof import FOOOF
from fooof import FOOOFGroup
from fooof.sim.utils import set_random_seed
from fooof.plts.spectra import plot_spectrum
from fooof.plts.annotate import plot_annotated_model


##############
## ANALYSIS ##
##############

freq = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis-chronics-Adrian/freq.csv',
                   sep=',', header=None)
events_pfc = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis-chronics-Adrian/power_spec_pfc.csv', 
                                  sep=',', header=None)
events_hpc = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis-chronics-Adrian/power_spec_hpc.csv', 
                                  sep=',', header=None)


freq = np.array(freq)
events_pfc = np.array(events_pfc)
events_hpc = np.array(events_hpc)

# squeeze
freq = np.squeeze(freq)

# Check the shape of data
freq.shape # must be e.g. (401,)
events_pfc.shape  # must be e.g. (400,401)

# Initialize a FOOOFGroup object, which accepts all the same settings as FOOOF
fg = FOOOFGroup(peak_width_limits=[1, 8], min_peak_height=0.05, verbose=False)

# Fit a group of power spectra with the .fit() method

# 1) PFC
fg.fit(freq, events_pfc, [0,100])
exps = fg.get_params('aperiodic_params', 'exponent')
DF = pd.DataFrame(exps)
DF.to_csv("slopes_pfc.csv")

offsets_ = fg.get_params('aperiodic_params', 'offset')
DF = pd.DataFrame(offsets_)
DF.to_csv("offsets_pfc.csv")

# 2) HPC
fg.fit(freq, events_hpc, [0,100])
exps = fg.get_params('aperiodic_params', 'exponent')
DF = pd.DataFrame(exps)
DF.to_csv("slopes_hpc.csv")

offsets_ = fg.get_params('aperiodic_params', 'offset')
DF = pd.DataFrame(offsets_)
DF.to_csv("offsets_hpc.csv")





