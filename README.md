[![Build Status](https://travis-ci.org/ConorSheehan1/fits.deb.svg?branch=master)](https://travis-ci.org/ConorSheehan1/fits.deb)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Debian package for havard file information tool set

I have no affiliation with harvard or fits.  
I'm just trying to make a debian friendly installation path.  
Inspired by [this fits brew package](https://formulae.brew.sh/formula/fits).

For more information on fits see:
https://github.com/harvard-lts/fits  
https://projects.iq.harvard.edu/fits

## Install

#### From the ppa
```
sudo add-apt-repository ppa:conorsheehan1/fits-ppa
sudo apt-get update
sudo apt install fits
```

On older versions on ubuntu you may need
```
sudo apt-key update
sudo apt-get install fits
```

#### From this repository
.deb files available at https://github.com/ConorSheehan1/fits.deb/releases

for ubuntu >= 16.04  
`sudo apt install ./fits-$version.deb`

for older / different flavours of debian  
```
sudo dpkg -i fits-$version.deb
# may be required if you don't have a java runtime environment >= 7
sudo apt-get -f install
```

## Uninstall

Any of the following (depending on your os version)
```
sudo apt remove fits
sudo apt-get remove fits
sudo dpkg -r ./fits-$version.deb
```

To remove the ppa

`sudo add-apt-repository --remove ppa:conorsheehan1/fits-ppa`

## Why not brew?

The main dependency for this application is java >= 1.7 (see [fits readme](https://github.com/harvard-lts/fits/tree/be66a2e100e7a772c08c17b5a47658d7359ce2aa#system-requirements)).  
While it is now possible to use the linuxbrew-wrapper, allowing brew rather than apt to manage java could cause problems.

## Dev notes

get fits  
`wget https://github.com/harvard-lts/fits/releases/download/1.4.0/fits-1.4.0.zip -O ~/Workspace/fits.deb/fits-1.4.0.zip`

extract it  
`unzip fits-1.4.0.zip -d fits-1.4.0`

requirements for building debian package  
`sudo apt-get install build-essential devscripts debhelper dh-make fakeroot`

run dh_make to build orig tar.gz and debian files  
```
cd fits-1.4.0
dh_make --createorig
```

patch the fits.xml file  
```
# edit xml/fits.xml
dpkg-source --commit
```

add to changelog  
`dch -i`

add debian/fits.install, debian/fits.dirs with the necessary files / dirs

build the deb file (unsigned for now)  
`debuild -us -uc --lintian-opts --profile debian`

## TODO

Move to manually created orig.tar.gz instead of dh_make orig.tar.xz so versions of ubuntu older that 12.04 trusty can be supported. See https://travis-ci.org/ConorSheehan1/fits.deb/jobs/476466402

