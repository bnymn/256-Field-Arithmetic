#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mul_n.h"
#include "magmac/magmac.h"

int test_huseyin()
{

	/*

	 a = 9acb7c5a4f6e34eba7abe54208162bca
	 b = 287ef26201fe10319cba532faef320ab

	*/
	unsigned long an[4] = { 0x9cba532faef320abUL, 0x287ef26201fe1031UL, 0xa7abe54208162bcaUL, 0x9acb7c5a4f6e34ebUL };
	unsigned long bn[4] = { 0x54432ee03244feacUL, 0x87152c4712054e2fUL, 0x154154a124875b24UL, 0xff45f28e45487f54UL };
	unsigned long zn[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };

	mul_2e256mc_x8664_asm_recursive(zn, 0, NULL, an, bn);



	return 1;
}
