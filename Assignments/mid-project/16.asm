#Mid-Exam, Problem 16
#Author: Kieu Dang Nam_20176830

.data
str:		.space	50		
Message1:	.ascii	"Enter a string which consists of lower alphabetic characters (a-z): "	
Message2:	.ascii	"Number of different character is: "


.text
main:
	add	$t0, $zero, $zero	#$t0 = count = 0
	add	$t1, $zero, $zero	#$t1 = i = 0
	addi	$s1, $zero, 10		#Ascii code of Enter (end of string)
	
	
	jal	get_string		#jump and link to get_string procedure
		
	la	$a0, str			#$a0 = address str[0]	
	
	jal 	countCharacter		#jump and link to countCharacter procedure
endmain:

#------------------------------------------------------------------------------------
#Procedure get_string: a dialog to enter a input string
#------------------------------------------------------------------------------------
get_string:
input:
	li	$v0, 54			#Input Dialog String
	la	$a0, Message1		#$a0 = address of Message1
	la	$a1, str			#$a1 = address of input buffer
	la	$a2, 50			#$a2 = maximun of number characters to read	
	syscall
	
	la	$a0, str	
	
	jal	check_input
	beq	$s0, $zero, end_get_string
	j	input		
end_get_string:
	jr	$ra
#------------------------------------------------------------------------------------
#Procedure check_input: check string is all 
#------------------------------------------------------------------------------------
check_input:
	addi	$s2, $zero, 97		#ascii for 'a'
	addi	$s3, $zero, 122		#ascii for 'z'
	add	$s0, $zero, $zero	#check error input or not ?
	add	$t4, $zero, $zero	#$t4 = j = 0
input_for:		
	add	$t2, $a0, $t4		#$t2 = $a0 + $t1 = address of str[j]
	lb	$t3, 0($t2)		#$t3 = str[i]
	beq	$t3, $s1, end_check_input 	#is 'enter' char ?
	slt	$s4, $t3, $s2		#str[j] < 'a' ?
	bgtz	$s4, set_s0		 
	
	slt	$s4, $s3, $t3		#str[j] > 122
	bgtz	$s4, set_s0 
	
	addi	$t4, $t4, 1
	j	input_for	
set_s0:
	addi	$s0, $zero, 1
	j	end_check_input
end_check_input:
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
