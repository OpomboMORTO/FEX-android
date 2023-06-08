# FEX-android

FEX Quick Installation Script on Android Devices 
This script is made to automate the process of installing fex-emu on Android devices.


# what is the fex

FEX allows you to run x86 and x86-64 binaries on an AArch64 host, similar to qemu-user and box86. I
t has native support for a rootfs overlay, so you don't need to chroot, as well as some thunklibs so it can forward things like GL to the host. FEX presents a Linux 5.0 interface to the guest, and supports both AArch64 and x86-64 as hosts. FEX is very much work in progress, so expect things to change.

# fex source code 

https://github.com/FEX-Emu/FEX

# install fex64droid

first install Termux-11 is Termux, after initializing Termux for the first time, copy and paste this command and hit enter 

curl -O https://raw.githubusercontent.com/OpomboMORTO/FEX-android/main/Scripts/instalador-Fex.sh && chmod +x instalador-Fex.sh && ./instalador-Fex.sh

