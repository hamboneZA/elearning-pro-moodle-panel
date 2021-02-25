echo 'lets fix permissions'

sudo chmod -R 0755 public_html
sudo find public_html -type f -exec chmod 0644 {} \;
# sudo chown public_html $VIRTUALSERVER_USER:$VIRTUALSERVER_USER


echo 'lets make moodledata'

mkdir moodledata

echo 'lets fix permissions'

sudo chmod -R 0777 moodledata
sudo find moodledata -type f -exec chmod 0664 {} \;

echo 'make yourself a coffee'
