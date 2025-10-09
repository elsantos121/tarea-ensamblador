.MODEL SMALL
.STACK 100h
.DATA
    num     DW 5          ; Número del cual queremos calcular el factorial
    result  DW 1          ; Resultado inicial (1 porque n! empieza en 1)
.CODE
START:
    MOV AX, @DATA         ; Inicializar el segmento de datos
    MOV DS, AX
    
    MOV CX, [num]         ; Guardamos el número en CX (contador)
    MOV AX, 1             ; AX = 1 (acumulador del resultado)
    
FACTORIAL_LOOP:
    MUL CX                ; AX = AX * CX  (multiplicación)
    LOOP FACTORIAL_LOOP   ; CX = CX - 1 y vuelve si CX ≠ 0
    
    MOV [result], AX      ; Guardamos el resultado final en memoria
    
    MOV AH, 4Ch           ; Terminar programa (INT 21h)
    INT 21h
END START
