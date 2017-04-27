/**
 * Multiplication of two 256-bit numbers
 *
 * @param a	256-bit number stores the multiplicand 1
 * @param b	256-bit number stores the multiplicand 2
 * @param c 64-bit number, which is the 2^256 - c
 * @param r	256-bit number stores the result
 */
void mul_n(unsigned long *a, unsigned long *b, unsigned long c, unsigned long *r);
void mul_n_v2(unsigned long *a, unsigned long *b, unsigned long c, unsigned long *r);
void mul_2e256mc_x8664_asm_recursive(unsigned long *zn, unsigned long c, unsigned long *noparam, unsigned long *an, unsigned long *bn);
