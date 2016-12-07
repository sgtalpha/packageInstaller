#!/bin/bash

##################################
######## HOMEBREW SECTION ########
##################################

#Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#Install Git via Homebrew if doesn't exis
EXISTS='type git'

if [ "$EXISTS" == *'not found'* ] ; then
        brew install git
        echo "Git successfully installed"
else
        echo "Git is already installed. Skipping..."
fi

#Install tmux via Homebrew
brew install tmux

#Install Nmap via Homebrew
brew install nmap

#Install Python via Homebrew
brew install python

#Install Python3 via Homebrew
brew install python3

#######################################
######## HOMEBREW CASK SECTION ########
#######################################

#Install Homebrew-Cask extension
brew tap caskroom/cask

#Install The Unarchiver via Homebrew-Cask
brew cask install the-unarchiver

#Install Spotify via Homebrew-Cask
brew cask install spotify

#Install Textmate via Homebrew-Cask
brew cask install textmate

#Install Vuze via Homebrew-Cask
brew cask install vuze

#Install Handbreak via Homebrew-Cask
brew cask install handbreak

#Install Slack via Homebrew-Cask
brew cask install slack

#Install VLC via Homebrew-Cask
brew cask install vlc

#Install Minecraft via Homebrew-Cask
brew cask install minecraft

#Install LOL via Homebrew-Cask
brew cask install league-of-legends

#Install Dolphin via Homebrew-Cask
brew cask install Dolphin

#Install Discord via Homebrew-Cask
brew cask install discord

#Install NameChanger via Homebrew-Cask
brew cask install namechanger
