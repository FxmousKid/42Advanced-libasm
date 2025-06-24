; x86_64, System V ABI, PIE
; void	ft_list_push_front(t_list **begin_list, void *data)

; Registers mapping
; %rdi = t_list **begin_list
; %rsi = void	*data

; permanent mapping
; %r12 = t_list **begin_list
; %r13 = void	*data
; %r14 = tmp

STRUC t_list
	.data	resq 1
	.next	resq 1
ENDSTRUC

default		rel
global		ft_list_push_front
extern		__errno_location
extern		calloc

section .data:
	msg db "Critical error occured"
	len equ $ - msg

section .text

ft_list_push_front:
	push	r12
	push	r13 
	push	r14
	mov		r12, rdi
	mov		r13, rsi

		
.create_node:
	mov		rdi, 1
	mov		rsi, t_list_size
	call	calloc wrt ..plt
	test	rax, rax
	je		.failure

	; adding push in front logic
	mov		[rax + t_list.data], r13
	mov		r14, [r12]
	mov		[rax + t_list.next], r14
	test	r12, r12
	je		.null_begin
	mov		[r12], rax
	jmp		.done

.null_begin:
	lea		r12, [rax]

.done:
	mov		rax, 0
	jmp		.pop_ret

.failure:
	mov		rdx, rax
	neg		edx
	call	__errno_location wrt ..plt
	mov		[rax], edx
	
	mov		rax, 1
	mov		rdi, 1
	lea		rsi, [msg]
	mov		rcx, len
	mov		rax, -1
	jmp		.pop_ret

.pop_ret:
	pop		r12
	pop		r13
	pop		r14
	ret

