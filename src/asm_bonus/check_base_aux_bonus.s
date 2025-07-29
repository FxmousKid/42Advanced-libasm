; x86_64; System V ABI; PIE
; int	check_base(char *base)

; Registers mapping
; %rdi = char *base

; Personal mapping
; %r11 = char *base
; %r12 = strlen(base)

default		rel
global		check_base
extern		ft_strlen

section .text

check_base:
	push	r11
	push	r12
	push	r13
	push	r14

	cmp		byte [rdi], 0
	je		.bad_base
	cmp		byte [rdi + 1], 0
	je		.bad_base

	mov		r11, rdi
	call	ft_strlen
	mov		r12, rax
	xor		rsi, rsi
	xor		rcx, rcx

.loop:
	cmp		[rdi + rsi], 0
	jne		
	incr	rsi

.snd_loop:

	

.bad_base:
	mov		rax, -1
	jmp		.pop_ret

.pop_ret:
	pop		r11
	pop		r12
	pop		r13
	pop		r14
	ret
