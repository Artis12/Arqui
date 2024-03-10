%include "linux64.inc" ; Se usa un archivo externo para poder leer e imprimir el archivo .txt de NOTAS

section .data
	filename db "NOTAS.txt",0 ; Se define el nombre del archivo que se va a leer 
	
section .bss
	text resb 300 ; Se define el largo del archivo
	
section .text
	global _start
	
_start:
; Open the file
	mov rax, SYS_OPEN ; Abre el archivo
	mov rdi, filename
	mov rsi, O_RDONLY
	mov rdx, 0
	syscall
	
;read from the file
	push rax
	mov rdi, rax
	mov rax, SYS_READ ; Lectura del archivo 
	mov rsi, text
	mov rdx, 300
	syscall
	
;close the file
	mov rax, SYS_CLOSE
	pop rdi
	syscall
	print text ; Imprime el archivo 
	exit
