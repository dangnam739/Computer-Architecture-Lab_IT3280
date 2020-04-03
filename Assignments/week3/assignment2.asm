.data
A:	.word	3,2,0,1,5

.text
	addi 	$s1, $zero, 0 	# i
	la 	$s2, A		# A
	addi 	$s3, $zero, 5	# n
	addi 	$s4, $zero, 1	# step 
	addi	$s5, $zero, 0	# sum
	
loop:
	slt 	$t2, $s3, $s1
	bne	$t2, $zero, endloop
	add	$t1, $s1, $s1
	add	$t1, $t1, $t1
	add	$t1, $t1, $s2
	lw	$t0, 0($t1)	
	beq	$t0, $zero, endloop # ss t0 ( A[i] == 0 ? endloop : cont)
	add	$s5, $s5, $t0
	add	$s1, $s1, $s4
	j	loop
endloop:




	
	
	