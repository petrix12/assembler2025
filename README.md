# Assembler

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

### Extensiones de VSC recomendadas
+ MASM | blindtiger | Microsoft Macro Assembler language support for VS Code

## Hola Mundo
1. Crear el siguiente archivo:
    ```asm title="C:\MASM\MASM611\BIN\asm\E01test\Hola.asm"
    .model small
    .stack 

    .data 
        msg db 'Hello World $'

    ; segemento de codigo    
    .code

        ; procedimiento principal main
        main PROC

            ; carga en memoria las variables del semento de datos
            MOV ax, @data
            MOV ds, ax
            xor ax,ax  

            ; impresion por pantalla
            mov dx, offset msg
            mov ah, 9
            int 21h   
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

### Hacer que DOSBox ejecute comando automaticamente
1. Ir a la carpeta en donde esta ubicado **DOSBox**:
    + C:\Program Files (x86)\DOSBox-0.74-3
2. Editar **DOSBox 0.74-3 Options.bat** y agregar al final del archivo el siguiente código:
    ```bat
    mount c: c:\masm
    c:
    cd masm611
    cd bin    
    ```
3. mmm

