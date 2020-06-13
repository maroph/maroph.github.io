# maroph.github.io
My personal GitHub site

---

## How I create the pages on site maroph.github.io
My pages are written in Markdown (directory mkdocs/docs-src) an transformed
into HTML pages (directory docs) with the mkdocs Python module. Because the mkdocs 
module on my Debian 10 system is pretty old (1.0.4) I use a virtual environment with
the current mkdocs module.

## Check the build environment

    mkdocs/build check

## Create the virtual environment

    mkdocs/build venv
    source mkdocs/venv/bin/activate

### Install missing Python3 software
If pip for Python3 and/or the Python3 venv module aren't installed on your system
use the following commands as administrator (root):

    sudo apt install python3-pip
    sudo apt install python3-venv

### How the virtual environment is created
The following commands are used to build the needed virtual environment:

    cd mkdocs
    python3 -m venv ./venv
    source ./venv/bin/activate
    python -m pip install --upgrade pip
    python -m pip install --upgrade setuptools
    python -m pip install --upgrade wheel
    python -m pip install --requirement ./requirements.txt

##  Build the docs for testing

    cd mkdocs
    source venv/bin/activate
    mkdocs build

The HTML files will be created in the directory mkdocs/docs. This directory is added 
to the .gitignore file.

## Build the docs for pushing

    mkdocs/build
    git commit -m "my commit message"
    git push

## Get hash of last commit

    git rev-parse [--short] HEAD

