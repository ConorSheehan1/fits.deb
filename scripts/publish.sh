#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd $SCRIPTPATH/..
dput -f ppa:conorsheehan1/fits-ppa fits_1.4.0-1_source.changes
