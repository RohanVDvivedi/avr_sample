#include<regs/gpio.h>

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

		// delay
		//delay_for(65535);
	}
}

void reset()
{
	main();
}