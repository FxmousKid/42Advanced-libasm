; x86_64, System V ABI, PIE
; int	ft_atoi_base(char *str, char *base)

; Registers mapping
; %rdi = char *str
; %rsi = char *base

; Personal mapping
; %r12 = char *str
; %r13 = char *base
	
default		rel
global		ft_atoi_base
extern		check_base


section .data
	bad_args_msg db "bad args", 10
	len_bad_args_msg equ $ - bad_args_msg

section .text

ft_atoi_base:
	push	r12
	push	r13
	push	r14

	xor		rax, rax
	mov		r12, rdi
	mov		r13, rsi
	xor		r14, r14

	jmp		.args_test


.args_test:
	call	check_base
	cmp		rax, 0
	jl		.bad_args
	jmp		.loop

.bad_args:

	mov		rax, 1
	mov		rdi, 1
	lea		rsi, [bad_args_msg]
	mov		rdx, len_bad_args_msg
	syscall

	mov		rax, -1
	jmp		.pop_ret


.loop:

.pop_ret:
	pop		r12
	pop		r13
	pop		r14
	ret

