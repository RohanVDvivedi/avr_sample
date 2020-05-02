#ifndef GPIO_REGS_H
#define GPIO_REGS_H

#include<stdint.h>

typedef struct GPIO_t GPIO_t;
struct GPIO_t
{
	uint8_t PIN;
	uint8_t DDR;
	uint8_t PORT;
};

#define GPIOB ((volatile GPIO_t*)(0x0016))

#endif