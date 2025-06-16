#include "libasm.h"

int test_ft_strcmp(void)
{
    struct {
        const char *lhs;
        const char *rhs;
    } cases[] = {
        /* equal */
        { "",  ""           },
        { "a", "a"          },
        { "same string", "same string" },

        /* lhs < rhs (expect negative) */
        { "abc",   "abd"    },
        { "short", "shorter"},
        { "A",     "B"      },

        /* lhs > rhs (expect positive) */
        { "abd",   "abc"    },
        { "longer","long"   },
        { "zoo",   "apple"  },
    };

    const size_t n = sizeof(cases) / sizeof(cases[0]);
    int failures = 0;

    puts("===== ft_strcmp test suite =====\n");

    for (size_t i = 0; i < n; ++i)
    {
        const char *lhs   = cases[i].lhs;
        const char *rhs   = cases[i].rhs;

        int expect = strcmp(lhs, rhs);
        int actual = ft_strcmp(lhs, rhs);

        /* strcmp spec only guarantees sign, not exact value */
        int passed = ((expect == 0 && actual == 0) ||
                      (expect  < 0 && actual  < 0) ||
                      (expect  > 0 && actual  > 0));

        printf("test %-2zu: \"%s\" <> \"%s\"\n", i + 1, lhs, rhs);
        printf("expect : %d\n", expect);
        printf("actual : %d\n", actual);
        printf("[%s]\n\n", passed ? "PASSED" : "FAILED");

        if (!passed) ++failures;
    }
    return failures;
}
