#!/bin/bash
########################################################################
#
# Script to upload files of LibreOffice 4.0 and dependencies to 
# Canaima GNU/Linux repository .
#
# Author: 	Erick Birbe <erickcion@gmail.com>
# Created:	2013-03-11
#
########################################################################

DATA_DIR="$1"
REPO_DIR="/srv/www/repositorios/canaima"
CODENAME="kerepakupai"

upload_files ()
{
	SRC_DIR="$1"
	
	# Uploading .deb files
	echo "Uploading .deb in $SRC_DIR"
	reprepro -b $REPO_DIR includedeb $CODENAME $DATA_DIR/$SRC_DIR/*.deb
	if [ $? -ne 0 ]; then
		echo "Error uploading .deb"
		exit 1
	fi
	
	# Uploading source files
	echo "Uploading .dsc in $SRC_DIR"
	reprepro -b $REPO_DIR includedsc $CODENAME $DATA_DIR/$SRC_DIR/*.dsc
	if [ $? -ne 0 ]; then
		echo "Error uploading .dsc"
		exit 1
	fi
	
}

upload_files "b/boost1.49"
upload_files "c/clucene-core"
upload_files "g/gstreamer1.0" # TODO agregar -P -S en este paquete: 
upload_files "g/gst-plugins-base1.0" # TODO agregar -P -S en este paquete: 
upload_files "libc/libcdr"
upload_files "libc/libcmis"
upload_files "libl/liblangtag"
upload_files "libm/libmspub"
upload_files "libo/liborcus"
upload_files "libr/libreoffice" # TODO agregar -P optional -S editors en este paquete: 
upload_files "libz/libzip"
upload_files "r/redland"
