include macro01.asm
.model small
.stack
.data
    msgWelcome db "Bienvenido", 13, 10, '$'
    msg1 db "Primer mensaje", 13, 10, '$'
    msg2 db "Segundo mensaje", 13, 10, '$'
    msg3 db "Tercer mensaje", 13, 10, '$'
    msg4 db "Cuarto mensaje", 13, 10, '$'
    msgBye db "Bye", 13, 10, '$'
.code
    ; Procedimiento principal
    main PROC
        ; Importamos variables
        mov dx, @data
        mov ds, dx
        xor dx, dx

        ; llamada al procedimiento imprimir_msg
        call imprimir_msg 

        ; llamada a la macro print desde el procedimiento main
        print msgBye

        .exit
    main ENDP

    ; Procedimientos
    imprimir_msg proc
        mov dx, offset msgWelcome
        mov ah, 9h
        int 21h  
        ; llamadas a la macro print desde el procedimiento imprimir_msg
        print msg1
        print msg2
        print msg3
        print msg4
        ret            
    imprimir_msg endp
end main