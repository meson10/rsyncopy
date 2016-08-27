# rsyncopy
Rsync based utility to create backups of your linux machine

Mount the drive at /mnt and call `bash backup.sh`

## Does the following
- Checks if a previous backup is available. Copies that first to ensure faster rsync.
- Uses current-day as backup ident, which reuses the same backup per-day. You can alter this.
- As well deletes the files changed in the same-day.
- Skips most common vestegial directories.
- Ensures that it doesn't recursively back itself.

## Todo
- Allow a custom exclude list.
- Rotate older backups to .tar.gz to save storage space.
- Streaming sync to/from S3 etc.
