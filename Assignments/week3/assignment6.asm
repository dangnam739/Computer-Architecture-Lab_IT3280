.data
	A:	.word	10, 7, -6, -5, 0
.text
	la 		$s0, A			# Load A to $s0
	addi		$s1, $zero, 0		# Initialize i = 0
	addi		$s2, $zero, 0		# Initialize max = 0
	addi		$s3, $zero, 5		# Initialize n = 5
loop:
	slt		$t2, $s1, $s3		# $t2 = i < n ? 1 : 0
	beq		$t2, $zero, endloop
	add		$t1, $s1, $s1		# $t1 = 2 * $s1
	add		$t1, $t1, $t1		# $t1 = 4 * $s1
	add		$t1, $t1, $s0		# $t1 store address of A[i]
	lw		$t0, 0($t1)		# $t0 = A[i]
ifLess:
	sle 		$t2, $zero, $t0		# $t2 = 0 <= A[i] ? 1 : 0
	bne		$t2, $zero, ifGreat
	sub		$t0, $zero, $t0		# $t0 = 0 - $t0
ifGreat:	
	slt		$t2, $t0, $s2		# $t2 = A[i] < max ? 1 : 0
	bne		$t2, $zero, endif
	add		$s2, $t0, $zero		# max = A[i]
endif:
	addi		$s1, $s1, 1		# i += 1
	j		loop
endloop:



