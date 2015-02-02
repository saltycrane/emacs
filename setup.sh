#!/bin/bash
#
# Create a virtualenv named "venv" for use with Emacs.
#
# Also compile helm elc files.
#
# Installs:
#  - ropemacs (http://rope.sourceforge.net/ropemacs.html)
#  - pyflakes (http://pypi.python.org/pypi/pyflakes/)
#  - pep8 (http://pypi.python.org/pypi/pep8/)
#
# Usage:
#    ./setup.sh <path to python executable>
#
# Example:
#    ./setup.sh /usr/bin/python

set -x
set -e

if [ "$#" -ne 1 ]
then
    echo "Error: script takes 1 argument"
    exit 1
fi

# Create virtualenv
virtualenv --python=$1 venv

# Install Pymacs
source ./venv/bin/activate
tar zxvf ./src/Pymacs-0.25.tar.gz

## python part
pushd Pymacs-0.25
make install
popd

## emacs part
rm -f ./vendor/pymacs.el*
cp ./Pymacs-0.25/pymacs.el ./vendor/pymacs.el
/usr/bin/emacs --batch -f batch-byte-compile ./vendor/pymacs.el

rm -rf ./Pymacs-0.25
deactivate

# Install other Python packages
./venv/bin/pip install ./src/python-rope-ropemacs-a6b7f1d.tar.gz
./venv/bin/pip install ./src/pyflakes-0.8.1.tar.gz
./venv/bin/pip install ./src/pep8-1.5.7.tar.gz
./venv/bin/pip install ./src/Jinja2-2.6.tar.gz
./venv/bin/pip install ./src/ipython-0.13.1.tar.gz
./venv/bin/pip install ./src/ipdb-0.7.tar.gz

# Install emacs helm (not a python package)
pushd vendor/helm-1.6.6
make
popd

set +x
