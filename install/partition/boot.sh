#! /bin/sh
set -e

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

DISK=${POSITIONAL[0]}
PARTITION=${POSITIONAL[1]}

umount $DISK$PARTITION || true
parted -s $DISK mkpart fat16 64s 300MiB
parted -s $DISK set $PARTITION msftdata off
parted -s $DISK set $PARTITION esp on