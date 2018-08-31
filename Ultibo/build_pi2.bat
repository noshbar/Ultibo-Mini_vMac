@echo off
del kernel7.img
del *.o
del *.ppu
e:\Ultibo\Core\fpc\3.1.1\bin\i386-win32\fpc -B -Tultibo -Parm -CpARMV7A -WpRPI2B @e:\Ultibo\Core\fpc\3.1.1\bin\i386-win32\RPI2.CFG -O2 -dPLATFORM_PI2 minivmac.lpr
echo Done.