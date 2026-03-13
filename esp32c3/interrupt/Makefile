# ===============================================
# Makefile para ESP32-C3 con debug en C y Assembly
# ===============================================

CFLAGS ?= -W -Wall -Wextra -Werror -Wundef -Wshadow
CFLAGS += -Wdouble-promotion -fno-common -Wconversion
CFLAGS += -march=rv32imc_zicsr -mabi=ilp32 -mcmodel=medany
CFLAGS += -g -O0 -ffunction-sections -fdata-sections -I.
PORT ?= /dev/ttyUSB0

# Debug info para assembly: usamos -g también
ASFLAGS = -g

LDFLAGS ?= -Lmain -Tmain/link.ld -nostdlib -nostartfiles -Wl,--gc-sections $(EXTRA_LINKFLAGS)

CWD ?= $(realpath $(CURDIR))
CC = $(shell which riscv32-esp-elf-gcc || find /opt/esp/tools -name "riscv32-esp-elf-gcc" | head -n 1)

# ===============================================
# Fuentes
# ===============================================
C_SRCS = main/startup.c main/hal.c
ASM_SRCS = main/program.s  # Se puede renombrar a program.S si quieres que pase por preprocesador
OBJS = $(C_SRCS:.c=.o) $(ASM_SRCS:.s=.o)

# ===============================================
# Targets
# ===============================================
build: firmware.bin

# Compila el ELF
firmware.elf: $(OBJS) main/hal.h main/link.ld Makefile
	@echo "Directorio actual: $(CWD)"
	$(CC) $(OBJS) $(LDFLAGS) -o $@

# Compilar C
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Compilar assembly con debug
%.o: %.s
	$(CC) $(CFLAGS) $(ASFLAGS) -c $< -o $@

# Genera binario para flash
firmware.bin: firmware.elf
	./esputil/esputil mkbin firmware.elf $@

# Flash al ESP32-C3
flash: firmware.bin
	./esputil/esputil -v -p $(PORT) flash 0 firmware.bin

# Monitor serial
monitor:
	./esputil/esputil -v -p $(PORT) monitor

# Limpiar todo
clean:
	@rm -rf *.{bin,elf,map,lst,tgz,zip,hex} firmware* *.o
