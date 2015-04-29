# Minimalistic Website Backup based on Git

Fetch files over FTP, dump remote MySQL databases and keep everything in a
local Git repository.


## Introduction

These scripts might be useful in case you

* want to keep an incremental backup of a (wordpress) website
* that happens to be hosted at a super cheap web hotel which provides:
	* file access thru FTP (and nothing else)
	* remote mysql access, and
* you have a VPS where you don't mind storing the backup
* you are ok with manual restore.



## Requirements

The scripts are tested on Ubuntu Server 14.04 and depends on lftp, mysqldump
and git which you can get thru apt-get:

	sudo apt-get install bash git lftp mysql-client-5.6

If there is not already installed an MTA for email delivery, go ahead and grab
postfix too.


## How to install it

Create a dedicated user:

	NEWUSER=mybackup
	sudo adduser $NEWUSER


Prepare the scripts:

	sudo -u $NEWUSER -i
	git init
	git remote add origin https://github.com/tlk/minimalistic-website-backup
	git pull origin master
	./bin/setup.sh


Enable configuration files:

	mv config/ftpcredentials.sample config/ftpcredentials
	mv config/wordpress.cnf.sample config/YOURDBNAME_CHANGE_THIS.cnf
	mv config/crontab.sample config/crontab

Edit these config files in your favorite editor. You might also want to adjust .gitconfig.


## Perform manual backup

	# backup files
	./bin/files.sh
	
	# backup database(s)
	./bin/db-dumps.sh
	
	
## Perform automatic backup

	# let cron perform future backups for you
	crontab config/crontab
	
	# receive error notifications by email (requires an MTA, e.g. postfix)
	echo YOUR_LOGIN_CHANGE_THIS > $HOME/.forward


## How to restore from the backup

You can find the latest backup in the ```backup``` directory
which contains two directories: db-dumps and files. The ```db-dumps``` directory
holds .sql files for your database(s) and the ```files``` directory holds a copy of
all files from the website.

Remember that the ```backup``` directory is a git repository, so you can use standard git
functions to fetch older database or file versions from the backup in case you
need that.
