MEMORY
{
	FLASH (rx) : ORIGIN = 0x0000, LENGTH = 4096
	SRAM (rw) : ORIGIN = 0x0060, LENGTH = 512
}

ENTRY(reset)

SECTIONS
{
	.text :
	{
		__text_section_starts_lma = .;
		KEEP(*(.interrupt_vector_table))
		*(.text*)
		__text_section_ends_lma = .;
	} > FLASH
	.data :
	{
		__data_section_starts_lma = .;
		*(.data*)
		__data_section_ends_lma = .;
	} > SRAM AT > FLASH
	.bss :
	{
		__bss_section_starts_lma = .;
		*(.bss*)
		__bss_section_ends_lma = .;
	} > SRAM
	/*.stack :
	{
		__stack_section_starts_lma = .;
		*(.stack*)
		__stack_section_ends_lma = .;
	} > SRAM*/
}