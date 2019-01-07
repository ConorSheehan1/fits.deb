## Debian package for havard fits

I have no affiliation with harvard or fits.  
I'm just trying to make a debian friendly installation path.  
Inspired by [this fits brew package](https://formulae.brew.sh/formula/fits).

For more information on fits see:

https://github.com/harvard-lts/fits  
https://projects.iq.harvard.edu/fits

## Installation

for ubuntu >= 16.04  
`sudo apt install ./fits.deb`

for older / different flavours of debian  
```
sudo dpkg -i fits.deb
# may be required if you don't have a java runtime environment >= 7
sudo apt-get -f install
```

To uninstall:

`sudo apt remove fits`

or 

`sudo dpkg -r ./fits.deb`

## Dev notes

get fits  
`wget https://github.com/harvard-lts/fits/releases/download/1.4.0/fits-1.4.0.zip -O ~/Workspace/fits.deb/fits-1.4.0.zip`

extract it  
`unzip fits-1.4.0.zip -d fits-1.4.0`

requirements for building debian package  
`sudo apt-get install build-essential devscripts debhelper dh-make`

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

add debian/fits.install, debian/fits.dirs with the necessary files / dirs

build the deb file (unsigned for now)  
`debuild -us -uc --lintian-opts --profile debian`

## TODO

sign changes with gpg key

