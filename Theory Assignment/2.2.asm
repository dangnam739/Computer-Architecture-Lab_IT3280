.data
A:	.word	1, 5, 4, 3, 6, 2, 7
B:	.word	1, 2, 3, 4, 5, 6, 8, 9, 10

.text
	la	$s6, A  	#address of A[0]
	la	$s7, B	#address of B[0]
	la	$s3, 3
	la	$s4, 1
	
	
	sub	$t3, $s3, $s4	#$t3 = $s3 - $s4 = i – j
	sll	$t2, $t3, 2	#$t2 = 4 * $t3
	add	$t1, $t2, $s6	# $t1 = address of A[i-j]
	lw	$t0, 0($t1)	# $t0 = A[i-j] 	 	
	sw	$t0, 32($s7)	# B[8] = A[i-j]

