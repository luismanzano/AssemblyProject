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
 aux1:		.space 50
 aux2: 		.space 50
 resultado:	.space 50
 
	.text
	
	.macro imprimir_string %mensaje #Imprimir en pantalla
	li $v0, 4
	la $a0,%mensaje
	syscall
	.end_macro
	
	.macro indice %numero, %indice #Metodo para conocer el numero con mas digitos 	
	li $t0, 0 #Indice para recorrer el numero de izquierda a derecha 
	li $t1, 0 #Contador
	
loopI1:	
	lb $t2, %numero1($t0)
	subiu $t2, $t2, 0x29 
	blt $t2, 0, finalI1  
	addi $t0, $t0, 1
	addi $t1, $t1, 1
	bgt $t2, 0, loopI1
	
finalI1:	
	move %indice, $t1 
										
	.end_macro
	
	
	
	
	
	
	
	.macro agregar0 %numero, %indice, %aux, %salto #Metodo para agregar 0's a la izquierda de los numeros
	li $t0, 50
	li $t1, %indice
	li $t1, 1
	subi $t1, $t1, 1
	
	bgez %aux loop
	beq %aux, $t1, loop2
	
loopA1:	lb $t4, %numero($t1) #cargamos el ultimo numero ingresado por el usuario en t4
	sb $t4, aux1($t0)
	subi $t0, $t0, 1
	subi $t1, $t1, 1
	bgez $t1, loopA1
	b  finalA
	
loopA2:	lb $t4, %numero($t1) #cargamos el ultimo numero ingresado por el usuario en t4
	sb $t4, aux1($t0)
	subi $t0, $t0, 1
	subi $t1, $t1, 1
	bgez $t1, loopA2
	
finalA: 
	
		
	
	.end_macro 
	
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 .macro es_mayor %indice_mayor, %indice_menor #Numero con mas digitos 
	 
	 move $t0, %indice_mayor
	 move $t1, %indice_menor
	 
	 bgt $t0, $t1, finalM
	 beq $t1, $t0, finalM
	 
	move %indice_mayor, $t1
	move %indice_menor, $t0

finalM:	 	 
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
	
	indice(numero1, $s0) 
	indice(numero2, $s1)
        es_mayor($s0, $s1)
        
	

        
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
	
	subi $s0, $s0, 1
	li $t9, 0 #Acarreo
	
loopS:			 
	lb $t2, numero1($s0) #Cargo el digito en la posicion $t8
	lb $t3, numero2($s0)
	subi $t2, $t2, 0x30 #Convrtir a decimal
	subi $t3, $t3, 0x30
	add $t4, $t2, $t3 #Suma de digitos
	add $t4, $t4, $t9 #Suma de acarreos
	li $t9, 0
	bgt $t4, 9, acarreoSuma
sumaC:	# Se continua con la suma
	addi $t4 $t4, 0x30 #Convertir a ASCII
	sb $t4, resultado($s0)#Almacenar digito
	subi $s0, $s0, 1 #Cambiar indice 
	bgez $s0, loopS
	
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
	subi $t4, $t4, 10
	li $t9, 1
	b sumaC
	
