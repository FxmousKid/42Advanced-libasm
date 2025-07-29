; x86_64, System V ABI, PIE
; void	ft_list_sort(t_list **head, int(*cmp)())

default		rel
global		ft_list_sort

; the t_list struct
STRUC t_list
	.data	resq 1
	.next	resq 1
ENDSTRUC


section .text
global ft_list_sort

ft_list_sort:
	mov		rcx, [rdi] ; curr_head
	mov		r9, rdi ; save rdi for when calling cmp
	xor		rdx, rdx
	xor		r8, r8

.outer_loop:
	test	rcx, rcx ; head == NULL
	je		.finish
	mov		r8, rcx
	mov		rcx, [rcx + t_list.next]
	jmp		.inner_loop


.inner_loop:

	mov		rax, [r8 + t_list]
	je		.outer_loop

	jmp		.inner_loop
	


.finish:
	mov		[r9], rdx
	ret


; ----- Register mapping
; rdi = &head
; rsi = int (*cmp)()
; rcx = curr_head
; rdx = sorted
; r8  = node_to_insert 
; r9  = og_head
