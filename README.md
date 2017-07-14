# SPCUP 2016

Make sure that you are in correct branch before moving forward

This repo's main aim is to classify given a ".wav" file

# Requirements

Matlab ( with NN toolbox and GUI support)

# Run

1) Download [mat_file](https://drive.google.com/file/d/0Bz0pFiirq_AkSEtyQWxvWHZ2S0E/view?usp=sharing) into spcup_software folder

2) cd spcup_software

3) Run "main.m" in Matlab (gui should popup)

4) Click on "BROWSE" and point to ".wav" file which should be classified

5) Another window popups which mentions to what class it belongs to.

# Some important files

## ComputeNominal.m
    Computes the nominal (whether it is a 50hz or 60hz grid)
## power_or_audio.m
    Computes ratio with which we can classify whether it is power or audio file
## ClassificationNN_Power.m
    Computes the final class to which the power ".wav" file belongs.(needs even nominal)
## ClassificationNN_audio.m
    Computes the final class to which the power ".wav" file belongs.(needs even nominal)

# Training

For training you can use the dataset by SPCUP-2016 people and reproduce the training condition stated in our paper.

## Pretrained models : 
    "net_50.mat" - 50hz power
    "net_60.mat" - 60hz power
    "Net_audio_50.mat" - 50hz audio
    "Net_audio_60.mat" - 60hz audio
