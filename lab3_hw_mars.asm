.data
prompt: .asciiz "Enter the power of 3:  "
display: .asciiz "The result is:  "
error: .asciiz "Error! Out of range."

.text
main: 	#prompt the user to enter the value of n
	#'Enter the power of 3'
	li $v0, 4 		 #string
	la $a0, prompt
	syscall 
	
	#get the input from the user
	li $v0, 5 		#input
	syscall
	
	#store n in $a1
	move $a1, $v0
	
	#if n is out of range, display error message and terminate program
	bgt $a1, 19, Error
	blt $a1, 10, Error
	
	#$t0 = 1
	li $t0, 3
	#jump to Power
	jal Power
	
	#display result message
	#"The result is: "
	li $v0, 4 		#string
	la $a0, display
	syscall
	
	#display result
	move $a0, $t0
	li $v0, 1 		#integer
	syscall
	
	#exit the program
	li $v0, 10
	syscall
	
Power:	#adjust stack for 2 elements
	addi $sp, $sp, -8
	#save register $a1 for use afterwords
	sw $a1, 4($sp)	
	#save the return address
	sw $ra, 0($sp)
	
	#decrement n 
	addi $a1, $a1, -1  	#$a1 = n-1
	#when $a1 gets 0, exit
	beq $a1, $zero, Exit    
	#recursion		
     	jal Power
     	
     	#t1 = 3 * power 3^(n-1)
	mul $t0, $t0, 3 	
	
Exit:	#restore registers
     	lw $a1, 4($sp)
     	lw $ra, 0($sp)
     	addi $sp, $sp, 8
     	#return the address register
     	jr $ra
	
Error:  #print error message
	#"Error! Out of range"
	li $v0, 4
	la $a0, error
	syscall
	
	#terminate program
	li $v0, 10
	syscall
     
     	
     	
     
	
	
