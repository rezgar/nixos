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

echo "Root partition /"
if [ -z "$ROOT_PARTITION" ]; then
    read ROOT_PARTITION
else
    echo "$ROOT_PARTITION (pre-configured)"
fi;

echo "Boot partition /boot"
if [ -z "$BOOT_PARTITION" ]; then
    read BOOT_PARTITION
else
    echo "$BOOT_PARTITION (pre-configured)"
fi;

echo "Swap partition (optional) /swap"
if [ -z "$SWAP_PARTITION" ]; then
    read SWAP_PARTITION
else
    echo "$SWAP_PARTITION (pre-configured)"
fi;

read -p "Root partition ($ROOT_PARTITION) will be formatted. Please type yes to confirm." reply
if [ "$reply" != "yes" ]; then
    echo "Installation aborted"
    exit 1;
fi;

## Partitioning and formatting

echo "Unmounting the partitions partition..."
umount $BOOT_PARTITION || umount /mnt/boot || true
umount $ROOT_PARTITION || umount /mnt || true
umount $SWAP_PARTITION || true

echo "Formatting the root partition..."
mkfs.ext4 -L nixos $ROOT_PARTITION

echo "Mounting the root partition..."
mount $ROOT_PARTITION /mnt

while true; do
    read -p "Do you want to format the boot partition ($BOOT_PARTITION)?" yn
    case $yn in
        [Yy]* ) echo "Formatting the boot partition..." && mkfs.fat -F 16 $BOOT_PARTITION; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

mkdir -p /mnt/boot
echo "Mounting the boot partition..."
mount $BOOT_PARTITION /mnt/boot

if [ "$SWAP_PARTITION" != "" ]; then 
    echo "Formatting the swap partition..."
    mkswap -L swap $SWAP_PARTITION
    echo "Enabling swap..."
    swapon $SWAP_PARTITION
fi;

## Setting up NixOS configuration

echo "Generating NixOS config..."
nixos-generate-config --root /mnt

# Backing up the generated configuration
echo "Backing up NixOS config..."
mv /mnt/etc/nixos /mnt/etc/nixos.bak

# Installing Git
echo "Installing Git..."
nix-env -iA nixos.pkgs.gitAndTools.gitFull

echo "Pulling NixOS settings..."
git clone https://github.com/rezgar/nixos-settings.git /mnt/etc/nixos

echo "Preparing hardware and user configs..."
cp /mnt/etc/nixos.bak/hardware-configuration.nix /mnt/etc/nixos/
cp /mnt/etc/nixos/user.template.nix /mnt/etc/nixos/user.nix

echo "Installing NixOS..."
nixos-install