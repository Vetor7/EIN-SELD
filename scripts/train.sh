#!/bin/bash

set -e

CONFIG_FILE='./configs/seld.yaml'

python modules/main.py -c $CONFIG_FILE train --seed=$(shuf -i 0-10000 -n 1) --num_workers=8
