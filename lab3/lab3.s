.text
square:
  push %ebp 
  mov %esp,%ebp
  fmuls 8(%ebp)			# multiply st(0) with the parameter
				# st(0) should be equal to 8(%ebp)
  mov %ebp,%esp
  pop %ebp
  ret
odd:
  mov 4(%esp), %eax
  and $1, %eax			# compare 1 and eax by bit-wise arithmetic
				# return 1 to %eax if the number is odd
				# or return 0 to %eax if the number is even
  ret
power:
  push %ebp
  mov %esp, %ebp
  sub $4, %esp			# room for local varible t
  
  cmp $0, 8(%ebp)		# p == 0
  jne first_else		# if p !=0 go to first else

  # if p = 0
  fld1				# push 1 to FP-stack, st(0) = 1
  jmp end_if			# exit function
first_else:
  push 8(%ebp)			# push p to stack for odd function's parameter
  call odd			# store 1 to %eax if p is odd
				# or store 0 to %eax if p is even 
  add $4, %esp
  cmp $1, %eax			# eax == 1
  jne second_else		# if p is even, go to second_else 

  # if p is odd
  mov 8(%ebp), %eax		# eax = p
  dec %eax			# eax = p - 1
  mov %eax, -4(%ebp)		# t = eax = p - 1

  # call power function with two parameters r and t = p-1
  push 12(%ebp)			# r
  push -4(%ebp)			# t
  call power
  add $8, %esp
  fmul 12(%ebp)			# st(0) *= r
  jmp end_if
second_else:
  mov 8(%ebp), %eax		# eax = p
  shr %eax			# eax = eax/2, bit-shift right will divide by 2
  mov %eax, -4(%ebp)		# t = p/2

  #call power function with two parameters r and t = p/2
  push 12(%ebp)			# r
  push -4(%ebp)			# t
  call power
  add $8, %esp

  #push st(0) to stack to prepare parameter for calling square function
  fsts (%esp)
  call square
  add $4, %esp 

end_if:
  mov %ebp, %esp
  pop %ebp
  ret
  
power_more:
  cmp $0, 4(%esp)
  jne first_else_more
  fld1
  jmp end_if_more
first_else_more:
  push 4(%esp)
  call odd
  add $4, %esp
  cmp $1, %eax
  #jump to second_else if p is even
  jne second_else_more

  sub $1, p
  mov p, %eax
  push r
  push p
  call power_more
  add $8, %esp

  fmuls r
  jmp end_if_more
second_else_more:
  mov p, %eax
  shr %eax
  mov %eax, p
 
  push r
  push p
  call power_more
  add $8, %esp

  fst ST0
  push ST0 
  call square
  add $4, %esp
  jmp end_if_more
end_if_more:
  ret

.data
r: .float 5.0
p:  .int 3
r2: .float 2.0
p2: .int 8
fmt: .string "%f\n"
fmt2: .string "%i\n"
ST0 : .float 0.0
.text
.globl _start
_start:
  flds r
  push r
  call square
  add $4,%esp
  #expect result in %st(0)

  add $-8,%esp 
  fstpl (%esp) #push 64-bits st(0) onto the stack and pop st(0)
  push $fmt
  call printf
  add $12, %esp
  push p
  call odd
  add $4,%esp
  #expect result in %eax

  push %eax
  push $fmt2
  call printf
  add $8, %esp
 
  push p2
  call odd
  add $4,%esp
  #expect result in %eax

  push %eax
  push $fmt2
  call printf
  add $8, %esp
  push r
  push p
  call power
  add $8,%esp
  #expect result in %eax

  add $-8,%esp 
  fstpl (%esp) #push 64-bits st(0) onto the stack and pop st(0)
  push $fmt
  call printf
  add $12, %esp

  push r2
  push p2
  call power
  add $8,%esp
  #expect result in %eax

  add $-8,%esp 
  fstpl (%esp) #push 64-bits st(0) onto the stack and pop st(0)
  push $fmt
  call printf
  add $12, %esp
  
  mov $1, %eax
  mov $0, %ebx
  int $0x80
