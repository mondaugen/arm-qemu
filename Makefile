# The name of the output binary
SRC=main
# This sets the compiler to use. Most people use gcc clang is also another
# common compiler. It becomes the variable which can be accessed with $(CC)
CC=arm-none-eabi-gcc
LINKER=arm-none-eabi-ld
OBJCOPY=arm-none-eabi-objcopy
# Compiler flags
CFLAGS=-c -g -mcpu=cortex-a8
# These are linker flags only needed if using external libraries but we are not
# in this
LDFLAGS=-T linker.ld -nostartfiles
# This says to grab all the files with the c extension in this directory and
# make them the array called SRC_SOURCES
SRC_SOURCES=$(wildcard *.c)
# This makes an array of all the c files but replaces .c with .o
SRC_OBJECTS=$(SRC_SOURCES:.c=.o)

ELF=$(SRC).elf
BIN=$(SRC).bin

# When you run make then all is the default command to run. So running `make` is
# the same as running `make all`
all: $(SRC)

# This says to build $(SRC) then all the o files need to be present / up to
# date first. The way they get up to date is by compiling the c files in to
# their respective o files
$(ELF): $(SRC_OBJECTS)
	@# The $@ variable gets replaced with $(SRC)
	$(LINKER) $(LDFLAGS) $(SRC_OBJECTS) -o $@

$(BIN): $(ELF)
	@# Make the elf a binary
	$(OBJCOPY) -O binary $< $@

# This is the action that is run to create all the .o files, object files.
# Every c file in the array SRC_SOURCES is compiled to its object file for
# before being linked together
%.o:%.c
	$(CC) $(CFLAGS) $< -o $@

# Clean deletes everything that gets created when you run the build. This means
# all the .o files and the binary named $(SRC)
clean:
	rm -f $(SRC) *.o *.tar.xz *.core *.elf *.bin

# This creates the tar file for submission
tar:
	tar czvf $(SRC).tar.xz $(SRC_SOURCES) Makefile

# Run the binary in qemu
qemu: $(BIN)
	qemu-system-arm -M realview-pb-a8 -m 128M -nographic -s -S -kernel $(SRC).bin &

# Run the binary in qemu with gdb server then launch gdb
gdb: qemu
	gdb-multiarch
