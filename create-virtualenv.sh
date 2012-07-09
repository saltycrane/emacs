#!/bin/bash
#
# Create a virtualenv named "venv" for use with Emacs. Note: Python 2.7 is
# required for Jarvis.
#
# Installs:
#  - ropemacs (http://rope.sourceforge.net/ropemacs.html)
#  - pyflakes (http://pypi.python.org/pypi/pyflakes/)
#  - pep8 (http://pypi.python.org/pypi/pep8/)
#  - jarvis (http://madlag.github.com/jarvis/)
#
# OS level prerequisites:
#     sudo apt-get install libqt4-dev
#     sudo apt-get install libxml2-dev libxslt1-dev
#
# Usage:
#    ./create-virtualenv <path to python2.7 executable>
#
# Example:
#    ./create-virtualenv $HOME/lib/python-2.7.2/bin/python

set -x
set -e

if [ "$#" -ne 1 ]
then
    echo "Error: script takes 1 argument"
    exit 1
fi

# Create virtualenv
virtualenv --python=$1 venv

# Install Pymacs 0.25
source venv/bin/activate
tempdir=$(mktemp -d)
pushd $tempdir
wget -O tmp.tar.gz https://github.com/pinard/Pymacs/tarball/v0.25
tar zxvf tmp.tar.gz
pushd pinard-Pymacs-5989046
make install
popd
popd
rm -rf $tempdir
deactivate

# Install sip (for PyQt4 for jarvis)
source venv/bin/activate
tempdir=$(mktemp -d)
pushd $tempdir
curl http://www.riverbankcomputing.com/static/Downloads/sip4/sip-4.13.3.tar.gz | tar zxv
pushd sip-4.13.3
python configure.py
make
# Use sudo to install sip.h. ~/.emacs.d/venv/include/python2.7 -> /usr/include/python2.7
sudo make install
popd
popd
rm -rf $tempdir
deactivate

# Install PyQt4 (for jarvis)
source venv/bin/activate
tempdir=$(mktemp -d)
pushd $tempdir
curl http://www.riverbankcomputing.co.uk/static/Downloads/PyQt4/PyQt-x11-gpl-4.9.4.tar.gz | tar zxv
pushd PyQt-x11-gpl-4.9.4
python configure.py
make
make install
popd
popd
rm -rf $tempdir
deactivate

# Install other Python packages
venv/bin/pip install http://bitbucket.org/agr/ropemacs/get/tip.tar.gz
venv/bin/pip install pyflakes==0.5.0
venv/bin/pip install pep8==1.0.1
venv/bin/pip install https://github.com/saltycrane/jarvis/tarball/master
venv/bin/pip install Jinja2==2.6
venv/bin/pip install lxml==2.3.4

set +x
