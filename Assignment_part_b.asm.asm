#Filename: Assignment_part_b.asm
#Author: Tebello Masike
#student number: 202002500
#date: 30/10/2022
#purpose: Printing first 10 reversible prime sqaures

#====================================================================================================================================================================================================================
#include<stdio.h>
#include<stdbool.h>
#include<math.h>

#int reverse(int num) // iterative function that reverses digits of num 
#{
#	int r;             
#	int reverse=0;
#	while(num!=0) 
#	{
#		r=num%10;
#		reverse= (reverse*10)+r;
#		num=num/10;
#	}
#	return reverse;
#}

#bool prime_num(int num) //this function checks whether a given number is prime or not
#{
#	int i;
#	bool isPrime=true;
	
#	if(num==0 || num==1 ) //since 0 and 1 are not
#	{
#		isPrime=false;
#	}
#	
#	for(i=2;i<=(num)/2;i++)
#	{
#		if(num%i == 0)
#			isPrime=false;
#			break;
#		}
#		
#	}
#	return isPrime;
#}
#
#bool isPerfect(long num)//checks whether a given number is a perfect sqaure 
#{
#	int i;
#    for(i=1; i * i <= num; i++ )
#    {
#        if((num % i == 0) && (num / i == i))
#        {
#            return 1;
#        }
#    }
#    return 0;
#}

#bool not_palindrome(int num) //checks that a given is not a palindrome
#{
#	if(reverse(num)==num)
#	{
#		return false;
#	}
#	return true;
#}
#
#
#
#
#int main(){
#	int count=0;
#	int k,x,s,l;
#
#	for(k=0;k>=0;k++)//checking for every number from k to infinity which is defined by the declared functions
#	{
#		
#		int s = reverse(k); //stores the reverse of int k in s
#
#        if(isPerfect(k) == 1 && isPerfect(s) == 1) //checks if k and s are perfect 
#        {
#            x = sqrt(k); //takes the square root of the given numbers
#            l = sqrt(s);
#
#            if(prime_num(x) == 1 && prime_num(l))// checks if x and l are prime
#            {
#                if(not_palindrome(k)) //checks that k is not a palindrome
#                {
#                    printf("%d \n",k); //prints out k
#                   count++;
#                    if(count==11) //accounts for the first 10 reversibleprime sqaures
#                    {
#                    	break;
#					}
#              }
#
#            }
#        }
#			
#	}
#
#	return 0;
#}
#=============================================================================================================================================================================================

.data
	newLine:	.asciiz		"\n"
	
.text
.globl main
main:
#========================================================================================
# R E G I S T E R - V A R I A B L E  M A P P I N G
# $a1 -> int k; argument for reverse, isperfect, sqrt and not_palindrome procedures
# $a2 -> argument for prime_num procedure
# $v1 -> return value for not_palindrome procedure
# $t0 -> int count
# $t1 -> const 10
# $s0 -> int s; return value for reverse procedure
# $s1 -> return value for bool isPerfect(int k); bool prime_num(1)
# $s2 -> return value for bool isPerfect(int s); bool prime_num(int x)
# $s3 -> int x;return value for int sqrt(int k)
# $s4 -> int l;return value for int sqrt(int s)
#========================================================================================

	li $t0, 0									#int count = 0
	li $a1, 1									#int k = 1
	
	while:
		beqz $a1, stop								#if k < 0, stop loop
		
		addi $sp, $sp, -8							#Allocate memory in the stack for 2 registers
		sw $t0, 0($sp)								#Store the t register
		sw $a1, 4($sp)								#Store the a register		
			jal reverse									#Call the reverse procedure; argument == int k
			add $s0, $v1, $zero							#Move the return value to $s0
		lw $a1, 4($sp)								#Load the a register
		lw $t0, 0($sp)								#load the t register
		addi $sp, $sp, 8							#Deallocate memory in the stack
		
		addi $sp, $sp, -8							#Allocate memory in the stack for 2 registers
		sw $t0, 0($sp)								#Store the t register
		sw $a1, 4($sp)								#Store the a register
			jal isPerfect								#Call the isPerfect procedure; argument == int k
			add $s1, $v1, $zero							#Move the return value to $s1
		lw $a1, 4($sp)								#Load the a register
		lw $t0, 0($sp)								#Load the t register
		addi $sp, $sp, 8							#Deallocate memory in the stack
		
		addi $sp, $sp, -8							#Allocate memory in the stack for 2 registers
		sw $t0, 0($sp)								#Store the t register
		sw $a1, 4($sp)								#Store the a register
			addi $a1, $zero, 0							#Clear the register
			add $a1, $s0, $zero							#Set the $s0, as isPerfect argument for this call
			jal isPerfect								#Call the isPerfect procedure; argument == int s
			add $s1, $v1, $zero							#Move the return value to $s1
		lw $a1, 4($sp)								#Load the a register
		lw $t0, 0($sp)								#Load the t register
		addi $sp, $sp, 8							#Deallocate memory in the stack
		
		while_1:
			beqz $s1, stop_1							#If isPerfect == false(0), stop loop
			beqz $s2, stop_1							#If isPerfect == false(0), stop loop
			
			li $v0, 1
			addi $a0, 5
			syscall
		
			addi $sp, $sp, -8							#Allocate memory in the stack for 2 registers
			sw $t0, 0($sp)								#Store the t register
			sw $a1, 4($sp)								#Store the a register
				jal sqrt									#Call the sqrt procedure; argument == int k
				add $s3, $v1, $zero							#Move the return value to $s3
			lw $a1, 4($sp)								#Load the a register
			lw $t0, 0($sp)								#Load the t register
			addi $sp, $sp, 8							#Deallocate memory in the stack
		
			addi $sp, $sp, -8							#Allocate memory in the stack for 2 registers
			sw $t0, 0($sp)								#Store the t register
			sw $a1, 4($sp)								#Store the a register
				addi $a1, $zero, 0							#Clear the register
				add $a1, $s0, $zero							#Set the $s0, as argument
				jal sqrt									#Call the sqrt procedure; argument == int s
				add $s4, $v1, $zero							#Move the return value to $s4
			lw $a1, 4($sp)								#Load the a register
			lw $t0, 0($sp)								#Load the t register
			addi $sp, $sp, 8							#Deallocate memory in the stack
			
			addi $sp, $sp, -8							#Allocate memory in the stack for 2 registers
			sw $t0, 0($sp)								#Store the t register
			sw $a1, 4($sp)								#Store the a register
				addi $a2, $zero, 1							#Set 1, as our argument
					addi $sp, $sp, -4							#Allocate memory in the stack for 1 register
					sw $a2, 0($sp)								#Store the a register
						jal prime_num								#Call the prime_num procedure; argument == 1
					lw $a2, 0($sp)								#Load the a register
					addi $sp, $sp, 4							#Deallocate memory in the stack
				add $s1, $v1, $zero								#Move the return value in $s1
			lw $a1, 4($sp)								#Load the a register
			lw $t0, 0($sp)								#Load the t register
			addi $sp, $sp, 8							#Deallocate memory in the stack
		
			addi $sp, $sp, -12							#Allocate memory in the stack for 3 registers
			sw $t0, 0($sp)								#Store the t register
			sw $a1, 4($sp)								#Store the a register
			sw $a2, 8($sp)
				addi $a2, $zero, 0
				add $a2, $s3, $zero								#Set $s3, as our argument
				jal prime_num								#Call the prime_num procedure; argument == int x
				add $s2, $v1, $zero								#Move the return value to $s2
			lw $a2, 8($sp)
			lw $a1, 4($sp)								#Load the a register
			lw $t0, 0($sp)								#Load the t register
			addi $sp, $sp, 12							#Deallocate memory in the stack
		
			while_2:
				beqz $s2, stop_2						#if prime_num(x) == 0; stop loop
				beqz $s1, stop_2						#if prime_num(1) == 0; stop loop
				
				addi $sp, $sp, -12						#Allocate memory for 3 registers in the stack
				sw $t0, 0($sp)							#Store the t register
				sw $a1, 4($sp)							#Store the a register
				sw $a2, 8($sp)							
					jal not_palindrome						#Call the not_palindrome procedure; argument == int k
				lw $a2, 8($sp)
				lw $a1, 4($sp)							#Load the a register
				lw $t0, 0($sp)							#Load the t register
				
				while_3:
					beqz $v1, stop_3						#If not_palindrome(k) == false(0); stop loop
					
					li $v0, 1
					add $a0, $a1, $zero						
					syscall
					
					li $v0, 4
					la $a0, newLine							#printf("%d\n", k)
					syscall
					
					add $t0, $t0, 1							#count++
					
					beq $t0, $t1, stop						#if count == 10; break loop
				stop_3:
			stop_2:
		stop_1:
		
		addi $a1, $a1, 1							#k++
		
		j while
	stop:

	li $v0, 10
	syscall

# A L L  T H E  P R O C E D U R E S  I N  T H E  P R O G R A M
#======================================================================================================================
# R E G I S T E R - V A R I A B L E  M A P P I N G
# $a1 -> int num; argument for procedure
# $v1 -> int Reverse
# $t1 -> int r
# $t2 -> const 10
#======================================================================================================================
reverse:
#This procedure is a Callee by main and not_palindrome procedure; store the s register
	li $v1, 0										#int Reverse = 0
	li $t1, 0										#int r = 0
	li $t2, 10										#const 10
	
	while_reverse:
		beqz $a1, stop_reverse						#if int num == 0; stop loop
		
		div $a1, $t2
		mfhi $t1									#num%10
		
		mult $v1, $t2
		mflo $t3 									#reverse * 10
		
		add $v1, $t3, $t1							#reverse = (reverse*10) + r
		
		div $a1, $t2
		mflo $a1									#num = num/10
		
		j while_reverse
	stop_reverse:
	
	jr $ra
	
#======================================================================================================================
# R E G I S T E R - V A R I A B L E  M A P P I N G
# $a2 -> int num; argument for the procedure
# $v1 -> bool isPrime
# $t0 -> int i
# $t2 -> num % i
#======================================================================================================================
prime_num:
#This procedure is a Callee by main procedure; store the s register
	li $v1, 0										#bool isPrime = false
	li $t0, 2										#int i = 2
	
	while_prime_num:
		bgt $t0, $a2, stop_prime_num				#if int i > num; stop loop
		
		div $a2, $t0
		mfhi $t2									#num % i
		
		li $v1, 0									#Set isPrime = false(0)
		beqz $t2, stop_prime_num					#if (num%i == 0); stop loop
		li $v1, 1									#Set isprime = true(0)
		
		addi $t0, $t0, 1							#i++
		
		j while_prime_num
	stop_prime_num:

	jr $ra
	
#======================================================================================================================
# R E G I S T E R - V A R I A B L E  M A P P I N G
# $a1 -> int num; argument for the procedure
# $v1 -> return value
# $t0 -> int i
# $t1 -> i * i
# $t2 -> num % i
# $t3 -> num / i
# $t4 -> slt; true(1), false(0)
#======================================================================================================================
isPerfect:
#This procedure is a Callee by main procedure; store the s register
	li $t0, 1										#int i = 1
	li $v1, 0										#bool isPerfect = false(0)
	
	while_isPerfect:
		mult $t0, $t0
		mflo $t1										#i * i
	
		slt $t4, $a1, $t1								#if i*i > num; stop loop
			bnez $t4, stop_isPerfect
		
		div $a1, $t0
		mfhi $t2										#num % i
		mflo $t3										#num / i
		
		if_isPerfect:
			bnez $t2, skip_isPerfect						#if num % i != 0, skip
			bne $t3, $t0, skip_isPerfect					#if num / i != 1, skip
			
			
			li $v1, 1										#bool isPerfect = true(1)
		skip_isPerfect:
		
		addi $t0, $t0, 1								#i++
		
		j while_isPerfect
	stop_isPerfect:
	
	jr $ra
	
#======================================================================================================================
# R E G I S T E R - V A R I A B L E  M A P P I N G
# $a1 -> int num; argument for procedure and reverse procedure 
# $t0 -> reverse, return value
#======================================================================================================================
not_palindrome:
#This procedure is a Callee by main procedure; store the s and ra register 
#This procedure is a Caller to reverse procedure; store the t, a and v register
	addi $sp, $sp, -4									#Allocate memory in the stack for one register
	sw $ra, 0($sp)										#Store the ra register
	
	addi $sp, $sp, -4									#Allocate memory in the stack for one register
	sw $a1, 0($sp)										#Store the a register
		jal reverse											#Call the reverse procedure; argument int num
		move $t0, $v1										#Move return to $t0
	lw $a1, 0($sp)										#Load the a register
	addi $sp, $sp, 4									#Deallocate memory in the stack
	
	li $v1, 1											#bool not_palindrome = true(1)
	if_not_palindrome:
		bne $t0, $a1, skip_not_palindrome					#if num != reverse(num); skip
	
		li $v1, 0											#bool not_palindrome = false(0)
	skip_not_palindrome:	
	
	lw $ra, 0($sp)										#Load the ra register
	addi $sp, $sp, 4									#Deallocate memory in the stack
	
	jr $ra
	
#======================================================================================================================
# R E G I S T E R - V A R I A B L E  M A P P I N G
# $a1 -> int num; argument for procedure and reverse procedure 
# $t0 -> int i
# $t1 -> num%i
# $t2 -> num/i
#======================================================================================================================
sqrt:
#This procedure is a Callee by main procedure; store the s register
	li $t0, 1											#int i = 1
	li $v1, 0											#Set the perfect square root to 0
	
	while_sqrt:
		beq $t0, $a1, stop_sqrt								#if int num = i; stop loop
		
		div $a1, $t0
		mfhi $t1											#num%i
		mflo $t2											#num/i
		 
		if_while_sqrt:
			bnez $t1, skip_sqrt									#if num%i != 0; skip
			bne $t1, $t0, skip_sqrt								#if n/i != i; skip
		
			add $v1, $t0, $zero									#Return value
		skip_sqrt:
		
		addi $t0, $t0, 1									#i++
		
		j while_sqrt
	stop_sqrt:
	
	jr $ra