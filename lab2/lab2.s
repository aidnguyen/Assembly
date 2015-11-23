.data 
  fmt: .string "%d\n" 
.text                 
.global _start  
_start:            
  push $198        
  push $558
  call euclid      
  add $8, %esp     
  push %eax
  push $fmt         
  call printf    
  add $8, %esp
  mov $1, %eax  
  mov $0, %ebx
  int $0x80    
euclid:
  push %ebp          #push the old ebp onto the stack
  mov %esp,%ebp  
   mov 8(%ebp),%eax  #m, 8 b/c old ebp is on stack
   mov $0, %edx      #upper 32-bits of dividend
   mov 12(%ebp),%ebx #n
  cmp $0,%ebx
 jng _else

   idiv %ebx #m % n -> ebx
   push %edx
   push %ebx
   call euclid
   add $8, %esp

 jmp endif
_else: 
endif:
  mov %ebp,%esp  #move stack pointer back onto the main stack
  pop %ebp     # pop the old ebp (which is on top) back into %ebp
  ret

