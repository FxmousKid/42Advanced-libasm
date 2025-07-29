/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main_bonus.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: inazaria <inazaria@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/06/17 21:44:29 by inazaria          #+#    #+#             */
/*   Updated: 2025/06/24 19:24:39 by inazaria         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm_bonus.h"

int main(void)
{
	printf("Now launching Tests...\n\n");
	test_ft_list_size();
	write(1, "\n", 1);
	test_ft_list_remove_if();
	write(1, "\n", 1);
	test_ft_list_push_front();
	write(1, "\n", 1);
	test_ft_atoi_base();
	write(1, "\n", 1);
	return (0); 
}
