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
		__text_section_starts_vma = .;
		KEEP(*(.interrupt_vector_table))
		*(.text*)
		__text_section_ends_vma = .;
	} > FLASH
	.data :
	{
		__data_section_starts_vma = .;
		*(.data*)
		__data_section_ends_vma = .;
	} > SRAM AT > FLASH
	.bss :
	{
		__bss_section_starts_vma = .;
		*(.bss*)
		*(COMMON)
		__bss_section_ends_vma = .;
	} > SRAM
	/*.stack :
	{
		__stack_section_starts_vma = .;
		*(.stack*)
		__stack_section_ends_vma = .;
	} > SRAM*/
}