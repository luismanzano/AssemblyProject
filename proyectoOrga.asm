		.data

 mensaje1: 	.asciiz "Ingrese el primer numero "
 mensaje2: 	.asciiz "Ingrese el segundo numero "
 mensaje3:	.asciiz "Indique la operacion a realizar Sumar(0), Restar(1), Multiplicar(2)"
 mensajeFinal: 	.asciiz "El resultado de la operacion es "
 salto:		.asciiz "\n"
 numero1: 	.space 56
 numero2: 	.space 56
 

	.text

	li $v0, 4
	la $a0, mensaje1 #Mensaje para ingresar el primer numero 
	syscall 
	
	li $v0,8
	la $a0, numero1 #Cargar el byte que se va a sobrescribir
        li $a1, 50 #Se indica máximo de bytes para escribir  
        syscall
        
	li $v0,4
	la $a0,salto
	syscall
	
	li $v0,4
	la $a0, mensaje2 #Mensaje para ingresar segundo número
	syscall
	
	li $v0,8
	la $a0, numero2 # Segundo numero
        li $a1, 50  
        syscall
        
        li $v0,4
	la $a0,salto
	syscall
        
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
	
suma:	li $v0, 1
	li $a0, 0
	syscall

resta:	li $v0, 1
	li $a0, 1
	syscall

multi:	li $v0, 1
	li $a0, 2
	syscall
	
	li $v0,10
	syscall

