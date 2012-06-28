#!/bin/bash
#
# Create a virtualenv named "venv" for use with Emacs.
#
# Usage:
#    ./create-virtualenv <path to python executable>
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

# Install other Python packages
venv/bin/pip install http://bitbucket.org/agr/ropemacs/get/tip.tar.gz
venv/bin/pip install pyflakes==0.5.0
venv/bin/pip install pep8==1.0.1

set +x
