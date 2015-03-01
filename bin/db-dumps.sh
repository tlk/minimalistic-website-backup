#!/bin/bash
#
# Minimalistic Website Backup
# Thomas L. Kjeldsen 2015-01-14

HOME=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/..

BACKUPDIR="$HOME/backup/db-dumps"

# databases must be configured with one $dbname.cnf file per database
for f in "$HOME/config/*.cnf"; do
  DBNAME=$(/usr/bin/basename $f|/bin/sed 's/.cnf$//');
  /usr/bin/mysqldump --defaults-extra-file="$HOME/config/$DBNAME.cnf" $DBNAME > $BACKUPDIR/$DBNAME.sql;
done

cd $BACKUPDIR
/usr/bin/git add --all .
/usr/bin/git commit -q -a -m 'database dumps updated'

