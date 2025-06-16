; X86_64, System V ABI, PIE
; int strcmp(const char *s1, const char *s2)

default rel
global ft_strcmp

section .text
ft_strcmp:
	xor		eax, eax ; eax = 0

.loop:
	mov		al, [rdi]
	mov		bl, [rsi]
	cmp		al, bl
	jne		.diff
	test	al, al ; al == 0 ?
	je		.done
	inc		rdi
	inc		rsi
	jmp		.loop

.diff:
	movzx	eax, al
	movzx	ecx, bl
	sub		eax, ecx

.done:
	ret
