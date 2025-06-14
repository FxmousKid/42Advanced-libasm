; X86_64, System V ABI, PIE
; size_t ft_strlen(const char *)

default rel
global ft_strlen

section .text
ft_strlen:
	xor		rax, rax ;put rax to 0

.loop:
	cmp		byte [rdi + rax], 0 ; str[idx] == '\0'
	je		.done
	inc		rax
	jmp		.loop

.done:
	ret
