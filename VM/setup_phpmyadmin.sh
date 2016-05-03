#!/bin/bash

# Executes from /var/www/public
# PhpMyAdmin is extracted into /var/www/public/phpmyadmin

# Spring cleaning (what for? who knows)
rm -f config.sample.inc.php
rm -f config.inc.php

cp /var/www/public/phpmyadmin/config.sample.inc.php /var/www/public/phpmyadmin/config.inc.php
mv /var/www/public/phpmyadmin/config.sample.inc.php /var/www/public/phpmyadmin/config.sample.inc.php.bk

# Replace blowfish secret
randomBlowfishSecret=`openssl rand -base64 32`;
sed -e "s|cfg\['blowfish_secret'\] = ''|cfg['blowfish_secret'] = '$randomBlowfishSecret'|" -i /var/www/public/phpmyadmin/config.inc.php

sed -e "s|cfg\['Servers'\]\[\$i\]\['auth_type'\] = 'cookie'|cfg\['Servers'\]\[\$i\]\['auth_type'\] = 'config';\n\$cfg\['Servers'\]\[\$i\]\['user'\] = 'root';\n\$cfg\['Servers'\]\[\$i\]\['password'\] = 'root'|" -i /var/www/public/phpmyadmin/config.inc.php

echo "\$cfg['CheckConfigurationPermissions'] = false;" >> /var/www/public/phpmyadmin/config.inc.php
