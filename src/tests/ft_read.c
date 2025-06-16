#include "libasm.h"

static int compare(const char *label,
                   ssize_t ret_asm, const char *buf_asm, int err_asm,
                   ssize_t ret_std, const char *buf_std, int err_std)
{
    int ok = (ret_asm == ret_std) &&
             (err_asm == err_std) &&
             (memcmp(buf_asm, buf_std,
                     (ret_std > 0 ? (size_t)ret_std : 0)) == 0);

    printf("test %-12s %s\n", label, ok ? "[PASSED]" : "[FAILED]");
    if (!ok) {
        printf("  expect ret=%zd errno=%d\n"
               "  actual ret=%zd errno=%d\n",
               ret_std, err_std, ret_asm, err_asm);
    }
    return ok ? 0 : 1;
}

/* ------------------------------------------------------------------------- */
/* helper for pipe-based tests: give each call its own pipe                  */
/* ------------------------------------------------------------------------- */
static int pipe_case(const char *label,
                     const char *payload, size_t nbytes /* request size */)
{
    /* ---- ft_read side ---- */
    int p1[2]; pipe(p1);
    write(p1[1], payload, strlen(payload));
    close(p1[1]);

    char buf_asm[256] = {0};
    errno = 0;
    ssize_t ret_asm = ft_read(p1[0], buf_asm, nbytes);
    int err_asm = errno;
    close(p1[0]);

    /* ---- libc read side ---- */
    int p2[2]; pipe(p2);
    write(p2[1], payload, strlen(payload));
    close(p2[1]);

    char buf_std[256] = {0};
    errno = 0;
    ssize_t ret_std = read(p2[0], buf_std, nbytes);
    int err_std = errno;
    close(p2[0]);

    return compare(label, ret_asm, buf_asm, err_asm,
                          ret_std, buf_std, err_std);
}

/* ------------------------------------------------------------------------- */
/* helper for single FD tests (bad-fd, dir-fd)                               */
/* ------------------------------------------------------------------------- */
static int fd_case(const char *label, int fd, size_t n, int expect_errno)
{
    char buf_asm[4] = {0};
    errno = 0;
    ssize_t ret_asm = ft_read(fd, buf_asm, n);
    int err_asm = errno;

    char buf_std[4] = {0};
    errno = 0;
    ssize_t ret_std = read(fd, buf_std, n);
    int err_std = errno;

    /* if libc failed we expect ft_read to fail same way */
    (void)expect_errno;
    return compare(label, ret_asm, buf_asm, err_asm,
                          ret_std, buf_std, err_std);
}

/* ------------------------------------------------------------------------- */
/* main battery                                                              */
/* ------------------------------------------------------------------------- */
int test_ft_read(void)
{
    int failures = 0;

    /* 1. valid read from pipe */
    failures += pipe_case("pipe-valid", "libasm\n", 7);

    /* 2. read zero bytes */
    failures += pipe_case("read 0", "X", 0);

    /* 3. short read (ask for more than available) */
    failures += pipe_case("short-read", "hi", 10);

    /* 4. EBADF */
    failures += fd_case("bad-fd", -1, 4, EBADF);

    /* 5. EISDIR */
    {
        int dirfd = open(".", O_RDONLY);
        if (dirfd != -1) {
            failures += fd_case("dir-fd", dirfd, 4, EISDIR);
            close(dirfd);
        }
    }

    printf("\n===== ft_read: %s =====\n",
           failures ? "Some tests FAILED" : "All tests PASSED");
    return failures;
}
