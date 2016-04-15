#!/bin/bash

rm -f config.sample.inc.php
rm -f config.inc.php

mv /var/www/public/phpmyadmin/config.sample.inc.php .

randomBlowfishSecret=`openssl rand -base64 32`;
sed -e "s|cfg\['blowfish_secret'\] = ''|cfg['blowfish_secret'] = '$randomBlowfishSecret'|" config.sample.inc.php > config.inc.php
echo "\$cfg['CheckConfigurationPermissions'] = false;" >> config.inc.php

mv config.inc.php phpmyadmin/.
mv config.sample.inc.php phpmyadmin/config.sample.inc.php.bk
