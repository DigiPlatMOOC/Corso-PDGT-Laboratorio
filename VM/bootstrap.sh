#!/bin/bash

echo "Refreshing packages..."
sudo apt-get -qq -y update --fix-missing
sudo apt-get -qq -y install dos2unix

# Enter into shared directory
cd /var/www

# Restore UNIX line endings (prevents Git's autocrlf=true from creating installation errors)
dos2unix -kq *.sh

# Setup MySQL database credentials
echo "Setting up database..."
sh setup_db.sh testdb testuser testpassword
sh setup_db.sh programo botmaster botmaster2016

# Entering /public/ sub-directory to setup working space
pushd public > /dev/null

# Setup phpMyAdmin
echo "Installing phpMyAdmin..."
wget -q https://files.phpmyadmin.net/phpMyAdmin/4.6.0/phpMyAdmin-4.6.0-all-languages.tar.gz
tar xf phpMyAdmin-4.6.0-all-languages.tar.gz
mv phpMyAdmin-4.6.0-all-languages phpmyadmin
rm phpMyAdmin-4.6.0-all-languages.tar.gz
sh ../setup_phpmyadmin.sh

# Setup Program-O
echo "Installing Program-O..."
git clone https://github.com/DigiPlatMOOC/Program-O.git programo
curl -H "Content-Type: application/x-www-form-urlencoded" -X POST -d 'botmaster_name=Botmaster&debugemail=botmaster%40example.org&bot_name=MyFirstBot&bot_desc=My+first+AIML+bot&bot_active=1&format=json&error_response=No+AIML+category+found.+This+is+a+Default+Response.&page=2&bot_id=1&error_response=No+AIML+category+found.+This+is+a+Default+Response.&action=Save&dbh=localhost&dbn=programo&dbPort=3306&dbu=botmaster&dbp=botmaster2016&time_zone_locale=Europe%2FBerlin&adm_dbu=botmaster&adm_dbp=botmaster2016&adm_dbp_confirm=botmaster2016&debug_level=4&debug_mode=1&save_state=database' http://127.0.0.1/setup/programo/install/install_programo.php

# Download TelegramBotSample files
echo "Downloading sample repository..."
git clone https://github.com/DigiPlatMOOC/TelegramBotSample.git telegram-bot-sample

# Exiting /public/ sub-directory
popd > /dev/null

echo "All set!"
