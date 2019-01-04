prefix = /usr/local

all: src/fits

src/fits: src/fits/fits.sh
	ln -s fits.sh fits

install:
	ln -s fits.sh bin/fits
clean:
	-rm -rf src/fits
uninstall:
	-rm -f bin/fits

