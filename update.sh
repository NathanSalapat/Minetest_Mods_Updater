#!/bin/bash

#This script should pull a list of the directories in the parent folder, cd into each folder issue the Git Update command, update the files, move back to the parent directory and repeat until all files have been updated, then copy the files to the main mod directory.

#Define MODS as a listing of all the subdirectories
MODS=`ls`

for i in ${MODS}; do
     echo "$i"  #Prints the current directory, useful for debugging and logs, pointless right now.
     cd $i      #Moves into the current directory, VERY IMPORTANT
     git pull   #Runs the update call for GIT
     cd -;      #Moves back up to the parent directory
done            #Once all directories have cycled through this ends the loop

#Now that all files are updated copy them to the main directory.

#rsync GIT_LOCATION MINETEST_MOD_LOCATION

#Move to the minetest/mods folder Please fill this out for your computer, currently is the default
cd ~/.minetest/mods

#Rename the folders that need it. This must be filled out manually. Basically removes the folder with the right name, and then renames the folder with the wrong name to the right name
rm -rf Correct_Folder_Name
mv Git_Folder_Name Correct_Folder_Name
