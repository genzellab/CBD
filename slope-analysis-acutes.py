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

## REM ##

freq = pd.read_csv('/home/genzellab/Desktop/Pelin/november_periodograms/slope-analysis/acutes/freq.csv',
                   sep=',', header=None)
rem_cbd_PFC_acutes = pd.read_csv('/home/genzellab/Desktop/Pelin/november_periodograms/slope-analysis/acutes/rem_cbd_PFC_acutes.csv', 
                                  sep=',', header=None)

rem_cbd_HPC_acutes = pd.read_csv('/home/genzellab/Desktop/Pelin/november_periodograms/slope-analysis/acutes/rem_cbd_HPC_acutes.csv', 
                                  sep=',', header=None)

rem_veh_PFC_acutes = pd.read_csv('/home/genzellab/Desktop/Pelin/november_periodograms/slope-analysis/acutes/rem_veh_PFC_acutes.csv', 
                                  sep=',', header=None)

rem_veh_HPC_acutes = pd.read_csv('/home/genzellab/Desktop/Pelin/november_periodograms/slope-analysis/acutes/rem_veh_HPC_acutes.csv', 
                                  sep=',', header=None)



# # transposed format
# freq = np.transpose(np.array(freq))
# all_events_veh = np.transpose(np.array(all_events_veh))

freq = np.array(freq)
rem_cbd_PFC_acutes = np.array(rem_cbd_PFC_acutes)
rem_cbd_HPC_acutes = np.array(rem_cbd_HPC_acutes)
rem_veh_PFC_acutes = np.array(rem_veh_PFC_acutes)
rem_veh_HPC_acutes = np.array(rem_veh_HPC_acutes)


# squeeze
freq = np.squeeze(freq)
rem_cbd_PFC_acutes = np.squeeze(rem_cbd_PFC_acutes)
rem_cbd_HPC_acutes = np.squeeze(rem_cbd_HPC_acutes)
rem_veh_PFC_acutes = np.squeeze(rem_veh_PFC_acutes)
rem_veh_HPC_acutes = np.squeeze(rem_veh_HPC_acutes)


# Check the shape of data
freq.shape # must be e.g. (2049,)
rem_cbd_PFC_acutes.shape  # must be e.g. (34,2049)

# Initialize a FOOOFGroup object, which accepts all the same settings as FOOOF
fg1 = FOOOFGroup(peak_width_limits=[1, 8], min_peak_height=0.05, verbose=False)
fg2 = FOOOFGroup(peak_width_limits=[1, 8], min_peak_height=0.05, verbose=False)
fg3 = FOOOFGroup(peak_width_limits=[1, 8], min_peak_height=0.05, verbose=False)
fg4 = FOOOFGroup(peak_width_limits=[1, 8], min_peak_height=0.05, verbose=False)


# Fit a group of power spectra with the .fit() method
fg1.fit(freq, rem_cbd_PFC_acutes , [0, 100])
fg2.fit(freq, rem_cbd_HPC_acutes , [0, 100])
fg3.fit(freq, rem_veh_PFC_acutes , [0, 100])
fg4.fit(freq, rem_veh_HPC_acutes , [0, 100])

# Print out results
fg1.print_results()
exps1 = fg1.get_params('aperiodic_params', 'exponent')
exps2 = fg2.get_params('aperiodic_params', 'exponent')
exps3 = fg3.get_params('aperiodic_params', 'exponent')
exps4 = fg4.get_params('aperiodic_params', 'exponent')

# save
# convert array into dataframe
DF1 = pd.DataFrame(exps1)
DF2 = pd.DataFrame(exps2)
DF3 = pd.DataFrame(exps3)
DF4 = pd.DataFrame(exps4)
 
# save the dataframe as a csv file
DF1.to_csv("slopes_rem_cbd_PFC_acutes.csv")
DF2.to_csv("slopes_rem_cbd_HPC_acutes.csv")
DF3.to_csv("slopes_rem_veh_PFC_acutes.csv")
DF4.to_csv("slopes_rem_veh_HPC_acutes.csv")

# OFFSETS
offsets1_ = fg1.get_params('aperiodic_params', 'offset')
DF1 = pd.DataFrame(offsets1_)
DF1.to_csv("offsets_rem_cbd_PFC_acutes.csv")

offsets2_ = fg2.get_params('aperiodic_params', 'offset')
DF2 = pd.DataFrame(offsets2_)
DF2.to_csv("offsets_rem_cbd_HPC_acutes.csv")

offsets3_ = fg3.get_params('aperiodic_params', 'offset')
DF3 = pd.DataFrame(offsets3_)
DF3.to_csv("offsets_rem_veh_PFC_acutes.csv")

offsets4_ = fg4.get_params('aperiodic_params', 'offset')
DF4 = pd.DataFrame(offsets4_)
DF4.to_csv("offsets_rem_veh_HPC_acutes.csv")






## NREM ##

freq = pd.read_csv('/home/genzellab/Desktop/Pelin/november_periodograms/slope-analysis/acutes/freq.csv',
                   sep=',', header=None)
nrem_cbd_PFC_acutes = pd.read_csv('/home/genzellab/Desktop/Pelin/november_periodograms/slope-analysis/acutes/nrem_cbd_PFC_acutes.csv', 
                                  sep=',', header=None)

nrem_cbd_HPC_acutes = pd.read_csv('/home/genzellab/Desktop/Pelin/november_periodograms/slope-analysis/acutes/nrem_cbd_HPC_acutes.csv', 
                                  sep=',', header=None)

nrem_veh_PFC_acutes = pd.read_csv('/home/genzellab/Desktop/Pelin/november_periodograms/slope-analysis/acutes/nrem_veh_PFC_acutes.csv', 
                                  sep=',', header=None)

nrem_veh_HPC_acutes = pd.read_csv('/home/genzellab/Desktop/Pelin/november_periodograms/slope-analysis/acutes/nrem_veh_HPC_acutes.csv', 
                                  sep=',', header=None)



# # transposed format
# freq = np.transpose(np.array(freq))
# all_events_veh = np.transpose(np.array(all_events_veh))

freq = np.array(freq)
nrem_cbd_PFC_acutes = np.array(nrem_cbd_PFC_acutes)
nrem_cbd_HPC_acutes = np.array(nrem_cbd_HPC_acutes)
nrem_veh_PFC_acutes = np.array(nrem_veh_PFC_acutes)
nrem_veh_HPC_acutes = np.array(nrem_veh_HPC_acutes)


# squeeze
freq = np.squeeze(freq)
nrem_cbd_PFC_acutes = np.squeeze(nrem_cbd_PFC_acutes)
nrem_cbd_HPC_acutes = np.squeeze(nrem_cbd_HPC_acutes)
nrem_veh_PFC_acutes = np.squeeze(nrem_veh_PFC_acutes)
nrem_veh_HPC_acutes = np.squeeze(nrem_veh_HPC_acutes)


# Check the shape of data
freq.shape # must be e.g. (2049,)
nrem_cbd_PFC_acutes.shape  # must be e.g. (34,2049)

# Initialize a FOOOFGroup object, which accepts all the same settings as FOOOF
fg1 = FOOOFGroup(peak_width_limits=[1, 8], min_peak_height=0.05, verbose=False)
fg2 = FOOOFGroup(peak_width_limits=[1, 8], min_peak_height=0.05, verbose=False)
fg3 = FOOOFGroup(peak_width_limits=[1, 8], min_peak_height=0.05, verbose=False)
fg4 = FOOOFGroup(peak_width_limits=[1, 8], min_peak_height=0.05, verbose=False)


# Fit a group of power spectra with the .fit() method
fg1.fit(freq, nrem_cbd_PFC_acutes , [0, 100])
fg2.fit(freq, nrem_cbd_HPC_acutes , [0, 100])
fg3.fit(freq, nrem_veh_PFC_acutes , [0, 100])
fg4.fit(freq, nrem_veh_HPC_acutes , [0, 100])

# Print out results
fg1.print_results()
exps1 = fg1.get_params('aperiodic_params', 'exponent')
exps2 = fg2.get_params('aperiodic_params', 'exponent')
exps3 = fg3.get_params('aperiodic_params', 'exponent')
exps4 = fg4.get_params('aperiodic_params', 'exponent')

# save
# convert array into dataframe
DF1 = pd.DataFrame(exps1)
DF2 = pd.DataFrame(exps2)
DF3 = pd.DataFrame(exps3)
DF4 = pd.DataFrame(exps4)
 
# save the dataframe as a csv file
DF1.to_csv("slopes_nrem_cbd_PFC_acutes.csv")
DF2.to_csv("slopes_nrem_cbd_HPC_acutes.csv")
DF3.to_csv("slopes_nrem_veh_PFC_acutes.csv")
DF4.to_csv("slopes_nrem_veh_HPC_acutes.csv")

# OFFSETS
offsets1_ = fg1.get_params('aperiodic_params', 'offset')
DF1 = pd.DataFrame(offsets1_)
DF1.to_csv("offsets_nrem_cbd_PFC_acutes.csv")

offsets2_ = fg2.get_params('aperiodic_params', 'offset')
DF2 = pd.DataFrame(offsets2_)
DF2.to_csv("offsets_nrem_cbd_HPC_acutes.csv")

offsets3_ = fg3.get_params('aperiodic_params', 'offset')
DF3 = pd.DataFrame(offsets3_)
DF3.to_csv("offsets_nrem_veh_PFC_acutes.csv")

offsets4_ = fg4.get_params('aperiodic_params', 'offset')
DF4 = pd.DataFrame(offsets4_)
DF4.to_csv("offsets_nrem_veh_HPC_acutes.csv")







