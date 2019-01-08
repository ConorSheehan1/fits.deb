#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
sudo apt install $SCRIPTPATH/../fits_1.4.0-1_all.deb
