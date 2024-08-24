#!/bin/bash

set -e

# check bin requirement
command -v wget >/dev/null 2>&1 || { echo 'wget is missing' >&2; exit 1; }
command -v zip >/dev/null 2>&1 || { echo 'zip is missing' >&2; exit 1; }
command -v unzip >/dev/null 2>&1 || { echo 'unzip is missing' >&2; exit 1; }

# download dataset
Dataset_dir='dataset'
Dataset_raw=$Dataset_dir'/dataset_raw'
mkdir -p $Dataset_raw
data_dir=$Dataset_dir'/STARSS23'
mkdir -p $data_dir

unzip_if_not_exists() {
    zipfile=$1
    targetdir=$2
    if [ -d "$targetdir" ]; then
        echo "$targetdir already exists, skipping..."
    else
        unzip $zipfile -d $targetdir
    fi
}

unzip_if_not_exists $data_dir'/foa_dev.zip' $Dataset_raw'/foa_dev'
unzip_if_not_exists $data_dir'/mic_dev.zip' $Dataset_raw'/mic_dev'
unzip_if_not_exists $data_dir'/metadata_dev.zip' $Dataset_raw'/metadata_dev'
unzip_if_not_exists $data_dir'/foa_eval.zip' $Dataset_raw'/foa_eval'
unzip_if_not_exists $data_dir'/mic_eval.zip' $Dataset_raw'/mic_eval'