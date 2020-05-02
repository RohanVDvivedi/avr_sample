MEMORY
{
	FLASH (rx) : ORIGIN = 0x0000, LENGTH = 4096
}

ENTRY(reset)

SECTIONS
{
	.text :
	{
		KEEP(*(.interrupt_vector_table))
		*(.text*)
	} > FLASH
}