#!/bin/bash
########################################################################
#
# Script to remove files in repository of LibreOffice 4.0 and 
# dependencies.
#
# Author: 	Erick Birbe <erickcion@gmail.com>
# Created:	2013-03-11
#
########################################################################

REPO_DIR="/srv/www/repositorios/canaima"
CODENAME="kerepakupai"


remove_source ()
{
        SRC_NAME="$1"

        echo "Removing $SRC_NAME"
        reprepro -b $REPO_DIR removesrc $CODENAME $SRC_NAME
        if [ $? -ne 0 ]; then
                echo "Error removing $SRC_NAME"
                exit 1
        fi
}


remove_source "clucene-core"
remove_source "gstreamer1.0"
remove_source "gst-plugins-base1.0"
remove_source "libcdr"
remove_source "libcmis"
remove_source "liblangtag"
remove_source "libmspub"
remove_source "liborcus"
remove_source "libreoffice"
remove_source "redland"
remove_source "libzip"
remove_source "boost1.49"
