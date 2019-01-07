#!/bin/bash
cd ../fits-1.4.0
sudo dh_make --createorig --native --single --yes
sudo debuild -us -uc --lintian-opts --profile debian
