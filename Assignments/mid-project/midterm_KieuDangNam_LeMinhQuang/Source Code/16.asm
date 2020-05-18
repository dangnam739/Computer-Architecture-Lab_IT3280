#Mid-Exam, Problem 16
#Author: Kieu Dang Nam_20176830

.data		
Message1:	.ascii	"Enter a string which consists of lower alphabetic characters (a-z): "	
str:		.space	50
Message2:	.ascii	"Number of different character is: "

.text
main:
	jal	get_string		#jump and link to get_string procedure
		
	la	$a0, str			#$a0 = address str[0]
	add	$t0, $zero, $zero	#$t0 = count = 0
	add	$t1, $zero, $zero	#$t1 = i = 0
	addi	$s1, $zero, 10		#Ascii code of Enter (end of string)
	
	jal 	countCharacter		#jump and link to countCharacter procedure
endmain:

#------------------------------------------------------------------------------------
#Procedure get_string: a dialog to enter a input string
#------------------------------------------------------------------------------------
get_string:
	li	$v0, 54			#Input Dialog String
	la	$a0, Message1		#$a0 = address of Message1
	la	$a1, str			#$a1 = address of input buffer
	la	$a2, 50			#$a2 = maximun of number characters to read	
	syscall
	jr	$ra
#------------------------------------------------------------------------------------
#Procedure countCharacter: check character and accsend accsend the counter and print 
#                          the number of different character in a string.
#------------------------------------------------------------------------------------
countCharacter:
	add	$t2, $a0, $t1		#$t2 = $a0 + $t1 = address of str[i]
	lb	$t3, 0($t2)		#$t3 = str[i]
	beq	$t3, $s1, print_result	#is 'enter' char ?
					#if str[i] != Enter (end of string in a dialog)
	jal 	check_diff
	nop
	
	bne	$s0, $zero, next_char	#$s0 != 0 -> jump to next_char
	addi	$t0, $t0, 1		#$t0 = $t0 + 1 -> count = count + 1	
	addi	$t1, $t1, 1		#$t1 = $t1 + 1 -> i = i + 1
	j	countCharacter
next_char:
	addi	$t1, $t1, 1		#$t1 = $t1 + 1 -> i = i + 1
	j	countCharacter
print_result:
	li	$v0, 56
	la	$a0, Message2
	add	$a1, $zero, $t0
	syscall
	li 	$v0, 10			#exit 
	syscall	
end_count:
	
		

#------------------------------------------------------------------------------------
#Procedure check_diff: check character is counted or not
#------------------------------------------------------------------------------------
check_diff:
	add	$s0, $zero, $zero	#number of exist character str[i] = 0
	add	$t4, $zero, $zero	#$t4 = j = 0
for:
	beq	$t4, $t1, end_of_for	#if j = i ? end_of_for
	add	$t5, $a0, $t4		#$t5 = address of str[j]	
	lb	$t6, 0($t5)		#$t6 = str[j]
	bne	$t6, $t3, continue_for	#str[j] = str[i] ? s0= s0 + 1 : contine_for 
	addi	$s0, $s0, 1		#$s0 = $s0 + 1
	addi	$t4, $t4, 1		# j = j + 1
	j	for	
continue_for:
	addi	$t4, $t4, 1		# j = j + 1
	j	for
end_of_for:
	jr	$ra
end_check:	
