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
    hola.exehol
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

## Comentarios
```asm
; Esto es un comentario
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



