.text
.global	_start

@ The purpose of _start / main is to set up the stack for the run procedure
_start:
	@ Do stuff, jump to the rest of your program, whatever you want
	B _start

.END
