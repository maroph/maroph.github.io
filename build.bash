#!/bin/bash
#
####################################################
# Copyright (c) 2026 by Manfred Rosenboom          #
# https://maroph.github.io/ (maroph@pm.me)         #
#                                                  #
# This work is licensed under a CC-BY 4.0 License. #
# https://creativecommons.org/licenses/by/4.0/     #
####################################################
declare -r COPYRIGHT="Copyright (C) 2026 Manfred Rosenboom"
declare -r LICENSE="License: CC-BY 4.0 <https://creativecommons.org/licenses/by/4.0/>"
#
declare -r SCRIPT_NAME=$(basename $0)
declare -r VERSION="0.1.0"
declare -r VERSION_DATE="29-SEP-2026"
declare -r VERSION_STRING="${SCRIPT_NAME}  ${VERSION}  (${VERSION_DATE})"
#
###############################################################################
#
SCRIPT_DIR=`dirname $0`
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
declare -r SCRIPT_DIR
#
###############################################################################
#
declare -r use_markdown_exec=0
#
###############################################################################
#
if [ -d ${SCRIPT_DIR}/.git ]
then
    gitrepo=1
else
    gitrepo=0
fi
declare -r gitrepo
#
GHP_IMPORT=""
if [ -x $HOME/bin/ghp-import.bash ]
then
    GHP_IMPORT="$HOME/bin/ghp-import.bash"
fi

#
###############################################################################
#
export LANG="en_US.UTF-8"
#
check=1
checkOnly=0
force=0
port=8000
#
###############################################################################
#
print_usage() {
    cat - <<EOT

Usage: ${SCRIPT_NAME} [option(s)] [venv|build|deploy|serve|shut|status]
       Call zensical to build the site related files
       https://zensical.org/docs/get-started/

Options:
  -h|--help        : show this help and exit
  -V|--version     : show version information and exit
  -c|--check-only  : check for needed Python3 modules and exit
  -f|--force       : don't use option --strict for zensical build
  -n|--no-check    : no check for needed Python3 modules
  -p|--port <port> : serve: change port (default: ${port})

  Arguments
  venv          : create the required virtual environment and exit
  build         : create the site (default)
                  (zensical build)
  deploy        : create the site and push all data to branch gh-pages
                  (zensical build ; ghp-import - similar to: mkdocs gh-deploy)
  serve         : Run the Zensical builtin development server
                  (zensical serve)
                  Default URL: http://localhost:${port}
  shut          : shutdown Zensical development web server
  status        : show status of  Zensical development web server

  Default: call 'zensical build'

  Trace of git commands during deploy:

  GIT_TRACE=1 ${SCRIPT_NAME} deploy

EOT
}
#
###############################################################################
#
getpid() {
    pid=$(ps -opid,cmd | grep '/zensical' | grep -v grep | awk '{ print $1; }')
    echo "${pid}"
}
#
###############################################################################
#
while :
do
    option=$1
    case "$1" in
        -h | --help)    
            print_usage
            exit 0
            ;;
        -V | --version)
            echo "${VERSION_STRING}"
            echo "${COPYRIGHT}"
            echo "${LICENSE}"
            exit 0
            ;;
        -c | --check-only)
            checkOnly=1
            ;;
        -f | --force)
            force=1
            ;;
        -n | --no-check)
            check=0
            ;;
        -p | --port)
            shift
            if [ "$1" = "" ]
            then
                echo "${SCRIPT_NAME}: option ${option} : port number missing"
                exit 1
            fi
            if ! [[ "$1" =~ ^[1-9][0-9]*$ ]]
            then
                echo "${SCRIPT_NAME}: option ${option}: value is not a positive integer number"
                exit 1
            fi
            port=$1
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
if [ "$1" != "" ]
then
    case "$1" in
        venv) ;;
        build) ;;
        deploy) ;;
        serve) ;;
        shut)
            pid=$(getpid)
            if [ "${pid}" != "" ]
            then
                echo "${SCRIPT_NAME}: shutdown Zensical development web server"
                pkill -15 zensical || exit 1
            else
                echo "${SCRIPT_NAME}: Zensical server not running"
            fi
            exit 0
            ;;
        status)
            pid=$(getpid)
            if [ "${pid}" != "" ]
            then
                echo "${SCRIPT_NAME}: Zensical server running, pid: ${pid}"
            else
                echo "${SCRIPT_NAME}: Zensical server not running"
            fi
            exit 0
            ;;
        *)
            echo "${SCRIPT_NAME}: '$1' : unknown argument"
            exit 1
            ;;
    esac
fi
#
###############################################################################
#
cd ${SCRIPT_DIR} || exit 1
#
###############################################################################
#
if [ "$1" = "venv" ]
then
    pid=$(getpid)
    if [ "${pid}" != "" ]
    then
        echo "${SCRIPT_NAME}: Zensical server running, pid: ${pid}"
        exit 1
    fi
    #
    if [ "${VIRTUAL_ENV}" != "" ]
    then
        echo "${SCRIPT_NAME}: deactivate the current virtual environment"
        echo "${SCRIPT_NAME}: \$VIRTUAL_ENV : ${VIRTUAL_ENV}"
        exit 1
    fi
#
    rm -fr ${SCRIPT_DIR}/venv
    echo "${SCRIPT_NAME}: python3 -m venv --prompt venv venv"
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
#
    echo "${SCRIPT_NAME}: python -m pip install --upgrade zensical"
    python -m pip install --upgrade zensical || exit 1
#
    if [ ${use_markdown_exec} -eq 1 ]
    then
        echo "${SCRIPT_NAME}: python -m pip install --upgrade markdown-exec"
        python -m pip install --upgrade markdown-exec || exit 1
    fi
#
    echo "${SCRIPT_NAME}: python -m pip install --upgrade ghp-import"
    python -m pip install --upgrade ghp-import || exit 1
#
    echo "${SCRIPT_NAME}: python -m pip freeze >requirements.txt"
    python -m pip freeze >${SCRIPT_DIR}/venv/requirements.txt || exit 1
#
    echo ""
    echo ""
    echo "----------"
    cat ${SCRIPT_DIR}/venv/requirements.txt | sort
    echo "----------"
    echo ""
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
    data=$(python -m pip show zensical 2>/dev/null)
    if [ $? -ne 0 ]
    then
        echo "${SCRIPT_NAME}: Python module zensical not available"
        exit 1
    fi
    echo ${data} | awk '{ printf "%s %s\n%s %s\n", $1, $2, $3, $4;}'
    echo ""
#
    data=$(python -m pip show ghp-import 2>/dev/null)
    if [ $? -ne 0 ]
    then
        echo "${SCRIPT_NAME}: Python module ghp-import not available"
        exit 1
    fi
    echo ${data} | awk '{ printf "%s %s\n%s %s\n", $1, $2, $3, $4;}'
    echo "----------"
    echo ""
#
    if [ ${use_markdown_exec} -eq 1 ]
    then
        data=$(python -m pip show markdown-exec 2>/dev/null)
        if [ $? -ne 0 ]
        then
            echo "${SCRIPT_NAME}: Python module markdown-exec not available"
            exit 1
        fi
        echo ${data} | awk '{ printf "%s %s\n%s %s\n", $1, $2, $3, $4;}'
        echo "----------"
        echo ""
    fi
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
    if [ ${gitrepo} -eq 0 ]
    then
        echo "${SCRIPT_NAME}: current directory is not a Git repository"
        exit 1
    fi
#
    if [ "${GHP_IMPORT}" = "" ]
    then
        python3 -m pip show ghp-import >/dev/null 2>/dev/null
        if [ $? -ne 0 ]
        then
            echo "${SCRIPT_NAME}: Python module ghp-import not available"
            exit 1
        fi

#
        GHP_IMPORT="ghp-import"
    fi
#
    pid=$(getpid)
    if [ "${pid}" != "" ]
    then
        echo "${SCRIPT_NAME}: Zensical server running, pid: ${pid}"
        exit 1
    fi
#
    echo "${SCRIPT_NAME}: zensical build --clean --strict"
    zensical build --clean --strict || exit 1
    echo ""
#
    if [ -d docs/.well-known ]
    then
        if [ ! -d site/.well-known ]
        then
            cp -rp docs/.well-known site || exit 1
        else
            cp -p --update=older docs/.well-known/security*.txt site/.wel-known || exit 1
        fi
    fi
#
    # export GIT_TRACE=1
    # export GIT_CURL_VERBOSE=1
#
    echo "${SCRIPT_NAME}: ghp-import --no-jekyll --push --no-history ./site"
    ${GHP_IMPORT} --no-jekyll --push --no-history ./site || exit 1
    echo ""
    exit 0
fi
#
###############################################################################
#
if [ "$1" = "serve" ]
then
    pid=$(getpid)
    if [ "${pid}" != "" ]
    then
        echo "${SCRIPT_NAME}: Zensical server already running, pid: ${pid}"
        exit 1
    fi
    #
    # File Watcher
    # see: https://github.com/zensical/zensical/releases/tag/v0.0.28
    #
    # You can now opt into using a polling-based file watcher, 
    # which is particularly useful when running Docker on 
    # Windows, where filesystem event limitations (e.g., inotify 
    # constraints) can cause issues.
    ##### export ZENSICAL_POLL_WATCHER=1
    # The polling interval is configurable and defaults to 
    # 500 milliseconds (aligned with MkDocs behavior)
    ##### export ZENSICAL_POLL_INTERVAL=500
    #
    rm -fr ./.cache
    rm -fr ./site
    echo "${SCRIPT_NAME}: zensical serve --dev-addr "localhost:${port}" ..."
    zensical serve --dev-addr "localhost:${port}" &
    exit 0
fi
#
###############################################################################
#
if [ -r docs/assets/variables.yml ]
then
    grep zensical_version docs/assets/variables.yml >/dev/null 2>/dev/null
    if [ $? -ne 0 ]
    then
        echo "${SCRIPT_NAME}: ERROR: variable zensical_version missing in file docs/assets/variables.yml"
    else
        grep $(zensical --version) docs/assets/variables.yml >/dev/null 2>/dev/null
        if [ $? -ne 0 ]
        then
            echo "${SCRIPT_NAME}: WARN: update Zensical version in variable zensical_version in file docs/assets/variables.yml"
            echo "${SCRIPT_NAME}: WARN: current Zensical version: $(zensical --version)"
        fi
    fi
fi
#
###############################################################################
#
pid=$(getpid)
if [ "${pid}" != "" ]
then
    echo "${SCRIPT_NAME}: Zensical server running, pid: ${pid}"
    exit 1
fi
#
#
rm -fr ./.cache
rm -fr ./site
if [ ${force} -eq 1 ]
then
    echo "${SCRIPT_NAME}: zensical build --clean"
    zensical build --clean || exit 1
else
    echo "${SCRIPT_NAME}: zensical build --clean --strict"
    zensical build --clean --strict || exit 1
fi
echo ""
#
touch site/.nojekyll
chmod 640 site/.nojekyll
#
if [ -d docs/.well-known ]
then
    if [ ! -d site/.well-known ]
    then
        cp -rp docs/.well-known site || exit 1
    else
        cp -p --update=older docs/.well-known/security*.txt site/.wel-known || exit 1
    fi
fi
#
if [ -d ${SCRIPT_DIR}/.git ]
then
    echo "${SCRIPT_NAME}: git status"
    git status
fi
#
###############################################################################
#
exit 0

