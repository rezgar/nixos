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
parted -s $DISK rm $PARTITION || true
parted -s $DISK mktable gpt || true
./boot.sh $DISK $(parted $DISK print | grep esp | awk '{print $1}') 1
parted -s $DISK -- mkpart ext4 300MiB -1