file main.elf
target remote 127.0.0.1:1234
handle SIGINT stop
#layout asm
#focus cmd
#break *_start
#continue
