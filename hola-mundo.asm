;--------------------Segmento de datos--------------------
;Aqui se declaran las constantes que se van a usar en el
programa
section .data
cons_hola: db 'Hola mundo!',0xa
cons_tamano: equ $-cons_hola
;--------------------Segmento de codigo--------------------
;Contiene la secuencia de ejecucion del programa
;La ejecucion inicia en "_start", que es una etiqueta o
referencia
section .text
global _start
_start:
mov rax,1
mov rdi,1
mov rsi,cons_hola
mov rdx,cons_tamano
syscall
