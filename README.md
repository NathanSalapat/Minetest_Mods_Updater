Minetest_Mods_Updater
=====================

A bash script for LINUX that automatically updates your minetest mods

To use, create a directory where you will put all your git cloned folders for mods. Git Clone the mods into said folder. Add Update.sh to that folder, and change the permissions to be executable, if needed. Change the rsync locations to be the location you are git cloning into and your mods directory. To update your mods just run the script, or create a cron job to execute the script for you. I personally have it run every morning at four am.

The script now calls another script, which needs to be located in ~/.minetest/mods and called rename.sh
Sample script for the rename script:
rm -rf mesecons
mv minetest-mod-mesecons mesecons

Just duplicate these two lines as you need to. The first line deletes the original folder, and the second renames the folder from GIT to the name the mod needs.
