.data
x:	.word 	1
y:	.word 	2
z:	.word	3

.text
	addi 	$s1, $zero, 2	# i
	addi	$s2, $zero, 1	# j
	la	$t7, x
	la	$t8, y
	la	$t9, z
	lw	$t1, 0($t7)
	lw	$t2, 0($t8)
	lw	$t3, 0($t9)

start:
	slt 	$t0, $s2, $s1
	bne  	$t0, $zero, else
	addi 	$t1, $t1, 1
	addi 	$t3, $zero, 1
	j	endif
else:
	addi	$t2, $t2, -1
	add 	$t3, $t3, $t3
endif: 
	