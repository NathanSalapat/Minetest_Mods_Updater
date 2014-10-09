#!/usr/bin/env bash
# This script should pull a list of the directories in the parent folder,
# cd into each folder issue the Git Update command, update the files,
# move back to the parent directory and repeat until all files have been updated,
# then copy the files to the main mod directory.

SCRIPT_PATH=$(dirname "${BASH_SOURCE[0]}")

show_help() {
	printf 'Usage: update.sh -s "path to mods" -d "destination"\n'
}

# log function by Sebastien Andre
# https://gist.github.com/swaeku/6560309
log() {
	local level=${1?}
	shift
	local code= line="[$(date '+%F %T')] $level: $*"
	if [[ -t 2 ]]; then
		case "$level" in
		  INFO) code=36 ;;
		  DEBUG) code=30 ;;
		  WARN) code=33 ;;
		  ERROR) code=31 ;;
		  *) code=37 ;;
		esac
		printf '\e[%dm%s\e[0m\n' ${code} "${line}"
	else
		printf '%s\n' "$line"
	fi >&2
}
update_self() {
	log INFO 'Updating the script'
	cd ${SCRIPT_PATH}
	git pull \
		&& log INFO 'OK' \
		|| log WARN 'fail'
}

# Set variables accordingly to passed arguments or show help
[[ ${#@} -eq 0 ]] && show_help && exit 0
while :
do
	case "$1" in
		-h | --help)
		  show_help
		  exit 0
		  ;;
		-s | --source)
		  MODS_PATH="${2}"
		  shift 2
		  ;;
		-d | --destination)
		  DESTINATION_PATH="${2}"
		  shift 2
		  ;;
		-u | --update)
		  AUTO_UPDATE=1
		  shift
		  ;;
		*)
		  break
		  ;;
	esac
done

# update the script
if [[ -t 1 ]]; then # if stdout is terminal
	# optionally, ask before updating
	if [[ ${AUTO_UPDATE} -eq 0 ]]; then
		printf 'Do you wish to update the script?\nType Y to update: '
		read yn
		[[ $yn == [Yy]* ]] \
			&& update_self
	else
		update_self
	fi
fi

find "${MODS_PATH}" -maxdepth 1 -type d -print0 | while read -d $'\0' dir
do
	cd "$dir"
	# just skip directories without git
	[[ ! -d .git ]] && continue

	log INFO "Updating mod $(basename "$dir"):"
	# check if there is remote-tracking branch
	if git branch -v | grep 'remote-tracking'; then
		# placeholder for interactive
		# merging of forks
		:
	else
		if git pull; then
			# TODO add check if it actually updated
			log INFO 'OK'
			git reflog | head -3
		else
			log ERROR 'pull failed'
		fi
	fi
done

# Now that all files are updated copy them to the main directory.
rsync -r --exclude='.git' \
	"${MODS_PATH}" \
	"${DESTINATION_PATH}"

#Move to the minetest/mods folder this should be default on all installs.
cd "${DESTINATION_PATH}"

#Run an external script to find out which files to rename and do it.
if [[ -f ${SCRIPT_PATH}/rename.sh ]]; then
	exec ${SCRIPT_PATH}/rename.sh
fi
