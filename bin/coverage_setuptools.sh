#!/bin/bash

set -e

RC="--rcfile=.coveragerc.setuptools"

# Comment out various lines below for speed if running multiple times.

# See https://github.com/cython/cython/issues/6658
# Needed for Python 3.13 only
pip uninstall cython
pip install git+https://github.com/cython/cython.git@fdbca99

touch src/*/*/*.pyx
PYTHON_FLINT_COVERAGE=1 python setup.py build_ext --inplace
PYTHONPATH=src coverage run $RC -m flint.test
coverage report $RC -m --sort=cover
coverage html $RC
