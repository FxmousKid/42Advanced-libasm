/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: inazaria <inazaria@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/06/14 20:04:05 by inazaria          #+#    #+#             */
/*   Updated: 2025/06/17 16:39:59 by inazaria         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef  LIBASM_H
# define LIBASM_H

#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>

extern ssize_t	ft_write(int fd, const void *buf, size_t count);
extern size_t	ft_strlen(const char *buf);
extern int		ft_strcmp(const char *s1, const char *s2);
extern ssize_t	ft_read(int fd, void *buf, size_t count);
extern char		*ft_strcpy(char *dest, const char *src);
extern char		*ft_strdup(const char *s);


int 	test_ft_write(void);
int 	test_ft_strlen(void);
int		test_ft_strcmp(void);
int 	test_ft_read(void);
int		test_ft_strcpy(void);
int		test_ft_strdup(void);

#endif
