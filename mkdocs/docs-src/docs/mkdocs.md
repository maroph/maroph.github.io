# Python3 mkdocs Module
With the help of the Python3 [mkdocs](https://www.mkdocs.org/) module you can create 
simple web sites written in 
[Markdown](https://daringfireball.net/projects/markdown/syntax).

## Setup a mkdocs Python3 Virtual Environment
I use the Python3 module venv to setup a virtual environment:

    $ python3 -m venv venv-mkdocs
    $ source venv-mkdocs/bin/activate
    (venv-mkdocs) $ python -m pip install --upgrade pip
    (venv-mkdocs) $ python -m pip install --upgrade setuptools
    (venv-mkdocs) $ python -m pip install --upgrade wheel
    (venv-mkdocs) $ python -m pip install --upgrade mkdocs
    (venv-mkdocs) $ python -m pip freeze >venv-mkdocs/requirements.txt

