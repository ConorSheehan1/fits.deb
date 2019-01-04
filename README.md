## Debian package for havard fits

I have no affiliation with harvard or fits.  
I'm just trying to make a debian friendly installation path.  
Inspired by [this fits brew package](https://formulae.brew.sh/formula/fits).

For more information on fits see:

https://github.com/harvard-lts/fits  
https://projects.iq.harvard.edu/fits

### TODO
Make changes to fits.xml as patch, as per https://github.com/harvard-lts/fits/issues/160

requirements for build  
`sudo apt-get install build-essential devscripts debhelper dh-make`

extract fits  
`unzip $fits.zip`

move to semantic version e.g
`mv fits fits-1.4.0`

run dh_make to build orig tar.gz and debian files
`cd fits-1.4.0 && dh_make`

