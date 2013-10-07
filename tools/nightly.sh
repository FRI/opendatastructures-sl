#!/bin/bash
# Script for nightly builds of the Slovenian opendatastructures book.
# Author: Matevz Jekovec <matevz.jekovec@fri.uni-lj.si>

REV=$1
OUT_PATH=/var/www/sl.opendatastructures.org/versions-sl
TMP_DIR=ods-sl-r$REV
TMP_PATH=/home/mjekovec/ods-nightly/$TMP_DIR
LOG=$OUT_PATH/ods-sl-r${REV}.log

echo "ODS-NIGHTLY: Checking out from SVN..."
echo "-------------------------------------"

svn co https://lusy.fri.uni-lj.si/svn/ods/sl $TMP_PATH --username ods-nightly --password y4FV\&X8C6 --non-interactive --trust-server-cert

echo "ODS-NIGHTLY: Tarring source..."
echo "-------------------------------------"

cd $TMP_PATH/..
tar --exclude .svn -z -c -v -f $OUT_PATH/ods-sl-r${REV}.tgz $TMP_DIR

echo "ODS-NIGHTLY: Running make..."
echo "-------------------------------------"

cd $TMP_PATH
make

echo "ODS-NIGHTLY: Moving results..."
echo "-------------------------------------"

mv latex/ods-sl-java.pdf $OUT_PATH/ods-sl-java-r${REV}.pdf
mv latex/ods-sl-cpp.pdf $OUT_PATH/ods-sl-cpp-r${REV}.pdf

rm $OUT_PATH/../ods-sl.tgz $OUT_PATH/../ods-sl-java.pdf $OUT_PATH/../ods-sl-cpp.pdf
ln $OUT_PATH/ods-sl-r${REV}.tgz $OUT_PATH/../ods-sl.tgz -s
ln $OUT_PATH/ods-sl-java-r${REV}.pdf $OUT_PATH/../ods-sl-java.pdf -s
ln $OUT_PATH/ods-sl-cpp-r${REV}.pdf $OUT_PATH/../ods-sl-cpp.pdf -s

