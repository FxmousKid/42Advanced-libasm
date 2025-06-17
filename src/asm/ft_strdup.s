; x86_64, System V ABI, PIE
; char *ft_strdup(const char *s)

default		rel
global		ft_strdup

extern		__errno_location
extern		malloc
extern		ft_strcpy
extern		ft_strlen

section .text
ft_strdup:

	; no need to move *s into rdi for strlen, as it's already in there
	call	ft_strlen
	mov		rbx, rdi ; save the string to dup
	mov		rdi, rax ; tell malloc how much to alloc
	call	malloc wrt ..plt
	cmp		rax, 0
	jl		.error

	mov		rdi, rax ; dest
	mov		rsi, rbx ; src
	call	ft_strcpy
	ret

.error:
	mov		rdx, rax
	neg		rdx

	call	__errno_location wrt ..plt
	mov		[rax], edx
	mov		rax, -1
