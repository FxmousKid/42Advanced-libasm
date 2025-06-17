; x86_64, System V ABI, PIE
; char *ft_strcpy(char *dst, const char *src)

default		rel
global		ft_strcpy

section .text
ft_strcpy:
	xor		rcx, rcx ; rcx = 0
	mov		rbx, rdi ; saving dest
	
.loop:
	mov		al, [rsi]
	cmp		al, 0 ; src[idx] == '\0'
	je		.done
	mov		[rdi], al
	inc		rdi
	inc		rsi
	jmp		.loop

.done:
	mov		byte [rdi], 0
	mov		rax, rbx
	ret
