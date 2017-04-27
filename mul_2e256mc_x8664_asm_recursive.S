.text

mul_2e256mc_x8664_asm_recursive:
  .globl mul_2e256mc_x8664_asm_recursive
  	pushq %r15
  	pushq %r14
  	pushq %r13
  	pushq %r12
  	pushq %rbx
  	pushq %rsi
  	pushq %rdi


	//A1*B0. [r13,r12,r11,r10].
	movq 8*2+8*0(%r8), %rax
	mulq 8*1+8*0(%rcx)
	movq %rdx, %r12
	movq %rax, %r11
	movq 8*3+8*0(%r8), %rax
	mulq 8*0+8*0(%rcx)
	addq %rax, %r11
	adcq %rdx, %r12
	movq 8*0+8*0(%rcx), %rax
	mulq 8*2+8*0(%r8)
	addq %rdx, %r11
	movq %rax, %r10
	adcq $0, %r12
	movq 8*3+8*0(%r8), %rax
	mulq 8*1+8*0(%rcx)
	addq %rax, %r12
	adcq $0, %rdx
	movq %rdx, %r13


	//A0*B0. [rdx,rax,r9,rbx].
	movq 8*0+8*0(%r8), %rax
	mulq 8*1+8*0(%rcx)
	movq %rdx, %r14
	movq %rax, %r9
	movq 8*1+8*0(%r8), %rax
	mulq 8*0+8*0(%rcx)
	addq %rax, %r9
	adcq %rdx, %r14
	movq 8*0+8*0(%rcx), %rax
	mulq 8*0+8*0(%r8)
	addq %rdx, %r9
	movq %rax, %rbx
	adcq $0, %r14
	movq 8*1+8*0(%r8), %rax
	mulq 8*1+8*0(%rcx)
	addq %r14, %rax
	adcq $0, %rdx

	addq %rax, %r10
	adcq %rdx, %r11
	adcq $0, %r12
	adcq $0, %r13


	//A0*B1. [rdx,rax,r15,r14].
	movq 8*0+8*0(%r8), %rax
	mulq 8*3+8*0(%rcx)
	movq %rdx, %rsi
	movq %rax, %r15
	movq 8*1+8*0(%r8), %rax
	mulq 8*2+8*0(%rcx)
	addq %rax, %r15
	adcq %rdx, %rsi
	movq 8*2+8*0(%rcx), %rax
	mulq 8*0+8*0(%r8)
	addq %rdx, %r15
	movq %rax, %r14
	adcq $0, %rsi
	movq 8*1+8*0(%r8), %rax
	mulq 8*3+8*0(%rcx)
	addq %rsi, %rax
	adcq $0, %rdx

	movq %rax, %xmm0
	movq %rdx, %xmm1

	addq %r14, %r10
	adcq %r15, %r11
	adcq $0, %r12
	adcq $0, %r13


	//A1*B1. [rdx,rax,r15,r14].
	movq 8*2+8*0(%r8), %rax
	mulq 8*3+8*0(%rcx)
	movq %rdx, %rsi
	movq %rax, %r15
	movq 8*3+8*0(%r8), %rax
	mulq 8*2+8*0(%rcx)
	addq %rax, %r15
	adcq %rdx, %rsi
	movq 8*2+8*0(%rcx), %rax
	mulq 8*2+8*0(%r8)
	addq %rdx, %r15
	movq %rax, %r14
	adcq $0, %rsi
	movq 8*3+8*0(%r8), %rax
	mulq 8*3+8*0(%rcx)
	addq %rsi, %rax
	adcq $0, %rdx

	addq %r14, %r12
	adcq %r15, %r13
	adcq $0, %rax
	adcq $0, %rdx

	movq %xmm0, %r14
	movq %xmm1, %r15

	addq %r14, %r12
	adcq %r15, %r13
	adcq $0, %rax
	adcq $0, %rdx

	popq %rdi
	popq %rsi


	//En son yaziyoruz cunku zn=an ya da zn=bn olabilir.
	movq %rbx, 8*0+8*0(%rdi)
	movq %r9,  8*1+8*0(%rdi)
	movq %r10, 8*2+8*0(%rdi)
	movq %r11, 8*3+8*0(%rdi)
	movq %r12, 8*4+8*0(%rdi)
	movq %r13, 8*5+8*0(%rdi)
	movq %rax, 8*6+8*0(%rdi)
	movq %rdx, 8*7+8*0(%rdi)


	popq %rbx
	popq %r12
	popq %r13
	popq %r14
	popq %r15

ret
