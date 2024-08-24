#!/bin/bash

set -e

CONFIG_FILE='./modules/ein_seld/seld.yaml'

python modules/main.py -c $CONFIG_FILE evaluate