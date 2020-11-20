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
	syscall
	move $t0,$v0
	
	li $v0,4
	la $a0,salto
	syscall
	
	li $v0,4
	la $a0, mensaje2
	syscall
	
	li $v0,8
	syscall
	move $t1,$v0

	li $v0,4
	la $a0,salto
	syscall

	li $v0,4
	move $a0,$t0
	syscall
	
	li $v0,4
	la $a0,salto
	syscall
	
	li $v0,4
	move $a0,$t1
	syscall

	li $v0,10
	syscall

