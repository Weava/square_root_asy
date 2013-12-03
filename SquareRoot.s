#SquareRoot.s

#DATA

.data

square: .asciiz "Enter the number you wish to find the square root for: "
answer: .asciiz "The answer is: "
newline: .asciiz "\n"

#Text

.text
.globl main

main:
	li $v0, 4            	#Prompt user for input
	la $a0, square
	syscall
	
	li $v0, 5				#Receive said input
	syscall
	move $a0, $v0
	
	move $t4, $zero			#Move variables to t registers
	move $t1, $a0
	
	addi $t0, $zero, 1		#Set $t0 to 1
	sll $t0, $t0, 30		#Bit Shift $t0 left by 30
	
	#For loop
	loop1:
		slt $t2, $t1, $t0
		beq $t2, $zero, loop2	
		nop
		
		srl $t0, $t0, 2			#Shift $t0 right by 2
		j loop1
		
	loop2:
		beq $t0, $zero, return	
		nop
		
		add $t3, $t4, $t0		#if $t0 != zero add t0 and t4 into t3
		slt $t2, $t1, $t3		
		beq $t2, $zero, else1	
		nop
		
		srl $t4, $t4, 1			#shift $t4 right by 1
		j loopEnd
		
	else1:
		sub $t1, $t1, $t3		#Decrement $t1 by $t3
		srl $t4, $t4, 1			#Shift $t4 right by 1
		add $t4, $t4, $t0		#then add $t0 to that
		
	loopEnd:
		srl $t0, $t0, 2			#shift $t0 to the right
		j loop2
		
	return:
		li $v0, 4				#print out the answer then exit
		la $a0, answer
		syscall
	
		li $v0, 1
		move $a0, $t4
		syscall
		
		li $v0, 10
   		syscall
		