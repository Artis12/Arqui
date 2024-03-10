; Definiciones de memoria

.data
; Mensaje de error para archivo no encontrado
error_archivo: db "Error: Archivo no encontrado", 10, '<span class="math-inline">'
; Mensaje de encabezado
encabezado\: db "Lista de estudiantes ordenados por notas\:", 10, '</span>'

; Estructura para almacenar un estudiante
estudiante: db 32 dup(?) ; Nombre completo (32 caracteres max)
        dw ? ; Nota

; Buffer para leer una línea del archivo
buffer: db 80 dup(?)

; Variables
num_estudiantes: dw 0 ; Número de estudiantes leídos
estudiantes: dw ? ; Puntero a la lista de estudiantes

; Código

.code

; Función para leer una línea del archivo
leer_linea:
        mov eax, 3 ; Lectura
        mov ebx, handle ; Manejador del archivo
        mov ecx, buffer ; Buffer
        mov edx, 80 ; Tamaño del buffer
        int 21h ; Llamada al sistema

        ; Si se leyó una línea, retornar el número de bytes leídos
        ; Si no, retornar -1
        cmp eax, 0
        jl leer_linea_fin
        ret

leer_linea_fin:
        mov eax, -1
        ret

; Función para convertir una cadena a un número
atoi:
        mov esi, eax ; Puntero al inicio de la cadena
        mov eax, 0 ; Valor numérico

        ; Recorrer la cadena
        ciclo_atoi:
                mov ebx, [esi] ; Obtener el siguiente caracter
                cmp ebx, 0 ; Fin de la cadena?
                je ciclo_atoi_fin

                ; Convertir el caracter a un dígito
                sub ebx, '0'

                ; Multiplicar el valor actual por 10
                mov ecx, 10
                mul ecx

                ; Sumar el dígito al valor actual
                add eax, ebx

                ; Avanzar al siguiente caracter
                inc esi
                jmp ciclo_atoi

        ciclo_atoi_fin:
                ; Retornar el valor numérico
                ret

; Función para imprimir una cadena
imprimir_cadena:
        mov edx, eax ; Puntero a la cadena
        mov ecx, 1 ; Salida estándar
        mov ebx, 1 ; Longitud de la cadena
        int 21h ; Llamada al sistema

        ret

; Función para imprimir un número
imprimir_numero:
        push eax ; Guardar el valor en la pila

        ; Convertir el valor a una cadena
        mov eax, 10 ; Base 10
        call itoa

        ; Imprimir la cadena
        mov edx, eax ; Puntero a la cadena
        mov ecx, 1 ; Salida estándar
        mov ebx, 1 ; Longitud de la cadena
        int 21h ; Llamada al sistema

        ; Restaurar el valor de la pila
        pop eax

        ret

; Función para ordenar la lista de estudiantes por notas
ordenar:
        ; Implementar un algoritmo de ordenación, como burbuja o quicksort

; Función principal
main:
        ; Abrir el archivo de estudiantes
        mov eax, 5 ; Apertura de archivo
        mov ebx, "NOTAS.txt" ; Nombre del archivo
        mov ecx, 0 ; Modo de apertura (lectura)
        int 21h ; Llamada al sistema

        ; Si el archivo no se pudo abrir, mostrar un mensaje de error y salir
        cmp eax, -1
        je error_archivo

        ; Almacenar el manejador del archivo
        mov handle, eax

        ; Leer el número de estudiantes
        leer_linea
        mov num_estudiantes, eax

        ; Reservar memoria para la lista de estudiantes
        mov eax, num_estudiantes
        mul sizeof(estudiante)
        mov estudiantes, malloc(eax)

        ; Leer los datos de cada estudiante
        mov esi,
