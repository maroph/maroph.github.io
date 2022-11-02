# About
This is my personal GitHub site.

The data are stored in my [GitHub repository ](https://github.com/maroph/maroph.github.io).

## Bio
I work as a software lead developer for 
[Fujitsu Germany](https://www.fujitsu.com/de/) in the Munich Area.

At the moment I work mainly on the 
[SecDocs Archive Service](https://www.fujitsu.com/de/products/computing/servers/mainframe/bs2000/ccp/) 
project.

## Skills

* Databases  
  H2, Oracle DB/RAC, MariaDB, MySQL
* Languages  
  Dutch, English, German (native speaker)
* Operating Systems  
  Debian, SUSE SLES
* Programming Languages  
  Bash, C, Java, JavaScript, PHP, Python, SQL
* Servers  
  Apache Web Server, Tomcat, WildFly

You can contact me via 

* [Mastodon]{:target="blank" rel="me"}
* [Personal Home Page]{:target="blank"}

[Mastodon]: https://fosstodon.org/@maroph
[Personal Home Page]: https://manfred.rosenboom.name/

## Site Creation

### How I create the pages on site maroph.github.io
My pages are written in Markdown (directory docs) an transformed into HTML 
pages (local directory site) with the [MkDocs](https://www.mkdocs.org/) Python
module. The site data are published in the gh-pages branch of the directory.

#### Software in use to produce this site:

* [MkDocs]{:target="blank"}
* [Theme Material for MkDocs]{:target="blank"}
* [MkDocs plugin git-revision-date]{:target="blank"}

[MkDocs]: https://www.mkdocs.org/
[Theme Material for MkDocs]: https://squidfunk.github.io/mkdocs-material/
[MkDocs plugin git-revision-date]: https://github.com/zhaoterryy/mkdocs-git-revision-date-plugin/

### Python Virtual Environment
I use a virtual environment with the current MkDocs module.

#### How the virtual environment is created
The following commands are used to build the needed virtual environment:

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

#### Create the virtual environment with the build script

```bash
./build venv
source ./venv/bin/activate
```

#### Install missing Python3 software
If pip for Python3 and/or the Python3 venv module aren't installed on your system
use the following commands as administrator (root):

```bash
sudo apt install python3-pip
sudo apt install python3-venv
```

###  Build the docs for testing

```bash
source venv/bin/activate
mkdocs build
```

or

```bash
./build
```

### Build the docs for publishing

```bash
source venv/bin/activate
./build deploy
```

```bash
git commit -m "my commit message"
git push
```

### Get hash of last commit

```bash
git rev-parse [--short] HEAD
```

