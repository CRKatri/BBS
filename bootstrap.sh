#!/bin/bash

iproxy 4444 44 >> /dev/null 2>/dev/null &

echo '#!/bin/bash' > device.sh
echo '' >> device.sh
echo 'mount -uw -o  union /dev/disk0s1s1' >> device.sh
echo 'rm -rf /etc/profile' >> device.sh
echo 'rm -rf /etc/profile.d' >> device.sh
echo 'rm -rf /etc/alternatives' >> device.sh
echo 'rm -rf /etc/pacman.d' >> device.sh
echo 'rm -rf /etc/pacman.conf' >> device.sh
echo 'rm -rf /etc/ssl' >> device.sh
echo 'rm -rf /etc/ssh' >> device.sh
echo 'rm -rf /var/cache' >> device.sh
echo 'rm -rf /var/lib' >> device.sh
echo 'tar --preserve-permissions -xf bootstrap.tar -C /' >> device.sh
echo 'launchctl load -w /Library/LaunchDaemons/com.openssh.sshd.plist' >> device.sh
echo '/usr/bin/snaputil -n $(/usr/bin/snaputil -l /) orig-fs /' >> device.sh
echo 'pwd_mkdb -p /etc/master.passwd &>/dev/null' >> device.sh
echo 'chsh -s /usr/bin/zsh root &>/dev/null' >> device.sh
echo 'chsh -s /usr/bin/zsh mobile &>/dev/null' >> device.sh
echo 'rm /etc/pwd.db /etc/spwd.db' >> device.sh
echo 'pacman-key --init' >> device.sh
echo 'pacman-key --populate' >> device.sh
echo 'echo 7D3B36CEA40FCC2181FB6DCDBAFFD97826540F1C:6: | gpg --homedir /etc/pacman.d/gnupg/ --import-ownertrust' >> device.sh
echo 'touch /.mount_rw' >> device.sh
echo 'touch /.bootstrapped' >> device.sh
echo 'rm bootstrap.tar' >> device.sh
echo 'rm device.sh' >> device.sh

zstd -d bootstrap.tar.zst
scp -P4444 -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" bootstrap.tar device.sh root@127.0.0.1:/var/root/
ssh -p4444 -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" root@127.0.0.1 "bash /var/root/device.sh"
rm device.sh bootstrap.tar

killall iproxy
