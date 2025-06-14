#include "libasm.h"

/* ─── your assembly symbol ──────────────────────────────────────────────── */
size_t ft_strlen(const char *s);

/* ─── one big battery; returns #failures so main() can act on it ────────── */
int test_ft_strlen(void)
{
    const char *tests[] = {
        "",                              /* empty string                    */
        "A",                             /* single char                     */
        "Hello, world!",                 /* ASCII                           */
        "libasm \xF0\x9F\x94\xA5",       /* UTF-8 emoji (🔥)                */
        "line1\nline2\n",                /* contains a newline              */
        "0123456789abcdef0123456789abcdef0123456789abcdef", /* long-ish     */
    };

    size_t n_tests  = sizeof(tests) / sizeof(tests[0]);
    int    failures = 0;

    puts("===== ft_strlen test suite =====\n");

    for (size_t i = 0; i < n_tests; ++i)
    {
        const char *str      = tests[i];
        size_t      expect   = strlen(str);
        size_t      actual   = ft_strlen(str);
        int         passed   = (expect == actual);

        printf("test %-2zu: \"%s\"\n", i + 1, str);
        printf("expect : %zu\n", expect);
        printf("actual : %zu\n", actual);
        printf("[%s]\n\n", passed ? "PASSED" : "FAILED");

        if (!passed) ++failures;
    }
    return failures;
}
