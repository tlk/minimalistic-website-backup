#!/bin/bash
#
# Minimalistic Website Backup
# Thomas L. Kjeldsen 2015-01-14

HOME=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/..
DATADIR="$HOME/backup/"

mkdir -p "$DATADIR" && cd "$DATADIR"
/usr/bin/git init

mkdir db-dumps files
touch db-dumps/.keep files/.keep

/usr/bin/git add db-dumps/.keep files/.keep
/usr/bin/git commit -q -a -m 'initialize backup directory structure'


cd $HOME
chmod go-rwx config backup

