.section .text
mul_n:
  .globl mul_n
  pushq %rbx
  pushq %r12
  pushq %r13
  pushq %r14
  pushq %r15

  movq %rdx, %xmm0
  movq 8*0(%rsi), %rbx
  movq 8*0(%rdi), %rax
  mulq %rbx
  movq %rax, %r8
  movq %rdx, %r9

  movq $0, %r10
  movq $0, %r11
  movq $0, %r12
  movq $0, %r13
  movq $0, %r14
  movq $0, %r15

  movq 8*1(%rdi), %rax
  mulq %rbx
  addq %rax, %r9
  adcq %rdx, %r10

  movq 8*2(%rdi), %rax
  mulq %rbx
  addq %rax, %r10
  adcq %rdx, %r11

  movq 8*3(%rdi), %rax
  mulq %rbx
  addq %rax, %r11
  adcq %rdx, %r12

  #---

  movq 8*1(%rsi), %rbx
  movq 8*0(%rdi), %rax
  mulq %rbx
  addq %rax, %r9
  adcq %rdx, %r10
  adcq $0, %r11
  adcq $0, %r12
  adcq $0, %r13

  movq 8*1(%rdi), %rax
  mulq %rbx
  addq %rax, %r10
  adcq %rdx, %r11
  adcq $0, %r12
  adcq $0, %r13

  movq 8*2(%rdi), %rax
  mulq %rbx
  addq %rax, %r11
  adcq %rdx, %r12
  adcq $0, %r13

  movq 8*3(%rdi), %rax
  mulq %rbx
  addq %rax, %r12
  adcq %rdx, %r13
  adcq $0, %r14

  #---

  movq 8*2(%rsi), %rbx
  movq 8*0(%rdi), %rax
  mulq %rbx
  addq %rax, %r10
  adcq %rdx, %r11
  adcq $0, %r12
  adcq $0, %r13
  adcq $0, %r14

  movq 8*1(%rdi), %rax
  mulq %rbx
  addq %rax, %r11
  adcq %rdx, %r12
  adcq $0, %r13
  adcq $0, %r14

  movq 8*2(%rdi), %rax
  mulq %rbx
  addq %rax, %r12
  adcq %rdx, %r13
  adcq $0, %r14

  movq 8*3(%rdi), %rax
  mulq %rbx
  addq %rax, %r13
  adcq %rdx, %r14
  adcq $0, %r15

  #---

  movq 8*3(%rsi), %rbx
  movq 8*0(%rdi), %rax
  mulq %rbx
  addq %rax, %r11
  adcq %rdx, %r12
  adcq $0, %r13
  adcq $0, %r14
  adcq $0, %r15

  movq 8*1(%rdi), %rax
  mulq %rbx
  addq %rax, %r12
  adcq %rdx, %r13
  adcq $0, %r14
  adcq $0, %r15

  movq 8*2(%rdi), %rax
  mulq %rbx
  addq %rax, %r13
  adcq %rdx, %r14
  adcq $0, %r15

  movq 8*3(%rdi), %rax
  mulq %rbx
  addq %rax, %r14
  adcq %rdx, %r15

  #---
  movq %xmm0, %rbx

  movq %r12, %rax
  mulq %rbx
  addq %rax, %r8
  adcq %rdx, %r9
  adcq $0, %r10

  movq %r13, %rax
  mulq %rbx
  addq %rax, %r9
  adcq %rdx, %r10
  adcq $0, %r11

  movq $0, %r12
  movq %r12, %r13

  movq %r14, %rax
  mulq %rbx
  addq %rax, %r10
  adcq %rdx, %r11
  adcq $0, %r12

  movq %r15, %rax
  mulq %rbx
  addq %rax, %r11
  adcq %rdx, %r12
  adcq $0, %r13

  movq %r12, %rax
  mulq %rbx
  addq %rax, %r8
  adcq %rdx, %r9
  adcq $0, %r10

  movq %r13, %rax
  mulq %rbx
  addq %rax, %r9
  adcq %rdx, %r10
  adcq $0, %r11

  movq %r8, %r12
  movq %r9, %r13
  movq %r10, %r14
  movq %r11, %r15

  addq %rbx, %r8
  adcq $0, %r9
  adcq $0, %r10
  adcq $0, %r11

  cmovnc %r12, %r8
  cmovnc %r13, %r9
  cmovnc %r14, %r10
  cmovnc %r15, %r11

  #---

  movq %r8, 8*0(%rcx)
  movq %r9, 8*1(%rcx)
  movq %r10, 8*2(%rcx)
  movq %r11, 8*3(%rcx)

  popq %r15
  popq %r14
  popq %r13
  popq %r12
  popq %rbx
  ret
