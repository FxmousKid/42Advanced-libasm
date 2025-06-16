; x86_64, System V ABI, PIE
; ssize_t read(int fd, void *buf, size_t count)

default		rel
global		ft_read
extern		__errno_location

section .text
ft_read:
	
	mov		eax, 0 ; syscall for read
	syscall

	cmp		rax, 0
	jge		.done

	; Error path -------
	; rax == -ERRNO
	mov		rdx, rax
	neg		rdx

	call	__errno_location wrt ..plt
	mov		[rax], edx
	mov		rax, -1

.done:
	ret
