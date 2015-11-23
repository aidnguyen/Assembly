.data #Where to list any memory storage you will need for data
fmt: .string "Hello from asm\n"
fmt2: .string "x1 = %d\n"
.text #where the program instructions live
.globl _start #where program starts, same as main function in C
_start: #define the value of _start label
push $fmt
call printf
add $4,%esp
mov $17,%eax    #eax = 17
mov $3,%ebx     #ebx = 3
mov $1,%ecx     #ecx = 1
mov $1000,%edx  #edx = 1000
add %ebx,%eax
add %ecx,%eax
add %edx,%eax
push %eax
push $fmt2
call printf
add $8,%esp
mov $1,%eax #1 is the number of exit system call, require status code in %ebx
mov $0,%ebx #0 is returned to the system
int $0x80
