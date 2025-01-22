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
        ;--------WHILE con BREAK y CONTINUE en lenguaje de alto nivel
        ;   contador = 0
        ;   while(true) {
        ;       contador++
        ;       if(contador == 2) {
        ;           print('c')
        ;           continue
        ;       }
        ;       print('a')
        ;       if(contador == 4) {
        ;           break
        ;       }
        ;   }
        ; Salida esperada: acaa

        ;--------WHILE con BREAK y CONTINUE en Assembler (existen muchas otras formas de simular un WHILE con BREAK y CONTINUE)
        xor si, si      ; limpiar las variable de indice        
        CWHILE: 
            inc si
            cmp si, 2d      ; verificar que si sea igual a 2d 
            je SIES2        ; 
            jmp NOES2
            SIES2:
                printChar 'b'   ; imprimir b
                jmp CWHILE
            NOES2:
                printChar 'a'   ; imprimir a
                cmp si, 4d      ; verificar que si sea igual a 4d 
                je SALIRWHIlE                
                jmp CWHILE      ; ir a CWHILE
        SALIRWHILE:
        .exit
    main ENDP
end main