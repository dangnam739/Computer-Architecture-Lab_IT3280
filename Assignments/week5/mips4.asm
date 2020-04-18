.text
start:
	addi	$s1, $zero, 0x80000001
	addi	$s2, $zero, 0x80000fff
	li 	$t0, 0 		#No Overflow is default status
	addu 	$s3, $s1, $s2 	# s3 = s1 + s2
	xor 	$t1, $s1, $s2 	#Test if $s1 and $s2 have the same sign
	bltz 	$t1, EXIT 	#If not, exit
	
	xor 	$t2, $s3, $s1	#Test if $s3 and $s1 have the same sign
	bltz	$t2, OVERFLOW	# if s3, s1 no same sign -> overflow
	j 	EXIT		# if not -> exit

OVERFLOW:
	li 	$t0, 1 		#the result is overflow
EXIT:

