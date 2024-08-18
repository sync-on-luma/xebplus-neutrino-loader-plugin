neutrino is a digital game loader for PlayStation 2

It is based on OPL. but a lot simpler...

Usage: neutrino.elf -drv=<driver> -iso=<path>

Options:
  -drv=<driver>     Select block device driver, supported are: ata, usb, mx4sio(sdc), udpbd(udp) and ilink(sd)
  -iso=<file>       Select iso file (full path!)
  -mt=<type>        Select media type, supported are: cd, dvd. Defaults to cd for size<=650MiB, and dvd for size>650MiB
  -ip=<ip>          Set IP adres for udpbd, default: 192.168.1.10
  -nR               No reboot before loading the iso (faster)
  -eC               Enable eecore debug colors

Usage example:
  ps2client -h 192.168.1.10 execee host:neutrino.elf -drv=usb -iso=mass:path/to/filename.iso

neutrino was coded by Maximus32
