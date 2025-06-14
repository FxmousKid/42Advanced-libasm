#include "libasm.h"

/* Helper: capture what ft_write() puts into a pipe ------------------------- */
static ssize_t capture_ft_write(const char *msg, char *out, size_t cap)
{
    int     pfd[2];
    ssize_t ret;

    if (pipe(pfd) == -1)
        return -1;                              /* pipe() failure */

    ret = ft_write(pfd[1], msg, strlen(msg));   /* write into pipe’s write-end */
    close(pfd[1]);                              /* we’ll only read now        */

    /* read back whatever the ASM wrote */
    ssize_t r = read(pfd[0], out, cap - 1);
    if (r >= 0)
        out[r] = '\0';                          /* null-terminate */
    close(pfd[0]);
    return ret;
}

/* One big test battery ----------------------------------------------------- */
int test_ft_write(void)
{
    const char *tests[] = {
        "Hello, world!\n",
        "42 school\n",
        ""
    };
    const size_t n_tests = sizeof(tests) / sizeof(tests[0]);
    int failures = 0;

    for (size_t i = 0; i < n_tests; ++i)
    {
        char   buf[256] = {0};
        errno  = 0;

        ssize_t ret = capture_ft_write(tests[i], buf, sizeof(buf));

        printf("test %zu: \"%s\"\n", i + 1, tests[i]);
        printf("-->   : \"%s\"\n", buf);

        int pass = (ret == (ssize_t)strlen(tests[i])) &&
                   (strcmp(buf, tests[i]) == 0) &&
                   (errno == 0);

        printf("[%s]\n\n", pass ? "PASSED" : "FAILED");
        if (!pass) ++failures;
    }
    return failures;
}
