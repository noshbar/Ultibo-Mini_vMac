@echo off
del kernel7.img
del *.o
del *.ppu
e:\Ultibo\Core\fpc\3.1.1\bin\i386-win32\fpc -B -Tultibo -Parm -CpARMV7A -WpQEMUVPB @e:\Ultibo\Core\fpc\3.1.1\bin\i386-win32\QEMUVPB.CFG -O2 -dPLATFORM_QEMU minivmac_sdl.lpr
echo Done.