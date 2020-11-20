.data

 mensaje1: .asciiz "Ingrese el primer numero "
 mensaje2: .asciiz "Ingrese el segundo numero "
 mensajeFinal: .asciiz "El resultado de la operacion es "
 numero1: .space 50
 numero2: .space 50
 

.text

li $v0, 4
lw $a0, mensaje1
syscall 

li $v0, 10
syscall

