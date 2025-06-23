/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_remove_if_bonus.c                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: inazaria <inazaria@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/06/21 18:51:20 by inazaria          #+#    #+#             */
/*   Updated: 2025/06/24 01:46:53 by inazaria         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */


#include "libasm_bonus.h"

void debug_print_list(t_list *list)
{
    printf("---- Linked list dump ----\n");
    int i = 0;
    while (list)
    {
        printf("Node %2d @ %p\n", i, (void *)list);
        printf("  data: %s\n", (char *)list->data);
        printf("  next: %p\n", (void *)list->next);
        list = list->next;
        i++;
    }
    printf("--------------------------\n");
}

static t_list *push_front(t_list *head, const char *str)
{
    t_list *n  = malloc(sizeof(*n));
    n->data    = strdup(str);
    n->next    = head;
    return n;
}

static void free_node(void *ptr)
{
    free(ptr);
}

static void free_list(t_list *lst)
{
    while (lst)
    {
        t_list *tmp = lst->next;
        free(lst->data);
        free(lst);
        lst = tmp;
    }
}

static int cmp_str(void *a, void *b)
{
    return strcmp((char *)a, (char *)b);
}

static int one_case(const char *label,
                    const char *initial[], size_t init_len,
                    const char *to_remove,
                    size_t expect_len)
{
    t_list *list = NULL;
    for (size_t i = 0; i < init_len; ++i)
		list = push_front(list, initial[i]);

    ft_list_remove_if(&list, (void *)to_remove, cmp_str, free_node);

    size_t got = ft_list_size(list);
    int ok = (got == expect_len);

    printf("test %-12s %s (size %zu → %zu exp %zu)\n",
           label, ok ? "[PASSED]" : "[FAILED]",
           init_len, got, expect_len);

    if (list)      // only call free_list() if there's anything left
        free_list(list);
    return ok ? 0 : 1;
}

int test_ft_list_remove_if(void)
{
    int failures = 0;

    const char *a1[] = { "A", "B", "C" };
    failures += one_case("remove-head",  a1, 3, "C", 2);

    const char *a2[] = { "A", "B", "C" };
    failures += one_case("remove-mid",   a2, 3, "B", 2);

    const char *a3[] = { "A", "B", "C" };
    failures += one_case("remove-tail",  a3, 3, "A", 2);

    const char *a5[] = { "A", "B", "C" };
    failures += one_case("remove-none",  a5, 3, "Z", 3);

    const char *a4[] = { "X", "X", "X" };
    failures += one_case("remove-all",   a4, 3, "X", 0);

    printf("\n===== ft_list_remove_if: %s =====\n",
           failures ? "Some tests FAILED" : "All tests PASSED");
    return failures;
}

