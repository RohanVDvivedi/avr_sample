CC:=avr-gcc -c
LD:=avr-ld
OC:=avr-objcopy

#compiler flags
CCFLAGS:=-mmcu=attiny85 -Os

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
	${OC} -O ihex main.elf main.bin

all : main.bin

clean : 
	rm -rf *.o *.elf *.bin *.temp

# upload command to upload the code to the microcontroller
upload :
	avrdude -v -c usbasp -p t85 -U flash:w:main.bin

read_generics :
	avrdude -v -c usbasp -p t85 -U signature:r:signature.temp:h -U lfuse:r:lfuse.temp:h -U hfuse:r:hfuse.temp:h -U efuse:r:efuse.temp:h -U lock:r:lockbits.temp:h

read_eeprom :
	avrdude -v -c usbasp -p t85 -U eeprom:r:eeprom_contents.temp:r

read_flash :
	avrdude -v -c usbasp -p t85 -U flash:r:flash_contents.temp:h