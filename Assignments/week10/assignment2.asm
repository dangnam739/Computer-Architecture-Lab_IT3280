#Laboratory Exercise 10, Assignment 2
.eqv 	MONITOR_SCREEN 	0x10010000
.eqv 	RED 		0x00FF0000

.text
	li 	$k0, MONITOR_SCREEN
	
	addi	$t0, $zero, 1584		#$t0 = i = 1584 = (12*32 + 12)*4
					#start point of start row)
	addi	$t5, $zero, 2608		#$t5 =  2608 = (20*32 + 12)*4
					#end point of end row
draw:
	addi	$t4, $t0, 32		#t4 = i + 32 : start point of row
	add	$t1, $zero, $t0		#t1 = j = i
draw_row:
	add	$t2, $k0, $t1		#address of k[j]
	li 	$t3, RED			#draw for address j
	sw	$t3, ($t2) 
	add	$t1, $t1, 4		#j = j+ 4 
	beq	$t1, $t4, end_of_draw_row 
	j	draw_row
end_of_draw_row:
	addi	$t0, $t0, 128		#i = start point of next row	
	beq	$t0, $t5, end_of_draw	
	j	draw
end_of_draw:
	
	