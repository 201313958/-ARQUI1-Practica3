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
cadena_resultado db 0ah,0dh, '  El resultado fue: ' , '$'
cadena_guardar db 0ah,0dh, '  Desea Guardar(s/n)' , '$'
cadena_MaxOpe db 0ah,0dh, 'HA REALIZADO EL MAXIMO DE OPERACIONES PERMITIDAS' , '$'
cadena_entrante db 10 dup('$'), '$'
Num1 db 10 dup('$'), '$'
Signo_Num1 db 10 dup('$'), '$'
Num2 db 10 dup('$'), '$'
Signo_Num2 db 10 dup('$'), '$'
Resultado db 10 dup('$'), '$'
Signo_Resultado db 10 dup('$'), '$'
ope db 10 dup('$'), '$'
temp db 10 dup('$'), '$'
contador_operandos db 0

;Variables para factorial
msg_fact db 0ah,0dh, 'Ingrese un numero(0-4): ', '$'
msg_fact2 db 0ah,0dh, 'El Resultado es: ', '$'
msg_fact3 db 0ah,0dh, 'Operaciones: ', '$'
fact_res_ascii db 3 dup('$'), '$'
fact_res db 16 dup('$'), '$'
cadena_fact db 40 dup('$'), '$'

;Variables para Creacion y Escritura de archivos
bufferentrada db 'Reporte.html'
handlerentrada dw ?
bufferInformacion db 4000 dup(' ')
Contador_operaciones db 1
cadena_reporte1 db '<html><header><h1 align="center">Practica 3 Arqui 1 Seccion B</h1>$'
cadena_reporte2 db '<p style="font-size:20px" align="center"><b>Nombre:</b> Jose Pablo Valiente Montes</p>$'
cadena_reporte3 db '<p style="font-size:20px" align="center"><b>Carne:</b> 201313958</p>$'
cadena_reporte4 db '<p style="font-size:20px" align="center"><b>Fecha:</b>$'
cadena_reporte5 db '<script align="center">var f = new Date();$'
cadena_reporte6 db 'document.write(f.getDate() + "/" + (f.getMonth() +1) + "/" + f.getFullYear());$'
cadena_reporte7 db '</script></p>$'
cadena_reporte8 db '<p style="font-size:20px" align="center"><b>Hora:</b>$'
cadena_reporte9 db '<script align="center">var f = new Date();$'
cadena_reporte10 db 'document.write(f.getHours() + ":" + f.getMinutes());$'
cadena_reporte12 db '</script></p>$'
cadena_reporte13 db '</header><body><table border="1" align="center"><tbody>$'
cadena_reporte14 db '<tr><th>ID Operacion</th><th>Operaciones</th><th>Resultado</th></tr>$'
cadena_reporte15 db '</tbody></table></body></html>$'
cadena_Operacion1 db '<tr><td>Operacion1</td><td>$'
cadena_Operacion2 db '<tr><td>Operacion2</td><td>$'
cadena_Operacion3 db '<tr><td>Operacion3</td><td>$'
cadena_Operacion4 db '<tr><td>Operacion4</td><td>$'
cadena_Operacion5 db '<tr><td>Operacion5</td><td>$'
cadena_Operacion6 db '<tr><td>Operacion6</td><td>$'
cadena_Operacion7 db '<tr><td>Operacion7</td><td>$'
cadena_Operacion8 db '<tr><td>Operacion8</td><td>$'
cadena_Operacion9 db '<tr><td>Operacion9</td><td>$'
cadena_Operacion10 db '<tr><td>Operacion10</td><td>$'
cadena_Operacion11 db '<tr><td>Operacion11</td><td>$'
cadena_Operacion12 db '<tr><td>Operacion12</td><td>$'
cadena_Operacion13 db '<tr><td>Operacion13</td><td>$'
cadena_Operacion14 db '<tr><td>Operacion14</td><td>$'
cadena_Operacion15 db '<tr><td>Operacion15</td><td>$'
cadena_Tabla1 db '</td><td>$'
cadena_Tabla2 db '</td></tr>$'
cadena_OperadorHTML db 10 dup('$'), '$'

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
		limpiar bufferInformacion, SIZEOF bufferInformacion,24h
		xor si, si
		Concatenar_Encabezado_HTML bufferInformacion, cadena_reporte1
		Concatenar_Encabezado_HTML bufferInformacion, cadena_reporte2
		Concatenar_Encabezado_HTML bufferInformacion, cadena_reporte3
		Concatenar_Encabezado_HTML bufferInformacion, cadena_reporte4
		Concatenar_Encabezado_HTML bufferInformacion, cadena_reporte5
		Concatenar_Encabezado_HTML bufferInformacion, cadena_reporte6
		Concatenar_Encabezado_HTML bufferInformacion, cadena_reporte7
		Concatenar_Encabezado_HTML bufferInformacion, cadena_reporte8
		Concatenar_Encabezado_HTML bufferInformacion, cadena_reporte9
		Concatenar_Encabezado_HTML bufferInformacion, cadena_reporte10
		Concatenar_Encabezado_HTML bufferInformacion, cadena_reporte12
		Concatenar_Encabezado_HTML bufferInformacion, cadena_reporte13
		Concatenar_Encabezado_HTML bufferInformacion, cadena_reporte14
		Concatenar_Encabezado_HTML bufferInformacion, cadena_Operacion1
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
			je Crear_Reporte
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
		mov cadena_entrante[3], 36
		Concatenar_Encabezado_HTML bufferInformacion, cadena_entrante
		print cadena_ingreseop
		print saltolinea
		getChar
		mov ope[0], al
		mov ope[1], 36
		Concatenar_Encabezado_HTML bufferInformacion, ope
		;print ope		
		jmp Comp_Operacion		

	Continuar:
		mov bl, Resultado
		mov Num1, bl
		mov bl, Signo_Resultado
		mov Signo_Num1, bl
		;SignoToAscii Signo_Num1
		;print Signo_Num1
		;NumToAscii Num1
		;print Num1
		mov al,contador_operandos
		cmp al, 10
			je Max_Ope
		print cadena_ingreseop2
		print saltolinea
		getChar
		mov ope[0], al
		mov ope[1], 36
		Concatenar_Encabezado_HTML bufferInformacion, ope
		;print ope
		jmp Comp_Operacion		
		;jmp menu

	fin_calc:
		mov contador_operandos, 0
		print cadena_resultado
		SignoToAscii Signo_Resultado

        Concatenar_Encabezado_HTML bufferInformacion, cadena_Tabla1
		Concatenar_Encabezado_HTML bufferInformacion, Signo_Resultado
				
		print Signo_Resultado
		NumToAscii Resultado
		Concatenar_Encabezado_HTML bufferInformacion, Resultado
		Concatenar_Encabezado_HTML bufferInformacion, cadena_Tabla2

		IncContador Contador_operaciones
		mov al, Contador_operaciones
		cmp al, 2
		    je operacion2
		cmp al, 3
		    je operacion3
		cmp al, 4
		    je operacion4
		cmp al, 5
		    je operacion5
		cmp al, 6
		    je operacion6
		cmp al, 7
		    je operacion7
		cmp al, 8
		    je operacion8
		cmp al, 9
		    je operacion9
		cmp al, 10
		    je operacion10
		cmp al, 11
		    je operacion11
		cmp al, 12
		    je operacion12
		cmp al, 13
		    je operacion13
		cmp al, 14
		    je operacion14
		cmp al, 15
		    je operacion15

	Crear_Reporte: 
	    Concatenar_Encabezado_HTML bufferInformacion, cadena_reporte15
		crear bufferentrada, handlerentrada
		escribir  handlerentrada, bufferInformacion, SIZEOF bufferInformacion
		cerrar handlerentrada
	jmp menu

	Max_Ope:
		print saltolinea
		print cadena_MaxOpe
		print saltolinea
		mov contador_operandos, 0
	jmp fin_calc

	Comp_Operacion:
		xor al,al
		mov al,ope[0]
		cmp al, 42
			je Producto
		cmp al, 47
			je Division
		cmp al, 43
			je Suma
		cmp al, 45
			je Resta
		cmp al, 59
			je fin_calc

	Resta:
		print cadena_ingresenum ;imprime la cadenna de ingrese numero
		print saltolinea; imprime uns salto de linea
		ObtenerTexto cadena_entrante ; captura la cadena entrante
		EsNegativo cadena_entrante, Num2, Signo_Num2, temp ; determina si es + o - y asigna el signo
		Restar Num1, Signo_Num1, Num2, Signo_Num2, Resultado, Signo_Resultado, Cadena_Debu
		Concatenar_Encabezado_HTML bufferInformacion, cadena_entrante
		IncContador contador_operandos
		;SignoToAscii Signo_Resultado
		;print Signo_Resultado
		;NumToAscii Resultado
	jmp Continuar

	Suma:
		print cadena_ingresenum ;imprime la cadenna de ingrese numero
		print saltolinea; imprime uns salto de linea
		ObtenerTexto cadena_entrante ; captura la cadena entrante
		EsNegativo cadena_entrante, Num2, Signo_Num2, temp ; determina si es + o - y asigna el signo
		Sumar Num1, Signo_Num1, Num2, Signo_Num2, Resultado, Signo_Resultado
		Concatenar_Encabezado_HTML bufferInformacion, cadena_entrante
		IncContador contador_operandos
		;SignoToAscii Signo_Resultado
		;print Signo_Resultado
		;NumToAscii Resultado
		jmp Continuar

	Producto:
		print cadena_ingresenum ;imprime la cadenna de ingrese numero
		print saltolinea; imprime uns salto de linea
		ObtenerTexto cadena_entrante ; captura la cadena entrante
		EsNegativo cadena_entrante, Num2, Signo_Num2, temp ; determina si es + o - y asigna el signo

		Multi Num1, Num2, Resultado
		Ley_Signos Signo_Num1, Signo_Num2, Signo_Resultado
		Concatenar_Encabezado_HTML bufferInformacion, cadena_entrante
		IncContador contador_operandos
		;SignoToAscii Signo_Resultado
		;print Signo_Resultado
		;NumToAscii Resultado
		jmp Continuar

	Division:
		;print Cadena_Debu
		print cadena_ingresenum ;imprime la cadenna de ingrese numero
		print saltolinea; imprime uns salto de linea
		ObtenerTexto cadena_entrante ; captura la cadena entrante
		EsNegativo cadena_entrante, Num2, Signo_Num2, temp ; determina si es + o - y asigna el signo
		Concatenar_Encabezado_HTML bufferInformacion, cadena_entrante
		IncContador contador_operandos
		Divi Num1, Num2, Resultado
		Ley_Signos Signo_Num1, Signo_Num2, Signo_Resultado
		
		;SignoToAscii Signo_Resultado
		;print Signo_Resultado
		;NumToAscii Resultado
		jmp Continuar

	factorial:
		print msg_fact
		ObtenerTexto cadena_entrante
		mov Num1, al
		AsciiPos_To_Num cadena_entrante, Num1, temp
		OpFactorial fact_res, Num1, msg_fact3
		print msg_fact2
		NumToAscii fact_res
		jmp menu

	salir:
		close

	operacion2:
	    Concatenar_Encabezado_HTML bufferInformacion, cadena_Operacion2
		print saltolinea
		print cadena_guardar
		print saltolinea
		getChar		
		cmp al, 115
			;je Crear_Reporte
		jmp menu

	operacion3:
	    Concatenar_Encabezado_HTML bufferInformacion, cadena_Operacion3
		print saltolinea
		print cadena_guardar
		print saltolinea
		getChar		
		cmp al, 115
			;je Crear_Reporte
		jmp menu

	operacion4:
	    Concatenar_Encabezado_HTML bufferInformacion, cadena_Operacion4
		print saltolinea
		print cadena_guardar
		print saltolinea
		getChar		
		cmp al, 115
			;je Crear_Reporte
		jmp menu

	operacion5:
	    Concatenar_Encabezado_HTML bufferInformacion, cadena_Operacion5
		print saltolinea
		print cadena_guardar
		print saltolinea
		getChar		
		cmp al, 115
			;je Crear_Reporte
		jmp menu

	operacion6:
	    Concatenar_Encabezado_HTML bufferInformacion, cadena_Operacion6
		print saltolinea
		print cadena_guardar
		print saltolinea
		getChar		
		cmp al, 115
			;je Crear_Reporte
		jmp menu

	operacion7:
	    Concatenar_Encabezado_HTML bufferInformacion, cadena_Operacion7
		print saltolinea
		print cadena_guardar
		print saltolinea
		getChar		
		cmp al, 115
			;je Crear_Reporte
		jmp menu

	operacion8:
	    Concatenar_Encabezado_HTML bufferInformacion, cadena_Operacion8
		print saltolinea
		print cadena_guardar
		print saltolinea
		getChar		
		cmp al, 115
			;je Crear_Reporte
		jmp menu

	operacion9:
	    Concatenar_Encabezado_HTML bufferInformacion, cadena_Operacion9
		print saltolinea
		print cadena_guardar
		print saltolinea
		getChar		
		cmp al, 115
			;je Crear_Reporte
		jmp menu

	operacion10:
	    Concatenar_Encabezado_HTML bufferInformacion, cadena_Operacion10
		print saltolinea
		print cadena_guardar
		print saltolinea
		getChar		
		cmp al, 115
			;je Crear_Reporte
		jmp menu

	operacion11:
	    Concatenar_Encabezado_HTML bufferInformacion, cadena_Operacion11
		print saltolinea
		print cadena_guardar
		print saltolinea
		getChar		
		cmp al, 115
			;je Crear_Reporte
		jmp menu

	operacion12:
	    Concatenar_Encabezado_HTML bufferInformacion, cadena_Operacion12
		print saltolinea
		print cadena_guardar
		print saltolinea
		getChar		
		cmp al, 115
			;je Crear_Reporte
		jmp menu

	operacion13:
	    Concatenar_Encabezado_HTML bufferInformacion, cadena_Operacion13
		print saltolinea
		print cadena_guardar
		print saltolinea
		getChar		
		cmp al, 115
			;je Crear_Reporte
		jmp menu

	operacion14:
	    Concatenar_Encabezado_HTML bufferInformacion, cadena_Operacion14
		print saltolinea
		print cadena_guardar
		print saltolinea
		getChar		
		cmp al, 115
			;je Crear_Reporte
		jmp menu

	operacion15:
	    Concatenar_Encabezado_HTML bufferInformacion, cadena_Operacion15
		print saltolinea
		print cadena_guardar
		print saltolinea
		getChar		
		cmp al, 115
			;je Crear_Reporte
		jmp menu
main endp
end main