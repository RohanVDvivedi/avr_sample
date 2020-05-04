#include<regs/gpio.h>

uint16_t blink_count;

uint16_t delay_cycles = 100;

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
		blink_count = (blink_count > 655) ? 0 : blink_count;

		volatile uint16_t multiplied = 0;
		volatile uint16_t i;
		for(i = 0; i < blink_count; i++)
		{
			multiplied += delay_cycles;
		}

		// delay
		delay_for(multiplied);
	}
}