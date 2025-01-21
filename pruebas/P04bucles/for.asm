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
        ;--------FOR en lenguaje de alto nivel
        ;   for n in range(0, 6) {
        ;       print('a')
        ;   }
        ; Salida esperada: aaaaa (5 veces a)

        ;--------FOR en Assembler (existen muchas otras formas de simular un FOR)        
        xor si, si  ; limpiar las variable de indice
        CFOR: 
            cmp si, 5d      ; verificar que si sea igual a 5d
            je SALIRFOR     ; si es igual a 5d ir a SALIRFOR
            printChar 'a'   ; imprimir a
            inc si          ; incrementar si
            jmp CFOR        ; ir a CFOR
        SALIRFOR:
        .exit
    main ENDP
end main