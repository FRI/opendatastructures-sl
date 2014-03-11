#!/bin/bash

REPOS="$1"
TXN="$2"
CO_DIR="/home/mjekovec/ods-nightly/tmp-ods-sl-r$TXN"

# ENV variables not correctly set from svn hook calls?!
export PATH=/usr/local/bin:/usr/bin:/bin

svn co file://$REPOS/sl $CO_DIR --username ods-nightly --password y4FV\&X8C6 --non-interactive --trust-server-cert
svnlook diff -t "$TXN" "$REPOS" | patch -d $CO_DIR -p1 1>&2

cd $CO_DIR/latex
make noninteractive 1>&2
RES=$?

rm $CO_DIR -rf

exit $RES
