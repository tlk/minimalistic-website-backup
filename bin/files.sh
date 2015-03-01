#!/bin/bash
#
# Minimalistic Website Backup
# Thomas L. Kjeldsen 2015-01-14

HOME=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/..

CONFIG="$HOME/config/ftpcredentials"
LCD="$HOME/backup/files"
RCD="/"

. $CONFIG
cd $LCD

# NOTE: you can adjust the mirror line(s) below if you want to limit the backup
# to a particular directory/directories. E.g.:
#    mirror --delete 'subsite1.example.com';
#    mirror --delete 'subsite2.example.com';"
#
# The --delete option refers to deleting local files that no longer exists on
# the remote server.

/usr/bin/lftp -q -c "set ftp:list-options -a;
set cmd:fail-exit true;
open ftp://$USER:'$PASS'@$HOST;
lcd $LCD;
cd $RCD;
mirror --delete;"

# update changed/removed files
/usr/bin/git add --update

# add any new files
/usr/bin/git add --all

# commit only when there are staged changes for commit
/usr/bin/git diff-index --quiet --cached HEAD || /usr/bin/git commit -q -m 'files updated'

# assert that there are no uncommitted changes - make noise otherwise
/usr/bin/git diff-files

