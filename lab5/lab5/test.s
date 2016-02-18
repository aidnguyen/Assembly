.data
epsilon: .float 0.000001
delta: .float 0.000001
fmt: .string "%f\n"
r: .float 0.0
.text
.globl _start
_start:

flds r
flds delta
fcomi
jb _if

add $-8, %esp
fstl (%esp)
push $fmt
call printf
add $12, %esp

_if:
mov $1, %eax
mov $0, %ebx
int $0x80


