#!/bin/bash

./simg2img system.img system.raw

# Windows
/cygdrive/c/Program\ Files/7-Zip/7z.exe x -osystem system.raw

# macOS
#mkdir -p mnt/ system/
#ext4fuse system.raw mnt/
#cp -r mnt/* system/
#umount mnt/
