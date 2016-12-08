#!/usr/bin/env sh

INPUT="git"

EXISTS="$(which $INPUT)"
echo "${EXISTS}"
#echo $EXISTS | grep -o $INPUT

#Replace [[ with 'if test' so that this works with shell as well. (see posix comliance - [[ works with bash, but not shell)

if test "$(echo $EXISTS | grep -o $INPUT)" = "$INPUT" ; then
        echo "$INPUT is already installed. Skipping..."
else
        echo "INSTALL"
fi

INPUT="python3"

EXIST="$(which $INPUT)"
echo "${EXIST}"

if test "$(echo $EXIST | grep -o $INPUT)" = "$INPUT" ; then 
	echo "This is NOT what it should respond with."
else
	echo "Installing $INPUT..."
fi

