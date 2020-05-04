	.section .interrupt_vector_table
		rjmp reset

	.text
	reset :
			; copy data from FLASH to SRAM
			ldi	r30, lo8(__text_section_ends_vma)
			ldi	r31, hi8(__text_section_ends_vma)
		
		copy_data:

			ldi	r28, lo8(__data_section_starts_vma)
			ldi	r29, hi8(__data_section_starts_vma)

			ldi r25, hi8(__data_section_ends_vma)
		copy_data_loop:
			cpi	r28, lo8(__data_section_ends_vma)
			cpc	r29, r25

			breq zero_bss

			lpm r0, Z
			st	Y, r0

			adiw r30,1
			adiw r28,1

			rjmp copy_data_loop

		zero_bss:
			; make bss section to zero
			ldi	r28, lo8(__bss_section_starts_vma)
			ldi	r29, hi8(__bss_section_starts_vma)

			ldi r24, 0

			ldi	r25, hi8(__bss_section_ends_vma)
		zero_bss_loop:
			cpi	r28, lo8(__bss_section_ends_vma)
			cpc	r29, r25

			breq setup_stack_pointer

			st	Y, r24

			adiw r28,1

			rjmp zero_bss

		setup_stack_pointer:
			; setup stack pointer
			ldi	r24, 0x5F
			ldi	r25, 0x02
			out	0x3e, r25
			out	0x3d, r24

			; call main function
			rcall main