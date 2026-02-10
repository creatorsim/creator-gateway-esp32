CFLAGS ?= -W -Wall -Wextra -Werror -Wundef -Wshadow
CFLAGS += -Wdouble-promotion -fno-common -Wconversion
CFLAGS += -march=rv32imc_zicsr -mabi=ilp32 -mcmodel=medany
CFLAGS += -Os -ffunction-sections -fdata-sections -I.
LDFLAGS ?= -Lmain  -Tlink.ld -nostdlib -nostartfiles -Wl,--gc-sections $(EXTRA_LINKFLAGS)
CWD ?= $(realpath $(CURDIR))
C = $(shell which riscv32-esp-elf-gcc || find /opt/esp/tools -name "riscv32-esp-elf-gcc" | head -n 1)
SOURCES = main/startup.c main/hal.c main/program.s

build: firmware.bin

firmware.elf: $(SOURCES) main/hal.h main/link.ld Makefile
	@echo "Directorio actual: $(CWD)"
	$(C) $(CFLAGS) $(CFLAGS_EXTRA) $(SOURCES) $(LDFLAGS) -o $@

firmware.bin: firmware.elf
	./esputil/esputil mkbin firmware.elf $@

flash: firmware.bin
	./esputil/esputil flash 0 firmware.bin

monitor:
	./esputil/esputil monitor

clean:
	@rm -rf *.{bin,elf,map,lst,tgz,zip,hex} firmware*
