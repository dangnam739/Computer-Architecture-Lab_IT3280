.data
Message:	.asciiz "Ko chia dc cho 0"

.eqv IN_ADRESS_HEXA_KEYBOARD 0xFFFF0012
.eqv OUT_ADRESS_HEXA_KEYBOARD 0xFFFF0014 
.eqv SEVENSEG_RIGHT 	0xFFFF0010 	# dia chi den LED phai
.eqv SEVENSEG_LEFT	0xFFFF0011 	# dia chi den LED trai

.text
main: 

	li $t1, IN_ADRESS_HEXA_KEYBOARD
 	li $t2, OUT_ADRESS_HEXA_KEYBOARD
	li $t3, 0x08 		# duyet hang chua phim C, D, E, F
	li $t4, 0x01 		# duyet hang chua phim 0,1,2,3
	li $t5, 0x02 		# duyet hang chua phim 4,5,6,7
	li $t6, 0x04 		# duyet hang chua phim 8, 9, A, B
	
	li $s0, 0x3f 		# Ma hien thi hang don vi
	li $a1, 0x3f 		# Ma hien thi hang chuc
polling: 
	sb $t3, 0($t1 ) 		# Quét hàng C, D, E, F
 	lbu $t0, 0($t2) 		# $t0: ma phim quet duoc. $t0=0 neu ko có phím nào duoc an
 	bnez $t0, checkButton 	
 	nop
 	sb $t4, 0($t1 ) 		# Quét hàng 0,1,2,3
 	lbu $t0, 0($t2) 
 	bnez $t0, checkButton
 	nop 	
 	sb $t5, 0($t1 ) 		# Quét hàng 4,5,6,7
 	lbu $t0, 0($t2) 
 	bnez $t0, checkButton 
 	nop	
 	sb $t6, 0($t1 ) 		# Quét hàng 8, 9, A, B
 	lbu $t0, 0($t2) 
checkButton: 	
	beq $t0, 0x00, free 		# Ko an phím nào
	beq $t0, 0x11, button0		# An phím 0
	beq $t0, 0x21, button1		# An phím 1
	beq $t0, 0x41, button2		# An phím 2
	beq $t0, 0x81, button3		# An phím 3
	beq $t0, 0x12, button4		# An phím 4
	beq $t0, 0x22, button5		# An phím 5
	beq $t0, 0x42, button6		# An phím 6
	beq $t0, 0x82, button7		# An phím 7
	beq $t0, 0x14, button8		# An phím 8
	beq $t0, 0x24, button9		# An phím 9
	beq $t0, 0x44, buttonA		# An phím A
	beq $t0, 0x84, buttonB		# An phím B
	beq $t0, 0x18, buttonC		# An phím C
	beq $t0, 0x28, buttonD		# An phím D
	beq $t0, 0x88, buttonF		# An phím F
	nop
button0:	
	li $a0, 0x3f		# Nap ma hien thi so 0 vao $a0
	li $s2, 0		# $s2: luu gia tri phim duoc an
	j processButton	
button1:	
	li $a0, 0x06		# Nap ma hien thi so 1 vao $a0
	li $s2, 1
	j processButton
button2:	
	li $a0, 0x5B		# Nap ma hien thi so 2 vao $a0
	li $s2, 2
	j processButton
button3:	
	li $a0, 0x4f		# Nap ma hien thi so 3 vao $a0
	li $s2, 3
	j processButton
button4:	
	li $a0, 0x66		# Nap ma hien thi so 4 vao $a0
	li $s2, 4
	j processButton
button5:	
	li $a0, 0x6D		# Nap ma hien thi so 5 vao $a0
	li $s2, 5
	j processButton
button6:	
	li $a0, 0x7d		# Nap ma hien thi so 6 vao $a0
	li $s2, 6
	j processButton
button7:	
	li $a0, 0x07		# Nap ma hien thi so 7 vao $a0
	li $s2, 7
	j processButton
button8:	
	li $a0, 0x7f		# Nap ma hien thi so 8 vao $a0
	li $s2, 8
	j processButton
button9:	
	li $a0, 0x6f		# Nap ma hien thi so 9 vao $a0
	li $s2, 9
	j processButton
buttonA:
	li $t7, '+'		# Gán $t7 phep tinh cong
	j processMath		# Nhay xuong phan xu ly khi phep tinh duoc bam
buttonB:	
	li $t7, '-'		# Phép tru
	j processMath
buttonC:
	li $t7, '*'		# Phép nhân
	j processMath
buttonD:	
	li $t7, '/'		# Phép chia
	j processMath
buttonF:	
	j result		# Neu an dau =
 
free:	
 	move $a0, $s0		# Chuyen Ma phim ve lai $a0
	li $s1, 0		# Dat den bao = 0, phim da duoc tha ra
	j showNumber		# Chuyen den phan hien thi
processButton:
 	bnez $s1, showNumber	# Kiem tra trang thai cua phim
	move $a1, $s0		# Chuyen ma hien thi sang hang chuc
	bnez $s4, secondNumber	# Neu la toan hang thu 2 chuyen den xu ly toan hang 2
	mul $s3, $s3, 10	# Xu ly toan hang 1
	add $s3, $s3, $s2	# $s3 luu gia tri so hang thu nhat
	j printInt
secondNumber:		
	mul $s5, $s5, 10	# Xu ly toan hang 2
	add $s5, $s5, $s2	# $s5 luu gia tri so hang thu 2
		
printInt:	
	move $a0, $s2		#
	li $v0, 1		#
	syscall			# In so vua nhan ra console
	j isOldNumber
processMath:	
 	li $a0, 0x3f		# Dat lai ma hien thi so 0
 	li $a1, 0x3f 		# 
 	bnez $s1, isOldNumber	# Kiem tra co phim moi duoc bam chua
 	move $a0, $t7		#
 	li $v0, 11		#
 	syscall			# Hien thi phep tinh len man hinh console
 	li $s2, 0		# Dat $s2 (gia tri phim bam hien tai) ve 0
 	li $s4, 1		# $s4 = 1, Xu ly Toan hang thu 2
isOldNumber:	
	li $s1, 1		# gan $s1 = 1 : Chua co phim moi duoc bam	
	
showNumber:	
	move $s0, $a0		# Luu lai gia tri ma hien thi hang don vi
 	jal SHOW_LED_RIGHT 	
 	jal SHOW_LED_LEFT 	
delay: 
 	li $a0, 100 		# sleep 100ms
 	li $v0, 32
	syscall
	nop
back_to_polling: 
	j polling 		
result:
	li $v0, 11
	li $a0, '='
	syscall 		#In ra dau bang ra man hinh van ban
	
	beq $t7, '+', add	# Neu la dau cong, chuyen den phan xu ly phep cong
	beq $t7, '-', sub	# Neu la dau tru, chuyen den phan xu ly phep tru
	beq $t7, '*', mul	# Neu la dau nhan, chuyen den phan xu ly phep nhan
	beq $t7, '/', div	# Neu la dau chia, chuyen den phan xu ly phep chia
add:	add $a0, $s3, $s5	# Cong hai so hang
	j showResult		# chuyen den phan hien thi ket qua
sub:	sub $a0, $s3, $s5
	j showResult
mul:	mul $a0, $s3, $s5
	j showResult
div:	beq $s5, 0 , printMessage
	div $a0, $s3, $s5

showResult:
	li $v0, 1
	syscall			# In ket qua ra console (Ket qua tinh duoc luu o $a0)
	div $s7, $a0, 10	# $s7 = ketqua($a0) chia 10 
	mfhi $t0		# Lay so du khi chia ket qua cho 10 (Hang don vi)
	jal DATA_FOR_LED	# Chuyen gia tri don vi cua ket qua sang ma hien thi cua LED
	move $s0, $a0		# Luu ma hien thi vao $s0
	div $s7, $s7, 10	# Chia $s7 cho 10
	mfhi $t0		# Lay so du (Chinh la hang chuc cua ket qua)
	jal DATA_FOR_LED	# Chuyen gia tri hang chuc cua ket qua sang ma hien thi cua LED
	move $a1, $a0		# Gan ma hien thi hang chuc cho $a1
	
	jal SHOW_LED_RIGHT 	# show LED phai
 	jal SHOW_LED_LEFT  	# Show LED trai
 	li $v0, 10		
 	syscall			# Ket thuc chuong trinh

#---------------------------------------------------------------

#---------------------------------------------------------------
SHOW_LED_RIGHT: 
 	sb $s0, SEVENSEG_RIGHT # assign new value
 	jr $ra
SHOW_LED_LEFT:
 	sb $a1, SEVENSEG_LEFT # assign new value
 	jr $ra
DATA_FOR_LED:
	beq $t0, 0, setNumber0
	beq $t0, 1, setNumber1
	beq $t0, 2, setNumber2
	beq $t0, 3, setNumber3
	beq $t0, 4, setNumber4
	beq $t0, 5, setNumber5
	beq $t0, 6, setNumber6
	beq $t0, 7, setNumber7
	beq $t0, 8, setNumber8
	beq $t0, 9, setNumber9
	nop
setNumber0:	
	li $a0, 0x3f
	j END__F
setNumber1:	
	li $a0, 0x06
	j END__F
setNumber2:	
	li $a0, 0x5B
	j END__F
setNumber3:	
	li $a0, 0x4f
	j END__F
setNumber4:	
	li $a0, 0x66
	j END__F
setNumber5:	
	li $a0, 0x6D
	j END__F
setNumber6:	
	li $a0, 0x7d
	j END__F
setNumber7:	
	li $a0, 0x07
	j END__F
setNumber8:	
	li $a0, 0x7f
	j END__F
setNumber9:	
	li $a0, 0x6f
	j END__F
END__F:
	jr $ra	

# Trong truong hop so chia = 0 
printMessage:
	li	$v0, 4
	la	$a0, Message
	syscall
	li	$v0, 10
	syscall	
