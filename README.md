## Synopsis

Package installer for your desired apps. Use a txt file to list any apps that you want to install onto your computer.<br>
Feed that txt file to the script and walk away while your computer does all the work for you.

Note: The installations are done via [Homebrew](http://brew.sh) and [Homebrew Cask](https://caskroom.github.io), so the installer will install those two things first if you do not already have them.<br> Also, if the program is not available via either of these, then it will not be installed. 

## Motivation

I created this project so that I can easily install my favorite applications in one go after fresh OS installs.
I was tired of manually downloading apps from all of their different websites on a new machine.

## Installation

Download the installPackage.sh script. 

## Usage

1: Create a txt file with a list of applications that you want to install (one application per line). Save the file somewhere easy to remember.

2: Run the script with the following command, replacing the brackets with the full path to the txt file from step 1:<br>
```shell
sh installPackage.sh -f [full/path/to/txt/file]
```
Example: 
```shell
sh installPackage.sh -f /Users/JohnDoe/Desktop/appList.txt
```

#### Options

```shell
    -f or --file :          Used to specify the path to your input file. #REQUIRED
```
```shell
    -h or --help :          Will provide a brief help menu
```