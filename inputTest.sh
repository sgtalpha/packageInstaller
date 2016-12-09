#!/usr/bin/env bash

echo "Type the FULL path to the file that lists your desired programs, then press [enter]: "
read INPUT_FILE

INPUT_FILE=$(<$INPUT_FILE)

for INPUT in $INPUT_FILE; do
	EXISTS="$(which $INPUT | tr '[:upper:]' '[:lower:]')"
	MAC="$(find /Applications -iname *$INPUT* -maxdepth 1 | grep -io $INPUT | tr '[:upper:]' '[:lower:]')"
	INPUT="$(echo $INPUT | tr '[:upper:]' '[:lower:]')"
	
	if test "$MAC" = "$INPUT" || test "$(echo $EXISTS | grep -io $INPUT)" = "$INPUT" ; then
		echo "$INPUT is already installed. Skipping...:"
	else
		echo "Installing $INPUT..."
	fi
done

#do
#	echo $EXISTS
#done

###	CHECK TO SEE IF ITEM IS BREW

###	IF ITEM IS NOT BREW, CHECK TO SEE IF ITEM IS CASK


#	if [ "$EXISTS" == *'not found'* ] ; then
#        	echo "Git successfully installed"
#	else
#        	echo "Git is already installed. Skipping..."
#	fi
