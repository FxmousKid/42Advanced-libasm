/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_size_bonus.c                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: inazaria <inazaria@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/06/17 23:12:20 by inazaria          #+#    #+#             */
/*   Updated: 2025/06/17 23:13:49 by inazaria         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm_bonus.h"

static t_list *make_list(size_t n)
{
    t_list *head = NULL;
    for (size_t i = 0; i < n; ++i)
    {
        t_list *node = malloc(sizeof(*node));
        node->data = NULL;
        node->next = head;
        head = node;
    }
    return head;
}

/* ───────────────── helper: free list ──────────────────────────────────── */
static void free_list(t_list *lst)
{
    while (lst)
    {
        t_list *tmp = lst->next;
        free(lst);
        lst = tmp;
    }
}

/* ───────────────── single case tester ─────────────────────────────────── */
static int one_case(const char *label, size_t len)
{
    t_list *list = make_list(len);
    size_t  got  = ft_list_size(list);
    int     ok   = (got == len);

    printf("test %-10s %s (got %zu, expect %zu)\n",
           label, ok ? "[PASSED]" : "[FAILED]", got, len);

    free_list(list);
    return ok ? 0 : 1;
}

/* ───────────────── battery — returns #failures ────────────────────────── */
int test_ft_list_size(void)
{
    int failures = 0;

    failures += one_case("empty",      0);
    failures += one_case("single",     1);
    failures += one_case("triple",     3);
    failures += one_case("ten-nodes", 10);

    printf("\n===== ft_list_size: %s =====\n",
           failures ? "Some tests FAILED" : "All tests PASSED");
    return failures;
}
