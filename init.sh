#!/bin/bash

echo a moodle install is about to commence...
wait 5s
echo it\'s started. go get yourself a cuppa-summin\'

php public_html/admin/cli/install.php --chmod=770 --lang=en --wwwroot=https://$VIRTUALSERVER_DOM  --dataroot=$VIRTUALSERVER_HOME/moodledata --dbtype=mariadb --dbhost=$VIRTUALSERVER_USER --dbpass=$VIRTUALSERVER_PASS --fullname=MOODLE --shortname=MDL --adminuser=$VIRTUALSERVER_USER --adminpass=$VIRTUALSERVER_PASS --adminemail=$VIRTUALSERVER_EMAILTO --non-int

echo moodle is installed
echo print current crontab to session
crontab -l > jobs
echo add cron.php for moodle
echo "* * * * * sudo -u $VIRTUALSERVER_USER php public_html/admin/cli/cron.php" >> jobs
echo install new cron file
crontab jobs
rm jobs

echo READ THIS
echo -----------------------------------------------------------------------------------
echo 1. moodle is installed on this virtual server with demo content
echo 2. visit $VIRTUALSERVERDOM to configure and set branding 
echo 3. a backup of this installation compiles nightly
echo 4. config.php is .dotfile on git and is not included in the backup
echo 5. databse backup compiles nightly and may cause interrupted sessions while running
echo 6. moodledata rsyncs nightly but initial backup may be incomplete for several days
echo    if site content is populated heavily post-intallation  
echo 7. $VIRTUALSERVERDOM not found is likely to occurr if you used moodle panel to init
echo    this requires force closing all your open browsers and possibly a dns cache reset
echo 8. certbot will renew certificates monthly
echo 9. the installation is not production ready until cron runs at least twice
echo 10.email for this virtualserver is configured on the installation but should tested
echo -----------------------------------------------------------------------------------

echo let the logs reflect this install completed in less than 15 minutes and you\'re OK
echo bye!

<EOF>
