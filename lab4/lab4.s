.data 
  .equ NODESIZE,8
  .lcomm int_list,NODESIZE
.text
.globl _start
_start:
  push $2
  call dec_to_bin		
#expect result in EAX
  add $4, %esp
  push %eax
  call print_list
  add $4, %esp
  push $95
  call dec_to_bin		
  add $4, %esp
  push %eax
  call print_list
  add $4, %esp
push $10
  call dec_to_bin		
  add $4, %esp
  push %eax
  call print_list
  add $4, %esp
push $4096
  call dec_to_bin		
  add $4, %esp
  push %eax
  call print_list
  add $4, %esp
  mov $1, %eax
  mov $0, %ebx
  int $0x80
cons:
  push %ebp
  mov %esp, %ebp
  push $8		
  call malloc
  add $4, %esp  	# expect address in eax
  push %ebx
  mov 12(%ebp), %ebx 	#i
  mov %ebx, (%eax) 	#head
  mov 8(%ebp), %ebx 	#p
  mov %ebx, 4(%eax) 	#tail
  pop %ebx
  mov %ebp, %esp
  pop %ebp
  ret
append:
 push %ebp
 mov %esp, %ebp
 push %ebx
 mov 12(%ebp), %ebx 	# ebx = address of lst1
 cmp $0, %ebx	 	# lst1 == NULL
 jne if_append
 mov 8(%ebp), %ebx
 mov %ebx, %eax
 jmp end_append
if_append:
 push 4(%ebx)		# lst1->tail
 push 8(%ebp) 		# lst2
 call append
 add $8, %esp
 push (%ebx)
 push %eax
 call cons	
 add $8, %esp
end_append:
 pop %ebx
 mov %ebp, %esp
 pop %ebp
 ret
dec_to_bin: 
  push %ebp
  mov %esp, %ebp
  sub $8,%esp 		# room for 2 local variables
  
  cmp $0, 8(%ebp) 	# n == 0
  jne else_part
  mov $0, %eax		# empty list
  jmp end_func
else_part:
  mov 8(%ebp),%eax
  mov %eax,-4(%ebp) 	# copying n to quotient
  shrl -4(%ebp) 	# divide quotient by 2
  push -4(%ebp)
  call dec_to_bin
  add $4, %esp
  push %ebx
  mov %eax, %ebx	# EBX = EAX
  movl $0, -8(%ebp)		# remainder =0
  mov 8(%ebp),%ecx
  mov %ecx,-4(%ebp) 		# copying n to quotient
  shrl -4(%ebp) 		# divide quotient by 2
  jnc call_cons
  movl $1, -8(%ebp) 		# remainder = 1
call_cons:
  push -8(%ebp) 		# remainder
  push $0  			# NULL
  call cons			# expect result in EAX
  add $8, %esp
  push %ebx
  push %eax
  call append
  add $8, %esp			# expect result in EAX
end_func:
  pop %ebx
  mov %ebp, %esp
  pop %ebp
  ret

.data 
  fmt: .string "%i"
  fmt2: .string "\n"
.text
print_list:
  push %ebp
  mov %esp, %ebp
  push %ebx
  mov 8(%ebp), %ebx 		# parameter
  cmp $0, %ebx
  je else_print
  push (%ebx)
  push $fmt
  call printf
  add $8, %esp
  push 4(%ebx)
  call print_list
  add $4, %esp
  jmp end_print
# print out "\n" if reach the end of the list
else_print:
  push $fmt2
  call printf
  add $4, %esp
end_print:
  pop %ebx
  mov %ebp, %esp
  pop %ebp
  ret
