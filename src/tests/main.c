#include "libasm.h"

int main(void)
{
	printf("Now launching Tests...\n\n");
	test_ft_write();
	write(1, "\n", 1);
	test_ft_strlen();

	return (0);
}
