.equ N,53	 
.equ M,20
.equ M1,29
.equ M2,37
.equ DISK_SIZE, 23
.data
  dataIn: .string "DataIn: This is some test data for a RAID simulator  "
  dataOut: .string "DataOut: This is some test data for a RAID simulator  "
  disk1: .string "Disk1:                 "
  disk2: .string "Disk2:                 "
  disk3: .string "Disk3:                 "
  disk4: .string "Disk4:                 "
  msg: .string "ASM RAID simulator\n"
  msg1: .string "After one disk is corrupted\n"
  msg2: .string "After rebuilding the corrupted disk\n"
  endline: .string "\n"
.text
.globl _start
_start:

mov $M, %edx
mov $msg, %ecx
mov $1, %ebx
mov $4, %eax
int $0x80
mov $N, %edx
mov $dataIn, %ecx
mov $1, %ebx
mov $4, %eax
int $0x80

mov $1, %edx
mov $endline, %ecx
mov $1, %ebx
mov $4, %eax
int $0x80
# store data to disks
call load_data
mov $DISK_SIZE, %edx
mov $disk1, %ecx
mov $1, %ebx
mov $4, %eax
int $0x80

mov $1, %edx
mov $endline, %ecx
mov $1, %ebx
mov $4, %eax
int $0x80
mov $DISK_SIZE, %edx
mov $disk2, %ecx
mov $1, %ebx
mov $4, %eax
int $0x80

mov $1, %edx
mov $endline, %ecx
mov $1, %ebx
mov $4, %eax
int $0x80
mov $DISK_SIZE, %edx
mov $disk3, %ecx
mov $1, %ebx
mov $4, %eax
int $0x80

mov $1, %edx
mov $endline, %ecx
mov $1, %ebx
mov $4, %eax
int $0x80
mov $DISK_SIZE, %edx
mov $disk4, %ecx
mov $1, %ebx
mov $4, %eax
int $0x80

mov $1, %edx
mov $endline, %ecx
mov $1, %ebx
mov $4, %eax
int $0x80
push $disk2 #disk2 is corrupted
call make_corrupt
add $4, %esp
mov $M1, %edx
mov $msg1, %ecx # print msg1
mov $1, %ebx
mov $4, %eax
int $0x80
call print_dataOut

# print msg2
mov $M2, %edx
mov $msg2, %ecx
mov $1, %ebx
mov $4, %eax
int $0x80
#Rebuild corrupted disk
push $disk1
push $disk3
push $disk4
push $disk2	# this for fixing
call rebuild
add $12, %esp
call print_dataOut
#End 
mov $1, %eax
mov $0, %ebx
int $0x80
load_data:
push %ebp
mov %esp, %ebp
mov $8, %esi		#i = 8
mov $7, %edi		#j = 7
_L1:
cmp $51, %esi		# N-2
jge _L2			# if i >= 51
movb dataIn(%esi), %cl
movb %cl, disk1(%edi)
inc %esi
movb dataIn(%esi), %cl
movb %cl, disk2(%edi)
inc %esi
movb dataIn(%esi), %cl
movb %cl, disk3(%edi)
xor disk1(%edi),%cl
xor disk2(%edi),%cl
movb %cl, disk4(%edi)
inc %esi
inc %edi
jmp _L1
_L2:
mov %ebp, %esp
pop %ebp
ret
make_corrupt:
push %ebp
mov %esp, %ebp
mov 8(%ebp), %eax
mov $0, %edi
_L3:
cmp $DISK_SIZE, %edi
jg _L4
movb $'.', (%eax,%edi,1)
inc %edi
jmp _L3
_L4:
mov %ebp, %esp
pop %ebp
ret
print_dataOut:
push %ebp
mov %esp, %ebp
mov $9, %esi	# i = 9
mov $7, %edi	# j = 7
_L5:
cmp $DISK_SIZE, %edi	
jge _L6
movb disk1(%edi), %cl	#disk1[j]
movb %cl, dataOut(%esi)	#dataOut[i]
inc %esi
movb disk2(%edi), %cl	#disk2[j]
movb %cl, dataOut(%esi)	#dataOut[i+1]
inc %esi
movb disk3(%edi), %cl	#disk3[j]
movb %cl, dataOut(%esi)	#dataOut[i+2]
inc %esi
inc %edi
jmp _L5
_L6:
mov $N, %edx
mov $dataOut, %ecx
mov $1, %ebx
mov $4, %eax
int $0x80

mov $1, %edx
mov $endline, %ecx
mov $1, %ebx
mov $4, %eax
int $0x80

mov %ebp, %esp
pop %ebp
ret
rebuild:
push %ebp
mov %esp, %ebp
mov $7, %edi	# j = 7
mov $DISK_SIZE, %edx
_L7:
cmp $DISK_SIZE, %edi
jge _L8
mov 20(%ebp), %eax
movb (%eax,%edi,1), %cl
mov 16(%ebp), %eax
xor (%eax,%edi,1),%cl
mov 12(%ebp), %eax
xor (%eax,%edi,1),%cl
mov 8(%ebp), %eax	#this need rebuilding
movb %cl, (%eax,%edi,1)
inc %edi
jmp _L7
_L8:
mov %ebp, %esp
pop %ebp
ret
