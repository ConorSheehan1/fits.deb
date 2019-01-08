#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd $SCRIPTPATH/..

# use -f to force push even if package is already uploaded
dput ppa:conorsheehan1/fits-ppa fits_1.4.0-1_source.changes
