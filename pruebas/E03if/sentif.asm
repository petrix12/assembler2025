; macro para imprimir un caracter (char)
printChar macro char
    mov ah, 02h
    mov dl, char
    int 21h
endm

.model small
.stack
.data
    cond1 db 1b     ; true
    cond2 db 1b     ; true
.code
    main PROC
        ; importamos variables
        mov dx, @data   ; gurdamos el puntero de data en dx
        mov ds, dx      ; recuperamos data en ds
        xor dx, dx      ; limpiamos dx

        ;--------IF en lenguaje de alto nivel
        ;   if(cond1) {
        ;       print('a')
        ;   } else  {
        ;       print('b')
        ;   }

        ;--------IF en Assembler (existen muchas otras formas de simular un IF)
        cmp cond1, 1b   ; verificar que cond1 sea true
        je L1           ; si cond1 es true ir a L1
        jmp L2          ; ir a L2
        L1:
            printChar 'a'
            jmp L3
        L2:
            printChar 'b'
        L3:
        .exit
    main ENDP
end main