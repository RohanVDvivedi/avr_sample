void delay_for(int clocks)
{
	while(clocks > 0)
	{
		clocks--;
	}
}

void main()
{
	// led GPIO setup
	while(1)
	{
		// led GPIO toggle
		delay_for(1000000);
	}
}