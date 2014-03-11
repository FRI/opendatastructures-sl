#!/bin/bash
# Script for nightly builds of the Slovenian opendatastructures book.
# Author: Matevz Jekovec <matevz.jekovec@fri.uni-lj.si>

REV=$1
OUT_PATH=/var/www/sl.opendatastructures.org/versions-sl
TMP_DIR=ods-sl-r$REV
TMP_PATH=/home/mjekovec/ods-nightly/$TMP_DIR
LOG=$OUT_PATH/ods-sl-r${REV}.log

if [ -d "$TMP_PATH" ]; then
	exit
fi

echo "ODS-NIGHTLY: Checking out from SVN..."
echo "-------------------------------------"

svn co file:///var/svn/ods/sl $TMP_PATH --username ods-nightly --password y4FV\&X8C6 --non-interactive --trust-server-cert

echo "ODS-NIGHTLY: Tarring source..."
echo "-------------------------------------"

cd $TMP_PATH/..
tar --exclude .svn -z -c -v -f $OUT_PATH/ods-sl-r${REV}.tgz $TMP_DIR

echo "ODS-NIGHTLY: Running make..."
echo "-------------------------------------"

cd $TMP_PATH/latex
make noninteractive
cd ..
make tarballs

echo "ODS-NIGHTLY: Moving results..."
echo "-------------------------------------"

if [ ! -f latex/ods-sl-java.pdf ];
then
	echo "Compilation failed."
	exit -1
fi

ln $OUT_PATH/ods-sl-r${REV}.tgz $OUT_PATH/../ods-sl.tgz -s -f

mv ods-sl-javasrc.tgz $OUT_PATH/ods-sl-javasrc-r${REV}.tgz
mv ods-sl-cppsrc.tgz $OUT_PATH/ods-sl-cppsrc-r${REV}.tgz
ln $OUT_PATH/ods-sl-javasrc-r${REV}.tgz $OUT_PATH/../ods-sl-javasrc.tgz -s -f
ln $OUT_PATH/ods-sl-cppsrc-r${REV}.tgz $OUT_PATH/../ods-sl-cppsrc.tgz -s -f

mv latex/ods-sl-java.pdf $OUT_PATH/ods-sl-java-r${REV}.pdf
mv latex/ods-sl-cpp.pdf $OUT_PATH/ods-sl-cpp-r${REV}.pdf
mv latex/ods-sl-java-screen.pdf $OUT_PATH/ods-sl-java-r${REV}-screen.pdf
mv latex/ods-sl-cpp-screen.pdf $OUT_PATH/ods-sl-cpp-r${REV}-screen.pdf
mv latex/ods-sl-java-grayscale.pdf $OUT_PATH/ods-sl-java-r${REV}-grayscale.pdf
mv latex/ods-sl-cpp-grayscale.pdf $OUT_PATH/ods-sl-cpp-r${REV}-grayscale.pdf

ln $OUT_PATH/ods-sl-java-r${REV}.pdf $OUT_PATH/../ods-sl-java.pdf -s -f
ln $OUT_PATH/ods-sl-cpp-r${REV}.pdf $OUT_PATH/../ods-sl-cpp.pdf -s -f
ln $OUT_PATH/ods-sl-java-r${REV}-screen.pdf $OUT_PATH/../ods-sl-java-screen.pdf -s -f
ln $OUT_PATH/ods-sl-cpp-r${REV}-screen.pdf $OUT_PATH/../ods-sl-cpp-screen.pdf -s -f
ln $OUT_PATH/ods-sl-java-r${REV}-grayscale.pdf $OUT_PATH/../ods-sl-java-grayscale.pdf -s -f
ln $OUT_PATH/ods-sl-cpp-r${REV}-grayscale.pdf $OUT_PATH/../ods-sl-cpp-grayscale.pdf -s -f

echo "ODS-NIGHTLY: Removing older ODS builds..."
echo "-----------------------------------------"
cd $TMP_PATH/..
rm -rf `ls -t1 | tail -n +2`
