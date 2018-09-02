[![Baremetal Mini vMac](https://img.youtube.com/vi/7l2lzfapa88/0.jpg)](https://www.youtube.com/watch?v=7l2lzfapa88 "Bare metal Mini vMac")

# Bare metal Macintosh Plus emulator for Raspberry Pi

To quote the Mini vMac [homepage](https://www.gryphel.com/c/minivmac/): `The Mini vMac emulator collection allows modern computers to run software made for early Macintosh computers, the computers that Apple sold from 1984 to 1996 based upon Motorola's 680x0 microprocessors. Mini vMac is part of the Gryphel Project.`

As part of a Hackathon, the (out of date) SDL port was ported hastily to the [Ultibo](https://ultibo.org/) bare metal environment for Raspberry Pi.
This allows for quick booting, at the expense of other luxuries.

This is by no means a complete port, just a proof-of-concept.
Future work will instead be focused on the most up-to-date version of the source directly from the Mini vMac page.

## Running

* Format an SD card to be FAT32
* Copy the Raspberry Pi [firmware files](https://github.com/raspberrypi/firmware/tree/master/boot) onto it
* Download and extract the zip file from this release page onto the SD card, overwriting `kernel7.img`
* Put your `vMac.ROM` file in the root of the SD card
* Put your hard disk image in the root of the SD card
  *Note:* If you are using the precompiled release provided here, you will need to name it `224M.dsk`

No work has been done to make it easy to setup your Mac installation on the Raspberry Pi itself.
You will find it infinitely easier to set everything up on your desktop, then simply copy the hard disk image over to the SD card.

## Compiling

To build the library
* Install the arm-none-eabi toolchain from [here](https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads)
* Run `make` as usual
* This should result in `libminivmac.a`

To build the bare metal kernel
* Copy the `libminivmac.a` file to the Ultibo project folder
* Compile the project from inside Ultibo Lazarus, or by using one of the batch files
*Note*: you will need to edit the path to your Ultibo installation in the batch files.

---
Original README.txt:

MnvM_bld: README
Paul C. Pratt
www.gryphel.com
July 27, 2005


MnvM_bld is the build system for Mini vMac,
a miniature Macintosh emulator.

Further information may be found at
"http://minivmac.sourceforge.net/".


You can redistribute MnvM_bld and/or modify it under the terms
of version 2 of the GNU General Public License as published by
the Free Software Foundation.  See the included file COPYING.

MnvM_bld is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
license for more details.
