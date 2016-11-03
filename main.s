.text
.global	main
@ For debugging in GDB this must be commented out but when you run on a real
@ target you will proably need it and need to possibly comment out .global main
@ .global	_start

.type	main, %function
@ The purpose of _start / main is to set up the stack for the run procedure
main:
_start:
	@ Save the link register, stack and frame pointers so we can return
	@ to it and restore the stack after we are done
  STMFD sp!, {sp, fp, lr}
	@ Do stuff, jump to the resto fo your program, whatever you want
	@ BL do_stuff
	@ Restore the previous stack, frame, and link registers for the calling
	@ procedure
  LDMFD sp!, {sp, fp, lr}
	@ Jump back into the calling procedure
	bx	lr
	.size	main, .-main

.END
