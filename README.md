# BBS
A bad build system

I was bored so I made a pacman based bad build system for iOS, this is the first pacman based iOS bootstrap that I know of. 
Sadly it doesn't have automatic build dependency resolution, that is until I make a wrapper for it to build everything easily, which probably won't happen.

## Usage
Simply go into the package you want to build and run `makepkg -c ../makepkg.conf -d`
