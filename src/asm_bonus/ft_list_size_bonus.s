; x86_64, System V ABI, PIE
; int ft_list_size(t_list *list)

default		rel
global		ft_list_size

; The t_list structure
STRUC t_list
	.data	resq 1	
	.next	resq 1
ENDSTRUC


section .text
ft_list_size:
	mov		eax, 0

.loop:
	test	rdi, rdi
	je		.done
	mov		rdi, [rdi + t_list.next]
	inc		eax
	jmp		.loop

.done:
	ret
