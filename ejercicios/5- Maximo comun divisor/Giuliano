DATA_SEG SEGMENT
    MSG1        DB 'Ingrese el primer numero (0-65535): $'
    MSG2        DB 13,10,'Ingrese el segundo numero (0-65535): $'
    MSG3        DB 13,10,'El MCD es: $'
    NUM1        DW ?
    NUM2        DW ?
DATA_SEG ENDS

CODE_SEG SEGMENT
    ASSUME CS:CODE_SEG, DS:DATA_SEG

START:
    ; Inicializar segmento de datos
    MOV AX, DATA_SEG
    MOV DS, AX

    ; -------------------------------
    ; Entrada del primer numero
    ; -------------------------------
    MOV AH, 09H
    MOV DX, OFFSET MSG1
    INT 21H

    CALL READ_NUM
    MOV NUM1, AX

    ; -------------------------------
    ; Entrada del segundo numero
    ; -------------------------------
    MOV AH, 09H
    MOV DX, OFFSET MSG2
    INT 21H

    CALL READ_NUM
    MOV NUM2, AX

    ; -------------------------------
    ; Algoritmo de Euclides (MCD)
    ; -------------------------------
    MOV AX, NUM1
    MOV BX, NUM2

EUCLID_LOOP:
    CMP BX, 0
    JE DONE
    XOR DX, DX       ; limpiar DX antes de DIV
    DIV BX           ; AX / BX -> cociente en AX, resto en DX
    MOV AX, BX
    MOV BX, DX
    JMP EUCLID_LOOP

DONE:
    ; AX contiene el MCD
    MOV DX, OFFSET MSG3
    MOV AH, 09H
    INT 21H

    ; Convertir AX a cadena e imprimir
    CALL PRINT_NUM

    ; Terminar programa
    MOV AH, 4CH
    MOV AL, 0
    INT 21H

; -------------------------------------------------
; Rutina para leer un numero de teclado (0-65535)
; Devuelve el numero en AX
; -------------------------------------------------
READ_NUM PROC
    XOR AX, AX        ; acumulador = 0
READ_LOOP:
    MOV AH, 01H
    INT 21H           ; leer caracter
    CMP AL, 13        ; Enter?
    JE READ_DONE
    SUB AL, '0'       ; ASCII a n?mero
    MOV AH, 0         ; limpiar parte alta de AX
    MOV CX, AX        ; guardar acumulador
    MOV AX, CX
    MOV DX, 10
    MUL DX            ; AX = AX*10
    ADD AX, CX        ; sumar el d?gito le?do
    JMP READ_LOOP
READ_DONE:
    RET
READ_NUM ENDP

; -------------------------------------------------
; Rutina para imprimir AX como n?mero decimal
; -------------------------------------------------
PRINT_NUM PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV BX, 10
    XOR CX, CX       ; contador de d?gitos

CONVERT_LOOP:
    XOR DX, DX
    DIV BX           ; AX / 10 -> cociente en AX, resto en DX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE CONVERT_LOOP

PRINT_LOOP:
    POP DX
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    LOOP PRINT_LOOP

    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUM ENDP

CODE_SEG ENDS
END START
