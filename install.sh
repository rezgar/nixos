#! /bin/sh
set -e

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -r|--root)
    ROOT_PARTITION="$2"
    shift # past argument
    shift # past value
    ;;
    -b|--boot)
    BOOT_PARTITION="$2"
    shift # past argument
    shift # past value
    ;;
    -s|--swap)
    SWAP_PARTITION="$2"
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

echo "Getting ready to install NixOS."

echo "Please provide partition mapping:"
echo "Root partition /"
if [ $ROOT_PARTITION!="" ]; then
    echo "$ROOT_PARTITION (pre-configured)"
else
    read $ROOT_PARTITION
fi;

echo "Boot partition /boot"
if [ $BOOT_PARTITION!="" ]; then
    echo "$BOOT_PARTITION (pre-configured)"
else
    read $BOOT_PARTITION
fi;

echo "Swap partition (optional) /swap"
if [ $SWAP_PARTITION!="" ]; then
    echo "$SWAP_PARTITION (pre-configured)"
else
    read $SWAP_PARTITION
fi;

echo "Root partition ($ROOT_PARTITION) will be formatted. Please type yes to confirm."
read $INPUT
if [ $INPUT!="yes" ]; then
    echo "Installation aborted"
    exit 1;
fi;

## Partitioning and formatting

umount $ROOT_PARTITION && mkfs.ext4 -L nixos $ROOT_PARTITION
mount $ROOT_PARTITION /mnt

echo "Do you want to format the boot partition ($BOOT_PARTITION)?"
while true; do
    read -p "Do you wish to install this program?" yn
    case $yn in
        [Yy]* ) umount $BOOT_PARTITION && mkfs.fat -F 32 -L boot $BOOT_PARTITION; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
mkdir -p /mnt/boot
mount $BOOT_PARTITION /mnt/boot

if [ $SWAP_PARTITION!="" ]; then 
    umount $SWAP_PARTITION && mkswap -L swap $SWAP_PARTITION
    swapon $SWAP_PARTITION
fi;

## Setting up NixOS configuration

nixos-generage-config --root /mnt

# Backing up the generated configuration
mv /mnt/etc/nixos /mnt/etc/nixos.bak

# Installing Git
nix-env -iA nixos.pkgs.gitAndTools.gitFull

git clone https://github.com/rezgar/nixos-settings.git /mnt/etc/nixos
cp /mnt/etc/nixos.bak/hardware-configuration.nix /mnt/etc/nixos/
cp /mnt/etc/nixos/user.template.nix /mnt/etc/nixos/user.nix

nixos-install