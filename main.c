#include<regs/gpio.h>

uint16_t blink_count;

uint16_t base_delay_cycles = 100;

void delay_for(unsigned int clocks)
{
	while(clocks--)
	{
		asm("nop");
	}
}

uint16_t multiply(uint16_t a, uint16_t b)
{
	volatile uint16_t multiplied = 0;
	volatile uint16_t i;
	for(i = 0; i < a; i++)
	{
		multiplied += b;
	}
	return multiplied;
}

void increment_blink_count()
{
	blink_count++;
	blink_count = (blink_count > 655) ? 0 : blink_count;
}

uint16_t get_prescribed_delay()
{
	return multiply(blink_count, base_delay_cycles);
}

void main()
{
	// led GPIO setup
	GPIOB->DDR = (1<<4);

	while(1)
	{
		// led GPIO toggle
		GPIOB->PORT ^= 1<<4;

		// increment blink count to know, the number of times we blinked
		increment_blink_count();

		// delay
		delay_for(get_prescribed_delay());
	}
}