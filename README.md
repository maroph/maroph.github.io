# maroph.github.io
My personal GitHub site

---

## How I create the pages on site maroph.github.io
My pages are written in Markdown (directory mkdocs/docs-src) an transformed
into HTML pages (directory docs) with the mkdocs Python module. Because the mkdocs 
module on my Debian 10 system is pretty old (1.0.4) I use a virtual environment with
the current mkdocs module.

## Create the virtual environment

    cd mkdocs
    ./build venv
    source venv/bin/activate

##  Build the docs for testing

    cd mkdocs
    source venv/bin/activate
    mkdocs build

## Build the docs for pushing

    cd mkdocs
    ./build
    git commit -m "my commit message"
    git push

