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

parted -s $DISK rm $PARTITION
parted -s $DISK mktable gpt
parted -s $DISK mkpart fat16 64s 300MiB
parted -s $DISK mkpart ext4 300MiB -1s