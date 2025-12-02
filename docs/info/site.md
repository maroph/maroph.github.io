# This Site
This is my main GitHub Page. The data are stored in my GitHub repository
[maroph/maroph.github.io](https://github.com/maroph/maroph.github.io).

## How I create the pages on this site
My pages are written in Markdown (directory docs) an transformed into HTML 
pages (local directory site) with the [Zensical](https://www.zensical.org/)
static site generator. The site data are published in the gh-pages branch 
of the directory.

### Python modules in use to produce this site:

* [Zensical]{:target="blank"}
* [ghp-import]{:target="blank"}

[Zensical]: https://pypi.org/project/zensical/
[ghp-import]: https://pypi.org/project/ghp-import/

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
$ python -m pip install --upgrade zensical
$ python -m pip install --upgrade ghp-import
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
$ zensical build
```

or

```bash
$ source venv/bin/activate
$ ./build.bash
```

##  Build the docs for testing
```
$ source venv/bin/activate
$ ./build.bash serve
build.bash: check for needed Python modules
----------
Name: zensical
Version: 0.0.10

Name: ghp-import
Version: 2.1.0
----------

build.bash: zensical serve ...
Serving .../maroph.github.io/site on http://localhost:8000
Build started
+ /links/my_sites.html
+ /links/rankings.html
+ /links/github_pages.html
+ /links/gpt.html
+ /info/license.html
+ /info/sources.html
+ /links/software.html
+ /info/about.html
+ /index.html
+ /links.html
+ /links/security.html
+ /info/openpgp/openpgp.html
+ /info.html
+ /links/collaboration.html
+ /info/gdpr.html
+ /info/site.html

shutdown Zensical server: ./zensical.shut
```


## Build the docs for publishing
The build step is done by the GitHub Actions 
file _.github/workflows/ci.yml_ by every checkin in
the branch main.

### Manually: ghp-import deploy

```bash
$ source venv/bin/activate
$ ./build.bash deploy
```

```bash
$ git commit -m "my commit message"
$ git push
```
