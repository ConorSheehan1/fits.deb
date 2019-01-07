#!/bin/bash
cd ../fits-1.4.0
sudo dh_make --createorig --single --yes
sudo debuild -us -uc --lintian-opts --profile debian
