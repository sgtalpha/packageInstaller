#!/usr/bin/env sh

echo "Type the FULL path to the file that lists your desired programs, then press [enter]: "
read INPUT_FILE

INPUT_FILE=$(<$INPUT_FILE)

for INPUT in $INPUT_FILE; do
	EXISTS="$(which $INPUT | tr '[:upper:]' '[:lower:]')"
	MAC="$(find /Applications -iname *$INPUT* -maxdepth 1 | grep -io $INPUT | tr '[:upper:]' '[:lower:]')"
	INPUT="$(echo $INPUT | tr '[:upper:]' '[:lower:]')"
	
	if test "$MAC" = "$INPUT" || test "$(echo $EXISTS | grep -io $INPUT)" ; then
		echo "$INPUT is already installed. Skipping...:"
	else
		if test "$(brew cask search $INPUT | grep 'No Cask*')" ; then
			if test "$(find $(brew --prefix)/Library/Formula/$INPUT.rb 2>/dev/null)" ; then
				echo "Installing $INPUT via Homebrew..."
			else
				echo "Homebrew cannot install $INPUT. Skipping..."
			fi
		else 
			echo "Installing $INPUT via cask..."
			
		fi
	#	echo "Installing $INPUT..."
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
