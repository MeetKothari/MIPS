#####################################################	
# 						                                      #	
# Meet Kothari                                      #	
#                                                   #
# Homework 2                                        #
#                                                   #
# Time To Complete: 55 minutes                      #
#						                                        #	
#####################################################		
	
	.data

Tab:	.word	0:60		# 10-entry 

inbuf:	.word 	0, 0, 0, 0 	# to take in
outbuf:	.word	0, 0, 0, 0	# to take out

space: 	.asciiz  "\n"		# newline

	.text 	
	
main: 

        la $a0, Tab 	# tab is passed as an argument 
        jal fillTab
	
	la $a0, Tab	# tab is once again passed 
	jal dumpTab
	
	li $v0, 10 	# stop program
	syscall 
	
############################################################
#							                                             #	
# fillTab:                                                 #
#                                                          #
# fillTab repeatedly uses a pair of syscalls (one          #
# with $v0 of 8 for name and another with $v0 of 5 for val)# 
# into inBuf and copies inBuf to the next available        #
# entry in Tab.                                            #
#                                                          #
#                                                          #
#                                                          #
############################################################

fillTab:

	li $t4, 0
	
	while: 				# start a while loop
	
		addi	$t6, $t4, 4
		addi 	$t7, $t4, 8
			
		bge 	$t4, 36, exit
			
		li 	$v0, 8		# copy values into inbuf
		la	$a0, inbuf	# $v0 of 8
		li 	$a1, 10
		syscall 
			
		li	$v0, 5			# $v0 of 5
		syscall
			
		move 	$t0, $v0		# bring it to next available entry in Tab
		addi	$t0, $t0, 0x30
		sw	$t0, inbuf + 8
			
		lw	$t1, inbuf		# bring it to next available entry in Tab
		sw	$t1, Tab($t4)
			
		lw	$t1, inbuf + 4 		# bring it to next available entry in Tab
		sw	$t1, Tab($t6)  		# move by 4 to account for the next byte
			
		lw	$t1, inbuf + 8		# another 4 for another inbuf
		sw	$t1, Tab($t7)
		addi	$t4, $t4, 12
			
		j 	while
		
	exit: 
	
		jr 	$ra			# exit to main
	
	
############################################################
#							                                             #	
# dumpTab:                                                 #
#                                                          #
# which similarly copy each entry of Tab into              # 
# outBuf, which has four words.                            #
#                                                          #
#                                                          #
#                                                          #
#                                                          #
#                                                          #
############################################################

dumpTab: 

        li $t4, 0
        
        while2:				# start a while loop
        
        	addi    $t6, $t4, 4
               	addi    $t7, $t4, 8
        	bge     $t4, 48, exit2	# exit if the need is there

        	lw    	$t1, Tab($t4)	# copy each entry into outbuf
        	sw    	$t1, outbuf

        	lw    	$t1, Tab($t6)	# copy each entry into outbuf
        	sw    	$t1, outbuf + 4	# add for to account for the positioning 

        	la    	$a0, outbuf	# copy each entry into outbuf
        	li    	$v0, 4		# add for to account for the positioning 
        	syscall

        	lw    	$t1, Tab($t7)	# copy each entry into outbuf
        	sw    	$t1, outbuf + 8	# when the 3rd word is copied to outBuf, it has to be converted to ASCII alphanumeric to be printed
        	la    	$a0, outbuf + 8
        	li    	$v0, 4
        	syscall
        	
        	li 	$v0, 4       	# space it out
		      la 	$a0, space   	# ^^^^^^^^^^^^
		      syscall
		 
		      li 	$v0, 4       	# space it out
		      la 	$a0, space   	# ^^^^^^^^^^^^
		      syscall  
        	
        	addi    $t4, $t4, 12
        	
        	j 	while2
        	
        exit2:
        	jr 	$ra			# go back to main
