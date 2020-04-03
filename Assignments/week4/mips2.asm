.text
	li 	$s0, 0x12345678 		#load test value for these function
	andi 	$t1, $s0, 0xff000000 	#Extract the MSB of $s0
	andi	$t2, $s0, 0xffffff00	#Clear LSB of $s0
	ori 	$t3, $s0, 0xff		#Set LSB of $s0
	xor	$t4, $s0, $s0		#Clear $s0
	
