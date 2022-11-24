import scipy.io as sio
import numpy as np
import matplotlib.pyplot as plt
import pickle
from sklearn.decomposition import PCA
from scipy import signal
from scipy.io import savemat
import pandas as pd
from scipy.signal import hilbert, chirp
from scipy.signal import medfilt
from scipy import signal


def create_features(sw_belo, sw_pyr, duration_sw):

    fs = 600
    width = 6  # morlet2 width
    low_f = 1  # lowest frequency of interest
    high_f = 200  # highest frequency of interest
    freq = np.linspace(low_f, high_f, num=int(high_f / low_f))  # frequency resolution of time-frequency plot
    widths = width * fs / (2 * freq * np.pi)  # wavelet widths for all frequencies of interest

    insta_freq_sw = np.zeros((2, sw_belo.shape[0]))
    insta_freq_sw_morlet = np.zeros((2, sw_belo.shape[0]))
    envelope_sw = np.zeros((2, sw_belo.shape[0]))
    AUC_sw = np.zeros((2, sw_belo.shape[0]))
    duration_sw_ = np.zeros((sw_belo.shape[0],))

    for index in range(sw_belo.shape[0]):
        duration_sw_[index] = duration_sw[index, 0] + duration_sw[index, 1]
        if duration_sw_[index]  > 0:
            segment_index = np.arange(1800 - int(duration_sw[index, 0]), 1800 + int(duration_sw[index, 1]))
            data_signal = sw_belo[index, :]
            analytic_signal = hilbert(data_signal)
            amplitude_envelope = np.abs(analytic_signal)
            instantaneous_phase = np.unwrap(np.angle(analytic_signal))
            instantaneous_frequency = (np.diff(instantaneous_phase) / (2.0 * np.pi) * fs)
            instantaneous_frequency_filt = medfilt(instantaneous_frequency, 3)
            insta_freq_sw[0, index] = np.mean(instantaneous_frequency_filt[segment_index])
            envelope_sw[0, index] = np.sum(amplitude_envelope[segment_index])
            AUC_sw[0, index] = np.sum(np.abs(data_signal[segment_index]))

            cwtm = signal.cwt(data_signal, signal.morlet2, widths, w=width)
            segment = np.abs(np.sum(cwtm[:, segment_index], axis=1))
            x = np.dot(segment / np.sum(segment), freq)
            insta_freq_sw_morlet[0, index] = x

            data_signal = sw_pyr[index, :]
            analytic_signal = hilbert(data_signal)
            amplitude_envelope = np.abs(analytic_signal)
            instantaneous_phase = np.unwrap(np.angle(analytic_signal))
            instantaneous_frequency = (np.diff(instantaneous_phase) / (2.0 * np.pi) * fs)
            instantaneous_frequency_filt = medfilt(instantaneous_frequency, 3)
            insta_freq_sw[1, index] = np.mean(instantaneous_frequency_filt[segment_index])
            envelope_sw[1, index] = np.sum(amplitude_envelope[segment_index])
            AUC_sw[1, index] = np.sum(np.abs(data_signal[segment_index]))

            cwtm = signal.cwt(data_signal, signal.morlet2, widths, w=width)
            segment = np.abs(np.sum(cwtm[:, segment_index], axis=1))
            x = np.dot(segment / np.sum(segment), freq)
            insta_freq_sw_morlet[1, index] = x

    features_sw = np.zeros((sw_belo.shape[0], 9))
    features_sw[:, 0:2] = insta_freq_sw.T
    features_sw[:, 2:4] = insta_freq_sw_morlet.T
    features_sw[:, 4:6] = envelope_sw.T
    features_sw[:, 6:8] = AUC_sw.T
    features_sw[:, 8] = duration_sw_

    return features_sw

data_path= '/home/melisamc/Documentos/ripple/data/belo_pyr_output/'
data_path_output = '/home/melisamc/Documentos/ripple/data/features_meli/'

figure_path = '/home/melisamc/Documentos/ripple/figures/'

rat_ID_veh = [3,4,9,201,203,206,210,211,213]
rat_ID_cbd= [2,5,10,11,204,205,207,209,212,214]

for rat_number in range(len(rat_ID_veh)):
    data_file = 'GC_ratID' + str(rat_ID_veh[rat_number]) + '_veh_waveforms.mat'
    data = sio.loadmat(data_path + data_file)

    sw_belo = data['waveforms']['sw'][0,0]['belo'][0,0]
    sw_pyr = data['waveforms']['sw'][0,0]['pyr'][0,0]
    r_belo = data['waveforms']['r'][0,0]['belo'][0,0]
    r_pyr = data['waveforms']['r'][0,0]['pyr'][0,0]
    swr_belo = data['waveforms']['swr'][0,0]['belo'][0,0]
    swr_pyr = data['waveforms']['swr'][0,0]['pyr'][0,0]
    cswr_belo = data['waveforms']['cswr'][0,0]['belo'][0,0]
    cswr_pyr = data['waveforms']['cswr'][0,0]['pyr'][0,0]

    data_file_duration = 'GC_ratID' + str(rat_ID_veh[rat_number]) + '_veh.mat'
    duration = sio.loadmat(data_path + data_file_duration)

    duration_sw= np.diff(duration['duration']['sw'][0, 0], axis=1)
    features_sw = create_features(sw_belo, sw_pyr, duration_sw)
    duration_r= np.diff(duration['duration']['r'][0, 0], axis=1)
    features_r = create_features(r_belo, r_pyr, duration_r)
    duration_swr= np.diff(duration['duration']['swr'][0, 0], axis=1)
    features_swr = create_features(swr_belo, swr_pyr, duration_swr)
    duration_cswr= np.diff(duration['duration']['cswr'][0, 0], axis=1)
    features_cswr = create_features(cswr_belo, cswr_pyr, duration_cswr)

    total_number = features_sw.shape[0] + features_r.shape[0] + features_swr.shape[0] + features_cswr.shape[0]
    features = np.zeros((total_number,10))
    features[0:features_sw.shape[0],0:9] = features_sw
    features[0:features_sw.shape[0],9] = np.zeros((features_sw.shape[0],))
    features[features_sw.shape[0]:features_sw.shape[0]+features_r.shape[0],0:9] = features_r
    features[features_sw.shape[0]:features_sw.shape[0]+features_r.shape[0],9] = np.ones((features_r.shape[0],))
    features[features_sw.shape[0]+features_r.shape[0]:features_sw.shape[0]+features_r.shape[0]+features_swr.shape[0],0:9] = features_swr
    features[features_sw.shape[0]+features_r.shape[0]:features_sw.shape[0]+features_r.shape[0]+features_swr.shape[0],9] = np.ones((features_swr.shape[0],))*2
    features[features_sw.shape[0]+features_r.shape[0]+features_swr.shape[0]:features_sw.shape[0]+features_r.shape[0]+features_swr.shape[0]+features_cswr.shape[0],0:9] = features_cswr
    features[features_sw.shape[0]+features_r.shape[0]+features_swr.shape[0]:features_sw.shape[0]+features_r.shape[0]+features_swr.shape[0]+features_cswr.shape[0],9] = np.ones((features_cswr.shape[0],))*3


    data_file_output = 'GC_ratID' + str(rat_ID_veh[rat_number]) + '_veh_features.npy'
    np.save(data_path_output + data_file_output, features)



for rat_number in range(len(rat_ID_cbd)):
    data_file = 'GC_ratID' + str(rat_ID_cbd[rat_number]) + '_cbd_waveforms.mat'
    data = sio.loadmat(data_path + data_file)

    sw_belo = data['waveforms']['sw'][0,0]['belo'][0,0]
    sw_pyr = data['waveforms']['sw'][0,0]['pyr'][0,0]
    r_belo = data['waveforms']['r'][0,0]['belo'][0,0]
    r_pyr = data['waveforms']['r'][0,0]['pyr'][0,0]
    swr_belo = data['waveforms']['swr'][0,0]['belo'][0,0]
    swr_pyr = data['waveforms']['swr'][0,0]['pyr'][0,0]
    cswr_belo = data['waveforms']['cswr'][0,0]['belo'][0,0]
    cswr_pyr = data['waveforms']['cswr'][0,0]['pyr'][0,0]

    data_file_duration = 'GC_ratID' + str(rat_ID_cbd[rat_number]) + '_cbd.mat'
    duration = sio.loadmat(data_path + data_file_duration)

    duration_sw= np.diff(duration['duration']['sw'][0, 0], axis=1)
    features_sw = create_features(sw_belo, sw_pyr, duration_sw)
    duration_r= np.diff(duration['duration']['r'][0, 0], axis=1)
    features_r = create_features(r_belo, r_pyr, duration_r)
    duration_swr= np.diff(duration['duration']['swr'][0, 0], axis=1)
    features_swr = create_features(swr_belo, swr_pyr, duration_swr)
    duration_cswr= np.diff(duration['duration']['cswr'][0, 0], axis=1)
    features_cswr = create_features(cswr_belo, cswr_pyr, duration_cswr)

    total_number = features_sw.shape[0] + features_r.shape[0] + features_swr.shape[0] + features_cswr.shape[0]
    features = np.zeros((total_number,10))
    features[0:features_sw.shape[0],0:9] = features_sw
    features[0:features_sw.shape[0],9] = np.zeros((features_sw.shape[0],))
    features[features_sw.shape[0]:features_sw.shape[0]+features_r.shape[0],0:9] = features_r
    features[features_sw.shape[0]:features_sw.shape[0]+features_r.shape[0],9] = np.ones((features_r.shape[0],))
    features[features_sw.shape[0]+features_r.shape[0]:features_sw.shape[0]+features_r.shape[0]+features_swr.shape[0],0:9] = features_swr
    features[features_sw.shape[0]+features_r.shape[0]:features_sw.shape[0]+features_r.shape[0]+features_swr.shape[0],9] = np.ones((features_swr.shape[0],))*2
    features[features_sw.shape[0]+features_r.shape[0]+features_swr.shape[0]:features_sw.shape[0]+features_r.shape[0]+features_swr.shape[0]+features_cswr.shape[0],0:9] = features_cswr
    features[features_sw.shape[0]+features_r.shape[0]+features_swr.shape[0]:features_sw.shape[0]+features_r.shape[0]+features_swr.shape[0]+features_cswr.shape[0],9] = np.ones((features_cswr.shape[0],))*3


    data_file_output = 'GC_ratID' + str(rat_ID_cbd[rat_number]) + '_cbd_features.npy'
    np.save(data_path_output + data_file_output, features)
