/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: inazaria <inazaria@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/06/14 20:04:05 by inazaria          #+#    #+#             */
/*   Updated: 2025/06/14 22:33:08 by inazaria         ###   ########.fr       */
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

int test_ft_write(void);
int test_ft_strlen(void);

#endif
