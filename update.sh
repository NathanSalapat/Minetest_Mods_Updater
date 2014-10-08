#!/bin/bash

#This script should pull a list of the directories in the parent folder, cd into each folder issue the Git Update command, update the files, move back to the parent directory and repeat until all files have been updated, then copy the files to the main mod directory.

# Path to the directory with mods
MODS_PATH=.
#Move to the parent directory so the script can self update.
cd ..

find $MODS_PATH -maxdepth 1 -type d -print0 | while read -d $'\0' dir
do
	echo "$dir"  #Prints the current directory, useful for debugging and logs, pointless right now.
	cd "$dir"    #Moves into the current directory, VERY IMPORTANT
	if [[ -d .git ]]; then
		git pull   #Runs the update call for GIT
	else
		printf 'Not a git repository\n'
	fi
	cd ..      #Moves back up to the parent directory
done            #Once all directories have cycled through this ends the loop

#Now that all files are updated copy them to the main directory.
rsync -r '' ~/.minetest/mods

#Move to the minetest/mods folder this should be default on all installs.
cd ~/.minetest/mods

#Run an external script to find out which files to rename and do it.
if [[ -f ./rename.sh ]]; then
	exec ./rename.sh
fi
