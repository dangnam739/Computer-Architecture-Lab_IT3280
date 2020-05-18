.data
Message:	.asciiz "Number: "
Message1:	.asciiz "Lucky"
Message2:	.asciiz "Not lucky"
Message3:	.asciiz "The end"
.text
	li	$v0, 51
	la 	$a0, Message
	beq 	$a1, -1, Done		# Validate input value
	syscall
init:	
	add	$t0, $zero, $a0		# input value n
	
#------------------------------
# Loop: Calculate the number of characters saved in $t3
#------------------------------	
main:	
	add	$s1,$t0, $zero		# The variable temporarily stores the value of n
	addi	$s2, $zero, 10		# the dividend = 10
	jal 	countCharacter		# $t3 = number of character
	nop
			
	addi	$s3, $zero, 2		
	divu	$t3, $s3		
	mfhi	$t1
	mflo	$t6			# $t6: number of characters on each side
	bne	$t1, $zero, Done	# check number of character is even ?
	
	jal	totalOneSide
	add	$t5,$t2,$zero		# right value
	add	$t2, $zero,$zero
	
	jal	totalOneSide
	add	$t4,$t2, $zero		# left value
	
	sub	$t6, $t4, $t5		# if (left - right) == 0 ?
	beq	$t6, $zero, print1	
	j	print2
#------------------------------
# Count number of character
#------------------------------
countCharacter:			
Loop:	
	divu	$s1,$s2 		# n / 10
	mflo	$a1			# The result is saved to $a1
	add	$s1,$zero, $a1		# Update the value to n
	add	$t3, $t3, 1		# Increase count variable to 1
	bne	$a1, $zero, Loop	# if result = 0 exit loop
	jr	$ra
end_count:

#------------------------------
# Total one side
#------------------------------
totalOneSide:	
	add	$a2, $zero, $zero	# bien dem 
loop:	
	divu	$t0, $s2		# n / 10
	mflo	$a1			# result
	mfhi	$t1			# surplus	
	add	$t0, $zero, $a1		# update n
	add	$t2, $t2, $t1		# sum = sum + surplus
	addi	$a2, $a2, 1		# count
	slt	$s4, $a2, $t6		# the variable count = (total character) / 2 ?
	bne	$s4, $zero, loop
	jr	$ra		
#------------------------------
# Print mesage
#------------------------------
print1:
	li	$v0, 4
	la	$a0, Message1
	syscall
	li	$v0, 10
	syscall	
	
print2:
	li	$v0, 4
	la	$a0, Message2
	syscall	
	li	$v0, 10
	syscall	

Done:	
	li	$v0, 4
	la	$a0, Message3
	syscall
	li	$v0, 10
	syscall	