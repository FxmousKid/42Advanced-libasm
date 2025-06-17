#include "libasm.h"

static int one_case(const char *label, const char *src)
{
    char ref[256] = {0};      /* destination for libc strcpy   */
    char buf[256] = {0};      /* destination for asm  strcpy   */

    /* libc reference */
    char *ret_std = strcpy(ref, src);

    /* asm version */
    char *ret_asm = ft_strcpy(buf, src);

    /* conditions: same bytes + return-value == dst */
    int ok = (strcmp(ref, buf)     == 0) &&
             (ret_asm              == buf) &&
             (ret_std              == ref);

    printf("test %-12s %s\n", label, ok ? "[PASSED]" : "[FAILED]");
    if (!ok)
        printf("  expect \"%s\"\n  actual \"%s\"\n", ref, buf);

    return ok ? 0 : 1;
}

/* ─── master battery — returns #failures ───────────────────────────────── */
int test_ft_strcpy(void)
{
    const char *cases[] = {
        "",                       /* empty */
        "A",                      /* single char */
        "Hello, world!",          /* classic */
        "libasm 🔥",              /* UTF-8 */
        "abcdefghijklmnopqrstuvwxyz0123456789",
    };

    size_t n = sizeof(cases) / sizeof(cases[0]);
    int failures = 0;

    puts("===== ft_strcpy test suite =====");
    for (size_t i = 0; i < n; ++i)
        failures += one_case(cases[i], cases[i]);

    printf("\n===== ft_strcpy: %s =====\n",
           failures ? "Some tests FAILED" : "All tests PASSED");
    return failures;
}
