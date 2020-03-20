#! /bin/sh
set -e

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -d|--disk)
    DISK="$2"
    shift # past argument
    shift # past value
    ;;
    -pn|--partition-number)
    PARTITION="$2"
    shift # past argument
    shift # past value
    ;;
    --default)
    DEFAULT=YES
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

parted -s $DISK rm $PARTITION
parted -s $DISK mktable gpt
parted -s $DISK mkpart fat16 64s 300MiB
parted -s $DISK mkpart ext4 300MiB -1s