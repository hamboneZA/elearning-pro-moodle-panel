#!/bin/bash

git clone https://github.com/moodle/moodle.git

set -e

cd moodle

if [ "$1" != "" ]; then
    release_name="release/$1"
else
    release_name=$(git branch -r --list '*31[0-9]*STABLE' | tail -n1 | sed 's/.*origin\///')
fi
echo "Checking out branch '$release_name'..."
git checkout $release_name

cd ..\

echo 'lets move moodle-www'

rsync -a --no-perms --chmod=ugo=rwX --remove-source-files $VIRTUALSERVER_HOME/moodle/* $VIRTUALSERVER_HOME/public_html/

echo 'lets fix permissions'

sudo chmod -R 0755 public_html
sudo find public_html -type f -exec chmod 0644 {} \;
sudo chown public_html $VIRTUALSERVER_USER:$VIRTUALSERVER_USER

echo 'lets make moodledata'

mkdir moodledata

echo 'lets fix permissions'

sudo chmod -R 0777 moodledata
sudo find moodledata -type f -exec chmod 0664 {} \;
sudo chown public_html $VIRTUALSERVER_USER:$VIRTUALSERVER_USER

echo moodle code is ready for installation at the front end to customize a moodle instance, or run ~/init.sh 
echo from the virtual server control panel to install moodle on this virtual server with defaults and demo data.

<EOF>
