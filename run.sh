#!/bin/bash

if [ ! -d "env" ]; then
    echo "Creating virtual environment and installing dependencies..."
    python3 -m venv env
    source env/bin/activate
    pip install -r requirements.txt
    ipython kernel install --user --name=localenv
else
    source env/bin/activate # all dependencies assumed to be installed
fi

echo "Local environment set up!"

# check for data directory, if not present, download and unpack movielens dataset

if [ ! -d data ]; then
    echo "Downloading and unpacking dSata..."
    mkdir data
fi

cd data

if [ ! -f ml-latest.zip ]; then
    wget https://files.grouplens.org/datasets/movielens/ml-latest.zip
fi

if [ ! -d raw ]; then
    unzip ml-latest.zip -d ./raw
fi

cd ..
echo "Data ready!"

# set up directory for logging results and saving models
if [ ! -d output ]; then
    mkdir output
    mkdir output/model
fi


echo "Environment all set! Feel free to use notebook.ipynb to reproduce the results."