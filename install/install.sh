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
    -u|--user)
    USERNAME="$2"
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

if [ -z "$USERNAME" ]; then
    read -p "Username (default: user): " USERNAME
else
    echo "Username: $USERNAME (pre-configured)"
fi;

echo "Mount points:"
echo "* Mapping partitions to mount points."
echo "** Use parted/gparted or scripts within the 'partition' directory to prepare partitions in advance."

if [ -z "$BOOT_PARTITION" ]; then
    read -p "/boot: " BOOT_PARTITION
else
    echo "/boot: $BOOT_PARTITION (pre-configured)"
fi;

if [ -z "$ROOT_PARTITION" ]; then
    read -p "/: " ROOT_PARTITION
else
    echo "/: $ROOT_PARTITION (pre-configured)"
fi;

if [ -z "$SWAP_PARTITION" ]; then
    read -p "/swap (optional): " SWAP_PARTITION
else
    echo "/swap: $SWAP_PARTITION (pre-configured)"
fi;

while true; do
    read -p "Are you sure you want to format $ROOT_PARTITION (/ partition)? " yn
    case $yn in
        [Yy]* ) echo "Formatting the boot partition..." && mkfs.fat -F 16 $BOOT_PARTITION; break;;
        [Nn]* ) echo "Aborting the installation"; exit 1;;
        * ) echo "Please answer yes or no.";;
    esac
done

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
    read -p "Do you want to format the boot partition ($BOOT_PARTITION)? " yn
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
git clone https://github.com/rezgar/nixos.git /mnt/etc/nixos

echo "Preparing hardware and user configs..."
cd /mnt/etc/nixos
git checkout $USERNAME || git branch $USERNAME && git checkout $USERNAME && sed -i "s/username = \"user\";/username = \"$USERNAME\";/g" /mnt/etc/nixos/user.nix

cp /mnt/etc/nixos.bak/hardware-configuration.nix /mnt/etc/nixos/

echo "Installing NixOS..."
nixos-install