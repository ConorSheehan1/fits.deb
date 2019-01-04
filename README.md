## Debian package for havard fits

I have no affiliation with harvard or fits.  
I'm just trying to make a debian friendly installation path.  
Inspired by [this fits brew package](https://formulae.brew.sh/formula/fits).

For more information on fits see:

https://github.com/harvard-lts/fits  
https://projects.iq.harvard.edu/fits

### TODO
Make changes to fits.xml as patch, as per https://github.com/harvard-lts/fits/issues/160

get fits  
`wget https://github.com/harvard-lts/fits/releases/download/1.4.0/fits-1.4.0.zip -O ~/Workspace/fits.deb/fits-1.4.0.zip`

extract it  
`unzip fits-1.4.0.zip -d fits-1.4.0`

requirements for build  
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

