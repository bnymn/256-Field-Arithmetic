#--- 121 INS
.section .text
mul_n_v2:
	.globl mul_n_v2
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15

	// level 0
	movq 8*0(%rdi), %rax
	mulq 8*0(%rsi)
	movq %rax, %r8 // final
	movq %rdx, %r9

	// level 1
	movq $0, %r10
	movq $0, %r11

	movq 8*0(%rdi), %rax
	mulq 8*1(%rsi)
	addq %rax, %r9
	adcq %rdx, %r10

	movq 8*1(%rdi), %rax
	mulq 8*0(%rsi)
	addq %rax, %r9
	adcq %rdx, %r10
	adcq $0, %r11

	// level 2
	movq 8*0(%rdi), %rax
	mulq 8*2(%rsi)
	addq %rax, %r10
	adcq %rdx, %r11


	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
ret
