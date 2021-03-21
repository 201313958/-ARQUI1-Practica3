;menú para ingresar texto, mostrar texto y un ciclo 
include macros.asm 
.model small 
; -------------- SEGMENTO DE PILA -----------------
.stack 
; -------------- SEGMENTO DE DATOS -----------------
.data 
;Cadenas de encabezados y menus
encabezado1 db 0ah,0dh, 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA' , '$'
encabezado2 db 0ah,0dh, 'ESCUELA DE CIENCIAS Y SISTEMAS' , '$'
encabezado3 db 0ah,0dh, 'ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1' , '$'
encabezado4 db 0ah,0dh, 'SECCION B' , '$'
encabezado5 db 0ah,0dh, 'PRIMER SEMESTRE 2021' , '$'
encabezado6 db 0ah,0dh, 'Jose Pablo Valiente Montes' , '$'
encabezado7 db 0ah,0dh, '201313958' , '$'
encabezado8 db 0ah,0dh, 'Primer Practica Assembler' , '$'
cadena_menu1 db 0ah,0dh, '********** MENU **********' , '$'
cadena_opcion1 db 0ah,0dh, '  1.) Cargar Archivo' , '$'
cadena_opcion2 db 0ah,0dh, '  2.) Modo Calculadora' , '$'
cadena_opcion3 db 0ah,0dh, '  3.) Factorial' , '$'
cadena_opcion4 db 0ah,0dh, '  4.) Crear reporte' , '$'
cadena_opcion5 db 0ah,0dh, '  5.) Salir' , '$'
cadena_menu2 db 0ah,0dh, '**************************' , '$'
Cadena_Debu db 0ah,0dh, 'SI ESTA PASANDO POR AQUI', '$'
mensaje db 0ah,0dh, 'En ciclo' , '$'
saltolinea db 10,'$'
mensaje2 db 10,'El texto es: ','$' 

;Variables para la calculadora
cadena_menucalc db 0ah,0dh, '********** Calc **********' , '$'
cadena_ingresenum db 0ah,0dh, 'Ingrese un Numero(-99,99)' , '$'
cadena_ingreseop db 0ah,0dh, 'Ingrese un operador' , '$'
cadena_ingreseop2 db 0ah,0dh, 'Ingrese Un Operador o ; para finalizar' , '$'
cadena_resultado db 0ah,0dh, '  El resultado fue' , '$'
cadena_guardar db 0ah,0dh, '  Desea Guardar(S/N)' , '$'
cadena_entrante db 10 dup('$'), '$'
Num1 db 10 dup('$'), '$'
Signo_Num1 db 10 dup('$'), '$'
Num2 db 10 dup('$'), '$'
Signo_Num2 db 10 dup('$'), '$'
Resultado db 10 dup('$'), '$'
Signo_Resultado db 10 dup('$'), '$'
ope db 10 dup('$'), '$'
temp db 10 dup('$'), '$'

;Variables para factorial
msg_fact db 0ah,0dh, 'Ingrese un numero(0-4): ', '$'
msg_fact2 db 0ah,0dh, 'El Resultado es: ', '$'
msg_fact3 db 0ah,0dh, 'Operaciones: ', '$'
fact_res_ascii db 3 dup('$'), '$'
fact_res db 16 dup('$'), '$'
cadena_fact db 40 dup('$'), '$'



;----------------SEGMENTO DE CODIGO---------------------

.code
mov dx,@data
mov ds,dx

main proc
	encabezado:
		print encabezado1
		print encabezado2
		print encabezado3
		print encabezado4
		print encabezado5
		print encabezado6
		print encabezado7
		print encabezado8
		print saltolinea
		jmp menu	
	menu:
		print cadena_menu1
		print cadena_opcion1
		print cadena_opcion2
		print cadena_opcion3
		print cadena_opcion4
		print cadena_opcion5
		print cadena_menu2
		print saltolinea
		getChar
        ;cmp para comparar 
		cmp al,49 ;mnemonio 31h = 1 en hexadecimal, ascii 49
			;je carga_archivos
		cmp al,50 ;mnemonio 32h = 2 en hexadecimal, ascii 50
			je menu_calc
		cmp al,51 ;mnemonio 33h = 3 en hexadecimal, ascii 51
			je factorial
		cmp al,52 ;mnemonio 34h = 4 en hexadecimal, ascii 52
			;je crear_reporte
		cmp al,53 ;mnemonio 34h = 5 en hexadecimal, ascii 52
			je salir
		jmp menu

	carga_archivos: 
		jmp menu

	menu_calc:
		print cadena_menucalc ;Imprime la cadena del menu de la calculadora
		print cadena_ingresenum ;imprime la cadenna de ingrese numero
		print saltolinea; imprime uns salto de linea
		ObtenerTexto cadena_entrante ; captura la cadena entrante
		EsNegativo cadena_entrante, Num1, Signo_Num1, temp ; determina si es + o - y asigna el signo
		print cadena_ingreseop
		print saltolinea
		getChar
		mov ope[0], al
		;print ope
		jmp Comp_Operacion		
		jmp menu	

	Comp_Operacion:
		xor al,al
		mov al,ope[0]
		cmp al, 42
			je Producto
		cmp al, 47
			je Division

	Producto:
		print cadena_ingresenum ;imprime la cadenna de ingrese numero
		print saltolinea; imprime uns salto de linea
		ObtenerTexto cadena_entrante ; captura la cadena entrante
		EsNegativo cadena_entrante, Num2, Signo_Num2, temp ; determina si es + o - y asigna el signo
		;print Num1
		;print saltolinea
		;print Num2

		Multi Num1, Num2, Resultado
		Ley_Signos Signo_Num1, Signo_Num2, Signo_Resultado, Cadena_Debu
		SignoToAscii Signo_Resultado
		print Signo_Resultado
		NumToAscii Resultado
		jmp menu

	Division:
		;print Cadena_Debu
		print cadena_ingresenum ;imprime la cadenna de ingrese numero
		print saltolinea; imprime uns salto de linea
		ObtenerTexto cadena_entrante ; captura la cadena entrante
		EsNegativo cadena_entrante, Num2, Signo_Num2, temp ; determina si es + o - y asigna el signo

		Divi Num1, Num2, Resultado
		Ley_Signos Signo_Num1, Signo_Num2, Signo_Resultado, Cadena_Debu
		SignoToAscii Signo_Resultado
		print Signo_Resultado
		NumToAscii Resultado
		jmp menu

	factorial:
		print msg_fact
		ObtenerTexto cadena_entrante
		mov Num1, al
		AsciiPos_To_Num cadena_entrante, Num1, temp
		OpFactorial fact_res, Num1, msg_fact3
		print msg_fact2
		NumToAscii fact_res
		jmp menu

	crear_reporte:
		mov cx,5 ;siemre en el uso de loop, cx, lleva el contador de las veces que se va a repetir el loop 

		Mientras:
			print mensaje ;imprime el mensaje 
			Loop Mientras ;lo lleva a la etiqueta mientras pero decrementa cx 
			jmp menu ; y cuando cx ya es 0 , avanza y ejecuta este jmp 
	salir:
		close
main endp
end main