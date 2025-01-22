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
.code
    main PROC
        ; importamos variables
        mov dx, @data   ; gurdamos el puntero de data en dx
        mov ds, dx      ; recuperamos data en ds
        xor dx, dx      ; limpiamos dx

        ;--------WHILE en lenguaje de alto nivel
        ;   cond1 = true
        ;   contador = 0
        ;   while(cond1) {
        ;       print('a')
        ;       if(contador == 4) {
        ;           cond1 = false
        ;       }
        ;       contador++
        ;   }
        ; Salida esperada: aaaaa (5 veces a)

        ;--------WHILE en Assembler (existen muchas otras formas de simular un WHILE)
        ; mov cond1, 1b ; se podría inicializar cond1 en true, pero ya se hizo al declarar la variable en .data
        xor si, si      ; limpiar las variable de indice        
        CWHILE: 
            cmp cond1, 1b   ; verificar que cond1 sea true
            jne SALIRWHILE  ; si cond1 es false ir a SALIRWHILE
            printChar 'a'   ; imprimir a
            cmp si, 4d      ; verificar que si sea igual a 4d 
            je SIES5
            jmp NOES5
            SIES5:
                mov cond1, 0b
            NOES5:
                inc si
                jmp CWHILE      ; ir a CWHILE
        SALIRWHILE:
        .exit
    main ENDP
end main