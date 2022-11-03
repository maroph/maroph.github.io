# This Site
This is my main GitHub site.  The data are stored in my
[GitHub repository](https://github.com/maroph/maroph.github.io).

## How I create the pages on this site
My pages are written in Markdown (directory docs) an transformed into HTML 
pages (local directory site) with the [MkDocs](https://www.mkdocs.org/) Python
module. The site data are published in the gh-pages branch of the directory.

### Software in use to produce this site:

* [MkDocs]{:target="blank"}
* [Theme Material for MkDocs]{:target="blank"}
* [MkDocs plugin git-revision-date]{:target="blank"}

[MkDocs]: https://www.mkdocs.org/
[Theme Material for MkDocs]: https://squidfunk.github.io/mkdocs-material/
[MkDocs plugin git-revision-date]: https://github.com/zhaoterryy/mkdocs-git-revision-date-plugin/

## Python Virtual Environment
I use a virtual environment with the current MkDocs module.

### How the virtual environment is created
The following commands are used to build.bash the needed virtual environment:

```bash
python3 -m venv ./venv
source ./venv/bin/activate
python -m pip install --upgrade pip
python -m pip install --upgrade setuptools
python -m pip install --upgrade wheel
python -m pip install --upgrade mkdocs
python -m pip install --upgrade mkdocs-material
python -m pip install --upgrade mkdocs-git-revision-date-plugin
```

### Create the virtual environment with the build.bash script

```bash
./build.bash venv
source ./venv/bin/activate
```

### Install missing Python3 software
If pip for Python3 and/or the Python3 venv module aren't installed on your system
use the following commands as administrator (root):

```bash
sudo apt install python3-pip
sudo apt install python3-venv
```

##  Build the docs for testing

```bash
source venv/bin/activate
mkdocs build
```

or

```bash
./build.bash
```

## Build the docs for publishing

```bash
source venv/bin/activate
./build.bash deploy
```

```bash
git commit -m "my commit message"
git push
```

