#Laboratory Exercise 6, Assignment 3 - Home Assignment 2
.data
A: 	.word 	10, -2, 5, 1, -5, 6, 0 , 3, 6, 8, 8, 48, 9
Aend: 	.word

.text
main: 	la 	$a0,A 		#$a0 = Address(A[0])
	la 	$a1,Aend
	addi 	$a1,$a1,-4 	#$a1 = Address(A[n-1]) 
	j 	sort 		#sort
after_sort: 	
	li 	$v0, 10 		#exit
	syscall
end_main:

sort: 		
	beq 	$a0,$a1,done 	#single element list is sorted
	j 	max 		#call the max procedure
after_loop: 	
	addi 	$a1,$a1,-4 	#decrement pointer to last element
	j 	sort 		#repeat sort for smaller list
done: 		
	j 	after_sort
max:
	addi 	$t0,$a0,0 	#init pointer to first
loop:
	beq 	$t0,$a1,after_loop 	#if j = last or n - i -1, return
	addi 	$t1,$t0,0 	# init j 
	addi 	$t0,$t0,4	# init j + 1
	lw 	$t3,0($t1) 	#load j element into $t3
	lw 	$t4,0($t0) 	#load j+1 element into $t4
	slt 	$t5,$t4,$t3 	#(A[j+1])<(A[j]) ?
	bne 	$t5,$zero,swap 	#if A[j+1])<(A[j]), repeat
	j 	loop 		#if not, repeat
swap:
	sw 	$t3,0($t0)
	sw 	$t4,0($t1)
	j 	loop




