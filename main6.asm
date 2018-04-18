;Feb 28, 2018

;Displays the prime numbers up to a certain provided int

include Irvine32.inc

.data
msg1 BYTE "Input integer: ",0
space BYTE " ",0

num DWORD ?
counter DWORD ?
divisor dword ?



.code 
main PROC
mov edx,OFFSET msg1
call WriteString

call ReadInt ;read integer 
mov num, eax 

mov counter,1 
;start 
startloop:
	inc counter		;start the counter up to the given int
	mov ebx, counter
	mov eax,num 

	cmp ebx,eax  ;if the counter reaches the given, end
	je last ;

	mov eax, counter  ;pass counter to isPrime
	call isPrime 
	cmp ecx,0		;recieves eax value
	je startloop	;starts again if not prime
	mov eax, ecx	;if prime, continues to print
	call writeDec
	mov edx, OFFSET space
	call WriteString
	jmp startLoop	;restarts loop
last:
	ret			;end program
main ENDP

isPrime PROC  
	mov divisor,2  ;initialize values
	mov edx,0
	mov ecx, eax
start1:				;counts up to the given int
	mov edx,0		
	mov eax, ecx
	cmp divisor, eax
	jge Prime		;if the counter equal, return prime
	div divisor
	cmp edx, 0; 
	je notPrime  ;if not prime jump to notPrime
	inc divisor  ;if prime, inc divisor and restart loop
	jmp start1
notPrime:
	mov ecx, 0
	ret
Prime:
	ret
isPrime endp



END main
