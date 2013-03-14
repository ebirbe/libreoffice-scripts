#!/bin/bash
########################################################################
#
# Script to download files of LibreOffice 4.0 and dependencies for
# Canaima GNU/Linux
#
# Author: 	Erick Birbe <erickcion@gmail.com>
# Created:	2013-02-21
#
########################################################################

FTP_URL="ftp://ftp.br.debian.org:21/debian"
FASTER_URL="http://universo.canaima.softwarelibre.gob.ve"
RGX_ARCHS="(amd64|i386|armhf|armel|all)"
SCRIPT_BASE=$(pwd)
FILTER_FILE="filter.txt"
DOWNLD_FILE="download.txt"

check_version()
{
	SOURCE=$1
	VERSION=$2
	NUM_MATCHES=$(grep -E "$RGX_VERSION.*\.dsc" $FILTER_FILE | wc -l)
		
	if [ $NUM_MATCHES -eq 0 ];
	then
		echo "#########################################################"
		echo "$SOURCE $VERSION does not match, check version."
		echo "#########################################################"
		exit 1
	fi
}

download_package ()
{
	PKG_SRC="$1"
	RGX_VERSION=$2
		
	mkdir -p "$1"
	cd "$1"
	
	# Remove index of files
	rm -f "$1/index.html"
	
	# Retreive index of files
	wget -c "$FTP_URL/pool/main/$PKG_SRC"/
	
	# Filtering data
	cat "index.html" | awk -F'"' '{print $2}' > $FILTER_FILE
	
	# Check if version exists
	check_version $PKG_SRC $RGX_VERSION
	
	# Searching for correct files
	grep -E "$RGX_VERSION+(-[0-9]+)?.*(_$RGX_ARCHS.deb|tar\...|dsc)" $FILTER_FILE |
	sed "s|$FTP_URL|$FASTER_URL|" > $DOWNLD_FILE
	
	# Downloading the filtered files.
	wget -c --input-file $DOWNLD_FILE
	
	# Returning parent directory
	cd $SCRIPT_BASE
}

download_package "b/boost1.49"				"1\.49\.0"
download_package "c/clucene-core"			"2\.3\.3\.4"
download_package "g/gst-plugins-base1.0"		"1\.0\.5"
download_package "g/gstreamer1.0"			"1\.0\.5"
download_package "libc/libcdr"				"0\.0\.11"
download_package "libc/libcmis"				"0\.3\.1"
download_package "libl/liblangtag"			"0\.4\.0"
download_package "libm/libmspub"			"0\.0\.5"
download_package "libo/liborcus"			"0\.3\.0"
download_package "libr/libreoffice" 			"4\.0\.1"
download_package "libz/libzip"				"0\.10\.1"
download_package "r/redland"				"1\.0\.16"
