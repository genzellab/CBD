# Pelin Ozsezer
 
# FOOOF SLOPE ANLAYSIS

# import required libraries
import numpy as np
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
!pip install fooof

from fooof import FOOOF
from fooof import FOOOFGroup
from fooof.sim.utils import set_random_seed
from fooof.plts.spectra import plot_spectrum
from fooof.plts.annotate import plot_annotated_model

# DATA
# import scipy.io as sio
# freq = sio.loadmat('/Users/pelinozsezer/Desktop/freq.mat')
# all_events_veh = sio.loadmat('all_events_veh.mat')
# print(freq.keys())
# freq=["freq"]
# print(freq)



##############
## ANALYSIS ##
##############

## VEHICLE ##

freq = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/freq.csv',
                   sep=',', header=None)
all_events_veh = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/power_spec_all_events_veh.csv', 
                                  sep=',', header=None)

# # transposed format
# freq = np.transpose(np.array(freq))
# all_events_veh = np.transpose(np.array(all_events_veh))

freq = np.array(freq)
all_events_veh = np.array(all_events_veh)

# squeeze
freq = np.squeeze(freq)
all_events_veh = np.squeeze(all_events_veh)


# Check the shape of data
freq.shape # must be e.g. (399,)
all_events_veh.shape  # must be e.g. (18392,399)

# Initialize a FOOOFGroup object, which accepts all the same settings as FOOOF
fg = FOOOFGroup(peak_width_limits=[1, 8], min_peak_height=0.05, verbose=False)

# Fit a group of power spectra with the .fit() method
fg.fit(freq, all_events_veh, [0, 100])

# Print out results
fg.print_results()
exps = fg.get_params('aperiodic_params', 'exponent')

# save
# convert array into dataframe
DF = pd.DataFrame(exps)
 
# save the dataframe as a csv file
DF.to_csv("slopes_PFCshal_all_events_veh.csv")


# OFFSETS
offsets_ = fg.get_params('aperiodic_params', 'offset')
DF = pd.DataFrame(offsets_)
DF.to_csv("offsets_PFCshal_all_events_veh.csv")








## CBD ##
freq = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/freq.csv',
                   sep=',', header=None)
all_events_cbd = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/power_spec_all_events_cbd.csv', 
                                  sep=',', header=None)

# # transposed format
# freq = np.transpose(np.array(freq))
# all_events_cbd = np.transpose(np.array(all_events_cbd))

freq = np.array(freq)
all_events_cbd = np.array(all_events_cbd)

# squeeze
freq = np.squeeze(freq)
all_events_cbd = np.squeeze(all_events_cbd)


# Check the shape of data
freq.shape # must be e.g. (399,)
all_events_cbd.shape  # must be e.g. (18392,399)

# Initialize a FOOOFGroup object, which accepts all the same settings as FOOOF
fg = FOOOFGroup(peak_width_limits=[1, 8], min_peak_height=0.05, verbose=False)

# Fit a group of power spectra with the .fit() method
fg.fit(freq, all_events_cbd, [0, 100])

# Print out results
fg.print_results()
exps = fg.get_params('aperiodic_params', 'exponent')

# save
# convert array into dataframe
DF = pd.DataFrame(exps)
 
# save the dataframe as a csv file
DF.to_csv("slopes_PFCshal_all_events_cbd.csv")


# OFFSETS
offsets_ = fg.get_params('aperiodic_params', 'offset')
DF = pd.DataFrame(offsets_)
DF.to_csv("offsets_PFCshal_all_events_cbd.csv")



















