MEMORY
{
	FLASH (rx) : ORIGIN = 0x0000, LENGTH = 4096
}

ENTRY(Reset_Handler)

SECTIONS
{
	.text :
	{
		*(.text*)
	} > FLASH
}