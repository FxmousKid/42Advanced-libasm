/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main_bonus.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: inazaria <inazaria@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/06/17 21:44:29 by inazaria          #+#    #+#             */
/*   Updated: 2025/06/24 13:51:53 by inazaria         ###   ########.fr       */
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
	
	// ft_list_remove_if(0, 0, 0, 0);

	return (0); 
}
