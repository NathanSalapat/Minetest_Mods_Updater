Minetest_Mods_Updater
=====================

A bash script for LINUX that automatically updates your minetest mods

To use, create a directory where you will git clone mods. Make sure to clone this to the same location.
Call the updater with update.sh -s /home/yourname/gitclone/ -d /home/yourname/.minetest/mods Replace the yourname and gitclone as appropriate.

To run the script as a cron job just add it like this, open a terminal and type crontab -e
Your crontab will open, then add the following line.

* 4 * * * /home/yourname/gitclone/Minetest_Mods_Updater/update.sh >/dev/null 2>&1

Of course you can change when the job runs. If you aren't familiar with that syntax visit this page: http://www.howtoforge.com/a-short-introduction-to-cron-jobs


The script now calls another script, which needs to be located in ~/.minetest/mods and called rename.sh
Sample script for the rename script:
rm -rf mesecons
mv minetest-mod-mesecons mesecons

Just duplicate these two lines as you need to. The first line deletes the original folder, and the second renames the folder from GIT to the name the mod needs.
