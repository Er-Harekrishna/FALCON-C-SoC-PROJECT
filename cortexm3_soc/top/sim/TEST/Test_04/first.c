#include<stdio.h>
typedef unsigned int uint32_t; 

#define read_addr(addr)     (*(volatile uint32_t *)addr)
#define write_addr(addr, val) ((*(volatile uint32_t *)addr) = (val))


	
#define SRAM_A_base_ADDR (uint32_t ) (0x00000000) //0001FFFF
#define SRAM_S_base_ADDR (uint32_t ) (0x20000000) //2000FFFF
#define APB_base_ADDR (uint32_t ) (0x40000000)    //4000FFFF
#define UART_base_ADDR (uint32_t ) (APB_base_ADDR+0x2000)    //40002FFF
#define I2C_base_ADDR (uint32_t ) (APB_base_ADDR+0x1000)    //40001FFF
#define MEM_base_ADDR (uint32_t ) (APB_base_ADDR+0x0000)    //40000FFF

#define debug_reg0 (uint32_t *) (SRAM_A_base_ADDR+0x0ff0)
#define debug_reg1 (uint32_t *) (SRAM_A_base_ADDR+0x0ff4)
#define debug_reg2 (uint32_t *) (SRAM_A_base_ADDR+0x0ff8)
#define debug_reg3 (uint32_t *) (SRAM_A_base_ADDR+0x0ffC)

#define uart_reg_RBR (uint32_t *) (UART_base_ADDR+0x0)
#define uart_reg_THR (uint32_t *) (UART_base_ADDR+0x0)
#define uart_reg_DLL (uint32_t *) (UART_base_ADDR+0x0)
#define uart_reg_IER (uint32_t *) (UART_base_ADDR+0x1)
#define uart_reg_DLM (uint32_t *) (UART_base_ADDR+0x1)
#define uart_reg_IIR (uint32_t *) (UART_base_ADDR+0x2)
#define uart_reg_FCR (uint32_t *) (UART_base_ADDR+0x2)
#define uart_reg_LCR (uint32_t *) (UART_base_ADDR+0x3) //
#define uart_reg_MCR (uint32_t *) (UART_base_ADDR+0x4)
#define uart_reg_LSR (uint32_t *) (UART_base_ADDR+0x5)
#define uart_reg_MSR (uint32_t *) (UART_base_ADDR+0x6)
#define uart_reg_SCR (uint32_t *) (UART_base_ADDR+0x7)

int main () 
{ 
	
	uint32_t uart_read_store[50] , uart_write_store[50] ;
	uint32_t error ;
	uint32_t i,j;
	write_addr(debug_reg0, 0x00000001);
 
	write_addr(uart_reg_LCR, 0x00008000); //LCR
	
  write_addr(uart_reg_DLM, 0x00000000); //DLM

	write_addr(uart_reg_DLL, 0x00000003); //DLL
	read_addr(uart_reg_LCR);
	
  write_addr(uart_reg_LCR, 0x00000300); //LCR
	read_addr(uart_reg_LCR);
	
	write_addr(uart_reg_FCR, 0x00010000); //DLL
	read_addr(uart_reg_LCR);
	
	write_addr(uart_reg_IER, 0x00000000); //LCR
	read_addr(uart_reg_LCR);
	
	write_addr(uart_reg_LSR, 0x00000000); //LCR
	read_addr(uart_reg_LCR);

  // UART write 
  for(j=0;j< 16;j++) {
	 uart_write_store[j] = 0x00000056 + j;
	 write_addr(uart_reg_THR, uart_write_store[j]); //THR
	 read_addr(uart_reg_LCR);
	}
	
	//Delay
	for(i=0;i<100;i++);
	
	// UART Read
	for(j=0;j< 16;j++) {
	  uart_read_store[j]=read_addr(uart_reg_RBR);
	}
	
	// Check data
	error = 0;
	for(j=0;j< 16;j++) {
	  if(uart_read_store[j] != uart_write_store[j]) {
			error++;
		}
	}
	if(error !=0) {
	  write_addr(debug_reg0, 0x00000003 | (error<<8)); 
	}
	else {
	  write_addr(debug_reg0, 0x00000007); 
	} 

	//delay
	for(long int i=0;i<20;i++);

	while(1);
}