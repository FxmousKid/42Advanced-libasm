#include "libasm.h"

int main(void)
{
	printf("Now launching Tests...\n\n");
	test_ft_write();
	write(1, "\n", 1);
	test_ft_strlen();
	write(1, "\n", 1);
	test_ft_strcmp();
	write(1, "\n", 1);
	test_ft_read();
	write(1, "\n", 1);
	test_ft_strcpy();
	write(1, "\n", 1);

	return (0);
}
