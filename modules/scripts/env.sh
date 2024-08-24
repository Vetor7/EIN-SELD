#!/bin/bash

set -e

anaconda_dir=/root/anaconda3

. $anaconda_dir'/etc/profile.d/conda.sh'
conda remove -n seld --all -y
conda create -n seld python=3.10 -y
conda activate seld

conda install -c anaconda pandas h5py ipython pyyaml pylint -y
conda install pytorch torchvision torchaudio pytorch-cuda=12.1 -c pytorch -c nvidia -y
conda install -c conda-forge librosa pudb tqdm ruamel.yaml -y
conda install -c omnia termcolor -y
pip install tensorboard
