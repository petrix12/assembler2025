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

        ;--------IF AND en lenguaje de alto nivel
        ;   if(cond1 and cond2) {
        ;       print('a')
        ;   } else  {
        ;       print('b')
        ;   }

        ;--------IF AND en Assembler (existen muchas otras formas de simular un IF AND)
        cmp cond1, 1b   ; verificar que cond1 sea true
        jne L1          ; si cond1 es false ir a L1
        cmp cond2, 1b   ; verificar que cond1 sea true
        jne L1          ; si cond1 es false ir a L1        
        printChar 'a'
        jmp L2
        L1:
            printChar 'b'
        L2:
        .exit
    main ENDP
end main