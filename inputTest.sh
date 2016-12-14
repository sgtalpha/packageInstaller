#!/usr/bin/env sh

#Add variables to the command / check for variables
if test $# -lt 1; then
	echo "You must include an input file. Use -h for help."
	exit 0
else
	while test $# -gt 0; do
		case "$1" in
			-h|--help)
				echo "options:"
				echo "-h, --help		show brief help"
				echo "-f [path], --file	[path]	provide path to input file. Note: Must be FULL path."
				exit 0
			;;
			-f|--file)
				INPUT_FILE=$(tr ' ' '-' <$2)
				shift 2
			;;
			*)
				printf "Unexpected option $1.\nUse -h to see a list of accepted options.\n\n"
				exit 0
			;;
		esac
	done;
fi

#Check each program from the input file to see if it already exists. Skip if installed already.

for INPUT in $INPUT_FILE; do
	EXISTS="$(which $INPUT | tr '[:upper:]' '[:lower:]')"
	INPUT="$(echo $INPUT | tr '[:upper:]' '[:lower:]')"
#Make checks OSX friendly...
	OSX_INPUT="$(echo $INPUT | tr '-' ' ')"
	OSX="$(find /Applications -iname "*$OSX_INPUT*" -maxdepth 1 | grep -m 1 -io "$OSX_INPUT" | tr "[:upper:]" "[:lower:]")"
	
	if test "$OSX" = "$OSX_INPUT" || test "$(echo $EXISTS | grep -io $INPUT)" ; then
		printf "$INPUT is already installed. Skipping... \n"
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
