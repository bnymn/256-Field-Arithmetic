#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mul_n.h"
#include "magmac/magmac.h"

int test_bunyamin()
{
	unsigned long a[4] = {};
	unsigned long b[4] = {};
	unsigned long c = 47;
	unsigned long r[8];
	char magma_str[5000];

	struct magma_session session;
	char **result;
	result = malloc(sizeof(size_t));

	/* open a magma session */
	magma_init(&session);

	/**
	 * Library calculation
	 */
	int i;
	unsigned long has_error = 0;
	for(i=0; i<10000; i++)
	{
		int j;
		for(j=0; j<4; j++)
		{
			a[j] = (unsigned long)rand() * rand();
			b[j] = (unsigned long)rand() * rand();
		}
		mul_n_v2(a, b, c, r);
		sprintf(magma_str, "B := 2^64; a := %lu * B^3 + %lu * B^2 + %lu * B^1 + %lu * B^0; b := %lu * B^3 + %lu * B^2 + %lu * B^1 + %lu * B^0; r := %lu * B^3 + %lu * B^2 + %lu * B^1 + %lu * B^0; ( (a*b) mod (B^4 - %lu) ) - r;\n", a[3], a[2], a[1], a[0], b[3], b[2], b[1], b[0], r[3], r[2], r[1], r[0], c);
		printf(magma_str);
		fflush(stdout);

		//mul_2e256mc_x8664_asm_recursive(r, c, NULL, a, b);
		//sprintf(magma_str, "B := 2^64; a := %lu * B^3 + %lu * B^2 + %lu * B^1 + %lu * B^0; b := %lu * B^3 + %lu * B^2 + %lu * B^1 + %lu * B^0; r := %lu * B^7 + %lu * B^6 + %lu * B^5 + %lu * B^4 + %lu * B^3 + %lu * B^2 + %lu * B^1 + %lu * B^0; a*b - r;", a[3], a[2], a[1], a[0], b[3], b[2], b[1], b[0], r[7], r[6], r[5], r[4], r[3], r[2], r[1], r[0]);
		magma_cmd(&session, magma_str, result);
		if(**result != '0')
		{
			has_error++;
		}
		free(*result);
	}

	printf("Error: %lu", has_error);
	fflush(stdout);

	/* don't forget to close the session in order to avoid zombis */
	magma_close(&session);

	/* freeing memory */
	last_lines(result, 1);
	free(result);

	return 1;
}
