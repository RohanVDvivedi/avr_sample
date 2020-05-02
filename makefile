CC:=avr-gcc -c
LD:=avr-ld
OC:=avr-objcopy

#compiler flags
CCFLAGS:=-Os

#linker flags
LDFLAGS:=-L. -T linker_script.ld

# generate objects from c sources
%.o : %.c
	${CC} $(CCFLAGS) $< -o $@ -I.

# generate objects from asm sources
%.o : %.S
	${CC} $(CCFLAGS) $< -o $@

# generate final elf by linking all the object files
main.elf : startup.o main.o
	$(LD) $(LDFLAGS) $^ -o $@

# convert to hex or binary that can be transfered by the corresponding uploader driver
main.bin : main.elf
	${OC} -O binary main.elf main.bin

all : main.bin

clean : 
	rm -rf *.o *.elf *.bin

# upload command to upload the code to the microcontroller
upload :