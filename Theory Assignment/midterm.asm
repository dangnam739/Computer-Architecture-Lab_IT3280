.text
	#Ex1
	la	$s6, 0x10018000
	lui 	$s0, 0x8B9D
	ori	$s0, $s0, 0xA785
	addi	$s1, $0, 83
	sw	$s0, 0($s6)
	lhu	$s1, 2($s0)

	
	#Ex2
	add	$t0, $zero, 0x55555555
	add	$t1, $zero, 0x003F0000
	srl 	$t2, $t0, 5
	or 	$t3, $t2, $t1
	

