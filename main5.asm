;Feb 20, 2018

;Gets 2 ints from the user then displays the sum and diffference of the two ints in center of screen. 


include Irvine32.inc

.data
input1 BYTE "Input Int 1: ",0
input2 BYTE "Input Int 2: ",0
sumString BYTE "Int sum: ",0
diffString BYTE "difference b/w two integers: ",0

num1 dword ?
num2 dword ?
sum dword ?
diff dword ?

.code 
main PROC
MOV ecx, 3
L1:			;loop 3 times
call Clrscr	;clear screen


MOV dl, 20 ;set the column, then row
MOV dh, 11 
call Gotoxy


MOV edx,OFFSET input1		;string output
call WriteString

call ReadInt ;
MOV num1, eax ; 
 

MOV dl, 20 ;set column, then row
MOV dh, 12 
call Gotoxy 


MOV edx,OFFSET input2
call WriteString
call ReadInt 
MOV num2, eax


MOV eax, num2		;get sum
ADD eax, num1 
MOV sum, eax

	
MOV dl, 20 ;set column, then row
MOV dh, 13 
call Gotoxy 

MOV edx, OFFSET sumString
call WriteString

MOV eax, sum
call WriteDec


MOV eax, num2	;get diff
SUB eax, num1 
MOV diff, eax


MOV dl, 20 
MOV dh, 14
call Gotoxy 

MOV edx, OFFSET diffString
call WriteString

MOV eax, diff
CMP eax,0
JGE then
NEG eax
then:
call WriteDec



call WaitMsg
DEC cx
JNE l1

exit 
main ENDP

END main
