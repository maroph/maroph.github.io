# OpenSSL
Last update: 31-MAY-2020

## Introduction
This document collects some samples about how to use the OpenSSL CLI tool openssl.

Software versions in use:

* Debian/Raspbian: 10.4
* OpenSSL: 1.1.1d (standard version on Debian/Raspbian 10) 

---

## Compile Current OpenSSL Versions
You will find the current version of OpenSSL 1.1.1 at 
<https://www.openssl.org/source/>.

You have to call the related config script before compiling the software.

The command

    $ make install

will compile and install the software. For historic reasons, the default installation 
directory is

    /usr/local/ssl

You can change this default by using one of the following options in calling the config script:

    --prefix=DIR  Install in DIR/bin, DIR/lib, DIR/include/openssl.
                  Configuration files used by OpenSSL will be in DIR/ssl
                  or the directory specified by --openssldir.
    
    --openssldir=DIR Directory for OpenSSL files. If no prefix is specified,
                     the library files and binaries are also installed there.

For more details read the INSTALL file of the distribution.

### OpenSSL 1.1.1g

    wget https://www.openssl.org/source/openssl-1.1.1g.tar.gz
    tar xvzf openssl-1.1.1g.tar.gz
    cd openssl-1.1.1g
    ./config
    make depend
    make
    LD_LIBRARY_PATH=. apps/openssl version
    OpenSSL 1.1.1g  21 Apr 2020

### OpenSSL 3.0 (not yet released)
OpenSSL 3.0 is still in development, but you can already download the
[OpenSSL 3.0 Alpha2](https://www.openssl.org/source/openssl-3.0.0-alpha2.tar.gz)
Release.

If you want to try the most recent version of OpenSSL 3.0 you have to clone the
related Git repository:

    git clone https://github.com/openssl/openssl.git
    cd openssl
    ./config
    make depend
    make
    LD_LIBRARY_PATH=. apps/openssl version
    OpenSSL 3.0.0-alpha3-dev  (Library: OpenSSL 3.0.0-alpha3-dev )

You can update your local Git repository with the following commands:

    git fetch --all --tags
    git pull
    make clean
    ./config
    make depend
    make
    LD_LIBRARY_PATH=. apps/openssl version
    OpenSSL 3.0.0-alpha3-dev  (Library: OpenSSL 3.0.0-alpha3-dev )

