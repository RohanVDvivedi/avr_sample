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
	while(1)
	{
		// led GPIO toggle
		delay_for(65535);
	}
}