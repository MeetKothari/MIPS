#####################################################
# Meet Kothari                                      #
#                                                   #
# Homework 3                                        #
#                                                   #
# Time To Complete: 65 minutes                      #
#                                                   #
#####################################################	

	.data

inBuf:	.space 	80
outBuf:	.space	80
	
	
	.text
	
newinput:
	
	jal	getline		# getline()
	li	$t0, 0		# i=0
loop:
	bge	$t0, 80, dump	# if (i>= 80) goto dump
	lb	$t1, inBuf($t0)	# key = inBuf[i]
				
	jal	linesearch	# $t9 = linesearch($t1)
	addi	$t9, $t9, 0x30	# char(chType)
	sb	$t9, outBuf($t0)
	
	beq	$t1, '#', dump	# if (key=='#') exit
				
	addi	$t0, $t0, 1	# i++
	b	loop
			 
dump:	
	lb $t6, outBuf($zero)	#t6 = outbuff(0)
	beq $t6, '6', exit	#if t6 == '6' goto exit
	jal	printbuf
	jal	clearbufs
				
	jal	newinput
	
exit:
	li $v0, 10	# return 0;
	syscall
	
###################
#
# getline()
#	argument -
#	return value -
#
#######################
	.data
prompt:	.asciiz	"Enter an input string: "
	
	.text
getline:
	la	$a0, prompt		# Prompt to enter a new line
	li	$v0, 4
	syscall

	la	$a0, inBuf		# read a new line
	li	$a1, 80	
	li	$v0, 8
	syscall

	jr	$ra
	
##############################
#
# linesearch()
#	argument - $t1 for key
#	return val - $t9 for char type
#
#############################

linesearch:
	li $t3, 0 	# i =0
    	li $t7, 0	#found = 0
linesearch_loop:
	bne $t7, 0, linesearch_end	#if(found != 0) goto linesearch_end
	lw $t5, Tabchar($t3)		#t5 = tabchar(i)
	
	bne $t5, $t1, next		#t5 != key goto next
	li $t7, 1			#found = 1
	b next				#goto next
next:
	addi $t3, $t3, 8
	b linesearch_loop		#goto loop
linesearch_end:
	addi $t3, $t3, -4		
	lw $t9, Tabchar($t3)
	jr $ra
#####################
#
# printbuf()
#
#####################
printbuf:
	
	li $v0, 4		#printf("%c", outBufs)
    	la $a0, outBuf
	syscall
	
	jr	$ra		#return;
#######################
#
# clearbuf():
#
#######################
clearbufs:

	beq $s0, 80, clearExit   #if(i == 80) goto exit
    
 	sw $zero, outBuf($s0)    #outBuf[i] = 0
    	sw $zero, inBuf($s0)     #inBuf[i] = 0
        
    	addi $s0, $s0, 4         #i += 4 to make it the next element by byte
   	b clearbufs

clearExit:
	jr $ra			#return





	.data
Tabchar: 
	.word 	0x0a, 6		# LF
	.word 	' ', 5
 	.word 	'#', 6
	.word 	'$', 4
	.word 	'(', 4 
	.word 	')', 4 
	.word 	'*', 3 
	.word 	'+', 3 
	.word 	',', 4 
	.word 	'-', 3 
	.word 	'.', 4 
	.word 	'/', 3 
	.word 	'0', 1
	.word 	'1', 1 
	.word 	'2', 1 
	.word 	'3', 1 
	.word 	'4', 1 
	.word 	'5', 1 
	.word 	'6', 1 
	.word 	'7', 1 
	.word 	'8', 1 
	.word 	'9', 1 
	.word 	':', 4 
	.word 	'A', 2
	.word 	'B', 2 
	.word 	'C', 2 
	.word 	'D', 2 
	.word 	'E', 2 
	.word 	'F', 2 
	.word 	'G', 2 
	.word 	'H', 2 
	.word 	'I', 2 
	.word 	'J', 2 
	.word 	'K', 2
	.word 	'L', 2 
	.word 	'M', 2 
	.word 	'N', 2 
	.word 	'O', 2 
	.word 	'P', 2 
	.word 	'Q', 2 
	.word 	'R', 2 
	.word 	'S', 2 
	.word 	'T', 2 
	.word 	'U', 2
	.word 	'V', 2 
	.word 	'W', 2 
	.word 	'X', 2 
	.word 	'Y', 2
	.word 	'Z', 2
	.word 	'a', 2 
	.word 	'b', 2 
	.word 	'c', 2 
	.word 	'd', 2 
	.word 	'e', 2 
	.word 	'f', 2 
	.word 	'g', 2 
	.word 	'h', 2 
	.word 	'i', 2 
	.word 	'j', 2 
	.word 	'k', 2
	.word 	'l', 2 
	.word 	'm', 2 
	.word 	'n', 2 
	.word 	'o', 2 
	.word 	'p', 2 
	.word 	'q', 2 
	.word 	'r', 2 
	.word 	's', 2 
	.word 	't', 2 
	.word 	'u', 2
	.word 	'v', 2 
	.word 	'w', 2 
	.word 	'x', 2 
	.word 	'y', 2
	.word 	'z', 2
	.word	0x5c, -1	# if you put "\" as the end-of-table symbol
