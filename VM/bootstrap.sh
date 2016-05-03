#!/bin/bash

sudo apt-get -y update --fix-missing
sudo apt-get -y install dos2unix

#enter into shared directory and create log directory
cd /var/www/public

#restore UNIX line ending to prevent Git autocrlf=true to lead to errors
dos2unix *.sh

#setup mysql db and user login
sh setup_db.sh testdb testuser testpassword
sh setup_db.sh programo botmaster botmaster2016

#setup phpMyAdmin
wget -q https://files.phpmyadmin.net/phpMyAdmin/4.6.0/phpMyAdmin-4.6.0-all-languages.tar.gz
tar xf phpMyAdmin-4.6.0-all-languages.tar.gz
mv phpMyAdmin-4.6.0-all-languages phpmyadmin
rm phpMyAdmin-4.6.0-all-languages.tar.gz
sh ../setup_phpmyadmin.sh

#setup Program-O
git clone https://github.com/DigiPlatMOOC/Program-O.git programo
curl -H "Content-Type: application/x-www-form-urlencoded" -X POST -d 'botmaster_name=Botmaster&debugemail=botmaster%40example.org&bot_name=MyFirstBot&bot_desc=My+first+AIML+bot&bot_active=1&format=json&error_response=No+AIML+category+found.+This+is+a+Default+Response.&page=2&bot_id=1&error_response=No+AIML+category+found.+This+is+a+Default+Response.&action=Save&dbh=localhost&dbn=programo&dbPort=3306&dbu=botmaster&dbp=botmaster2016&time_zone_locale=Europe%2FBerlin&adm_dbu=botmaster&adm_dbp=botmaster2016&adm_dbp_confirm=botmaster2016&debug_level=4&debug_mode=1&save_state=database' http://127.0.0.1/setup/programo/install/install_programo.php

#download TelegramBotSample files
git clone https://github.com/DigiPlatMOOC/TelegramBotSample.git telegram-bot-sample
