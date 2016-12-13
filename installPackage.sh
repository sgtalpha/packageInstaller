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
				INPUT_FILE=$(<$2)
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

BREW="$(which brew) | grep -o brew"
CASK="$(ls /usr/local/Caskroom)"

if test "$BREW" = "brew" ; then
	echo "Homebrew is alreaedy installed. Checking for cask..."
else
	echo "Installing Homebrew..."
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &>/dev/null
fi

#Install Homebrew Cask if it doesn't exist.

if test "${#CASK}" -gt 0 ; then
	echo "Cask is already installed. Installing your apps..."
else
	echo "Installing Homebrew Cask... "
	brew tap caskroom/cask &>/dev/null

#Check each program from the input file to see if it already exists. Skip if installed already.

for INPUT in $INPUT_FILE; do
	EXISTS="$(which $INPUT | tr '[:upper:]' '[:lower:]')"
	MAC="$(find /Applications -iname *$INPUT* -maxdepth 1 | grep -io $INPUT | tr '[:upper:]' '[:lower:]')"
	INPUT="$(echo $INPUT | tr '[:upper:]' '[:lower:]')"
	
	if test "$MAC" = "$INPUT" || test "$(echo $EXISTS | grep -io $INPUT)" ; then
		echo "$INPUT is already installed. Skipping...:"
	else
#If it doesn't exist, see if it needs to be installed via Homebrew or Homebrew Cask; install it using appropriate method.  
		if test "$(brew cask search $INPUT | grep 'No Cask*')" ; then
			if test "$(find $(brew --prefix)/Library/Formula/$INPUT.rb 2>/dev/null)" ; then
				echo "Installing $INPUT via Homebrew..."
				brew install $INPUT
			else
				echo "Homebrew cannot install $INPUT. Skipping..."
			fi
		else 
			echo "Installing $INPUT via cask..."
			brew cask install $INPUT
		fi
	fi
done