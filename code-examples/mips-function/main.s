#	MIPS Example
#	Comments.  Anything after # is comments.

	# data segment
	.data		

        # The next variable (symbol) should starts at an address that is a multiple of 4.
        # define a single word and an array of words.
	.align 2

	#initialize a word
var_w0:	.word 1

	#initialize a word array
warray:	.word 1, 0x1, 'a', 3666, -100    # can add more

        # Just reserve 128 bytes space for a variable (array). Not initialized.
        # Can be used as an array of words, halwords, or bytes.
        # Set proper alignment for the data type
	.align 2
buf:	.space 128

	# there are more directives like .byte and .half. Read the help files.

	# null-terminated strings, 
hello:	.asciiz "Hello, World! \n"

fmt:	.asciiz	"max(%d, %d)=%d\n"

	# .text starts code segments
	.text
	.globl	main	# declare main to be global. Note it is ".globl"

	# define a label
main:	
	# calling a function 
	jal	print_hello	

	# Calling function in another file
	# In MARS, we must enable "assemble all files in directory" in Settings to call functions in other files

	li	$s0, -10
	li	$s1, 123

	# calling max
	# max($s0, $s1)

	add	$a0, $s0, $0	# set the first argument
	add	$a1, $s1, $0	# set the second argument
	jal	max		# calling the function 

	# calling printf(fmt, $s0, $s1, max($s0, $s1))
	la	$a0, fmt	# format string, argument 1
	add	$a1, $s0, $0	# $s0, argument 2
	add	$a2, $s1, $0	# $s1, argument 3
	add	$a3, $v0, $0	# max($s0, $s1), argument 4
	jal	printf
	
	# System call
	# The simulator supports many system calls. 
	# Regiter $v0 is used to specify which system calls to make.
	# Some system calls require additional info in reigseters like $a0 and $a1.
	# And some system calls also return values. Read the manuals.  
	# System call number 10 is for exiting from the program, and
	# it does not need additional info.
	# Therefore, set the value of $v0 to 10 and do 'syscall'
	
exit:	addi	$v0, $0, 10	
	syscall				# ...and call the OS

# a funciton in the same file
print_hello:
	# System call
	la	$a0, hello
	li	$v0, 4
	syscall
	jr	$ra		# return
