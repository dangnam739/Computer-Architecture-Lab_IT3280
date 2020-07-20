#sum = $s4; i=$s0; n=$a0; result=$v0; 
.data
M:	.word	1, 5, -4, -3, 6, -2, 7

.text
	la	$s0, M 	#address of A[0]
	li      $s5, 7 
	addi	$s1, $0, 0  
	addi	$s2, $0, 0 
loop: 
	slt	$t0, $s1, $s5
	beq	$t0, $0, finish
	sll	$t1, $s1, 2
	add	$s3, $s0, $t1
	lw	$s4, 0($s3)
	addi	$s1, $s1, 1
	
	slt	$t2, $s4, $0 
	beq	$t2, $0, loop 
	add	$s2, $s2, $s4 
	j	loop 
finish: 
	add	$v0, $s2, $0 