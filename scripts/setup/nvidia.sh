echo -e "$TAG_STATUS Setting up Nvidia..."

if grep -q ^nvidia_drm.modeset=1 "/boot/loader/entries/arch.conf"; then
    echo -e "$TAG_SKIP Nvidia is already set."
else
    echo "nvidia_drm.modeset=1" | sudo tee -a /boot/loader/entries/arch.conf
    echo "options nvidia-drm modeset=1" | sudo tee -a "/etc/modprobe.d/nvidia.conf"
    sudo sed -i 's/^MODULES=(/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm /g' /etc/mkinitcpio.conf

    sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
    echo -e "$TAG_DONE Nvidia has been set."
fi
