#include<regs/gpio.h>

uint16_t blink_count;

uint16_t delay_cycles = 10000;

void delay_for(unsigned int clocks)
{
	while(clocks--)
	{
		asm("nop");
	}
}

void main()
{
	// led GPIO setup
	GPIOB->DDR = (1<<4);

	while(1)
	{
		// led GPIO toggle
		GPIOB->PORT ^= 1<<4;

		// increment blink count to know, the number of timer we blinked
		blink_count++;

		// delay
		delay_for(delay_cycles);
	}
}

extern uint8_t __data_section_starts_lma;
extern uint8_t __data_section_ends_lma;

extern uint8_t __bss_section_starts_lma;
extern uint8_t __bss_section_ends_lma;

void reset()
{
	uint8_t* temp;

	// initialize data section
	uint8_t* data_start = &__data_section_starts_lma;
	uint8_t* data_end = &__data_section_ends_lma;
	temp = data_start;
	while(temp < data_end)
	{
		*temp = 0xff;
		temp++;
	}

	// zero bss section
	uint8_t* bss_start = &__bss_section_starts_lma;
	uint8_t* bss_end = &__bss_section_ends_lma;
	temp = bss_start;
	while(temp < bss_end)
	{
		*temp = 0;
		temp++;
	}

	// load stack pointer
	*((uint16_t *)0x5d) = 0x25f;

	// call main
	main();
}