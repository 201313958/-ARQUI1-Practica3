print macro cadena ;imprimir cadenas
    mov ah,09h ;Numero de funcion para imprimir cadena en pantalla
	mov dx, @data ;con esto le decimos que nuestro dato se encuentra en la sección data
	mov ds,dx ;el ds debe apuntar al segmento donde se encuentra la cadena (osea el dx, que apunta  a data)
	mov dx,offset cadena ;especificamos el largo de la cadena, con la instrucción offset
	int 21h  ;ejecutamos la interrupción
endm

close macro  ;cerrar el programa
    mov ah, 4ch ;Numero de función que finaliza el programa
    xor al,al ;limpiar al 
    int 21h
endm

getChar macro ;obtener caracter
    mov ah,01h ;se guarda en al en código hexadecimal del caracter leído 
    int 21h
endm

ObtenerTexto macro cadena ;macro para recibir una cadena, varios caracteres 

LOCAL ObtenerChar, endTexto 
;si, cx, di  registros que usualmente se usan como contadores 
    xor si,si  ; => mov si, 0  reinica el contador

    ObtenerChar:
        getChar  ;llamamos al método de obtener caracter 
        cmp al, 0dh ; como se guarda en al, comparo si al es igual a salto de línea, ascii de salto de linea en hexadecimal o 10en ascii
        je endTexto ;si es igual que el salto de línea, nos vamos a la etiqueta endTexto, donde agregamos el $ de dolar a la entrada 
        mov cadena[si],al ; mov destino, fuente.  Vamos copiando el ascii del caracter que se guardó en al, al vector cadena en la posicion del contador si
        inc si ; => si = si+1
        jmp ObtenerChar

    endTexto:
        mov al, 36 ;ascii del signo $ o en hexadecimal 24h
        mov cadena[si],al  ;copiamos el $ a la cadena
endm

EsNegativo macro cadena, numero, signo, temp
Local Negativo, Positivo, fin
    xor al, al
    mov al, cadena[0]
    cmp al, 45
        je Negativo  
    jmp Positivo

    Negativo:
        mov signo,-1
        AsciiNeg_To_Num cadena, numero, temp
        jmp fin
    Positivo:
        mov signo,1
        AsciiPos_To_Num cadena, numero, temp
        jmp fin
    fin:

endm

AsciiNeg_To_Num macro cadena, numero, temp
mov al, cadena[1];Obtenemos el primer numero numero en ascii de la cadena
sub al, 30h;Le restamos 0 para obtener su numero digital
mov bl, 10;guardamos el valor de 10 en bl
mul bl;Lo multiplicamos por 10 por se decenas
mov temp[0],al; por ultimo guardamos las decenas en temp[0]

mov al, cadena[2];obtenemos el segundo numero en ascii de la cadena
sub al, 30h; le restamos 0 para obtener su numero digital
mov bl, temp[0]; movemos las decenas a bl
add al, bl; y sumamos las decenas con las unidades
mov numero,al;por ultimo movemos el valor del numero a numero
;mov al,36;Estas dos lineas son para
;mov numero[1],al; imprimir el numero sin basura(DEBUG)
endm

AsciiPos_To_Num macro cadena, numero, temp
mov al, cadena[0];Obtenemos el primer numero numero en ascii de la cadena
sub al, 30h;Le restamos 0 para obtener su numero digital
mov bl, 10;guardamos el valor de 10 en bl
mul bl;Lo multiplicamos por 10 por se decenas
mov temp[0],al; por ultimo guardamos las decenas en temp[0]

mov al, cadena[1];obtenemos el segundo numero en ascii de la cadena
sub al, 30h; le restamos 0 para obtener su numero digital
mov bl, temp[0]; movemos las decenas a bl
add al, bl; y sumamos las decenas con las unidades
mov numero,al;por ultimo movemos el valor del numero a numero
;mov al,36;Estas dos lineas son para
;mov numero[1],al; imprimir el numero sin basura(DEBUG)
endm

NumToAscii macro temp
    mov al, temp      
    aam                
    add ax, 3030h 
    push ax     
    mov dl, ah         
    mov ah, 02h        
    int 21h
    pop dx             
    mov ah, 02h        
    int 21h
endm

OpFactorial macro resultado, numero, cadena
    LOCAL Zero, Normal, fin
        print cadena
        mov al, numero
        cmp al, 0
            je Zero
        mov cl, al
        mov ax, 1
        ciclo:
            mul cl
            push ax
            xor ax,ax

            mov bl, cl
            add cl, 48
            mov dl, cl
            mov ah, 02h               
            int 21h

            mov dl, 42
            mov ah, 02h               
            int 21h
            mov cl,bl

            xor ax,ax
            pop ax
            
        loop ciclo 
        mov resultado[0], al
        jmp fin   

        Zero:
            mov resultado[0], 01
            jmp fin
        fin:	    
endm

Multi macro numero1, numero2, resultado
mov al, numero1
imul numero2
mov resultado, al
endm

Divi macro numero1, numero2, resultado
mov al, numero1
idiv numero2
mov resultado, al
endm

Ley_Signos macro signo1, signo2, signo_final, cadena
    LOCAL menos, mas, menosXmenos, masXmas, masXmenos, menosXmas, fin
    mov al, signo1
    cmp al, -1
        je menos
    cmp al, 1
        je mas
    menos:
        mov al, signo2
        cmp al, -1  
            je menosXmenos
        cmp al, 1
            je menosXmas
    menosXmenos:
        mov signo_final, 1
        jmp fin
    menosXmas:
        mov signo_final, -1        
        jmp fin
    mas:
        mov al, signo2
        cmp al, -1  
            je masXmenos
        cmp al, 1
            je masXmas 
    masXmas:
        mov signo_final, 1
        jmp fin
    masXmenos:
        mov signo_final,-1
        jmp fin
    fin:
endm

SignoToAscii macro signo
    LOCAL positivo,negativo,fin
    mov al, signo
    cmp signo, -1
        je negativo
    jmp positivo
    positivo:
        mov signo, 43
        jmp fin
    negativo:
        mov signo, 45
        jmp fin
    fin:
endm   