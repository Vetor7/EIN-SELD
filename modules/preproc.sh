#!/bin/bash

set -e

CONFIG_FILE='./modules/ein_seld/seld.yaml'

# Extract data
python modules/main.py -c $CONFIG_FILE preprocess --preproc_mode='extract_data' --dataset_type='dev'
python modules/main.py -c $CONFIG_FILE preprocess --preproc_mode='extract_data' --dataset_type='eval'

# Extract scalar
python modules/main.py -c $CONFIG_FILE preprocess --preproc_mode='extract_scalar' --num_workers=8
# Extract meta
python modules/main.py -c $CONFIG_FILE preprocess --preproc_mode='extract_meta' --dataset_type='dev'
python modules/main.py -c $CONFIG_FILE preprocess --preproc_mode='extract_meta' --dataset_type='eval'
