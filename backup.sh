#! /bin/bash

set -e

grep -qs '/mnt' /proc/mounts || (echo "No external drive is mounted on /mnt"; exit 1)

DATE=`date +%Y%m%d`
DEST="backup-${DATE}"

# Find latest directory and copy it first.
LAST_DIR=$(find /mnt -maxdepth 1 -name 'backup-*' -type d | sort -nr | head -1)

if [[ -z "$LAST_DIR" ]]; then
  # Otherwise create a directory.
  sudo mkdir -p /mnt/${DEST}
else
  LAST_DIR=$(basename $LAST_DIR)
  [[ "$LAST_DIR" == "$DEST" ]] || (sudo rsync -aAxh --progress /mnt/${LAST_DIR} /mnt/${DEST})
fi

# Rsync the contents and exclude these paths. Also deletes any entries that were
# deleted at source.
sudo rsync -aAXh --progress --delete=before --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","/home/*/.cache/chromium/*","/home/*/.local/share/Trash/*","/home/*/.gvfs","/home/*/.thumbnails/*","/home/*/.cache/mozilla/*"} / /mnt/${DEST}/
