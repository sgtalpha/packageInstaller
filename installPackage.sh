#!/usr/bin/env sh

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

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

#Install Homebrew if it doesn't exist.

BREW="$(which brew)"
CASK="$(ls /usr/local/Caskroom 2>/dev/null)"

if test "$(echo $BREW | grep -o brew)" = "brew" ; then
	printf "Homebrew is already installed. Checking for cask... \n"
else
	printf "Installing Homebrew...\n"
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &>/dev/null
fi

#Install Homebrew Cask if it doesn't exist.

if test "${#CASK}" -gt 0 ; then
	printf "Cask is already installed. Installing your apps... \n"
else
	printf "Installing Homebrew Cask... \n"
	brew tap caskroom/cask &>/dev/null
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
#If it doesn't exist, see if it needs to be installed via Homebrew or Homebrew Cask; install it using appropriate method.  
		if test "$(brew cask search $INPUT | grep 'No Cask*')" ; then
			if test "$(find $(brew --prefix)/Library/Formula/$INPUT.rb 2>/dev/null)" ; then
				printf "Installing $INPUT via Homebrew... \n"
				brew install $INPUT
			else
				printf "Homebrew cannot install $INPUT. Skipping... \n"
			fi
		else 
			printf "Installing $INPUT via cask... \n"
			brew cask install $INPUT
		fi
	fi
done
