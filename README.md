Minetest_Mods_Updater
=====================

A bash script for LINUX that automatically updates your minetest mods

To use, create a directory where you will put all your git cloned folders for mods. Git Clone the mods into said folder. Add Update.sh to that folder, and change the permissions to be executable, if needed. Change the rsync locations to be the location you are git cloning into and your mods directory. To update your mods just run the script, or create a cron job to execute the script for you. I personally have it run every morning at four am.

TODO:
Add the actual code for renaming the folders.
Add a bit more documentation.
Add a log output that prints the date and what mods were updated.
