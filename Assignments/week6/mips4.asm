.data
A: 	.word 	10, -2, 5, 1, -5, 6, 0 , 3, 6, 8, 8, 48, 9
Aend: 	.word

.text
main: 		
	la 	$a0,A 		#$a0 = Address(A[0])
	la 	$a1,Aend 	#address A[n]
	addi 	$a2,$a0,4	#$a2 = i = A[1]  cuz i run from 1
	j 	sort 		#sort
after_sort: 	
	li 	$v0, 10 		#exit
	syscall
end_main:
	
sort: 		
	beq 	$a2,$a1,done 	# i = n ? or i > n - 1 ( that why we use Aend not Aend -4)
	j 	loop 		#call the loop procedure
after_loop: 	
	addi 	$a2,$a2,4	#increment pointer of i
	j 	sort		#repeat sort
done: 		
	j 	after_sort
loop:		
	addi 	$t0,$a2,-4 	#j = i -1
	lw 	$t1,0($a2)	# $t1 = key = A[i]
condition1:
	slt 	$t2,$t0,$a0	# j < 0 ? 1:0 or j is before the first element
	bne 	$t2,$0,ret
condition2:	
	lw 	$t3,0($t0)	#$t3 = A[j]
	slt 	$t2,$t1,$t3 	#key < A[j]
	beq 	$t2,$0,ret	# if not, ret
	sw 	$t3,4($t0)	# A[j+1] = A[j]
	addi 	$t0,$t0,-4	# j = j -1
	j 	condition1 	#repeat while loop
ret:
	sw 	$t1,4($t0)	# A[j+1] = key
	j 	after_loop

