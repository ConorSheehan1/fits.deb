#
# Regular cron jobs for the fits package
#
0 4	* * *	root	[ -x /usr/bin/fits_maintenance ] && /usr/bin/fits_maintenance
