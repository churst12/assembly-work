;asks the user for an array with rowsize, number of elements,
;and row index of the row they want to sum
;uses a stack to calculate the value sum of one row.


INCLUDE   Irvine32.inc

.data
array1 DWORD 40 DUP(0)
array2 WORD 40 DUP(0)
array3 BYTE 40 DUP(0)

numElem dword ?
rowSize dword ?
arrType dword ?
rowIndex dword ?

str1 BYTE "# elements in your array: ",0
str2 BYTE "Enter the row size (# columns) : ",0
str3 BYTE "Enter type of array:  1 = byte  2 = word  4 = doubleword : ",0
str4 BYTE "Enter an element in your array: ",0
str5 BYTE "Enter row # that you want to sum: ",0
str6 BYTE "sum: ",0

 
.code
main PROC
    ;prompt user for element number. The maxSize is 40.
    mov edx, OFFSET str1
    call writeString
    call readInt
    mov numElem, eax

    ;prompt user for row size
    mov edx, OFFSET str2
    call writeString
    call readInt
    mov rowSize, eax

    ;Prompt user for array type
    mov edx, OFFSET str3
    call writeString
    call readInt
    mov arrType, eax

    ;prompt user for elements of the array.
    mov ecx, numElem
    mov ebx, arrType		;different cases for each arrayType
	xor edx, edx
    cmp ebx, 4
    je then01
    cmp ebx, 2
    je then02
    cmp ebx, 1
    je then03

	;Each of these then statements are different cases for types of array
	;each then statement traveres the array and adds the values inputted
	;for(int i=0; i>array.length; i++) {
	;	input = user.input
	;	array[i] = input}
	;

    then01:					;DWORD ARRAY CASE
		push OFFSET array1
		xor ebx, ebx
		mov esi, 1
        Loop01:    ;see comment above for loop comment/code
            mov edx, OFFSET str4
            call writeString
            call readInt
            mov [array1+bx], eax	;mov value into array[i][i]
			add ebx, arrType	
            loop Loop01
        jmp out01
    then02:				;WORD ARRAY CASE
		push OFFSET array2
		xor ebx, ebx
		mov esi, 2
        Loop02:		;see comment above for loop comment/code
            mov edx, OFFSET str4
            call writeString
            call readInt
            mov [array2+bx], ax		;mov value into array[i][i]
			add ebx, arrType
            loop Loop02
			
        jmp out01
    then03:				;BYTE ARRAY CASE
		push OFFSET array3
		xor ebx, ebx
		mov esi, 3
        Loop03:		;see comment above for loop comment/code
            mov edx, OFFSET str4
            call writeString
            call readInt
            mov [array3+bx], al		;mov value into array[i][i]
			add ebx, arrType
            loop Loop03
        jmp out01

    out01:


    ;prompts user for row index and display the sum of the row.
    mov edx, OFFSET str5
    call writeString
    call readInt
    mov rowIndex, eax
    
    push rowSize	;pushing values to the stack
    push arrType
    push rowIndex

    call calcRowSum    ;call the calcRowSum proc for the sum


	mov edx, OFFSET str6
    call writeString

	mov eax,[esp + 20]		;getting sum from the beginning of the stack
	call writedec  
exit
main ENDP


calcRowSum PROC ;calcRowSum ( int *array, int rowSize, int type, int rowIndex)
				;returns the sum of the selected row
	push ebp
	mov ebp, esp

	push eax		;keeping original register values
	push ebx
	push ecx
	push edx
	push esi
	push edi
	
	mov esi, [ebp + 20]		;address fo the array

	mov edi, [ebp + 12]			;the type of the array
	mov eax, [ebp+16]			;calculating row index by (rowsize*rowindex*bytesize)
	mov ecx, [ebp + 8] 
	mul ecx
	mov edx, [ebp + 12] 
	mul edx
	mov ebx, eax		;ebx = target row
	add esi, ebx

	xor ecx, ecx		; the row counter
	xor eax, eax		; the sum counter
	xor edx, edx		; the column counter
	While1:				;traversing the row
						;for(int i=0; i>rowsize; i++) {
						;	sum += array[rowindex][i] }
					
		cmp ecx, [ebp+16]
		je Out2
		cmp edi, 4
		je then1
		cmp edi, 2		
		je then2		;actually adding to the sum now
			add al, [esi]   ;BYTE CASE
			jmp Out1
		then1:
			add eax, [esi]	;DWORD CASE
			jmp Out1
		then2:
			add ax, [esi]	;WORD CASE
			

		Out1:
		inc ecx
		add esi, [ebp + 12]		;addd to edx to traverse row
		jmp While1
	Out2:
	mov [ebp +28], eax		;push return value to the beginning of the stack
	
	pop edi
	pop esi		;restoring the original values
	pop edx
	pop ecx
	pop ebx
	pop eax
	pop ebp
	ret			;return value to complete the cleaning
calcRowSum endp

 end main


