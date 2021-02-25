#!/bin/bash

echo we're going to deploy moodle to this virtual server without you now
echo /bin/sh will run pretending to be you as definded for this env 
echo if you are not correctly defined .sh won't know where to loacte ~/bin/bash
echo or if you are correctly defined but not in sudo group this will fail
echo to fix your env open moodle panel and run  Environment Fix from the dash
echo run tail -f ~/etc/log/deploy.log to watch this run
echo we'll tell you when we're done
echo ok we're starting now and should be complete in 10 munites or less mkay

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>\~/etc/log/deploy.log 2>&1

sudo chmod +x skel.sh init.sh perms.sh
skel.sh && wait 5m && init.sh && perms.sh

echo done making new moodle on this virtual server
echo see postinstall.md for a checklist of post install operations
echo the site is in maintainance mode to allow you time to complete them
echo run php admin/cli/maintenance.php --disable from moodle panel to go live
echo or toggle Site administration > Server > Maintenance for go-live
echo
echo this installation took 10 minutes or less so yay for us
echo goodbye
