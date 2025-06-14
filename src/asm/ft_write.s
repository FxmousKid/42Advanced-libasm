; 64-bit, System-V ABI, PIE
; ssize_t ft_write(int fd, const void *buf, size_t count)
default rel

global ft_write
extern __errno_location

section .text

ft_write:

	mov		rax, 1 ; syscall for write
	syscall

	cmp		rax, 0
	jge		.done

	; Error path -------------------
	; rax == -ERRNO
	mov		rdx, rax
	neg		edx

	call	__errno_location wrt ..plt
	mov		[rax], edx
	mov		rax, -1

.done:
	ret
