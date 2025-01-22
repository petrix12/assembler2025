; macro para imprimir un caracter (char)
printChar macro char
    mov ah, 02h
    mov dl, char
    int 21h
endm

.model small
.stack
.code
    main PROC
        ;--------WHILE con BREAK en lenguaje de alto nivel
        ;   contador = 0
        ;   while(true) {
        ;       print('a')
        ;       if(contador == 4) {
        ;           break
        ;       }
        ;       contador++
        ;   }
        ; Salida esperada: aaaaa (5 veces a)

        ;--------WHILE con BREAK en Assembler (existen muchas otras formas de simular un WHILE con BREAK)
        xor si, si      ; limpiar las variable de indice        
        CWHILE: 
            printChar 'a'   ; imprimir a
            cmp si, 4d      ; verificar que si sea igual a 4d 
            je SALIRWHIlE
            inc si
            jmp CWHILE      ; ir a CWHILE
        SALIRWHILE:
        .exit
    main ENDP
end main