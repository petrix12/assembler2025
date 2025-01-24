print macro cadena
    mov dx, offset cadena
    mov ah, 9h
    int 21h      
endm