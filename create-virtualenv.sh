#!/bin/sh

virtualenv venv
venv/bin/pip install https://github.com/pinard/Pymacs/tarball/v0.23
venv/bin/pip install http://bitbucket.org/agr/ropemacs/get/tip.tar.gz
venv/bin/pip install pyflakes
venv/bin/pip install pep8
