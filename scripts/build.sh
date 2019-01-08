#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd $SCRIPTPATH/../fits-1.4.0
sudo dh_make --createorig --single --yes
sudo debuild -us -uc --lintian-opts --profile debian
