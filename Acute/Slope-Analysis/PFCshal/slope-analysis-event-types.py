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

##############
## ANALYSIS ##
##############

## VEHICLE ##

# Baseline
freq = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/freq.csv',
                   sep=',', header=None)
baseline_veh = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/power_spec_baseline_veh.csv', 
                                  sep=',', header=None)

# # transposed format
# freq = np.transpose(np.array(freq))
# baseline_veh = np.transpose(np.array(baseline_veh))

freq = np.array(freq)
baseline_veh = np.array(baseline_veh)

# squeeze
freq = np.squeeze(freq)
baseline_veh = np.squeeze(baseline_veh)


# Check the shape of data
freq.shape # must be e.g. (399,)
baseline_veh.shape  # must be e.g. (18392,399)

# Initialize a FOOOFGroup object, which accepts all the same settings as FOOOF
fg = FOOOFGroup(peak_width_limits=[1, 8], min_peak_height=0.05, verbose=False)

# Fit a group of power spectra with the .fit() method
fg.fit(freq, baseline_veh, [0, 100])

# Print out results
fg.print_results()
exps = fg.get_params('aperiodic_params', 'exponent')

# save
# convert array into dataframe
DF = pd.DataFrame(exps)
 
# save the dataframe as a csv file
DF.to_csv("slopes_PFCshal_baseline_veh.csv")


# OFFSETS
offsets_ = fg.get_params('aperiodic_params', 'offset')
DF = pd.DataFrame(offsets_)
DF.to_csv("offsets_PFCshal_baseline_veh.csv")









# Ripple
freq = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/freq.csv',
                   sep=',', header=None)
ripple_veh = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/power_spec_ripple_veh.csv', 
                                  sep=',', header=None)

# # transposed format
# freq = np.transpose(np.array(freq))
# ripple_veh = np.transpose(np.array(ripple_veh))

freq = np.array(freq)
ripple_veh = np.array(ripple_veh)

# squeeze
freq = np.squeeze(freq)
ripple_veh = np.squeeze(ripple_veh)


# Check the shape of data
freq.shape # must be e.g. (399,)
ripple_veh.shape  # must be e.g. (18392,399)

# Initialize a FOOOFGroup object, which accepts all the same settings as FOOOF
fg = FOOOFGroup(peak_width_limits=[1, 8], min_peak_height=0.05, verbose=False)

# Fit a group of power spectra with the .fit() method
fg.fit(freq, ripple_veh, [0, 100])

# Print out results
fg.print_results()
exps = fg.get_params('aperiodic_params', 'exponent')

# save
# convert array into dataframe
DF = pd.DataFrame(exps)
 
# save the dataframe as a csv file
DF.to_csv("slopes_PFCshal_ripple_veh.csv")

# OFFSETS
offsets_ = fg.get_params('aperiodic_params', 'offset')
DF = pd.DataFrame(offsets_)
DF.to_csv("offsets_PFCshal_ripple_veh.csv")







# SW
freq = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/freq.csv',
                   sep=',', header=None)
sw_veh = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/power_spec_sw_veh.csv', 
                                  sep=',', header=None)

# # transposed format
# freq = np.transpose(np.array(freq))
# sw_veh = np.transpose(np.array(sw_veh))

freq = np.array(freq)
sw_veh = np.array(sw_veh)

# squeeze
freq = np.squeeze(freq)
sw_veh = np.squeeze(sw_veh)


# Check the shape of data
freq.shape # must be e.g. (399,)
sw_veh.shape  # must be e.g. (18392,399)

# Initialize a FOOOFGroup object, which accepts all the same settings as FOOOF
fg = FOOOFGroup(peak_width_limits=[1, 8], min_peak_height=0.05, verbose=False)

# Fit a group of power spectra with the .fit() method
fg.fit(freq, sw_veh, [0, 100])

# Print out results
fg.print_results()
exps = fg.get_params('aperiodic_params', 'exponent')

# save
# convert array into dataframe
DF = pd.DataFrame(exps)
 
# save the dataframe as a csv file
DF.to_csv("slopes_PFCshal_sw_veh.csv")

# OFFSETS
offsets_ = fg.get_params('aperiodic_params', 'offset')
DF = pd.DataFrame(offsets_)
DF.to_csv("offsets_PFCshal_sw_veh.csv")








# SWR
freq = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/freq.csv',
                   sep=',', header=None)
swr_veh = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/power_spec_swr_veh.csv', 
                                  sep=',', header=None)

# # transposed format
# freq = np.transpose(np.array(freq))
# swr_veh = np.transpose(np.array(swr_veh))

freq = np.array(freq)
swr_veh = np.array(swr_veh)

# squeeze
freq = np.squeeze(freq)
swr_veh = np.squeeze(swr_veh)


# Check the shape of data
freq.shape # must be e.g. (399,)
swr_veh.shape  # must be e.g. (18392,399)

# Initialize a FOOOFGroup object, which accepts all the same settings as FOOOF
fg = FOOOFGroup(peak_width_limits=[1, 8], min_peak_height=0.05, verbose=False)

# Fit a group of power spectra with the .fit() method
fg.fit(freq, swr_veh, [0, 100])

# Print out results
fg.print_results()
exps = fg.get_params('aperiodic_params', 'exponent')

# save
# convert array into dataframe
DF = pd.DataFrame(exps)
 
# save the dataframe as a csv file
DF.to_csv("slopes_PFCshal_swr_veh.csv")

# OFFSETS
offsets_ = fg.get_params('aperiodic_params', 'offset')
DF = pd.DataFrame(offsets_)
DF.to_csv("offsets_PFCshal_swr_veh.csv")









# Complex SWR
freq = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/freq.csv',
                   sep=',', header=None)
complex_swr_veh = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/power_spec_complex_swr_veh.csv', 
                                  sep=',', header=None)

# # transposed format
# freq = np.transpose(np.array(freq))
# complex_swr_veh = np.transpose(np.array(complex_swr_veh))

freq = np.array(freq)
complex_swr_veh = np.array(complex_swr_veh)

# squeeze
freq = np.squeeze(freq)
complex_swr_veh = np.squeeze(complex_swr_veh)


# Check the shape of data
freq.shape # must be e.g. (399,)
complex_swr_veh.shape  # must be e.g. (18392,399)

# Initialize a FOOOFGroup object, which accepts all the same settings as FOOOF
fg = FOOOFGroup(peak_width_limits=[1, 8], min_peak_height=0.05, verbose=False)

# Fit a group of power spectra with the .fit() method
fg.fit(freq, complex_swr_veh, [0, 100])

# Print out results
fg.print_results()
exps = fg.get_params('aperiodic_params', 'exponent')

# save
# convert array into dataframe
DF = pd.DataFrame(exps)
 
# save the dataframe as a csv file
DF.to_csv("slopes_PFCshal_complex_swr_veh.csv")

# OFFSETS
offsets_ = fg.get_params('aperiodic_params', 'offset')
DF = pd.DataFrame(offsets_)
DF.to_csv("offsets_PFCshal_complex_swr_veh.csv")


#########################################################################



## CBD ##
# Baseline
freq = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/freq.csv',
                   sep=',', header=None)
baseline_cbd = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/power_spec_baseline_cbd.csv', 
                                  sep=',', header=None)

# # transposed format
# freq = np.transpose(np.array(freq))
# baseline_cbd = np.transpose(np.array(baseline_cbd))

freq = np.array(freq)
baseline_cbd = np.array(baseline_cbd)

# squeeze
freq = np.squeeze(freq)
baseline_cbd = np.squeeze(baseline_cbd)


# Check the shape of data
freq.shape # must be e.g. (399,)
baseline_cbd.shape  # must be e.g. (18392,399)

# Initialize a FOOOFGroup object, which accepts all the same settings as FOOOF
fg = FOOOFGroup(peak_width_limits=[1, 8], min_peak_height=0.05, verbose=False)

# Fit a group of power spectra with the .fit() method
fg.fit(freq, baseline_cbd, [0, 100])

# Print out results
fg.print_results()
exps = fg.get_params('aperiodic_params', 'exponent')

# save
# convert array into dataframe
DF = pd.DataFrame(exps)
 
# save the dataframe as a csv file
DF.to_csv("slopes_PFCshal_baseline_cbd.csv")

# OFFSETS
offsets_ = fg.get_params('aperiodic_params', 'offset')
DF = pd.DataFrame(offsets_)
DF.to_csv("offsets_PFCshal_baseline_cbd.csv")







# Ripple
freq = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/freq.csv',
                   sep=',', header=None)
ripple_cbd = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/power_spec_ripple_cbd.csv', 
                                  sep=',', header=None)

# # transposed format
# freq = np.transpose(np.array(freq))
# ripple_cbd = np.transpose(np.array(ripple_cbd))

freq = np.array(freq)
ripple_cbd = np.array(ripple_cbd)

# squeeze
freq = np.squeeze(freq)
ripple_cbd = np.squeeze(ripple_cbd)


# Check the shape of data
freq.shape # must be e.g. (399,)
ripple_cbd.shape  # must be e.g. (18392,399)

# Initialize a FOOOFGroup object, which accepts all the same settings as FOOOF
fg = FOOOFGroup(peak_width_limits=[1, 8], min_peak_height=0.05, verbose=False)

# Fit a group of power spectra with the .fit() method
fg.fit(freq, ripple_cbd, [0, 100])

# Print out results
fg.print_results()
exps = fg.get_params('aperiodic_params', 'exponent')

# save
# convert array into dataframe
DF = pd.DataFrame(exps)
 
# save the dataframe as a csv file
DF.to_csv("slopes_PFCshal_ripple_cbd.csv")

# OFFSETS
offsets_ = fg.get_params('aperiodic_params', 'offset')
DF = pd.DataFrame(offsets_)
DF.to_csv("offsets_PFCshal_ripple_cbd.csv")





# SW
freq = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/freq.csv',
                   sep=',', header=None)
sw_cbd = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/power_spec_sw_cbd.csv', 
                                  sep=',', header=None)

# # transposed format
# freq = np.transpose(np.array(freq))
# sw_cbd = np.transpose(np.array(sw_cbd))

freq = np.array(freq)
sw_cbd = np.array(sw_cbd)

# squeeze
freq = np.squeeze(freq)
sw_cbd = np.squeeze(sw_cbd)


# Check the shape of data
freq.shape # must be e.g. (399,)
sw_cbd.shape  # must be e.g. (18392,399)

# Initialize a FOOOFGroup object, which accepts all the same settings as FOOOF
fg = FOOOFGroup(peak_width_limits=[1, 8], min_peak_height=0.05, verbose=False)

# Fit a group of power spectra with the .fit() method
fg.fit(freq, sw_cbd, [0, 100])

# Print out results
fg.print_results()
exps = fg.get_params('aperiodic_params', 'exponent')

# save
# convert array into dataframe
DF = pd.DataFrame(exps)
 
# save the dataframe as a csv file
DF.to_csv("slopes_PFCshal_sw_cbd.csv")

# OFFSETS
offsets_ = fg.get_params('aperiodic_params', 'offset')
DF = pd.DataFrame(offsets_)
DF.to_csv("offsets_PFCshal_sw_cbd.csv")








# SWR
freq = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/freq.csv',
                   sep=',', header=None)
swr_cbd = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/power_spec_swr_cbd.csv', 
                                  sep=',', header=None)

# # transposed format
# freq = np.transpose(np.array(freq))
# swr_cbd = np.transpose(np.array(swr_cbd))

freq = np.array(freq)
swr_cbd = np.array(swr_cbd)

# squeeze
freq = np.squeeze(freq)
swr_cbd = np.squeeze(swr_cbd)


# Check the shape of data
freq.shape # must be e.g. (399,)
swr_cbd.shape  # must be e.g. (18392,399)

# Initialize a FOOOFGroup object, which accepts all the same settings as FOOOF
fg = FOOOFGroup(peak_width_limits=[1, 8], min_peak_height=0.05, verbose=False)

# Fit a group of power spectra with the .fit() method
fg.fit(freq, swr_cbd, [0, 100])

# Print out results
fg.print_results()
exps = fg.get_params('aperiodic_params', 'exponent')

# save
# convert array into dataframe
DF = pd.DataFrame(exps)
 
# save the dataframe as a csv file
DF.to_csv("slopes_PFCshal_swr_cbd.csv")


# OFFSETS
offsets_ = fg.get_params('aperiodic_params', 'offset')
DF = pd.DataFrame(offsets_)
DF.to_csv("offsets_PFCshal_swr_cbd.csv")








# Complex SWR
freq = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/freq.csv',
                   sep=',', header=None)
complex_swr_cbd = pd.read_csv('/home/genzellab/Desktop/Pelin/slope-analysis/PFCshal/data/power_spec_complex_swr_cbd.csv', 
                                  sep=',', header=None)

# # transposed format
# freq = np.transpose(np.array(freq))
# complex_swr_cbd = np.transpose(np.array(complex_swr_cbd))

freq = np.array(freq)
complex_swr_cbd = np.array(complex_swr_cbd)

# squeeze
freq = np.squeeze(freq)
complex_swr_cbd = np.squeeze(complex_swr_cbd)


# Check the shape of data
freq.shape # must be e.g. (399,)
complex_swr_cbd.shape  # must be e.g. (18392,399)

# Initialize a FOOOFGroup object, which accepts all the same settings as FOOOF
fg = FOOOFGroup(peak_width_limits=[1, 8], min_peak_height=0.05, verbose=False)

# Fit a group of power spectra with the .fit() method
fg.fit(freq, complex_swr_cbd, [0, 100])

# Print out results
fg.print_results()
exps = fg.get_params('aperiodic_params', 'exponent')

# save
# convert array into dataframe
DF = pd.DataFrame(exps)
 
# save the dataframe as a csv file
DF.to_csv("slopes_PFCshal_complex_swr_cbd.csv")

# OFFSETS
offsets_ = fg.get_params('aperiodic_params', 'offset')
DF = pd.DataFrame(offsets_)
DF.to_csv("offsets_PFCshal_complex_swr_cbd.csv")





