#!/usr/bin/env bash

rm bootstrap.tar
mkdir root
mkdir -m 0755 -p root/var/{cache/pacman/pkg,lib/pacman,log} root/{dev,run,private/etc/pacman.d}
for pkgnames in $(cat BBS_EXTRA/boostrappkgs); do
  pkgs="$(pwd)/BBS_OUT/${pkgnames}*.pkg.tar.zst ${pkgs}"
done
fakeroot pacman --noscriptlet --root $(pwd)/root --arch arm64 -U ${pkgs}
fakeroot chown 0:80 root/Library
fakeroot chown 0:3 root/var/empty
fakeroot chown 0:1 root/var/run
fakeroot rmdir --ignore-fail-on-non-empty root/{Applications,bin,dev,etc/{default,profile.d},Library/{Frameworks,LaunchAgents,LaunchDaemons,Preferences,Ringtones,Wallpaper},sbin,System/Library/{Extensions,Fonts,Frameworks,Internet\ Plug-Ins,KeyboardDictionaries,LaunchDaemons,PreferenceBundles,PrivateFrameworks,SystemConfiguration,VideoDecoders},System/Library,System,tmp,usr/{bin,games,include,sbin,var,share/{dict,misc}},var/{backups,cache,db,lib/misc,local,lock,logs,mobile/{Library/Preferences,Library,Media},mobile,msgs,preferences,root/Media,root,run,spool,tmp,vm}}
fakeroot mkdir -p root/private
fakeroot rm -f root/{sbin/{fsck,fsck_apfs,fsck_exfat,fsck_hfs,fsck_msdos,launchd,mount,mount_apfs,newfs_apfs,newfs_hfs,pfctl},usr/sbin/{BTAvrcp,BTLEServer,BTMap,BTPbap,BlueTool,WirelessRadioManagerd,absd,addNetworkInterface,aslmanager,bluetoothd,cfprefsd,distnoted,filecoordinationd,ioreg,ipconfig,mDNSResponder,mDNSResponderHelper,mediaserverd,notifyd,nvram,pppd,racoon,rtadvd,scutil,spindump,syslogd,wifid}}
fakeroot rm -f root/sbin/umount
fakeroot chmod 0775 root/Library
fakeroot mv root/private/etc/profile.d/* root/etc/profile.d/
fakeroot mv root/private/etc/pacman.d root/etc/
fakeroot rm -rf root/private/etc
fakeroot mv root/etc root/private
fakeroot mv root/private/var/cache/pacman root/var/cache
fakeroot mv root/private/var/lib/pacman/local/ root/var/lib/pacman
fakeroot rm -rf root/private/var
fakeroot mv root/var root/private/
cd root
fakeroot tar cf ../bootstrap.tar .
cd ..
rm -rf root
