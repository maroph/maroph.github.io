# This Site
This is my main GitHub Page. The data are stored in my GitHub repository
[maroph/maroph.github.io](https://github.com/maroph/maroph.github.io).

## How I create the pages on this site
My pages are written in Markdown (directory docs) an transformed into HTML 
pages (local directory site) with the [MkDocs](https://www.mkdocs.org/)
static site generator. The site data are published in the gh-pages branch 
of the directory.

### Python modules in use to produce this site:

* [MkDocs]{:target="blank"}
* [Material for MkDocs]{:target="blank"}
* MkDocs plugin [mkdocs-git-revision-date-localized-plugin]{:target="blank"}
* MkDocs plugin [mkdocs-macros-plugin]{:target="blank"}

[MkDocs]: https://pypi.org/project/mkdocs/
[Material for MkDocs]: https://pypi.org/project/mkdocs-material/
[mkdocs-git-revision-date-localized-plugin]: https://pypi.org/project/mkdocs-git-revision-date-localized-plugin/
[mkdocs-macros-plugin]: https://pypi.org/project/mkdocs-macros-plugin/

## Python Virtual Environment
I use a virtual environment with the above Python modules.

### How the virtual environment is created
The following commands are used to build.bash the needed virtual environment:

```bash
$ python3 -m venv ./venv
$ source ./venv/bin/activate
$ python -m pip install --upgrade pip
$ python -m pip install --upgrade setuptools
$ python -m pip install --upgrade wheel
$ python -m pip install --upgrade mkdocs-material
$ python -m pip install --upgrade mkdocs-git-revision-date-localized-plugin
$ python -m pip install --upgrade mkdocs-macros-plugin
```

The current installed module versions are:

```
mkdocs==1.6.1
mkdocs-get-deps==0.2.0
mkdocs-git-revision-date-localized-plugin==1.3.0
mkdocs-macros-plugin==1.3.7
mkdocs-material==9.5.42
mkdocs-material-extensions==1.3.1
```

### Create the virtual environment with the build.bash script

```bash
$ ./build.bash venv
$ source ./venv/bin/activate
```

### Install missing Python3 software
If pip for Python3 and/or the Python3 venv module aren't installed on your system
use the following commands as administrator (root):

```bash
$ sudo apt install python3-pip
$ sudo apt install python3-venv
```

##  Build the docs

```bash
$ source venv/bin/activate
$ mkdocs build
```

or

```bash
$ ./build.bash
```

##  Build the docs for testing
```
$ source venv/bin/activate
$ ./build.bash serve
build.bash: check for needed Python modules
----------
Name: mkdocs
Version: 1.6.1

Name: mkdocs-material
Version: 9.5.42

Name: mkdocs-git-revision-date-localized-plugin
Version: 1.3.0
----------

Name: mkdocs-macros-plugin
Version: 1.3.7
----------

build.bash: mkdocs serve
INFO    -  Building documentation...
INFO    -  Cleaning site directory
INFO    -  Documentation built in 0.35 seconds
INFO    -  [10:03:56] Watching paths for changes: 'docs', 'mkdocs.yml'
INFO    -  [10:03:56] Serving on http://127.0.0.1:8000/

shutdown MkDocs server: ./mkdocs.shut
```


## Build the docs for publishing
The build step is done by the GitHub Actions 
file _.github/workflows/ci.yml_ by every checkin in
the branch.

### Old way: MkDocs deploy

```bash
$ source venv/bin/activate
$ ./build.bash deploy
```

```bash
$ git commit -m "my commit message"
$ git push
```
