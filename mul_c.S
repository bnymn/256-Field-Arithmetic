.section .text
mul_c:
  .globl mul_c
  movq 8*0(%rdi), %rax
  mulq %rsi
  movq %rax, %r8
  movq %rdx, %r9

  movq $0, %r10
  movq $0, %r11
  movq $0, %r12

  movq 8*1(%rdi), %rax
  mulq %rsi
  addq %rax, %r9
  adcq %rdx, %r10

  movq 8*2(%rdi), %rax
  mulq %rsi
  addq %rax, %r10
  adcq %rdx, %r11

  movq 8*3(%rdi), %rax
  mulq %rsi
  addq %rax, %r11
  adcq %rdx, %r12

  movq %r8, 8*0(%rcx)
  movq %r9, 8*1(%rcx)
  movq %r10, 8*2(%rcx)
  movq %r11, 8*3(%rcx)
  movq %r12, 8*4(%rcx)
  ret
