#--- 121 INS
.section .text
mul_n_v2:
	.globl mul_n_v2
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15

	movq %rcx, %xmm0

	#---
	movq 8*0(%rsi), %rbx
	movq 8*0(%rdi), %rax
	mulq %rbx
	movq %rax, %r8
	movq %rdx, %rcx

	movq 8*1(%rdi), %rax
	mulq %rbx
	addq %rcx, %rax
	adcq $0, %rdx
	movq %rax, %r9
	movq %rdx, %rcx

	movq 8*2(%rdi), %rax
	mulq %rbx
	addq %rcx, %rax
	adcq $0, %rdx
	movq %rax, %r10
	movq %rdx, %rcx

	movq 8*3(%rdi), %rax
	mulq %rbx
	addq %rcx, %rax
	adcq $0, %rdx
	movq %rax, %r11
	movq %rdx, %rcx

	#---
	movq 8*1(%rsi), %rbx
	movq 8*0(%rdi), %rax
	mulq %rbx
	addq %rax, %r9
	adcq $0, %rdx
	movq %rdx, %rcx

	movq 8*1(%rdi), %rax
	mulq %rbx
	addq %rax, %r10
	adcq $0, %rdx
	addq %rcx, %r10
	adcq $0, %rdx
	movq %rdx, %rcx

	movq 8*2(%rdi), %rax
	mulq %rbx
	addq %rax, %r11
	adcq $0, %rdx
	addq %rcx, %r11
	adcq $0, %rdx
	movq %rdx, %rcx

	movq 8*3(%rdi), %rax
	mulq %rbx
	addq %rcx, %rax
	adcq $0, %rdx
	movq %rax, %r12
	movq %rdx, %rcx

	#---
	movq 8*2(%rsi), %rbx
	movq 8*0(%rdi), %rax
	mulq %rbx
	addq %rax, %r10
	adcq $0, %rdx
	movq %rdx, %rcx

	movq 8*1(%rdi), %rax
	mulq %rbx
	addq %rax, %r11
	adcq $0, %rdx
	addq %rcx, %r11
	adcq $0, %rdx
	movq %rdx, %rcx

	movq 8*2(%rdi), %rax
	mulq %rbx
	addq %rax, %r12
	adcq $0, %rdx
	addq %rcx, %r12
	adcq $0, %rdx
	movq %rdx, %rcx

	movq 8*3(%rdi), %rax
	mulq %rbx
	addq %rcx, %rax
	adcq $0, %rdx
	movq %rax, %r13
	movq %rdx, %rcx

	#---
	movq 8*3(%rsi), %rbx
	movq 8*0(%rdi), %rax
	mulq %rbx
	addq %rax, %r11
	adcq $0, %rdx
	movq %rdx, %rcx

	movq 8*1(%rdi), %rax
	mulq %rbx
	addq %rax, %r12
	adcq $0, %rdx
	addq %rcx, %r12
	adcq $0, %rdx
	movq %rdx, %rcx

	movq 8*2(%rdi), %rax
	mulq %rbx
	addq %rax, %r13
	adcq $0, %rdx
	addq %rcx, %r13
	adcq $0, %rdx
	movq %rdx, %rcx

	movq 8*3(%rdi), %rax
	mulq %rbx
	addq %rcx, %rax
	adcq $0, %rdx
	movq %rax, %r14
	movq %rdx, %r15

	movq %xmm0, %rcx
	movq %r8, 8*0(%rcx)
	movq %r9, 8*1(%rcx)
	movq %r10, 8*2(%rcx)
	movq %r11, 8*3(%rcx)
	movq %r12, 8*4(%rcx)
	movq %r13, 8*5(%rcx)
	movq %r14, 8*6(%rcx)
	movq %r15, 8*7(%rcx)

	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
ret
