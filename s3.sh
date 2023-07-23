#!/bin/bash
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

REMOTE_PATH=s3://rambo-remote/Backups
LOCAL_PATH=$HOME/Backups

mkdir -p "$LOCAL_PATH"

s3cmd sync "$REMOTE_PATH/" "$LOCAL_PATH/"

s3cmd sync "$LOCAL_PATH/"BACKUP* "$REMOTE_PATH/"
