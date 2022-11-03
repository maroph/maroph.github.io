#!/bin/bash
#
#
##############################################
# Copyright (c) 2022 by Manfred Rosenboom    #
#                                            #
# This work is licensed under a MIT License. #
# https://choosealicense.com/licenses/mit/   #
##############################################
#
SCRIPT_NAME=`basename $0`
SCRIPT_DIR=`dirname $0`
VERSION="${SCRIPT_NAME}  1  (03-NOV-2022)"
#
###############################################################################
#
export LANG="en_US.UTF-8"
#
###############################################################################
#
print_usage() {
    cat - <<EOT

Usage: ${SCRIPT_NAME} [option(s)] [venv|deploy]
       Call mkdocs to build the maroph.github.io related files

Options:
  -h|--help       : show this help and exit
  -V|--version    : show version information and exit
  -c|--check-only : check for needed Python3 modules and exit
  -n|--no-check   : no check for needed Python3 modules

  Arguments
  venv          : create the required virtual environment and exit
  deploy        : create the site and push all data to branch gh-pages
                  (mkdocs gh-deploy)

  Default: call 'mkdocs build'

EOT
}
#
###############################################################################
#
cwd=`pwd`
if [ "${SCRIPT_DIR}" = "." ]
then
    SCRIPT_DIR=$cwd
else
    cd ${SCRIPT_DIR}
    SCRIPT_DIR=`pwd`
    cd $cwd
fi
cwd=
unset cwd
#
###############################################################################
#
check=1
checkOnly=0
while :
do
    option=$1
    case "$1" in
        -h | --help)    
            print_usage
            exit 0
            ;;
        -V | --version)
            echo ${VERSION}
            exit 0
            ;;
        -c | --check-only)
            checkOnly=1
            ;;
        -n | --no-check)
            check=0
            ;;
        --)
            shift 1
            break
            ;;
        --*)
            echo "${SCRIPT_NAME}: '$1' : unknown option"
            exit 1
            ;;
        -*)
            echo "${SCRIPT_NAME}: '$1' : unknown option"
            exit 1
            ;;
        *)  break;;
    esac
#
    shift 1
done
#
###############################################################################
#
cd ${SCRIPT_DIR} || exit 1
#
###############################################################################
#
if [ "$1" = "venv" ]
then
    if [ "${VIRTUAL_ENV}" != "" ]
    then
        echo "${SCRIPT_NAME}: deactivate the current virtual environment"
        echo "${SCRIPT_NAME}: \$VIRTUAL_ENV : ${VIRTUAL_ENV}"
        exit 1
    fi
#
    rm -fr ${SCRIPT_DIR}/venv
    echo "${SCRIPT_NAME}: python3 -m venv v --prompt ven venv"
    python3 -m venv --prompt venv ${SCRIPT_DIR}/venv || exit 1
    echo "${SCRIPT_NAME}: . venv/bin/activate"
    . ${SCRIPT_DIR}/venv/bin/activate
#
    echo "${SCRIPT_NAME}: python -m pip install --upgrade pip"
    python -m pip install --upgrade pip || exit 1
    echo "${SCRIPT_NAME}: python -m pip install --upgrade setuptools"
    python -m pip install --upgrade setuptools || exit 1
    echo "${SCRIPT_NAME}: python -m pip install --upgrade wheel"
    python -m pip install --upgrade wheel || exit 1
    echo "${SCRIPT_NAME}: python -m pip install --upgrade mkdocs"
    python -m pip install --upgrade mkdocs || exit 1
    echo "${SCRIPT_NAME}: python -m pip install --upgrade mkdocs-material"
    python -m pip install --upgrade mkdocs-material || exit 1
    echo "${SCRIPT_NAME}: python -m pip install --upgrade mkdocs-git-revision-date-plugin"
    python -m pip install --upgrade mkdocs-git-revision-date-plugin || exit 1
#
    echo "${SCRIPT_NAME}: python -m pip freeze >requirements.txt"
    python -m pip freeze >${SCRIPT_DIR}/venv/requirements.txt || exit 1
#
    exit 0
fi
#
###############################################################################
#
if [ "${VIRTUAL_ENV}" = "" ]
then
    echo "${SCRIPT_NAME}: no virtual environment active"
    if [ ! -d ${SCRIPT_DIR}/venv ]
    then
        echo "${SCRIPT_NAME}: directory ${SCRIPT_DIR}/venv missing"
        echo "${SCRIPT_NAME}: call first 'build venv'"
        exit 1
    fi
#
    if [ ! -r ${SCRIPT_DIR}/venv/bin/activate ]
    then
        echo "${SCRIPT_NAME}: script ${SCRIPT_DIR}/venv/bin/activate missing"
        exit 1
    fi
    . ${SCRIPT_DIR}/venv/bin/activate
fi
#
###############################################################################
#
if [ ${check} -eq 1 ]
then
#
    echo "${SCRIPT_NAME}: check for needed Python modules"
    echo "----------"
    data=$(python -m pip show mkdocs 2>/dev/null)
    if [ $? -ne 0 ]
    then
        echo "${SCRIPT_NAME}: Python module mkdocs not available"
        exit 1
    fi
    echo ${data} | awk '{ printf "%s %s\n%s %s\n", $1, $2, $3, $4;}'
    echo ""
#
    data=$(python -m pip show mkdocs-material 2>/dev/null)
    if [ $? -ne 0 ]
    then
        echo "${SCRIPT_NAME}: Python module mkdocs-material not available"
        exit 1
    fi
    echo ${data} | awk '{ printf "%s %s\n%s %s\n", $1, $2, $3, $4;}'
    echo ""
#
    data=$(python -m pip show mkdocs-git-revision-date-plugin 2>/dev/null)
    if [ $? -ne 0 ]
    then
        echo "${SCRIPT_NAME}: Python module mkdocs-git-revision-date-plugin not available"
        exit 1
    fi
    echo ${data} | awk '{ printf "%s %s\n%s %s\n", $1, $2, $3, $4;}'
    echo "----------"
    echo ""
#
    if [ ${checkOnly} -eq 1 ]
    then
        exit 0
    fi
#
fi
#
###############################################################################
#
if [ "$1" = "deploy" ]
then
    echo "${SCRIPT_NAME}: mkdocs gh-deploy"
    mkdocs gh-deploy || exit 1
    echo ""
    exit 0
fi
#
###############################################################################
#
echo "${SCRIPT_NAME}: mkdocs build"
mkdocs build || exit 1
echo ""
#
echo "${SCRIPT_NAME}: git status"
git status
#
###############################################################################
#
exit 0

