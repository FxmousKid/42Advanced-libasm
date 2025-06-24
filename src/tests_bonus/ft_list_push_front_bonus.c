/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_push_front_bonus.c                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: inazaria <inazaria@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/06/24 13:31:33 by inazaria          #+#    #+#             */
/*   Updated: 2025/06/24 18:56:27 by inazaria         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm_bonus.h"

// Helper function to print the list (optional)
// void debug_print_list(t_list *list)
// {
//     printf("---- Linked list dump ----\n");
//     int i = 0;
//     while (list)
//     {
//         printf("Node %2d @ %p: data=\"%s\" next=%p\n", 
//             i, (void *)list, (char *)list->data, (void *)list->next);
//         list = list->next;
//         i++;
//     }
//     printf("--------------------------\n");
// }

// Free the list after test
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

// single test case
static int one_case(const char *label, const char *values[], size_t len)
{
    t_list *list = NULL;

    for (size_t i = 0; i < len; ++i)
    {
        // we call your ASM function here directly
        ft_list_push_front(&list, strdup(values[i]));
    }

    printf("Test %-12s : ", label);
    int success = 1;

    // verify reversed insertion order
    for (size_t i = 0; i < len; ++i)
    {
        if (!list || strcmp((char *)list->data, values[len - 1 - i]) != 0)
        {
            printf("[FAILED]\n");
            success = 0;
            break;
        }
        list = list->next;
    }
    if (success && list == NULL)
        printf("[PASSED]\n");
    else if (success)
		printf("[FAILED: list longer than expected]\n");

    free_list(list);
    return success ? 0 : 1;
}

int test_ft_list_push_front(void)
{
    int failures = 0;

    const char *a1[] = { "A" };
    failures += one_case("push-one", a1, 1);

    const char *a2[] = { "A", "B" };
    failures += one_case("push-two", a2, 2);

    const char *a3[] = { "X", "Y", "Z" };
    failures += one_case("push-three", a3, 3);

    printf("\n===== ft_list_push_front: %s =====\n",
        failures ? "Some tests FAILED" : "All tests PASSED");
    return failures;
}

