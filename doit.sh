#!/bin/bash

../a85/a85 vdp-80.asm -l vdp-80.prn -o vdp-80.hex && /usr/local/opt/binutils/bin/objcopy -I ihex vdp-80.hex -O binary vdp-80.bin

xxd vdp-80.rom > /tmp/a.txt
xxd vdp-80.bin > /tmp/b.txt
diff /tmp/a.txt /tmp/b.txt
