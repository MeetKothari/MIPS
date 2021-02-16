#####################################################	
# Meet Kothari                                      #	
#                                                   #
# Homework 1                                        #
#                                                   #
# Time To Complete: 15 minutes                      #
#						    #	
#####################################################	

	.data 
 a:	.ascii	"abcd"
 b:	.ascii 	"xy z"
 c:	.word	9
	
	
	.text 

 la 	$a0, a
 jal	print3
 
 li	$v0, 10		#stop program 
 syscall

######################################################
#                                                    #
# print3: copy 3 words into buffer, buf: print buf   #
#                                                    #
# input arg: $a0 - addr of 3-word block              #
# return val;                                        #
#                                                    #
######################################################
  
 	.data 
 buf:	.word	0,0,0,0
 
 	.text
 	
 print3:    
        lw        $t0, ($a0)		#load the integers from the buffer into the register $t0, then to the $a0 
        sw        $t0, buf  		#copy the data  
        lw        $t0, 4($a0) 		#load contents to argument register $a0, then add 4. 
        sw        $t0, buf + 4 		#copy the data from register $t0 into the buffer 
        lw        $t0, 8($a0) 		#load the contents t0 to argument register $a0, then add 8. 
        
        sb        $t0, buf + 8 		#copy the data from register $t0 into the buffer
        sb        $t0, buf + 9 		#store spaces in the desired slots in the buffer 
        sb        $t0, buf + 10		# ^^^^^^^^
        sb        $t0, buf + 11		# ^^^^^^^^
        
        li        $v0, 4   		#prepare the system for printing out the ints
        la        $a0, buf 		#store data from the buffer into the argument register $a0 
        syscall 
        
        li        $v0, 1 		#prepare the system for printing c to the screen
        lw        $a0, c 		#load variable c into argument register   
        syscall 	 		#print 9
        
        jr        $ra    	 	#return from the function 
          
