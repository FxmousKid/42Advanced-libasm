/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm_bonus.h                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: inazaria <inazaria@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/06/17 21:19:08 by inazaria          #+#    #+#             */
/*   Updated: 2025/06/24 13:32:14 by inazaria         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef  LIBASM_BONUS_H
# define LIBASM_BONUS_H

# include <stdio.h>
# include <unistd.h>
# include <errno.h>
# include <string.h>
# include <fcntl.h>
# include <stdlib.h>

typedef struct s_list
{
	void			*data;
	struct s_list	*next;
}					t_list;	

extern ssize_t	ft_write(int fd, const void *buf, size_t count);
extern size_t	ft_strlen(const char *buf);
extern int		ft_strcmp(const char *s1, const char *s2);
extern ssize_t	ft_read(int fd, void *buf, size_t count);
extern char		*ft_strcpy(char *dest, const char *src);
extern char		*ft_strdup(const char *s);

extern int		ft_list_size(t_list *lst);
extern void		ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(void *, void *), void (*free_fct)(void *));
extern void		ft_list_push_front(t_list **begin_list, void *data);

int		test_ft_list_size(void);
int		test_ft_list_remove_if(void);
int		test_ft_list_push_front(void);

#endif
