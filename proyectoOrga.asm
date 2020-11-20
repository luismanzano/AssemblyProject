		.data

 mensaje1: 	.asciiz "Ingrese el primer numero "
 mensaje2: 	.asciiz "Ingrese el segundo numero "
 mensajeFinal: 	.asciiz "El resultado de la operacion es "
 salto:		.asciiz "\n"
 numero1: 	.space 50
 numero2: 	.space 50
 

	.text

	li $v0, 4
	la $a0, mensaje1
	syscall 
	
	li $v0,8
	la $a0, numero1 #load byte space into address
        li $a1, 50 # allot the byte space for string
        # GUARDADO PARA MAS TARDE save string to t0 move -> $t0,$a0 
        syscall
        
	#sw $a0, numero1 #cambiando a sw para guardar el string en memoria
	
	li $v0,4
	la $a0,salto
	syscall
	
	li $v0,4
	la $a0, mensaje2 #mostrar que tiene que ingresar el segundo numero a operar
	syscall
	
	li $v0,8
	la $a0, numero2 #load byte space into address
        li $a1, 50 # allot the byte space for string
        # GUARDADO PARA MAS TARDE save string to t1 move -> move $t1,$a0 
        syscall

	li $v0,4
	la $a0,salto
	syscall

	li $v0, 4
	la $a0, numero1
	syscall
	
	li $v0,4
	la $a0,salto
	syscall
	
	li $v0, 4
	la $a0, numero2
	syscall

	li $v0,10
	syscall

