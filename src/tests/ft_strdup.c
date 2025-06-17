#include "libasm.h"

char *tests[] = {"Hello World !", \
				"",
				"a",
				"❤️✓🫶🔥✨😭😂"};

int	test_ft_strdup(void)
{
	printf("============= ft_strdup  ===============\n");
	char 	*ref;
	char 	*test;
	int		ret = 0;	

	for (size_t i = 0; i < sizeof(tests) / sizeof(*tests); i++) {
		printf("TEST %zu : '%s'\n", i, tests[i]);
		ref = strdup(tests[i]);
		printf("Expected : ['%s']\n", ref);
		test = ft_strdup(tests[i]);
		printf("Actual   : ['%s']\n", test);

		if (ft_strcmp(ref, test) && (ret = 1))
			printf("[FAILED]\n");
		else
			printf("[PASSED]\n");
	}
	return (!ret);
}
