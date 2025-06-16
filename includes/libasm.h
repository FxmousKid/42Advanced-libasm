/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: inazaria <inazaria@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/06/14 20:04:05 by inazaria          #+#    #+#             */
/*   Updated: 2025/06/16 02:38:30 by inazaria         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef  LIBASM_H
# define LIBASM_H

#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>

extern ssize_t	ft_write(int fd, const void *buf, size_t count);
extern size_t	ft_strlen(const char *buf);
extern int		ft_strcmp(const char *s1, const char *s2);

int test_ft_write(void);
int test_ft_strlen(void);
int	test_ft_strcmp(void);

#endif
