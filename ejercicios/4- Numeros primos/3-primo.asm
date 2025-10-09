.MODEL SMALL
.STACK 100h

.DATA
    num         DW 47      ; El n?mero a verificar 
    isPrime     DB 1       ; Bandera: 1 = primo, 0 = no primo
    
    ; Mensajes para la salida por pantalla
    esPrimoMsg  DB 13, 10, 'El numero es primo.$'
    noPrimoMsg  DB 13, 10, 'El numero NO es primo.$'

.CODE
START:
    ; 1. Inicializar el Segmento de Datos (DS)
    MOV AX, DGROUP      
    MOV DS, AX          
    
    ; 2. Verificaci?n inicial: ?num < 2?
    MOV AX, [num]
    CMP AX, 2
    JL NOT_PRIME        
    
    MOV CX, 2           ; Inicializa el divisor (CX) en 2

CHECK_LOOP:
    ; 3. Comprobar divisibilidad
    MOV DX, 0           
    DIV CX              
    CMP DX, 0           
    JE NOT_PRIME        
    
    ; 4. Preparar para la siguiente iteraci?n
    INC CX              
    MOV AX, [num]       
    
    ; 5. Condici?n de salida del bucle
    CMP CX, AX
    JL CHECK_LOOP       
    
    JMP PRINT_RESULT    ; Si el bucle termina, es primo

NOT_PRIME:
    ; Establecer la bandera a 0 (No primo)
    MOV BYTE PTR [isPrime], 0 
    
; ------------------------------------------------------------------------
; INICIO DE LA RUTINA DE IMPRESI?N
; ------------------------------------------------------------------------
PRINT_RESULT:
    ; 1. Cargar la funci?n de "Mostrar cadena" (AH=09h)
    MOV AH, 09h         
    
    ; 2. Decidir qu? mensaje imprimir
    CMP BYTE PTR [isPrime], 1
    JE IS_PRIME_MSG     
    
    ; Si no es primo (isPrime = 0)
    MOV DX, OFFSET noPrimoMsg 
    JMP DISPLAY_MSG
    
IS_PRIME_MSG:
    ; Si es primo (isPrime = 1)
    MOV DX, OFFSET esPrimoMsg 

DISPLAY_MSG:
    ; 3. Ejecutar la interrupci?n para imprimir
    INT 21h             
    
END_PROGRAM:
    ; 4. Finalizar el programa
    MOV AH, 4Ch
    INT 21h
END START