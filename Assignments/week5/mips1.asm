#Laboratory Exercise 5, Home Assignment 1
.data
Message:		.ascii 	"Enter a character "
char:		.space	1
.text
	li 	$v0, 12
	#la 	$a0, Message
	#la	$a1, char
	#la	$a2, 1
	syscall


