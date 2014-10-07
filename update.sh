#!/bin/bash

#This script should pull a list of the directories in the parent folder, cd into each folder issue the Git Update command, update the files, move back to the parent directory and repeat until all files have been updated, then copy the files to the main mod directory.

#Define MODS as a listing of all the subdirectories
MODS=`ls`

for i in ${MODS}; do
     echo "$i"  #Prints the current directory, useful for debugging and logs
     cd $i      #Moves into the current directory, VERY IMPORTANT
     ls         #Runs the update call for GIT 'obviously not right now'
     cd -;      #Moves back up to the parent directory
done            #Once all directories have cycled through this ends the loop

#Now that all files are updated copy them to the main directory.

#rsync ./home/nathan/Mintest_Git ./home/nathan/.minetest/mods

#Rename the folders that need it. This must be filled out manually.


