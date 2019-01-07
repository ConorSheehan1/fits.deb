#!/bin/bash

# install dependencies
sudo apt-get install build-essential devscripts debhelper dh-make fakeroot

cd ../fits-1.4.0
# # no longer necessary now that orig.tar.xz is on git
dh_make --createorig --indep --yes
debuild -us -uc --lintian-opts --profile debian
