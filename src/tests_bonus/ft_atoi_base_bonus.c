/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_atoi_base_bonus.c                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: inazaria <inazaria@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/06/24 19:24:57 by inazaria          #+#    #+#             */
/*   Updated: 2025/06/25 13:06:30 by inazaria         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm_bonus.h"

int	one_case(char *str, char *base, int expected)
{
	int res = ft_atoi_base(str, base);
	char status[7] = {0};
	if (res == expected) 
		ft_strcpy(status, "PASSED");
	else
		ft_strcpy(status, "FAILED");

	printf("ft_atoi_base(\"%s\", \"%s\") : got [%d], expected [%d] : [%s]\n",str, base, res, expected, status);

	return (res != expected);
}

int	test_ft_atoi_base(void)
{
	
	int failure = 0;

	printf("======== test ft_atoi_base ===========\n\n");

	failure += one_case("42", "01", 101010);
	failure += one_case("42", "", -1);
	failure += one_case("42", "0", -1);
	
	write(1, "\n", 1);
	if (failure)
		printf("======== test ft_atoi_base [\"FAILED\"]===========\n\n");
	else
		printf("======== test ft_atoi_base [\"PASSED\"]===========\n\n");
	return (failure == 0 ? 0 : 1);
}
