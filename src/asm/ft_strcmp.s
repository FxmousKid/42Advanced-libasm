; X86_64, System V ABI, PIE
; int strcmp(const char *s1, const char *s2)

default rel
global ft_strcmp

section .text
ft_strcmp:
	xor		rax, rax ; rax = 0

.loop:
	mov		al, [rdi + rax]
	cmp		al, [rsi + rax] ; s1[idx] vs s2[idx]
	jg		.bigger
	jl		.smaller
	cmp		al, 0
	je		.same
	inc		rax
	jmp		.loop
	

.bigger:
	mov		rax, [rdi + rax]; - [rsi + rax]
	ret

.smaller:
	mov		rax, [rsi + rax]
	neg		rax
	ret

.same:
	mov		rax, 0
	ret
