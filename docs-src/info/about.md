# About
This is my personal GitHub site.

The data are stored in my GitHub repository 
[maroph/maroph.github.io](https://github.com/maroph/maroph.github.io).

## How I create the pages on site maroph.github.io
My pages are written in Markdown (directory docs-src) an transformed into HTML 
pages (directory docs) with the [mkdocs](https://www.mkdocs.org/) Python module.

Because the mkdocs module on my Debian 10 system is pretty old (1.0.4) I use a 
virtual environment with a current mkdocs module.

My current mkdocs version is **1.2.1**

## Check the build environment

    ./build check

## Create the virtual environment

    ./build venv
    source ./venv/bin/activate

### Install missing Python3 software
If pip for Python3 and/or the Python3 venv module aren't installed on your system
use the following commands as administrator (root):

    sudo apt install python3-pip
    sudo apt install python3-venv

### How the virtual environment is created
The following commands are used to build the needed virtual environment:

    python3 -m venv ./venv
    source ./venv/bin/activate
    python -m pip install --upgrade pip
    python -m pip install --upgrade setuptools
    python -m pip install --upgrade wheel
    python -m pip install --upgrade mkdocs

##  Build the docs for testing

    source venv/bin/activate
    mkdocs build

## Build the docs for pushing

    source venv/bin/activate
    ./build
    git commit -m "my commit message"
    git push

## Get hash of last commit

    git rev-parse [--short] HEAD

