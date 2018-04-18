;gets two ints and prints 5 multiples of them in ascending order

include Irvine32.inc

.data
msg1 BYTE "Input an integer between 1-10: ",0
msg2 BYTE "Merged Array: ",0
arr1 dword 5 DUP(?)
arr2 dword 5 DUP(?)
arr3 dword 5 DUP(?)
num1 dword ?
num2 dword ?
string1 BYTE " ",0


.code 
main PROC	

    mov edx,offset msg1   ;getting user input
    call WriteString
    call readint 
	mov num1, eax

    push offset arr1			;create first array 
    push 5
    call createArray
    call printArray
    call crlf

    mov edx,offset msg1  ; getting user input
    call WriteString
    call readint 
	mov num2, eax

    push offset arr2		;create second array
    push 5
    call createArray
    call printArray
    call crlf

	mov ebx, num2  ;swap array position if input 1> input 2
	cmp num1, ebx
	jg Other
    mov esi,offset arr1  ;start merging the two arrays
    mov edi,offset arr2
    mov edx,offset arr3
	jmp Skip
	Other: 
	mov esi,offset arr2  ;start merging the two arrays
    mov edi,offset arr1
    mov edx,offset arr3

	Skip:

	xor ecx, ecx
    xor ebx, ebx
    While01:        ;while(ecx < 5)
    cmp ecx, 5
    jge Out01
    mov ax,[esi]
    cmp ax, [edi]
    jl AddA1       
    jge AddA2       
    jmp While01

    Out01:
                                ;if the one of the arrays has finished printing
        While02:                    ;while(ebx < lengthof arr2)
        cmp ebx, lengthof arr2
        jge Out02
        add ebx,1
        mov ax,[edi]
        mov [edx],ax
        add edi,4
        add edx,4
        jmp While02


    Out02:						;exiting merge once done pushing all to array
    jmp End1

    AddA1:				;push the number from one array onto the second
    add ecx,1			
    mov ax,[esi]
    mov [edx],eax
    add esi,4
    add edx,4
    jmp While01

    AddA2:				;push the number from the second array
    add ebx,1
    mov ax,[edi]
    mov [edx],eax
    add edi,4
    add edx,4
    jmp While01

    End1:


    push offset arr3
	push 10
	call printArray

    exit

main ENDP

printArray proc   ;prints the array
    push ecx			;for(int i=0; i<array.length; i++)
    push esi				;{ print array[i] }
    push eax
    push ebp
    mov ebp, esp
    mov esi, [ebp+24]
    mov ecx, [ebp+20]
    While1:
        cmp ecx, 0
        je Out1
        mov eax, [esi]
        call writeDec   ;the part that actually prints it
		mov edx, OFFSET string1
		call writestring
		
        add esi, 4
        dec ecx
        jmp While1
    Out1:

    pop ebp
    pop eax
    pop esi
    pop ecx
    ret 
printArray endp

multiply proc			; multiplies the number by 2 and adds another one for counter
    shl eax, 1
    mov ebx, ecx
    While1: 
        cmp ebx,0
        je Out1
        add eax, edx 
        dec ebx
        jmp While1
    Out1:

    ret
multiply endp

createArray PROC		; creates the array jbased on the integer, uses multiply proc
    push ecx
    push eax
    push ebx
    push edx
    push esi
    push ebp
    mov ebp, esp
    mov edx, eax
    xor ecx, ecx
    mov esi, [ebp+32]
    mov [esi],eax
    add esi, type arr1
    While1:				;while the counter is still going
        cmp ecx, 4
        je Out1
        mov eax, edx
        call multiply
        mov [esi],eax
        add esi, type arr1
        inc ecx
    jmp While1


    Out1:
    pop ebp
    pop esi			;restoring all of the registers
    pop edx
    pop ebx
    pop eax
    pop ecx
    ret
createArray endp

END main

;Input an integer between 1-10: 7
;7 14 21 28 35
;Input an integer between 1-10: 5
;5 10 15 20 25
;5 7 10 14 15 20 21 25 28 35 Press any key to continue . . .