.text
.globl main
main:
mfc0 $a0, $12 # read from the C0 Status Register
ori $a0, 0xff11 # enable all interrupts
mtc0 $a0, $12 # write back to the Status Register
lui $t0, 0xFFFF # $t0 = 0xFFFF0000 - Receiver Control port
ori $a0, $0, 2 # enable keyboard interrupt
sw $a0, 0($t0) # write back to 0xFFFF0000;

ori $a0, $0, 2 # enable display interrupt
sw $a0, 8($t0) # write back to 0xFFFF0000;
here:
sw $a0, 12($t0) # get the input key from display Receiver Data port
nop
j here # stay here forever
syscall

.ktext 0x80000180 # kernel code starts here
lui $t0, 0xFFFF # $t0 = 0xFFFF0000
lw $a0, 4($t0) # get the input key from keyboard Receiver Data port
eret
