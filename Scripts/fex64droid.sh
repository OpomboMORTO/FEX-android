#!/bin/bash

echo ""
echo "1. [ PERMISSÕES DE ARMAZENAMENTO ]"
echo ""
termux-setup-storage && pkg update -y && pkg clean && pkg upgrade -y
echo ""
echo "PERMISSÕES ATUALIZADAS"
echo ""

sleep 1

echo ""
echo "2. [ INSTALANDO X11 ]"
echo ""
pkg install root-repo -y && pkg install tsu -y &&  pkg install x11-repo && pkg install pulseaudio xwayland xorg-server-xvfb wget -y && wget https://github.com/OpomboMORTO/FEX-android/raw/main/Apps/termux-x11-1.02.07-0-all.deb && dpkg -i ./*.deb && rm -rf ./*.deb
echo ""
echo "X11 INSTALADO"
echo ""

sleep 1

echo ""
echo "3. [ CORRIGINDO DEPENDENCIAS ]"
echo ""
apt --fix-broken install
echo ""
echo "PARTIÇÕES CORRIGIDAS"
echo ""

sleep 1

echo ""
echo "4. [ INSTALANDO ROOT FS -FEX ]"
echo ""
sudo mkdir -p /data/local/debian && cd /data/local/debian && sudo cp /storage/emulated/0/rootfs-Fex.tar.gz /data/local/debian && sudo tar -xvf rootfs-Fex.tar.gz
echo ""
echo "DESCOMPACTADO"
echo ""

sleep 1

echo ""
echo "5. [ CRIANDO PASTAS ]"
echo ""
sudo mkdir dev proc sys dev/pts
echo ""
echo ""
echo ""

sleep 1

echo ""
echo "6. [ CRIANDO EXECUTAVEL ]"
echo ""
echo '

#!/bin/bash

echo ""
echo "1. [ INICIANDO TERMUX:X11 ]"

DISPLAY=:1 termux-x11 &>/dev/null & env DISPLAY=:1 Xvfb -listen tcp :1 -ac -screen 0 1280x720x24 &>/dev/null & pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1 &>/dev/null

exit 0

' > x11-start

chmod +x x11-start && mv x11-start $PREFIX/bin

echo '

#!/bin/sh
echo -e ""
echo -e "\x1b[32m\033[1m#################################"
echo -e "\x1b[32m#      Script by Pro-L!nux      #"
echo -e "\x1b[32m#################################"
export PATH=/sbin:/usr/bin:/usr/sbin:/system/bin:/system/xbin:$PATH
export USER=root
export HOME=/root
export LANGUAGE=C
export LANG=C
folder=/data/local/debian
echo -e "\x1b[33m [ Mounting system folders ]"
echo "   [ Mounting /dev ... ]"
busybox mount --bind /dev $folder/dev
echo "   [ Mounting /sys ... ]"
busybox mount --bind /sys $folder/sys
echo "   [ Mounting /proc ... ]"
busybox mount --bind /proc $folder/proc
echo "   [ Mounting /dev/pts ... ]"
busybox mount --bind /dev/pts $folder/dev/pts
echo "   [ Mounting /sdcard ... ]"
busybox mount --bind /storage/emulated/0/ $folder/storage/emulated/0/
echo -e "\x1b[32m [ Mounting Done ! ]"

echo -e "\x1b[32m [ Chrooting ... ]\e[0m"
busybox chroot $folder /bin/su - root

echo -e "\033[1m\x1b[33m [ Unmounting dev/pts ... ]"
busybox umount $folder/dev/pts
echo -e " [ Unmounting /dev ... ]"
busybox umount $folder/dev
echo -e " [ Unmounting /proc ... ]"
busybox umount $folder/proc
echo -e " [ Unmounting sdcard ... ]"
busybox umount $folder/storage/emulated/0/
echo -e " [ Unmounting /sys ... ]"
busybox umount $folder/sys
echo -e " \x1b[32m[ Unmounted ]\e[0m"

exit 0

' > chroot.sh

mv chroot.sh $HOME && chmod 777 chroot.sh

cd

echo '

#!/bin/bash

./chroot.sh

x11-start

su
./chroot.sh '> start-fex

chmod +x start-fex && mv start-fex $PREFIX/bin

cd

exit 2

echo ""
echo "INSTALACAO FEITA"
echo ""
