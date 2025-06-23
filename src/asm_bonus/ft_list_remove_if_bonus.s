; x86_64, System V ABI, PIE
; void	ft_list_remove_if(
; 	t_list **begin_list,
; 	void *data_ref,
; 	int (*cmp)(void *, void *),
; 	void (*free_fct)(void *)
; )

; ---- Register mapping ----
; %rdi = t_list **begin_list
; %rsi = void *data_ref
; %rdx = int (*cmp)(void *, void *)
; %rcx= void (*free_fct)(void *)
; 
; my own mapping
; r12 = data_ref
; r13 = cmp()
; r14 = free_fct()
; r15 = cur (t_list **)


default rel
global ft_list_remove_if
extern free

STRUC t_list
    .data   resq 1
    .next   resq 1
ENDSTRUC

section .text

ft_list_remove_if:
    ; check arguments
    test    rdi, rdi
    je      .done
    test    rdx, rdx
    je      .done

    ; save arguments
    mov     r12, rsi        ; data_ref
    mov     r13, rdx        ; cmp()
    mov     r14, rcx        ; free_fct()
    mov     r15, rdi        ; cur = begin_list (t_list**)
	push	rbx

.loop:
    mov     rbx, [r15]      ; load *cur
    test    rbx, rbx
    je      .done

    mov     rdi, [rbx + t_list.data]   ; (*cur)->data into rdi

	; first time data_ref already in %rsi, but next time it might
	; have been clobbered by call instructions
    mov     rsi, r12
    call    r13 ; cmp()
    test    eax, eax
    jne     .advance

    ; if free_fct != NULL call free_fct((*cur)->data)
    test    r14, r14
    je      .skip_free_data
    mov     rdi, [rbx + t_list.data]
    call    r14

.skip_free_data:
    ; save next node
    mov     rax, [rbx + t_list.next]
    mov     [r15], rax ; *cur = curr->next
    mov     rdi, rbx
    call    free wrt ..plt
    ; do not advance cur, since *cur was updated, we stay on same pointer
    jmp     .loop

.advance:
    lea     r15, [rbx + t_list.next]
    jmp     .loop

.done:
	pop		rbx
    ret
