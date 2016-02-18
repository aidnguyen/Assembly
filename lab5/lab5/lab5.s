.data
two: .float 2.0
.text
parabola:
push %ebp
mov %esp, %ebp
fld 8(%ebp) 		# st0 = x
fmul 8(%ebp)		# st0 = x^2
fsub two		# st0 = x^2 - 2.0
mov %ebp, %esp
pop %ebp
ret
.data
epsilon: .float 0.000001
delta: .float 0.000001
zero: .float 0.0
ST0: .float 0.0
.text
bisection:
push %ebp
mov %esp, %ebp
fld 8(%ebp) 		#st0 = high
fadd 12(%ebp)		#st0 = high + low
fdiv two		#st0 = (high+low)/2
fst ST0
push ST0
mov 16(%ebp), %eax
call *%eax 	
add $4,%esp
fld %st(0)		# st0 = image	
fabs			# st0 = |image|
fld epsilon		# st0 = epsilon
fcomip			# compare st0 and st1
#pop |image| out, st0 =image
fstp ST0		#st0 = image, st1= mid
ja _end			# if st0 > st1
fld 8(%ebp) 		#st0 = high
fsub 12(%ebp)		#st0 = high - low
fabs			#st0 = |high - low|
fld delta		#st0 = delta
fcomip			
#pop |high -low|, st0 =image
fstp ST0		#st0 = image, st1= mid
ja _end			# if st0 > st1
fld zero		# st0 = 0
fcomip
fstp ST0		# pop image, st0 = mid			
ja _if			# if image < 0
push 16(%ebp)		# parabola
push 12(%ebp)		# low		
fstp ST0		
push ST0		# mid
call bisection
add $12, %esp
jmp _end
_if:
push 16(%ebp)		#parabola
fstp ST0		#mid
push ST0
push 8(%ebp)		#high
call bisection
add $12, %esp
_end:
mov %ebp, %esp
pop %ebp
ret
.data
high: .float 15.0
low: .float -1.0
fmt: .string "The root for function f is : %f\n"
.text
.globl _start
_start:
push $parabola
push low
push high
call bisection
add $12, %esp
fstp ST0
add $-8, %esp
fstpl (%esp)
push $fmt
call printf
add $12, %esp
mov $1, %eax
mov $0, %ebx
int $0x80
