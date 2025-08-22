#!/bin/bash

SRC=~/projects/private/ihhs-payment-forms/
ARCHIVE=~/projects/private/ihhs-payment-forms.7z
REMOTE=gdrive:/ihhs-payment-forms/

echo "Re-encrypting folder..."
7z a -t7z -mhe=on -p "$ARCHIVE" "$SRC"

echo "Uploading to Google Drive..."
rclone copy "$ARCHIVE" "$REMOTE"

echo "Done!"
