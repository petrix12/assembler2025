# Assembler

## Documentación
+ https://helppc.netcore2k.net/topics
+ https://sistel.xp3.biz

## Programas requeridos o recomendados
1. Emu8086
    + https://emu8086.waxoo.com/descargar
2. DOSBox
    + https://www.DOSBox.com/download.php?main=1
3. MASM
    + https://sourceforge.net/projects/masm611
4. Visual Studio Code
    + https://code.visualstudio.com/download

:::tip Nota
+ Instalar **Emu8086** y **DOSBox** como administrador.
+ Descomprimir **MASM** en el dico local **C**.
+ Abrir **DOSBox** y ejecutar los siguiente comandos:
    ```bash
    mount C: C:\masm611
    c:
    disk1\setup.exe    
    ```
    + Presionar **ENTER**.
    + Seleccionar **Inatall the Microsoft Macro Assembler**.
    + Seleccionar **MS-DOS/Microsoft Windows**.
    + Seleccionar **Yes** en todos los casos siguientes.
    + En **Please select the destination drive** seleccionar **Hard Drive C**.
    + Aceptar todas las opciones por defecto en las siguientes ventanas.
    + En la ventana de **Installing MASM 6.11...** se puede presionar **Ctrl + F12** para aumentar la velocidad de instalación.
    + Una vez terminada la instalación, presionar **ENTER** hasta llegar a una ventana que nos permita salir de la instalación (**Exit SETUP**).
    + La culminación de la instalación creará la siguiente carpeta: **C:\masm611\MASM611**.
+ Una vez culminado el paso anterior crear la siguiente carpeta **C:\MASM** y dentro de ella cortar y pegar la siguiente carpeta **C:\masm611\MASM611**.
+ Crear la siguiente ruta para guardar todos nuestros proyectos:
    + C:\MASM\MASM611\BIN\asm
:::

## Extensiones de VSC recomendadas
+ MASM | blindtiger | Microsoft Macro Assembler language support for VS Code
+ MASM/TASM | clcxsrolau | run MASM/TASM assembly in DOSBox 
+ Arm Assembly | dan-c-underwood | Arm assembly syntax support for Visual Studio Code

## Hola Mundo
1. Crear el siguiente archivo:
    ```asm title="C:\MASM\MASM611\BIN\asm\E01test\Hola.asm"
    .model small
    .stack 
    .data 
        msg db 'Hello World $'  ; nombre de la variable: msg | tipo: db | valor: Hello World | Simbolo de finalización: $
    ; segemento de codigo    
    .code
        ; procedimiento principal main
        main PROC
            ; carga en memoria las variables del segmento de datos al segmento de código
            MOV ax, @data
            MOV ds, ax  ; registros
            xor ax,ax

            ; nemonicos MOV, INT

            ; impresión por pantalla
            mov dx, offset msg
            mov ah, 9
            int 21h     ; interrupciones

            ; terminar programa
            .exit
        main ENDP
    end main
    ```
2. Abrir **DOSBox** y ejecutar el siguiente código:
    ```bash
    mount c: c:\masm
    c:
    cd masm611
    cd bin
    ml asm\E01test\Hola.asm
    hola.exe
    ```

## Hacer que DOSBox ejecute comando automaticamente
1. Ir a la carpeta en donde esta ubicado **DOSBox**:
    + C:\Program Files (x86)\DOSBox-0.74-3
2. Editar **DOSBox 0.74-3 Options.bat** y agregar al final del archivo el siguiente código:
    ```bat
    mount c: c:\masm
    c:
    cd masm611
    cd bin    
    ```
:::tip Nota
Ahora para ejecutar el programa hola.asm será de la siguiente forma al abrir **DOSBox**:
```bash
ml asm\E01test\Hola.asm
hola.exe
```
:::


## Comentarios
```asm
; Esto es un comentario
```

## Estructura base de un programa
```asm
.model small
.stack
.code
    main PROC
        ; código el programa
        .exit
    mein ENDP
end main
```


## Etructura de un programa en MASM
### Importación de macros
+ Sintaxis:
    ```asm
    include mimacro.asm
    ```

### Declaración del programa
+ Sintaxis:
    ```asm
    .model mimodelo
    ```
    :::tip Nota
    El modelo (mimodelo) puede ser:
    + Tiny: Los datos y el código juntos ocupan menos de 64KB.
    + Small: Los datos y el código están en segmentos individuales de 64KB.
    + Medium: Los datos entran a un segmento de 64KB, pero el código puede ser mayor de 64KB.
    + Large: Tanto el código como los datos pueden ocupar más de 64KB.
    :::

### Segmento de pila
+ Sintaxis:
    ```asm
    .stack tamano
    ```
    + **tamano**: es un número que indica el tamaño de la pila.
    + **Tamaño por defecto**: 1024.

### Segmento de datos
+ Sintaxis:
    ```asm
    .data
    ;--- Todas las declaraciones ----------------
    ;var 1
    ;var 2
    ;var 3
    ;var N
    ;--- Termina hasta segmento de código -------
    ```

### Segmento de código
+ Sintaxis:
    ```asm
    .code
    ;--- Código

    ;--- Todas las declaraciones

    ;--- Declaración del main
    ;--- Instrucciones del main
    ;--- Termina el main

    ;--- Declaración de otro método
    ;--- Instrucciones del otro método
    ;--- Termina el otro método

    ;--- Más código
    end main
    ```

### Ejemplo
```asm
; Importación de macros
include macro1.asm
include macro2.asm

; Declaración del programa
.model small

; Segmento de pila (1024) por defecto
.stack

; Segmento de datos
.data
;--- Taodas las declaraciones ---------------
;var 1
;var 2
;var 3
;var N
;--- Termina hasta segmento de código -------

; Segmento de código
.code
    main PROC
        ; Instrucción 1
        ; Instrucción 2

        Etiqueta1:
        ; Instrucción 3
        ; Instrucción 4
        ; Instrucción 5
        ; Instrucción 6

        Etiqueta2:
        ; Instrucción 7
        ; Instrucción 8
        ; Instrucción 9
    main ENDP
end main
```

## Registros
### Tipos de registros
+ Multipropositos
+ Proposito general

### División de registros
EAX: 32 bits
AX: 16 bits
AH: 8 bits
AL: 8 bits
```
| EAX                       |
                   | AL     |
          | AH     |
          | AX              |
| 16 bits | 8 bits | 8 bits |
```

### Registros en assembler
```
          |     16 bits     | 8 bits | 8 bits |
Registros |                 | Subregistros    | Descripción
----------|-----------------|-----------------|----------------------------
EAX       |                 |  AH   AX   AL   | Acumulador (✓)
EBX       |                 |  BH   BX   BL   | Índice base  (✓)
ECX       |                 |  CH   CX   CL   | Conteo  (✓)
EDX       |                 |  DH   DX   DL   | Datos  (✓)
ESP       |                 |       SP        | Apuntador de la pila
EDI       |                 |       DI        | Apuntador de la base
ESI       |                 |       SI        | Índice de deestino  (✓)
EBP       |                 |       BP        | Índice de origen  (✓)
    
EIP       |                 |       IP        | Apuntador de instrucciones
EFLAGS    |                 |     EFLAGS      | Banderas  (✓)

                            |    Segmentos    | Descripción
                            |-----------------|----------------------------
                            |       CS        | Código
                            |       DS        | Datos
                            |       ES        | Extra
                            |       SS        | Pila
                            |       FS        |
                            |       GS        |
```

### Registros multipropósito
+ **EAX (acumulador)**: se utiliza para instrucciones tales como multiplicación, divisón y algunas de las instrucciones de ajuste.
+ **EBX (conteo)**: guarda la dirección de desplazamiento de una posición en el sistema de memoria.
+ **ECX (índice base)**: guarda la dirección de desplazamiento de datos de la memoria, y para varias instrucciones como LOOP, REP, REPE y Shift.
+ **EDX (datos)**: gaurda una parte del resultado de una muliplicación, o parte del dividendo antes de una división.
+ **EDI (índice de destino)**: direcciona datos de destino de cadena para las instrucciones de cadenas.
+ **ESI (índice de origen)**: direcciona datos de cadena de origen para las instrucciones de cadenas.

### Registros de propósito especial:
+ **EFLAGS (banderas)**: registro que guarda en cada bit un 1 o 0 para indicar si cumple o no algún estado.

## Instrucciones y operadores
### Operadores principales
#### Operador MOV
```asm
MOV var1, var2
```
+ Lo que hace el operador **MOV** es asignarle a var1 el valor de var2.
#### Aritméticos
+ Suma: ADD
    ```asm
    ; Operación: 1000 + 999 = 1999
    mov ax, 1000d
    mov bx, 999d
    add ax, bx  ; suma ax mas bx y lo guarda en ax
    ```
+ Resta: SUB
    ```asm
    ; Operación: 300 - 255 = 45
    mov ax, 300d
    mov bx, 255d
    sub ax, bx  ; resta ax menos bx y lo guarda en ax
    ```
+ Multiplicación: MUL
    ```asm
    ; Operación: 11 * 255 = 2805
    mov ax, 255d
    mov bx, 11d
    mul bx  ; multiplica ax por bx y lo guarda en ax
    ```
+ División: DIV
    ```asm
    ; Operación: 1000 / 100 = 10
    mov ax, 1000d   ; el numerador debe ir aquí
    mov bx, 100d    ; el denominador debe ir aquí
    div bx  ; divide ax entre bx y lo guarda en ax
    ```

#### Lógicos
+ Y: AND
    ```asm
    ; Operación: 214 and 91
    ; 11010110b es 214 en binario
    ; 01011011b es 91 en binario
    ; 11010110b (214d) and 01011011b (91d) = 01010010b (82d)
    mov ax, 11010110b   ; 214 en binario
    and ax, 01011011b   ; en ax se guarda el resulta de aplicar el and bit a bit

    ; el and también se podría trabajar con dos registros
    mov ax, 11010110b
    mov bx, 01011011b
    and ax, bx
    ```
+ O: OR
    ```asm
    ; Operación: 214 or 91
    ; 11010110b es 214 en binario
    ; 01011011b es 91 en binario
    ; 11010110b (214d) or 01011011b (91d) = 11011111b (223d)
    
    mov ax, 11010110b   ; 214 en binario
    or ax, 01011011b    ; en ax se guarda el resulta de aplicar el or bit a bit

    ; el and también se podría trabajar con dos registros
    mov ax, 11010110b
    mov bx, 01011011b
    or ax, bx
    ```
+ Negación: NOT
    ```asm
    ; Operación: not 214
    ; 11010110b es 214 en binario
    ; not 11010110b (214d) = 00101001b (41d)
    mov ax, 11010110b   ; 214 en binario
    not al              ; en ax se guarda la negación de 214 en binario
    ; si el número hubiese sido mayor a 255 en lugar de al hubiesemos usado ax
    ```
+ O exclusivo: XOR
    ```asm
    ; Operación: 214 or 91
    ; 11010110b es 214 en binario
    ; 01011011b es 91 en binario
    ; 11010110b (214d) xor 01011011b (91d) = 10001101b (141d)
    mov ax, 11010110b   ; 214 en binario
    xor ax, 01011011b    ; en ax se guarda el resulta de aplicar el xor bit a bit

    ; el and también se podría trabajar con dos registros
    mov ax, 11010110b
    mov bx, 01011011b
    xor ax, bx
    ```

#### Relacionales
+ Condiciones y saltos.

## Variables
### Tipos de datos
+ **db**: data byte | 8 bits | AL, AH, BL, BH, CL, CH, DL, DH
+ **dw**: data word | 16 bits | AX, BX, CX, DX, DI, SI
+ **dd**: data double | 32 bits | EAX, EBX, ECX, EDX, EDI, ESI

### Ejemplo de creación de variables
```asm
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
```

## Condiciones y saltos
### Diagrama mental para condicionales
```
Alto Nivel | Visión en Assembler | Menejo en Assembler
-----------|---------------------|---------------------
1. A >  B  | A - B = X           | 1. Positivo
2. A <  B  | X puede ser:        | 2. Negativo
3. A == B  | 1. Cero             | 3. Cero
4. A != B  | 2. Positivo         | 4. No sea cero
5. A >= B  | 3. Negativo         | 5. Cero o positivo
6. A <= B  |                     | 6. Cero o negativo
```

### Nemónicos para comparaciones
```
Assembler | Banderas       | Operación                              | Signo      | Comparación
----------|----------------|----------------------------------------|------------|-------------
JA        | Z = 0 y C = 0  | Salta se está por encima               | Sin signo  | >
JAE       | C = 0          | Salta si está por encima o si es igual | Sin signo  | >=
JB        | C = 1          | Salta se está por debajo               | Sin signo  | <
JBE       | Z = 0 y C = 1  | Salta se está por debajo o si es igual | Sin signo  | <=
JC        | C = 1          | Salta si hay acarreo                   |            |
JE o JZ   | Z = 1          | Salta si es igual o si es cero         | No importa | =
JG        | Z = 0 y S = 0  | Salta si es mayor que                  | Con signo  | >
JGE       | S = 0          | Salta si es mayor o igual que          | Con signo  | >=
JL        | S != 0         | Salta si es menor que                  | Con signo  | <
JLE       | Z = 1 o S != 0 | Salta si es menor o igual que          | Con signo  | <=
JNC       | C = 0          | Salta si no hay acarreo                |            |
JNE o JNZ | Z = 0          | Salta si no es igual o si no es cero   | No importa | =
JNO       | O = 0          | Salta si no hay desbordamiento         |            |
JNS       | S = 0          | Salta si no hay signo (positivo)       |            |
JNP o JPO | P = 0          | Salta si no hay paridad o si es impar  |            |
```

### Nemónico para saltos
+ JMP
    ```asm
    jmp X ; ir a la etiqueta X
    ```
+ Ejemplo
    ```asm
    ; ...
    cmp a, b    ; a - b
    je L1       ; Si je es cero ir a L1
    jmp L2      ; Salto a L2

    L1:
        print("Entro if")
    
    L2:
        print("Fin del programa")
    ; ...
    ```

## Sentecias cíclicas y de control
### Sentencia de control IF
```asm
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
```

### Sentencia de control IF con un OR en la condición
```asm
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

        ;--------IF OR en lenguaje de alto nivel
        ;   if(cond1 or cond2) {
        ;       print('a')
        ;   } else  {
        ;       print('b')
        ;   }

        ;--------IF OR en Assembler (existen muchas otras formas de simular un IF OR)
        cmp cond1, 1b   ; verificar que cond1 sea true
        je L1           ; si cond1 es true ir a L1
        cmp cond2, 1b   ; verificar que cond1 sea true
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
```

### Sentencia de control IF con un AND en la condición
```asm
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
        jne L2          ; si cond1 es false ir a L2
        cmp cond2, 1b   ; verificar que cond1 sea true
        jne L2          ; si cond1 es false ir a L2
        jmp L1          ; ir a L1
        L1:
            printChar 'a'
            jmp L3
        L2:
            printChar 'b'
        L3:
        .exit
    main ENDP
end main
```
+ Otra forma del código anterior ligeramente distinta
```asm
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
```

### Sentencia ciclica FOR
```asm
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
        ;   for 0 to 5 {
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
```

### Sentencia ciclica WHILE
```asm
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
```

### Sentencia ciclica WHILE con BREAK
```asm
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
```

### Sentencia ciclica WHILE con BREAK y CONTINUE
```asm
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
```

## Interrupciones
### Documentación
+ https://helppc.netcore2k.net/interrupt

### Tipos de interrupciones
+ Generadas por hardware
+ Generadas por software

### Tipos de interrupciones por software
+ INT
+ INTO
+ INT 3

:::tip Nota
Las interrupciones son similares a las instrucciones CALL.
:::

#### Interrupciones INT
+ Existen 256 instrucciones distintas.
+ Cada instrucción INT tiene un operando numérico cuyo rango es de 0 a 255.

#### Ejemplos sencillos de algunas interrupciones:
+ Imprimir un char**:
    + INT 21h:  (21h indica que la interrupción puede imprimir un caracter).
    + AH = 2H   (Se requiere que AH tenga el número 2 en hexadecimal).
    + DL debe almacenar el valor ASCII a imprimir.
+ Pedir ingreso de char**:
    + INT 21h:  (21h indica que la interrupción puede leer un caracter).
    + AH = 1H   (Se requiere que AH tenga el número 1 en hexadecimal).
    + El char ingresado se guarda en AL.

:::tip Nota
Para imprimir o leer cadenas de caracteres será necesario apoyarse en sentencias ciclicas.
:::

#### Algunos operadores importantes
+ **SIZEOF**: devuelve el núemro de bytes utilizados.
+ **OFFSET**: devuelve el desplazamiento de una ubicación de momoria. En otras palabras devuelve la ubicación donde inicia una expresión.

#### Algunos ejemplos de código
1. Realizar en Assembler una programa que permita el ingreso deun char e imprimirlo:
    ```asm
    .model small
    .stack
    .data
        char db ?   ; ? indica que no hemos inicializado a char
    .code
        main PROC
            ; importamos variables
            mov dx, @data   ; gurdamos el puntero de data en dx
            mov ds, dx      ; recuperamos data en ds
            xor dx, dx      ; limpiamos dx

            ; leer un char 
            mov ah, 1h  ; almacenamos en AH en valor de 1h para poder pedir el ingreso de un char
            int 21h     ; interrupción que permite la lectura de un char y lo almacena en AL
            mov char, al    ; almacenamos el char contenido en AL a la varaible char

            ; imprimir un ENTER
            mov ah, 2h
            mov dl, 10d
            int 21h

            ; imprimir el char leido
            mov ah, 2h      ; almacenamos en AH en valor de 2h para poder pedir la escritura de un char
            mov dl, char    ; le indicamos a DL el char a imprimir
            int 21h         ; interrupción que permite la escritura de un char

            .exit
        main ENDP
    end main
    ```
2. Ampliar el ejercicio anterior para que permita el ingreso de un texto de n chars e imprimirlo:
    ```asm
    .model small
    .stack
    .data
        string db ?     ; ? indica que no se ha inicializado la variable
    .code
        main PROC
            ; importamos variables
            mov dx, @data   ; gurdamos el puntero de data en dx
            mov ds, dx      ; recuperamos data en ds
            xor dx, dx      ; limpiamos dx

            ; leer un string
            xor si, si  ; inicializar contador SI a cero
            BeginReadString:
                mov ah, 1h          ; almacenamos en AH en valor de 1h para poder pedir el ingreso de un char
                int 21h             ; interrupción que permite la lectura de un char y lo almacena en AL

                cmp al, 13d         ; verificar si al es un retorno de carro
                je EndReadString    ; salir de la lectura del string

                mov string[si], al  ; almacenamos el char contenido de AL en la posición si de string
                inc si
                jmp BeginReadString
            EndReadString:
            ; ya en este punto, el registro 'SI' tendrá la longitud del string            

            ; imprimir un ENTER
            mov ah, 2h
            mov dl, 10d
            int 21h

            ; imprimir el string leido
            xor di, di  ; inicializar el otro contador DI a cero
            BeginWriteString:
                mov ah, 2h          ; almacenamos en AH en valor de 2h para poder pedir la escritura de un char
                mov dl, string[di]  ; le indicamos a DL el char a imprimir
                int 21h             ; interrupción que permite la escritura de un char

                inc di
                cmp di, si          ; verificamos si hemos llegado al final del string
                je EndWriteString

                jmp BeginWriteString
            EndWriteString:

            .exit
        main ENDP
    end main
    ```




