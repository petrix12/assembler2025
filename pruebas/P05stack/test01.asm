.model small
.stack
.data
    ; Declaración e inicialización de variables
    ; Nota: La inserción de 10d y 13d corresponde a un salto de línea y un retorno de carro, respectivamente
    msgWelcome db 'Bienvenido$'
    msgChar1 db 10, 13, 'Ingrese el primer caracter: $'
    msgChar2 db 10, 13, 'Ingrese el segundo caracter: $'
    msgResultados db 10, 13, 'Los datos ingresados son: $'
    msgFin db 10, 13, '* * * Fin del programa * * *$'
    strSeparador db ' y $'
.code
    main PROC
        ; Importamos variables
        mov dx, @data   ; Guardamos el puntero de data en DX
        mov ds, dx      ; Recuperamos data en DS
        xor dx, dx      ; Limpiamos DX

        ; Despliegue de un mensaje de bienvenida:
        mov dx, offset msgWelcome       ; Almacenamos en DX la posición de memoria donde inicia el string msgWelcome
        mov ah, 9h                      ; Almacenamos en AH el valor 9h para solicitar la escritura de un string
        int 21h                         ; Interrupción que permite la escritura de un string hasta encontrar el caracter $

        ; Mostrar un mensaje para el ingreso del primer caracter:
        mov dx, offset msgChar1         ; Almacenamos en DX la posición de memoria donde inicia el string msgChar1
        mov ah, 9h                      ; Almacenamos en AH el valor 9h para solicitar la escritura de un string
        int 21h                         ; Interrupción que permite la escritura de un string hasta encontrar el caracter $

        ; Leer el primer caracter
        mov ah, 1h                      ; Almacenamos en AH el valor 1h para solicitar el ingreso de un caracter
        int 21h                         ; Interrupción que permite la lectura de un caracter y lo almacena en AL
        push ax                         ; Enviamos el valor del registro AX (que contiene el primer caracter) al stack

        ; Mostrar un mensaje para el ingreso del segundo caracter:
        mov dx, offset msgChar2         ; Almacenamos en DX la posición de memoria donde inicia el string msgChar2
        mov ah, 9h                      ; Almacenamos en AH el valor 9h para solicitar la escritura de un string
        int 21h                         ; Interrupción que permite la escritura de un string hasta encontrar el caracter $
        
        ; Leer el segundo caracter
        mov ah, 1h                      ; Almacenamos en AH el valor 1h para solicitar el ingreso de un caracter
        int 21h                         ; Interrupción que permite la lectura de un caracter y lo almacena en AL
        push ax                         ; Enviamos el valor del registro AX (que contiene el segundo caracter) al stack

        ; Reposicionar los elementos del stack para luego recuperarlos en orden
        pop dx                          ; Recuperamos el segundo caracter en DX
        pop ax                          ; Recuperamos el primer caracter en AX
        push dx                         ; Enviamos el segundo caracter al stack
        push ax                         ; Enviamos el primer caracter al stack
        
        ; Mostrar los dos caracteres ingresados en el orden en que fueron introducidos:
        mov dx, offset msgResultados    ; Almacenamos en DX la posición de memoria donde inicia el string msgResultados
        mov ah, 9h                      ; Almacenamos en AH el valor 9h para solicitar la escritura de un string   
        int 21h                         ; Interrupción que permite la escritura de un string hasta encontrar el caracter $
        
        ; Imprimir el primer caracter leído
        pop ax                          ; Recuperamos AX del stack, que contendrá el primer caracter leído
        mov ah, 2h                      ; Almacenamos en AH el valor 2h para solicitar la escritura de un caracter
        mov dl, al                      ; Indicamos a DL el caracter a imprimir
        int 21h                         ; Interrupción que permite la escritura de un caracter   

        ; Separador entre el primer y segundo caracter leído
        mov dx, offset strSeparador
        mov ah, 9h
        int 21h

        ; Imprimir el segundo caracter leído
        pop ax                          ; Recuperamos AX del stack, que contendrá el segundo caracter leído
        mov ah, 2h                      ; Almacenamos en AH el valor 2h para solicitar la escritura de un caracter
        mov dl, al                      ; Indicamos a DL el caracter a imprimir
        int 21h                         ; Interrupción que permite la escritura de un caracter

        ; Imprimir un mensaje de finalización del programa
        mov dx, offset msgFin           ; Almacenamos en DX la posición de memoria donde inicia el string msgFin
        mov ah, 9h                      ; Almacenamos en AH el valor 9h para solicitar la escritura de un string   
        int 21h                         ; Interrupción que permite la escritura de un string hasta encontrar el caracter $

        .exit
    main ENDP
end main
