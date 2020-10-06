# Ergo88 Wireless Keyboard Firmware
Firmware for Nordic MCUs used in the Redox wireless Keyboard, contains precompiled .hex files, as well as sources buildable with the Nordic SDK
This firmware was derived from [Reversebias' Mitosis](https://github.com/reversebias/mitosis) and [Durburz's Interphase](https://github.com/Durburz/interphase-firmware/) firmware.

This repository was clone from [mattdibi's redox-w-firmware](https://github.com/mattdibi/redox-w-firmware) firmware.

## Ergo88's documentation page
For additional information about the Ergo88 keyboard visit:
- [Ergo88's Github page](https://github.com/BurningBright/ergo88-firmware)

## Install dependencies

Tested on Ubuntu 16.04.2, but should be able to find alternatives on all distros.

```
sudo apt install openocd gcc-arm-none-eabi
```

## Download Nordic SDK

Nordic does not allow redistribution of their SDK or components, so download and extract from their site:

https://developer.nordicsemi.com/nRF5_SDK/nRF5_SDK_v11.x.x/nRF5_SDK_11.0.0_89a8197.zip

Firmware written and tested with version 11

```
unzip nRF5_SDK_11.0.0_89a8197.zip -d nRF5_SDK_11
cd nRF5_SDK_11
```

## Toolchain set-up

A cofiguration file that came with the SDK needs to be changed. Assuming you installed gcc-arm with apt, the compiler root path needs to be changed in /components/toolchain/gcc/Makefile.posix, the line:

```
GNU_INSTALL_ROOT := /usr/local/gcc-arm-none-eabi-4_9-2015q1
```

Replaced with:

```
GNU_INSTALL_ROOT := /usr/
```

## Clone repository
Inside nRF5_SDK_11/

```
git clone https://github.com/BurningBright/ergo88-firmware
```

## Install udev rules

```
sudo cp ergo88-firmware/49-stlinkv2.rules /etc/udev/rules.d/
```
Plug in, or replug in the programmer after this.

## OpenOCD server
The programming header on the bottom of the keyboard:

It's best to remove the battery during long sessions of debugging, as charging non-rechargeable lithium batteries isn't recommended.

Launch a debugging session with:

```
openocd -s /usr/local/Cellar/open-ocd/0.8.0/share/openocd/scripts/ -f interface/stlink-v2.cfg -f target/nrf51_stlink.tcl
```
Should give you an output ending in:

```
Info : nrf51.cpu: hardware has 4 breakpoints, 2 watchpoints
```
Otherwise you likely have a loose or wrong wire.


## Manual programming
From the factory, these chips need to be erased:

```
echo reset halt | telnet localhost 4444
echo nrf51 mass_erase | telnet localhost 4444
```
From there, the precompiled binaries can be loaded:

```
echo reset halt | telnet localhost 4444
echo flash write_image `readlink -f precompiled-basic-left.hex` | telnet localhost 4444
echo reset | telnet localhost 4444
```

## Automatic make and programming scripts
To use the automatic build scripts:
* keyboard-left:  `./ergo88-keyboard-basic/program_left.sh`
* keyboard-right: `./ergo88-keyboard-basic/program_right.sh`
* receiver:       `./ergo88-receiver-basic/program.sh`

An openocd session should be running in another terminal, as this script sends commands to it.
