#!/usr/bin/env bash

FLINT_DOC_DIR=$1

set -e

modules="\
    fmpz\
    fmpz_factor\
    fmpz_poly\
    fmpz_poly_factor\
    fmpz_mat\
    fmpz_lll\
    arf\
    arb\
    "

for module in $modules; do
    echo "Processing $module"
    bin/rst_to_pxd.py flint/$module --flint-doc-dir=$FLINT_DOC_DIR > src/flint/flintlib/$module.pxd
done
