# **Vagrant virtual machine setup** 

This repository contains a simple setup for a Vagrant virtual machine that can be used as a starting point to develop your own Program-O based Telegram Bot.

## **What you need to know?**
  This Vagrant machine is heavily based on [ScotchBox](https://box.scotch.io/) and basic information can be got from the linked website.
  The machine setup creates a private network in order to make the webserver of the guest machine be reachable from the host machine at  [http://192.168.33.10:80](http://192.168.33.10:80).
  Together with the ScotchBox basic components this machine include a working installation of PHPMyAdmin (at [http://192.168.33.10/phpmyadmin](http://192.168.33.10/phpmyadmin)), useful to manage the embedded MySQL database confuguration, along with a ready to be used Program-O instance (at [http://192.168.33.10/programo](http://192.168.33.10/programo)) derived from [https://github.com/DigiPlatMOOC/Program-O.git](https://github.com/DigiPlatMOOC/Program-O.git)
  
### **Basic configuration (other than the ones provided for ScotchBox)**
  * Local PHPMyAdmin URL: [http://192.168.33.10/phpmyadmin](http://192.168.33.10/phpmyadmin)
  
  * Local Program-O URL: [http://192.168.33.10/programo](http://192.168.33.10/programo)
  
  * Program-O MySQL database name: __programo__
  
  * Program-O MySQL user credential username: __botmaster__
  
  * Program-O MySQL user credential password: __botmaster2016__
  
  We also create another db and user for testing/developing purpose: 
  * Develop MySQL database ame: __testdb__
  
  * Develop MySQL user credential username: __testuser__
  
  * Develop MySQL user credential username: __testpassword__ 

### **File details**
  * **Vagrantfile**
  The Vagrant configuration file. It includes sub-network creation and provisioning directives. 
  * **bootstrap.sh**
  The script executed at the end of the vagrant machine creation. 
  * **public/**
  The shared directory between the host and the guest machine. The same directory is available inside the vagrant vm at _/var/www/public_. That is also the DocumentRoot of the Apache webserver which runs inside the vm. 
  * **public/index.php**
  It contains information about the ScotchBox instance. Can be seen at [http://192.168.33.10/](http://192.168.33.10/), here you can see all the stuff that are running inside your ScotchBox installation.
  * **public/info.php**
  It contains information about the PHP interpreter (basically is a standard *phpinfo()* file). Can be seen at [http://192.168.33.10/info.php](http://192.168.33.10/info.php).
  * **public/setup_db.sh**
  Script needed at bootstrap phase to add database and user to the MySQL instance. Can also be used like this:
  ```
  $: ./setup_db.sh <db_name> <db_user_login> <db_user_password>
  ``` 
  to add database and user at the same time.
  * **public/setup_phpmyadmin.sh**
  Script needed at bootstrap phase to properly configure your PHPMyAdmin installation. This should not be used directly.
  
## **How to use it?**
You only need to know few vagrant commands to use this development VM (following lines are taken directly from the official [Vagrant documentation](https://www.vagrantup.com/docs/cli/ssh.html)):

* **vagrant up**
This command creates and configures guest machines according to your Vagrantfile.
* **vagrant ssh**
This will SSH into a running Vagrant machine and give you access to a shell.
* **vagrant suspend**
This suspends the guest machine Vagrant is managing, rather than fully shutting it down or destroying it.
* **vagrant destroy**
This command stops the running machine Vagrant is managing and destroys all resources that were created during the machine creation process. After running this command, your computer should be left at a clean state, as if you never created the guest machine in the first place.

In any case, a normal develop cycle should follow only theese steps:

_vagrant up_
\> _vagrant ssh_
\> **you do your magic inside the vagrant machine**
\> _vagrant suspend_ 

For any other information about how to use Vagrant you should take a look at the official [Vagrant website](https://www.vagrantup.com/).

## ***Have Fun!***

