❗❗❗ DISCLAIMER ❗❗❗

THIS IS FOR EDUCATIONAL PURPOSES ONLY! READ IN FULL BEFORE YOU DO ANYTHING.  MAKE SURE YOU UNDERSTAND STEPS. IF UNCLEAR ASK FIRST! I AM NOT RESPONSIBLE FOR BRICKING DEVICE OR IF ANYTHING GOING WRONG.

# openwrt-victure-wr1200
Files and guide to upgrade router to newest OpenWrt.

## Tools Needed
* 1 x Victure WR1200 router
* 1 x OpenWrt initramfs-kernal.bin or sysupgrade.bin firmware to replace stock with
* 1 x PC with TTL cable USB and can work with UNO v3, Terminal software (PuTTY, screen, minicom, etc...), TFTP server
* 1 x Arduino UNO v3 (i had [ELEGOO Arduino UNO v3 clone](https://www.amazon.com/ELEGOO-Controller-ATmega328P-Compatible-Arduino/dp/B0B6VV7MS7/))
* 1 x USB A-to-B for Arduino UNO to PC (mine came with one)
* 3 x [Male-to-Male jumper wires](https://www.amazon.com/California-JOS-Breadboard-Optional-Multicolored/dp/B0BRTJXND9/)
* 1 x Thin durable plastic pry tool (old credit card or heavy guitar[bass] pick)
* 1 x Small needle nosed pliers (for plastic through hole clips on heat sink)
* 1 x Small phillips head screwdriver
* 1 x Tape (optional to keep some tension on jumper wires, taped to board)

## Case Cracking Steps

1. Carefully seperate the router case with thin durable plastic pry tool, start in seam and pop top from bottom
2. Remove the 4 x phillips head screws holding the board to bottom of case
3. Slowly turn over the board, so the soldered antenna wires dont break their joints
4. Use the needle nose pliers to lightly squeeze and push through the heat sink plastic clips, try hard not to break 😅

## Setting Up PC Terminal software, Network Settings and TFTP Server

1. Terminal Software - [Linux Minicom](https://wiki.emacinc.com/wiki/Getting_Started_With_Minicom) or [Windows PuTTY](https://openwrt.org/docs/guide-quick-start/sshadministration#putty)
2. Network Settings - [Setup manual static IP, netmask and gateway on network interface](https://www.industrialshields.com/blog/arduino-industrial-1/how-to-change-the-ip-in-windows-and-linux-242?srsltid=AfmBOoqrQVQL3wka0YKcve9hqgtHmitYUfuwH4xq6jlTj3TnO4OOwu2n)
   - I used the U-Boot default environment settings of:
     + IP: 192.168.16.123, MASK: 255.255.255.0, GW: 192.168.16.111
3. [TFTP Server](https://openwrt.org/docs/guide-user/troubleshooting/tftpserver) - I used dnsmasq and atftpd on Linux

## Serial Console Setup

1. Connect jumper wires from UNO to routers board like so: UNO_GND->RTR_GND, UNO_TX_PIN_0->RTR_TX, UNO_RX_PIN_1->RTR_RX.  I used some tape to hold down the wires to the board, help keep from moving.
2. Plug USB A/B cable into UNO and PC make sure it's reconized by the OS. Either serial port (like /dev/ttyACM0) or COM# port. Should see some LED's flashing...
3. Open your terminal software and connect to UNO's serial port (mine was /dev/ttyACM0) using: 57600 8N1 no flow control
4. Power up the router, you should see OEM firmware puking it's text to the terminal now.. eventually ending at login or admin/root prompt.
5. (Optionally) Hit ENTER to go into routers console when says to, I just start pressing it when log at about 30s 😀
6. Poke around, grab any settings, configs, make back ups of stuff if you want...

## Loading New Firmware

1. Scroll back through text (or dmesg if entered into console) and you will notice bootloader options menu text, basically:
   - Option 1 loads initramfs-kernel.bin via TFTP into RAM
   - Option 2 loads sysupgrade.bin via TFTP into RAM and then writes it to flash, in one step
   - Option 4 enters the bootloader CLI (U-Boot environment)
2. Soo...
   - If TFTP server is setup and initramfs ready and want to test it choose Option 1
   - If TFTP server is setup and your happy with above and have sysupgrade ready, choose Option 2
   - Want more control, inspect memory, U-Boot env etc.. use Option 4
   - WANT EVEN MORE control using own U-Boot build or from forum... use the bootloader flash Option 9 (UNTESTED BY ME)

* I took this path 🤷‍♂️:
  - Option 4 - then typed `erase linux` and let it zap flash firmware sector. Then typed `reset` to reboot router
  - During boot, held down 1 for option 1 to test my initramfs or 2 for option 2 when was ready for sysupgrade flashing

## Files

I've included in this repo my notes, logs, dump of stock mtd0 "ALL", builds of the initramfs, sysupgrade firmware and my merged DTS + Makefile from `Reese` and `cd4046bf` on - https://forum.openwrt.org/t/support-for-victure-wr1200-ac1200/116138

Have fun, hope this helps!! -cheers- 🍻

REFERENCES:

- https://openwrt.org/docs/guide-user/installation/generic.flashing.tftp
- https://openwrt.org/docs/guide-quick-start/sshadministration
- https://openwrt.org/docs/techref/hardware/port.serial#terminal_emulation_software
- https://openwrt.org/docs/guide-user/troubleshooting/tftpserver
- https://openwrt.org/docs/techref/hardware/port.serial.cables#arduino_uno_rev3_as_usb_to_serial_cable (Method C)
- https://fccid.io/2AREL-WR1200/Internal-Photos/Internal-photos-4783102
- https://forum.openwrt.org/t/support-for-victure-wr1200-ac1200/116138
