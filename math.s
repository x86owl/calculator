; PROGRAM: This program will perform the all the type of conversions

section .data

section .text
	global add
	global subtract
	global multiply
	global divide

add:
	addsd xmm0, xmm1
	ret

subtract:
	subsd xmm0, xmm1
	ret

multiply:
	mulsd xmm0, xmm1
	ret

divide:
	divsd xmm0, xmm1
	ret
