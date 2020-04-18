#Laboratory Exercise 6, Assignment 1
.data
A:	.word	1, 5, -4, 3, -6, 2, 7

.text
main:
	la	$a0, A  	#address of A[0]
	li	$a1, 7	#number of element in A
	j	mspfx
	nop
continue:
lock:
	j	lock
	nop
end_of_main:

#-----------------------------------------------------------------
#Procedure mspfx
# @brief find the maximum-sum prefix in a list of integers
# @param[in] a0 the base address of this list(A) need to be processed
# @param[in] a1 the number of elements in list(A)
# @param[out] v0 the length of sub-array of A in which max sum reachs.
# @param[out] v1 the max sum of a certain sub-array
#-----------------------------------------------------------------
#Procedure mspfx
#function: find the maximum-sum prefix in a list of integers
#the base address of this list(A) in $a0 and the number of
#elements is stored in a1

mspfx:
	addi	$v0, $zero, 0	#init length of sub-array in $v0 to 0
	addi	$v1, $zero, 0	#init max sum of sub-array in $v1 to 0
	addi	$t0, $zero, 0	#init index i in $t0 to 0	  
	addi 	$t1, $zero, 0	#init running sum in $t1 to 0
loop:
	add 	$t2, $t0, $t0	
	add	$t2, $t2, $t2	#put 4i in $t2
	add 	$t3, $t2, $a0 	#put 4i + A = Adress og A[i] in $t3
	lw 	$t4, 0($t3)	#load A[i] value from address $t3 into $t4
	add	$t1, $t1, $t4	#update sum = sum + A[i]
	slt	$t5, $v1, $t1	#compare sum and sum + A[i]
	bne	$t5, $zero, mdfy	#if max sum is less, modify result
	j	test		#done ?
mdfy:
	addi	$v0, $t0, 1	#update new leng = new index + 1
	addi	$v1, $t1, 0	#update new max sum
test:
	addi	$t0, $t0, 1	#advanxe the index i
	slt	$t5, $t0, $a1	#compare i != no. element
	bne	$t5, $zero, loop	#repeat if i < n
done:
	j	continue
mspfx_end:
