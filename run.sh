#!/bin/bash

# if [ ! -d "env" ]; then
#     echo "Creating virtual environment and installing dependencies..."
#     python3 -m venv env
#     source env/bin/activate
#     pip install -r requirements.txt
# else
#     source env/bin/activate # all dependencies assumed to be installed
# fi

# echo "Local environment set up!"

# check for data directory, if not present, download and unpack movielens dataset

if [ ! -d "data" ]; then
    echo "Downloading and unpacking dSata..."
    mkdir data
    cd data
    wget https://files.grouplens.org/datasets/movielens/ml-latest.zip
    unzip ml-latest.zip
    cd ..
fi

echo "Data ready!"

# set up directory for logging results and saving models
if [ ! -d "output" ]; then
    mkdir output
    mkdir output/model
fi

# some evironment variables for reproducibility
export RANDOM_SEED=42
export DATA_DIR=data/ml-latest
export OUTPUT_DIR=output
export MODEL_DIR=output/model

echo "Environment all set! Feel free to use notebook.ipynb to reproduce the results."

jupyter notebook