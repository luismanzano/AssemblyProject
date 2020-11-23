		.data
 bienvenida:	.asciiz "Bienvenido a la calculadora aritmetica de enteros largos\n"
 mensaje1: 	.asciiz "Ingrese el primer numero "
 mensaje2: 	.asciiz "Ingrese el segundo numero "
 mensaje3:	.asciiz "Indique la operacion a realizar Sumar(0), Restar(1), Multiplicar(2)"
 mensajeR: 	.asciiz "El resultado de la operacion es "
 continuar:	.asciiz "\n�Desea realizar otra operacion?  SI(1), NO(0)\n"
 salto:		.asciiz "\n"
 numero1: 	.space 50
 numero2: 	.space 50
 resultado:	.space 50
 tabla:		.space 48 #Tabla ASCII para realizar las operaciones
 		.byte 0,1,2,3,4,5,6,7,8,9
 		.space 198
 numeros:	.asciiz "0123456789"	 		
 
	.text
	
	li $v0, 4
	la $a0, bienvenida
	syscall
regresar: #Si el usuario desea realizar otra operacion	
	li $v0,4
	la $a0,salto
	syscall
	
	li $v0, 4
	la $a0, mensaje1 #Mensaje para ingresar el primer numero 
	syscall 
	
	li $v0,8
	la $a0, numero1 #Cargar el byte que se va a sobrescribir
        li $a1, 50 #Se indica m�ximo de bytes para escribir  
        syscall
        
	li $v0,4
	la $a0,salto
	syscall
	
	li $v0,4
	la $a0, mensaje2 #Mensaje para ingresar segundo n�mero
	syscall
	
	li $v0,8
	la $a0, numero2 # Segundo numero
        li $a1, 50  
        syscall
        
        li $v0,4
	la $a0,salto
	syscall
operacion:        
        li $v0, 4
        la $a0, mensaje3 #Mensaje para indicar la operacion
        syscall

	li $v0,4
	la $a0,salto
	syscall
	
	#El usuario indica la opracion a ralizar
	li $v0, 5
	syscall
	move $t0, $v0
        
	beq $t0, 0, suma
	beq $t0, 1, resta
	beq $t0, 2, multi
	bgt $t0, 2, operacion
	
suma:	
	li $t0, 50 #Indice para recorrer los numeros ingresados por el usuario CAMBIO A 50 AQUI
	li $t6, 0 #Numero de acarreo
	#li $t9, 0#Indice para guardar el resultado
loopS: # Proceso de sumar
	lb $t1, numero1($t0)
	lb $t2, numero2($t0)
	lb $t3, tabla($t1)
	lb $t4, tabla($t2)
	add $s1, $t3,$t4
	add $s1, $s1, $s0
	li $t6, 0
	bgt $s1, 9, acarreoSuma
sumaC:	# Se continua con la suma
	lb $t5,numeros($s1) 	
	sb $t5, resultado($t0)
	subi $t0, $t0, 1
	#addi $t9, $t9, 1
	bge $t0, 0, loopS
		
	b final #Se finaliza la operacion

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
	li $v0, 4
	la $a0, mensajeR
	syscall
	
	li $v0,4
	la $a0,salto
	syscall
	
	li $t0,50 #OTRO CAMBIO DE 49 A 50 AQUI
 #imprimir: 	
	li $v0, 4
	la $a0, resultado#($t0)
	syscall
	#subi $t0, $t0, 1
	#bgez $t0, imprimir
	
	li $v0, 4
	la $a0, continuar
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	beq $t0, 1, regresar
	  
					
	li $v0,10
	syscall

acarreoSuma: #Llevo 1 en la suma
	subi $s1, $s1, 10
	li $t6, 1
	b sumaC
	
