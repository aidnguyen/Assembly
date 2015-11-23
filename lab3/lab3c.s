   1              		.file	"lab3.c"
   2              		.text
   3              	.Ltext0:
   4              		.comm	ST0,4,4
   5              		.comm	EAX,4,4
   6              		.globl	square
   7              		.type	square, @function
   8              	square:
   9              	.LFB0:
  10              		.file 1 "lab3.c"
   1:lab3.c        **** #include <stdio.h>
   2:lab3.c        **** #include <stdbool.h>
   3:lab3.c        **** float ST0;
   4:lab3.c        **** int EAX;
   5:lab3.c        **** float square(float x) {ST0 = x * x;}
  11              		.loc 1 5 0
  12              		.cfi_startproc
  13 0000 55       		pushl	%ebp
  14              		.cfi_def_cfa_offset 8
  15              		.cfi_offset 5, -8
  16 0001 89E5     		movl	%esp, %ebp
  17              		.cfi_def_cfa_register 5
  18              		.loc 1 5 0
  19 0003 D94508   		flds	8(%ebp)
  20 0006 D84D08   		fmuls	8(%ebp)
  21 0009 D91D0000 		fstps	ST0
  21      0000
  22 000f D9050800 		flds	.LC0
  22      0000
  23 0015 DDD8     		fstp	%st(0)
  24 0017 D9050800 		flds	.LC0
  24      0000
  25 001d 5D       		popl	%ebp
  26              		.cfi_restore 5
  27              		.cfi_def_cfa 4, 4
  28 001e C3       		ret
  29              		.cfi_endproc
  30              	.LFE0:
  31              		.size	square, .-square
  32              		.globl	odd
  33              		.type	odd, @function
  34              	odd:
  35              	.LFB1:
   6:lab3.c        **** int odd(int x)
   7:lab3.c        **** {
  36              		.loc 1 7 0
  37              		.cfi_startproc
  38 001f 55       		pushl	%ebp
  39              		.cfi_def_cfa_offset 8
  40              		.cfi_offset 5, -8
  41 0020 89E5     		movl	%esp, %ebp
  42              		.cfi_def_cfa_register 5
   8:lab3.c        ****   EAX = x % 2;
  43              		.loc 1 8 0
  44 0022 8B4508   		movl	8(%ebp), %eax
  45 0025 99       		cltd
  46 0026 C1EA1F   		shrl	$31, %edx
  47 0029 01D0     		addl	%edx, %eax
  48 002b 83E001   		andl	$1, %eax
  49 002e 29D0     		subl	%edx, %eax
  50 0030 A3000000 		movl	%eax, EAX
  50      00
   9:lab3.c        **** } // return value 0 or 1 in EAX
  51              		.loc 1 9 0
  52 0035 5D       		popl	%ebp
  53              		.cfi_restore 5
  54              		.cfi_def_cfa 4, 4
  55 0036 C3       		ret
  56              		.cfi_endproc
  57              	.LFE1:
  58              		.size	odd, .-odd
  59              		.globl	power
  60              		.type	power, @function
  61              	power:
  62              	.LFB2:
  10:lab3.c        **** void power(float r, int p)
  11:lab3.c        **** {
  63              		.loc 1 11 0
  64              		.cfi_startproc
  65 0037 55       		pushl	%ebp
  66              		.cfi_def_cfa_offset 8
  67              		.cfi_offset 5, -8
  68 0038 89E5     		movl	%esp, %ebp
  69              		.cfi_def_cfa_register 5
  70 003a 83EC18   		subl	$24, %esp
  12:lab3.c        ****   if(p!=0) goto first_else;
  71              		.loc 1 12 0
  72 003d 837D0C00 		cmpl	$0, 12(%ebp)
  73 0041 7418     		je	.L4
  74 0043 90       		nop
  75              	.L5:
  13:lab3.c        ****   ST0 = 1.0;
  14:lab3.c        ****   goto end_if;
  15:lab3.c        **** first_else:
  16:lab3.c        ****   odd(p);
  76              		.loc 1 16 0
  77 0044 FF750C   		pushl	12(%ebp)
  78 0047 E8FCFFFF 		call	odd
  78      FF
  79 004c 83C404   		addl	$4, %esp
  17:lab3.c        ****   if(EAX != 1) goto second_else;
  80              		.loc 1 17 0
  81 004f A1000000 		movl	EAX, %eax
  81      00
  82 0054 83F801   		cmpl	$1, %eax
  83 0057 7444     		je	.L7
  84 0059 EB0C     		jmp	.L10
  85              	.L4:
  13:lab3.c        ****   ST0 = 1.0;
  86              		.loc 1 13 0
  87 005b A10C0000 		movl	.LC1, %eax
  87      00
  88 0060 A3000000 		movl	%eax, ST0
  88      00
  14:lab3.c        **** first_else:
  89              		.loc 1 14 0
  90 0065 EB60     		jmp	.L6
  91              	.L10:
  92              		.loc 1 17 0
  93 0067 90       		nop
  94              	.L8:
  18:lab3.c        ****   int t = p-1;
  19:lab3.c        ****   power(r,t);
  20:lab3.c        ****   ST0 = r * ST0; // ST0 *=r
  21:lab3.c        ****   goto end_if;
  22:lab3.c        **** second_else:
  23:lab3.c        ****   t = p/2;
  95              		.loc 1 23 0
  96 0068 8B450C   		movl	12(%ebp), %eax
  97 006b 89C2     		movl	%eax, %edx
  98 006d C1EA1F   		shrl	$31, %edx
  99 0070 01D0     		addl	%edx, %eax
 100 0072 D1F8     		sarl	%eax
 101 0074 8945F4   		movl	%eax, -12(%ebp)
  24:lab3.c        ****   power(r,t);
 102              		.loc 1 24 0
 103 0077 83EC08   		subl	$8, %esp
 104 007a FF75F4   		pushl	-12(%ebp)
 105 007d FF7508   		pushl	8(%ebp)
 106 0080 E8FCFFFF 		call	power
 106      FF
 107 0085 83C410   		addl	$16, %esp
  25:lab3.c        ****   square(ST0);
 108              		.loc 1 25 0
 109 0088 A1000000 		movl	ST0, %eax
 109      00
 110 008d 83EC0C   		subl	$12, %esp
 111 0090 50       		pushl	%eax
 112 0091 E8FCFFFF 		call	square
 112      FF
 113 0096 DDD8     		fstp	%st(0)
 114 0098 83C410   		addl	$16, %esp
  26:lab3.c        **** end_if:
  27:lab3.c        ****   return;
 115              		.loc 1 27 0
 116 009b EB2A     		jmp	.L6
 117              	.L7:
  18:lab3.c        ****   power(r,t);
 118              		.loc 1 18 0
 119 009d 8B450C   		movl	12(%ebp), %eax
 120 00a0 83E801   		subl	$1, %eax
 121 00a3 8945F4   		movl	%eax, -12(%ebp)
  19:lab3.c        ****   ST0 = r * ST0; // ST0 *=r
 122              		.loc 1 19 0
 123 00a6 83EC08   		subl	$8, %esp
 124 00a9 FF75F4   		pushl	-12(%ebp)
 125 00ac FF7508   		pushl	8(%ebp)
 126 00af E8FCFFFF 		call	power
 126      FF
 127 00b4 83C410   		addl	$16, %esp
  20:lab3.c        ****   goto end_if;
 128              		.loc 1 20 0
 129 00b7 D9050000 		flds	ST0
 129      0000
 130 00bd D84D08   		fmuls	8(%ebp)
 131 00c0 D91D0000 		fstps	ST0
 131      0000
  21:lab3.c        **** second_else:
 132              		.loc 1 21 0
 133 00c6 90       		nop
 134              	.L6:
 135              		.loc 1 27 0
 136 00c7 90       		nop
  28:lab3.c        **** } //result ST0
 137              		.loc 1 28 0
 138 00c8 C9       		leave
 139              		.cfi_restore 5
 140              		.cfi_def_cfa 4, 4
 141 00c9 C3       		ret
 142              		.cfi_endproc
 143              	.LFE2:
 144              		.size	power, .-power
 145              		.section	.rodata
 146              	.LC3:
 147 0000 252E3266 		.string	"%.2f\n"
 147      0A00
 148              		.text
 149              		.globl	main
 150              		.type	main, @function
 151              	main:
 152              	.LFB3:
  29:lab3.c        **** int main()
  30:lab3.c        **** {
 153              		.loc 1 30 0
 154              		.cfi_startproc
 155 00ca 8D4C2404 		leal	4(%esp), %ecx
 156              		.cfi_def_cfa 1, 0
 157 00ce 83E4F0   		andl	$-16, %esp
 158 00d1 FF71FC   		pushl	-4(%ecx)
 159 00d4 55       		pushl	%ebp
 160              		.cfi_escape 0x10,0x5,0x2,0x75,0
 161 00d5 89E5     		movl	%esp, %ebp
 162 00d7 51       		pushl	%ecx
 163              		.cfi_escape 0xf,0x3,0x75,0x7c,0x6
 164 00d8 83EC04   		subl	$4, %esp
  31:lab3.c        ****   power(5.0,3);
 165              		.loc 1 31 0
 166 00db 83EC08   		subl	$8, %esp
 167 00de 6A03     		pushl	$3
 168 00e0 A1100000 		movl	.LC2, %eax
 168      00
 169 00e5 50       		pushl	%eax
 170 00e6 E8FCFFFF 		call	power
 170      FF
 171 00eb 83C410   		addl	$16, %esp
  32:lab3.c        ****   printf("%.2f\n", ST0);
 172              		.loc 1 32 0
 173 00ee D9050000 		flds	ST0
 173      0000
 174 00f4 83EC04   		subl	$4, %esp
 175 00f7 8D6424F8 		leal	-8(%esp), %esp
 176 00fb DD1C24   		fstpl	(%esp)
 177 00fe 68000000 		pushl	$.LC3
 177      00
 178 0103 E8FCFFFF 		call	printf
 178      FF
 179 0108 83C410   		addl	$16, %esp
  33:lab3.c        ****   power(2.0,8);
 180              		.loc 1 33 0
 181 010b 83EC08   		subl	$8, %esp
 182 010e 6A08     		pushl	$8
 183 0110 A1140000 		movl	.LC4, %eax
 183      00
 184 0115 50       		pushl	%eax
 185 0116 E8FCFFFF 		call	power
 185      FF
 186 011b 83C410   		addl	$16, %esp
  34:lab3.c        ****   printf("%.2f\n", ST0);
 187              		.loc 1 34 0
 188 011e D9050000 		flds	ST0
 188      0000
 189 0124 83EC04   		subl	$4, %esp
 190 0127 8D6424F8 		leal	-8(%esp), %esp
 191 012b DD1C24   		fstpl	(%esp)
 192 012e 68000000 		pushl	$.LC3
 192      00
 193 0133 E8FCFFFF 		call	printf
 193      FF
 194 0138 83C410   		addl	$16, %esp
  35:lab3.c        **** }
 195              		.loc 1 35 0
 196 013b 8B4DFC   		movl	-4(%ebp), %ecx
 197              		.cfi_def_cfa 1, 0
 198 013e C9       		leave
 199              		.cfi_restore 5
 200 013f 8D61FC   		leal	-4(%ecx), %esp
 201              		.cfi_def_cfa 4, 4
 202 0142 C3       		ret
 203              		.cfi_endproc
 204              	.LFE3:
 205              		.size	main, .-main
 206              		.section	.rodata
 207 0006 0000     		.align 4
 208              	.LC0:
 209 0008 0000C07F 		.long	2143289344
 210              		.align 4
 211              	.LC1:
 212 000c 0000803F 		.long	1065353216
 213              		.align 4
 214              	.LC2:
 215 0010 0000A040 		.long	1084227584
 216              		.align 4
 217              	.LC4:
 218 0014 00000040 		.long	1073741824
 219              		.text
 220              	.Letext0:
 221              		.section	.debug_info,"",@progbits
 222              	.Ldebug_info0:
 223 0000 5B010000 		.long	0x15b
 224 0004 0400     		.value	0x4
 225 0006 00000000 		.long	.Ldebug_abbrev0
 226 000a 04       		.byte	0x4
 227 000b 01       		.uleb128 0x1
 228 000c 37000000 		.long	.LASF16
 229 0010 01       		.byte	0x1
 230 0011 0E000000 		.long	.LASF17
 231 0015 D3000000 		.long	.LASF18
 232 0019 00000000 		.long	.Ltext0
 233 001d 43010000 		.long	.Letext0-.Ltext0
 234 0021 00000000 		.long	.Ldebug_line0
 235 0025 02       		.uleb128 0x2
 236 0026 04       		.byte	0x4
 237 0027 07       		.byte	0x7
 238 0028 F4000000 		.long	.LASF0
 239 002c 02       		.uleb128 0x2
 240 002d 01       		.byte	0x1
 241 002e 08       		.byte	0x8
 242 002f 66000000 		.long	.LASF1
 243 0033 02       		.uleb128 0x2
 244 0034 02       		.byte	0x2
 245 0035 07       		.byte	0x7
 246 0036 A2000000 		.long	.LASF2
 247 003a 02       		.uleb128 0x2
 248 003b 04       		.byte	0x4
 249 003c 07       		.byte	0x7
 250 003d 89000000 		.long	.LASF3
 251 0041 02       		.uleb128 0x2
 252 0042 01       		.byte	0x1
 253 0043 06       		.byte	0x6
 254 0044 B5000000 		.long	.LASF4
 255 0048 02       		.uleb128 0x2
 256 0049 02       		.byte	0x2
 257 004a 05       		.byte	0x5
 258 004b EA000000 		.long	.LASF5
 259 004f 03       		.uleb128 0x3
 260 0050 04       		.byte	0x4
 261 0051 05       		.byte	0x5
 262 0052 696E7400 		.string	"int"
 263 0056 02       		.uleb128 0x2
 264 0057 08       		.byte	0x8
 265 0058 05       		.byte	0x5
 266 0059 00000000 		.long	.LASF6
 267 005d 02       		.uleb128 0x2
 268 005e 08       		.byte	0x8
 269 005f 07       		.byte	0x7
 270 0060 20000000 		.long	.LASF7
 271 0064 02       		.uleb128 0x2
 272 0065 04       		.byte	0x4
 273 0066 05       		.byte	0x5
 274 0067 79000000 		.long	.LASF8
 275 006b 02       		.uleb128 0x2
 276 006c 04       		.byte	0x4
 277 006d 07       		.byte	0x7
 278 006e 01010000 		.long	.LASF9
 279 0072 02       		.uleb128 0x2
 280 0073 01       		.byte	0x1
 281 0074 06       		.byte	0x6
 282 0075 61000000 		.long	.LASF10
 283 0079 04       		.uleb128 0x4
 284 007a 82000000 		.long	.LASF12
 285 007e 01       		.byte	0x1
 286 007f 05       		.byte	0x5
 287 0080 9F000000 		.long	0x9f
 288 0084 00000000 		.long	.LFB0
 289 0088 1F000000 		.long	.LFE0-.LFB0
 290 008c 01       		.uleb128 0x1
 291 008d 9C       		.byte	0x9c
 292 008e 9F000000 		.long	0x9f
 293 0092 05       		.uleb128 0x5
 294 0093 7800     		.string	"x"
 295 0095 01       		.byte	0x1
 296 0096 05       		.byte	0x5
 297 0097 9F000000 		.long	0x9f
 298 009b 02       		.uleb128 0x2
 299 009c 91       		.byte	0x91
 300 009d 00       		.sleb128 0
 301 009e 00       		.byte	0
 302 009f 02       		.uleb128 0x2
 303 00a0 04       		.byte	0x4
 304 00a1 04       		.byte	0x4
 305 00a2 CD000000 		.long	.LASF11
 306 00a6 06       		.uleb128 0x6
 307 00a7 6F646400 		.string	"odd"
 308 00ab 01       		.byte	0x1
 309 00ac 06       		.byte	0x6
 310 00ad 4F000000 		.long	0x4f
 311 00b1 1F000000 		.long	.LFB1
 312 00b5 18000000 		.long	.LFE1-.LFB1
 313 00b9 01       		.uleb128 0x1
 314 00ba 9C       		.byte	0x9c
 315 00bb CC000000 		.long	0xcc
 316 00bf 05       		.uleb128 0x5
 317 00c0 7800     		.string	"x"
 318 00c2 01       		.byte	0x1
 319 00c3 06       		.byte	0x6
 320 00c4 4F000000 		.long	0x4f
 321 00c8 02       		.uleb128 0x2
 322 00c9 91       		.byte	0x91
 323 00ca 00       		.sleb128 0
 324 00cb 00       		.byte	0
 325 00cc 07       		.uleb128 0x7
 326 00cd 0A010000 		.long	.LASF19
 327 00d1 01       		.byte	0x1
 328 00d2 0A       		.byte	0xa
 329 00d3 37000000 		.long	.LFB2
 330 00d7 93000000 		.long	.LFE2-.LFB2
 331 00db 01       		.uleb128 0x1
 332 00dc 9C       		.byte	0x9c
 333 00dd 27010000 		.long	0x127
 334 00e1 05       		.uleb128 0x5
 335 00e2 7200     		.string	"r"
 336 00e4 01       		.byte	0x1
 337 00e5 0A       		.byte	0xa
 338 00e6 9F000000 		.long	0x9f
 339 00ea 02       		.uleb128 0x2
 340 00eb 91       		.byte	0x91
 341 00ec 00       		.sleb128 0
 342 00ed 05       		.uleb128 0x5
 343 00ee 7000     		.string	"p"
 344 00f0 01       		.byte	0x1
 345 00f1 0A       		.byte	0xa
 346 00f2 4F000000 		.long	0x4f
 347 00f6 02       		.uleb128 0x2
 348 00f7 91       		.byte	0x91
 349 00f8 04       		.sleb128 4
 350 00f9 08       		.uleb128 0x8
 351 00fa 15000000 		.long	.LASF13
 352 00fe 01       		.byte	0x1
 353 00ff 0F       		.byte	0xf
 354 0100 44000000 		.long	.L5
 355 0104 08       		.uleb128 0x8
 356 0105 9B000000 		.long	.LASF14
 357 0109 01       		.byte	0x1
 358 010a 1A       		.byte	0x1a
 359 010b C7000000 		.long	.L6
 360 010f 08       		.uleb128 0x8
 361 0110 C1000000 		.long	.LASF15
 362 0114 01       		.byte	0x1
 363 0115 16       		.byte	0x16
 364 0116 68000000 		.long	.L8
 365 011a 09       		.uleb128 0x9
 366 011b 7400     		.string	"t"
 367 011d 01       		.byte	0x1
 368 011e 12       		.byte	0x12
 369 011f 4F000000 		.long	0x4f
 370 0123 02       		.uleb128 0x2
 371 0124 91       		.byte	0x91
 372 0125 6C       		.sleb128 -20
 373 0126 00       		.byte	0
 374 0127 0A       		.uleb128 0xa
 375 0128 74000000 		.long	.LASF20
 376 012c 01       		.byte	0x1
 377 012d 1D       		.byte	0x1d
 378 012e 4F000000 		.long	0x4f
 379 0132 CA000000 		.long	.LFB3
 380 0136 79000000 		.long	.LFE3-.LFB3
 381 013a 01       		.uleb128 0x1
 382 013b 9C       		.byte	0x9c
 383 013c 0B       		.uleb128 0xb
 384 013d 53543000 		.string	"ST0"
 385 0141 01       		.byte	0x1
 386 0142 03       		.byte	0x3
 387 0143 9F000000 		.long	0x9f
 388 0147 05       		.uleb128 0x5
 389 0148 03       		.byte	0x3
 390 0149 00000000 		.long	ST0
 391 014d 0B       		.uleb128 0xb
 392 014e 45415800 		.string	"EAX"
 393 0152 01       		.byte	0x1
 394 0153 04       		.byte	0x4
 395 0154 4F000000 		.long	0x4f
 396 0158 05       		.uleb128 0x5
 397 0159 03       		.byte	0x3
 398 015a 00000000 		.long	EAX
 399 015e 00       		.byte	0
 400              		.section	.debug_abbrev,"",@progbits
 401              	.Ldebug_abbrev0:
 402 0000 01       		.uleb128 0x1
 403 0001 11       		.uleb128 0x11
 404 0002 01       		.byte	0x1
 405 0003 25       		.uleb128 0x25
 406 0004 0E       		.uleb128 0xe
 407 0005 13       		.uleb128 0x13
 408 0006 0B       		.uleb128 0xb
 409 0007 03       		.uleb128 0x3
 410 0008 0E       		.uleb128 0xe
 411 0009 1B       		.uleb128 0x1b
 412 000a 0E       		.uleb128 0xe
 413 000b 11       		.uleb128 0x11
 414 000c 01       		.uleb128 0x1
 415 000d 12       		.uleb128 0x12
 416 000e 06       		.uleb128 0x6
 417 000f 10       		.uleb128 0x10
 418 0010 17       		.uleb128 0x17
 419 0011 00       		.byte	0
 420 0012 00       		.byte	0
 421 0013 02       		.uleb128 0x2
 422 0014 24       		.uleb128 0x24
 423 0015 00       		.byte	0
 424 0016 0B       		.uleb128 0xb
 425 0017 0B       		.uleb128 0xb
 426 0018 3E       		.uleb128 0x3e
 427 0019 0B       		.uleb128 0xb
 428 001a 03       		.uleb128 0x3
 429 001b 0E       		.uleb128 0xe
 430 001c 00       		.byte	0
 431 001d 00       		.byte	0
 432 001e 03       		.uleb128 0x3
 433 001f 24       		.uleb128 0x24
 434 0020 00       		.byte	0
 435 0021 0B       		.uleb128 0xb
 436 0022 0B       		.uleb128 0xb
 437 0023 3E       		.uleb128 0x3e
 438 0024 0B       		.uleb128 0xb
 439 0025 03       		.uleb128 0x3
 440 0026 08       		.uleb128 0x8
 441 0027 00       		.byte	0
 442 0028 00       		.byte	0
 443 0029 04       		.uleb128 0x4
 444 002a 2E       		.uleb128 0x2e
 445 002b 01       		.byte	0x1
 446 002c 3F       		.uleb128 0x3f
 447 002d 19       		.uleb128 0x19
 448 002e 03       		.uleb128 0x3
 449 002f 0E       		.uleb128 0xe
 450 0030 3A       		.uleb128 0x3a
 451 0031 0B       		.uleb128 0xb
 452 0032 3B       		.uleb128 0x3b
 453 0033 0B       		.uleb128 0xb
 454 0034 27       		.uleb128 0x27
 455 0035 19       		.uleb128 0x19
 456 0036 49       		.uleb128 0x49
 457 0037 13       		.uleb128 0x13
 458 0038 11       		.uleb128 0x11
 459 0039 01       		.uleb128 0x1
 460 003a 12       		.uleb128 0x12
 461 003b 06       		.uleb128 0x6
 462 003c 40       		.uleb128 0x40
 463 003d 18       		.uleb128 0x18
 464 003e 9742     		.uleb128 0x2117
 465 0040 19       		.uleb128 0x19
 466 0041 01       		.uleb128 0x1
 467 0042 13       		.uleb128 0x13
 468 0043 00       		.byte	0
 469 0044 00       		.byte	0
 470 0045 05       		.uleb128 0x5
 471 0046 05       		.uleb128 0x5
 472 0047 00       		.byte	0
 473 0048 03       		.uleb128 0x3
 474 0049 08       		.uleb128 0x8
 475 004a 3A       		.uleb128 0x3a
 476 004b 0B       		.uleb128 0xb
 477 004c 3B       		.uleb128 0x3b
 478 004d 0B       		.uleb128 0xb
 479 004e 49       		.uleb128 0x49
 480 004f 13       		.uleb128 0x13
 481 0050 02       		.uleb128 0x2
 482 0051 18       		.uleb128 0x18
 483 0052 00       		.byte	0
 484 0053 00       		.byte	0
 485 0054 06       		.uleb128 0x6
 486 0055 2E       		.uleb128 0x2e
 487 0056 01       		.byte	0x1
 488 0057 3F       		.uleb128 0x3f
 489 0058 19       		.uleb128 0x19
 490 0059 03       		.uleb128 0x3
 491 005a 08       		.uleb128 0x8
 492 005b 3A       		.uleb128 0x3a
 493 005c 0B       		.uleb128 0xb
 494 005d 3B       		.uleb128 0x3b
 495 005e 0B       		.uleb128 0xb
 496 005f 27       		.uleb128 0x27
 497 0060 19       		.uleb128 0x19
 498 0061 49       		.uleb128 0x49
 499 0062 13       		.uleb128 0x13
 500 0063 11       		.uleb128 0x11
 501 0064 01       		.uleb128 0x1
 502 0065 12       		.uleb128 0x12
 503 0066 06       		.uleb128 0x6
 504 0067 40       		.uleb128 0x40
 505 0068 18       		.uleb128 0x18
 506 0069 9742     		.uleb128 0x2117
 507 006b 19       		.uleb128 0x19
 508 006c 01       		.uleb128 0x1
 509 006d 13       		.uleb128 0x13
 510 006e 00       		.byte	0
 511 006f 00       		.byte	0
 512 0070 07       		.uleb128 0x7
 513 0071 2E       		.uleb128 0x2e
 514 0072 01       		.byte	0x1
 515 0073 3F       		.uleb128 0x3f
 516 0074 19       		.uleb128 0x19
 517 0075 03       		.uleb128 0x3
 518 0076 0E       		.uleb128 0xe
 519 0077 3A       		.uleb128 0x3a
 520 0078 0B       		.uleb128 0xb
 521 0079 3B       		.uleb128 0x3b
 522 007a 0B       		.uleb128 0xb
 523 007b 27       		.uleb128 0x27
 524 007c 19       		.uleb128 0x19
 525 007d 11       		.uleb128 0x11
 526 007e 01       		.uleb128 0x1
 527 007f 12       		.uleb128 0x12
 528 0080 06       		.uleb128 0x6
 529 0081 40       		.uleb128 0x40
 530 0082 18       		.uleb128 0x18
 531 0083 9642     		.uleb128 0x2116
 532 0085 19       		.uleb128 0x19
 533 0086 01       		.uleb128 0x1
 534 0087 13       		.uleb128 0x13
 535 0088 00       		.byte	0
 536 0089 00       		.byte	0
 537 008a 08       		.uleb128 0x8
 538 008b 0A       		.uleb128 0xa
 539 008c 00       		.byte	0
 540 008d 03       		.uleb128 0x3
 541 008e 0E       		.uleb128 0xe
 542 008f 3A       		.uleb128 0x3a
 543 0090 0B       		.uleb128 0xb
 544 0091 3B       		.uleb128 0x3b
 545 0092 0B       		.uleb128 0xb
 546 0093 11       		.uleb128 0x11
 547 0094 01       		.uleb128 0x1
 548 0095 00       		.byte	0
 549 0096 00       		.byte	0
 550 0097 09       		.uleb128 0x9
 551 0098 34       		.uleb128 0x34
 552 0099 00       		.byte	0
 553 009a 03       		.uleb128 0x3
 554 009b 08       		.uleb128 0x8
 555 009c 3A       		.uleb128 0x3a
 556 009d 0B       		.uleb128 0xb
 557 009e 3B       		.uleb128 0x3b
 558 009f 0B       		.uleb128 0xb
 559 00a0 49       		.uleb128 0x49
 560 00a1 13       		.uleb128 0x13
 561 00a2 02       		.uleb128 0x2
 562 00a3 18       		.uleb128 0x18
 563 00a4 00       		.byte	0
 564 00a5 00       		.byte	0
 565 00a6 0A       		.uleb128 0xa
 566 00a7 2E       		.uleb128 0x2e
 567 00a8 00       		.byte	0
 568 00a9 3F       		.uleb128 0x3f
 569 00aa 19       		.uleb128 0x19
 570 00ab 03       		.uleb128 0x3
 571 00ac 0E       		.uleb128 0xe
 572 00ad 3A       		.uleb128 0x3a
 573 00ae 0B       		.uleb128 0xb
 574 00af 3B       		.uleb128 0x3b
 575 00b0 0B       		.uleb128 0xb
 576 00b1 49       		.uleb128 0x49
 577 00b2 13       		.uleb128 0x13
 578 00b3 11       		.uleb128 0x11
 579 00b4 01       		.uleb128 0x1
 580 00b5 12       		.uleb128 0x12
 581 00b6 06       		.uleb128 0x6
 582 00b7 40       		.uleb128 0x40
 583 00b8 18       		.uleb128 0x18
 584 00b9 9642     		.uleb128 0x2116
 585 00bb 19       		.uleb128 0x19
 586 00bc 00       		.byte	0
 587 00bd 00       		.byte	0
 588 00be 0B       		.uleb128 0xb
 589 00bf 34       		.uleb128 0x34
 590 00c0 00       		.byte	0
 591 00c1 03       		.uleb128 0x3
 592 00c2 08       		.uleb128 0x8
 593 00c3 3A       		.uleb128 0x3a
 594 00c4 0B       		.uleb128 0xb
 595 00c5 3B       		.uleb128 0x3b
 596 00c6 0B       		.uleb128 0xb
 597 00c7 49       		.uleb128 0x49
 598 00c8 13       		.uleb128 0x13
 599 00c9 3F       		.uleb128 0x3f
 600 00ca 19       		.uleb128 0x19
 601 00cb 02       		.uleb128 0x2
 602 00cc 18       		.uleb128 0x18
 603 00cd 00       		.byte	0
 604 00ce 00       		.byte	0
 605 00cf 00       		.byte	0
 606              		.section	.debug_aranges,"",@progbits
 607 0000 1C000000 		.long	0x1c
 608 0004 0200     		.value	0x2
 609 0006 00000000 		.long	.Ldebug_info0
 610 000a 04       		.byte	0x4
 611 000b 00       		.byte	0
 612 000c 0000     		.value	0
 613 000e 0000     		.value	0
 614 0010 00000000 		.long	.Ltext0
 615 0014 43010000 		.long	.Letext0-.Ltext0
 616 0018 00000000 		.long	0
 617 001c 00000000 		.long	0
 618              		.section	.debug_line,"",@progbits
 619              	.Ldebug_line0:
 620 0000 57000000 		.section	.debug_str,"MS",@progbits,1
 620      02001D00 
 620      00000101 
 620      FB0E0D00 
 620      01010101 
 621              	.LASF6:
 622 0000 6C6F6E67 		.string	"long long int"
 622      206C6F6E 
 622      6720696E 
 622      7400
 623              	.LASF17:
 624 000e 6C616233 		.string	"lab3.c"
 624      2E6300
 625              	.LASF13:
 626 0015 66697273 		.string	"first_else"
 626      745F656C 
 626      736500
 627              	.LASF7:
 628 0020 6C6F6E67 		.string	"long long unsigned int"
 628      206C6F6E 
 628      6720756E 
 628      7369676E 
 628      65642069 
 629              	.LASF16:
 630 0037 474E5520 		.string	"GNU C 4.9.2 -mtune=generic -march=i586 -g"
 630      4320342E 
 630      392E3220 
 630      2D6D7475 
 630      6E653D67 
 631              	.LASF10:
 632 0061 63686172 		.string	"char"
 632      00
 633              	.LASF1:
 634 0066 756E7369 		.string	"unsigned char"
 634      676E6564 
 634      20636861 
 634      7200
 635              	.LASF20:
 636 0074 6D61696E 		.string	"main"
 636      00
 637              	.LASF8:
 638 0079 6C6F6E67 		.string	"long int"
 638      20696E74 
 638      00
 639              	.LASF12:
 640 0082 73717561 		.string	"square"
 640      726500
 641              	.LASF3:
 642 0089 6C6F6E67 		.string	"long unsigned int"
 642      20756E73 
 642      69676E65 
 642      6420696E 
 642      7400
 643              	.LASF14:
 644 009b 656E645F 		.string	"end_if"
 644      696600
 645              	.LASF2:
 646 00a2 73686F72 		.string	"short unsigned int"
 646      7420756E 
 646      7369676E 
 646      65642069 
 646      6E7400
 647              	.LASF4:
 648 00b5 7369676E 		.string	"signed char"
 648      65642063 
 648      68617200 
 649              	.LASF15:
 650 00c1 7365636F 		.string	"second_else"
 650      6E645F65 
 650      6C736500 
 651              	.LASF11:
 652 00cd 666C6F61 		.string	"float"
 652      7400
 653              	.LASF18:
 654 00d3 2F686F6D 		.string	"/home/debian/labs/lab3"
 654      652F6465 
 654      6269616E 
 654      2F6C6162 
 654      732F6C61 
 655              	.LASF5:
 656 00ea 73686F72 		.string	"short int"
 656      7420696E 
 656      7400
 657              	.LASF0:
 658 00f4 756E7369 		.string	"unsigned int"
 658      676E6564 
 658      20696E74 
 658      00
 659              	.LASF9:
 660 0101 73697A65 		.string	"sizetype"
 660      74797065 
 660      00
 661              	.LASF19:
 662 010a 706F7765 		.string	"power"
 662      7200
 663              		.ident	"GCC: (Debian 4.9.2-10) 4.9.2"
 664              		.section	.note.GNU-stack,"",@progbits
