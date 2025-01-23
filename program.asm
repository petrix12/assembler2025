section .data
    msg db "Hola, mundo!", 0

section .text
    global main

main:
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, msg        ; pointer to message
    mov rdx, 12         ; length of message
    syscall

    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; return code 0
    syscall
