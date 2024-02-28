qemu-system-x86_64 -accel kvm -hda ./main.raw -hdb ./secondary.raw -m 2048 -smp 2 -vga std -bios /usr/share/ovmf/x64/OVMF.fd -boot strict=on
