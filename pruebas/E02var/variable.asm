.model small
.stack
.data
    ; nombre | tipo | valor
    DataByte db 200d
    DataWord dw 60000d
    DataDouble dd 90000d
    
    ; Errores en definicion de variables
    ; Err1 db 256d      ; da error por exceder el limite del tipo db
    ; Err2 dw 65536d    ; da error por exceder el limite del tipo dw
    
    var1 db "!" 
    var2 dw "+!"
    var3 db "+!"        ; no da error a pesar de que var3 es de 8 bits y le estoy asignando un valor mayor
    var4 dw "+!+"       ; no da error a pesar de que var4 es de 16 bits y le estoy asignando un valor mayor
    var5 db "+", "!", "+"
    var6 dw "+", "!", "+"  
    var7 db 200d, 17d, 28d, 55d
    var8 dw 60000d, 7300d, 18d
            
.code
    main PROC
        ; Importacion a segmento
        mov ax, @data   ; muevo la direccion de memoria del segmento de datos a ax
        mov ds, ax      ; muevo ax a ds que es el registro para datos 
        xor ax, ax      ; reiniciar o vaciar ax    
        
        ; Pruebas
        ; mov ax, DataByte  ; da error porque no se puede mover una variable de 8 bits a un registro de 16 bits
        ; mov al, DataByte  ; no da error
                   
        ; Ejemplos:
        ; PRIMERA PARTE: Operaciones con variables
        ; Ejemplo 1: AL = DataByte + AL = 200d + 55d = 255d = 11111111b 
        mov al, 55d
        add al, DataByte         
        
        ; Ejemplo 2: DataWord = DataWord - CX = 60000d - 50000d = 10000d
        mov cx, 50000d   
        sub DataWord, cx   
        
        ; Ejemplo 3: EAX = DataDouble / EBX = 90000d / 10000d = 9d
        ; mov eax, DataDouble
        ; mov ebx, 10000d
        ; div ebx
        ; Esta operacion no se podra realizar ya que Emu 8086 tiene un procesador de 16 bits 
        ; y se requiere uno de 32 bits   
        
        ; Ejemplo 4: AX = DataWord / BX = 10000d / 2d = 5000d
        mov ax, DataWord
        mov bx,2d
        div bx  
        
        ; Ejemplo 4: AL = DataByte * BL = 200d * 2d = 400d
        mov al, DataByte
        mov bl, 2d
        mul bl
                 
        ; SEGUNDA PARTE: Diferencia entre registros y variables 
        ; Ejemplo 5:
        ; 1 caracter = 8 bits | 2 caracteres = 16 bits
        mov al, "+"     ; en ASCII es 43 
        ; mav al, "+!"  ; da error debido a que al solo tiene capacidad para 8 bits
        
        ; Ejemplo 6:
        mov ax, "+!"    ; en ASCII el + es 43 y el ! es 33
        ; mov ax, "+!-" ; da error debido a que ax solo tiene capacidad para 16 bits
        
        .exit
    main ENDP
end main