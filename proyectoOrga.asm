		.data
 bienvenida:	.asciiz "Bienvenido a la calculadora aritmetica de enteros largos\n"
 mensaje1: 	.asciiz "Ingrese el primer numero "
 mensaje2: 	.asciiz "Ingrese el segundo numero "
 mensaje3:	.asciiz "Indique la operacion a realizar Sumar(1), Restar(2), Multiplicar(3)"
 mensajeR: 	.asciiz "El resultado de la operacion es "
 continuar:	.asciiz "\n�Desea realizar otra operacion?  SI(1), NO(0)\n"
 salto:		.asciiz "\n"
 numero1: 	.space 50
 numero2: 	.space 50
 resultado:	.space 50
 
	.text
	
	.macro imprimir_string %mensaje #Imprimir en pantalla
	li $v0, 4
	la $a0,%mensaje
	syscall
	.end_macro
	
	.macro indice %numero1, %numero2, %indice #Metodo para conocer el numero con mas digitos 	
	li $t0, 0
	li $t1, 0
	
loop1:	
	lb $t2, %numero1($t0)
	subiu $t2, $t2, 0x30
	blt $t2, 0, final1
	addi $t0, $t0, 1
	addi $t1, $t1, 1
	bgt $t2, 0, loop1
	
final1:	
	li $t0, 0
	li $t3, 0
	
loop2:	lb $t2, %numero2($t0)
	subiu $t2, $t2, 0x30
	blt $t2, 0, final2
	addi $t0, $t0, 1
	addi $t3, $t3, 1
	bgt $t2, 0, loop2
	
final2: 
	bgt $t1, $t3, es_mayor1
	bgt $t3, $t1, es_mayor2
	beq $t1, $t3, finalI
	
es_mayor1:
	move %indice,$t1
loop3:	
	b finalI
es_mayor2: 
	move %indice,$t3
loop4:	
	
finalI:									
	.end_macro
	
	
	imprimir_string(bienvenida)	
	
regresar: #Si el usuario desea realizar otra operacion	
	
	imprimir_string(salto)
	
	imprimir_string(mensaje1)
	
	li $v0,8
	la $a0, numero1 #Cargar el byte que se va a sobrescribir
        li $a1, 50 #Se indica m�ximo de bytes para escribir  
        syscall
        
	imprimir_string(salto)
	
	imprimir_string(mensaje2)
	
	li $v0,8
	la $a0, numero2 # Segundo numero
        li $a1, 50  
        syscall
        
        imprimir_string(salto)
        
operacion:        
        
        imprimir_string(mensaje3)

	imprimir_string(salto)
	
	#El usuario indica la opracion a ralizar
	li $v0, 5
	syscall
	move $t0, $v0
        
	beq $t0, 1, suma
	beq $t0, 2, resta
	beq $t0, 3, multi
	bgt $t0, 3, operacion
	blt $t0, 1, operacion
	
suma:	#Operacion de suma 
	indice(numero1, numero2, $t8)
	li $t9, 0
	
loopS:
	lb $t2, numero1($t8)
	lb $t3, numero2($t8)
	subi $t2, $t2, 0x30
	subi $t3, $t3, 0x30
	add $t4, $t2, $t3
	add $t4, $t4, $t9
	li $t1, 0
	bgt $t4, 9, acarreoSuma
sumaC:	
	addi $t4 $t4, 0x30
	sb $t4, resultado($t8)
	subi $t8, $t8, 1
	bge $t0, 0,loopS
	
	b final
		

resta:	
	li $v0, 1
	li $a0, 1
	syscall
	
	b final

multi:	
	li $v0, 1
	li $a0, 2
	syscall
	
final: #Imprimir el resultado de la operacion 	
	imprimir_string(mensajeR)
	
	imprimir_string(salto)
	
	imprimir_string(resultado)
	
	imprimir_string(continuar)
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	beq $t0, 1, regresar
	  
					
	li $v0,10
	syscall

acarreoSuma: #Llevo 1 en la suma
	subi $s1, $s1, 10
	li $t9, 1
	b sumaC
	
