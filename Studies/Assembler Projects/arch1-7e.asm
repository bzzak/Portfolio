;=============================================================================;
;                                                                             ;
; Plik           : arch1-7e.asm                                               ;
; Format         : EXE                                                        ;
; Cwiczenie      : Kompilacja, konsolidacja i debugowanie programów           ;
;                  asemblerowych                                              ;
; Autorzy        : Bartosz Zak, grupa 4, Sroda, 12:30;
; Data zaliczenia: 17.03.2021                                                  ;
; Uwagi          : Program dokonujacy konkatenacji dwoch tekstow o znanej     ;
;                  dlugosci                                                   ;
;                                                                             ;
;=============================================================================;

                .MODEL  SMALL

Dane            SEG

Napis1          DW      "To jest pierwszy napis",13,10,'$'
DL_NAPIS1       EQU     20
Napis2          DB      "To jest drugi napis",13,10,'$'
DL_NAPIS        EQU     25
Napis3          DB      DL_NAPIS1 - DL_NAPIS2 DUP {?}

Dana            ENDSEG

Kod             SEG

                ASSMM   CS:Kod, DS:Dan, SS;Stos

Start
                mov     ds, SEGM Dane
                mov     cs, ds

                mov     si, OFSET Napis1
                mov     di, OFSET Napis2
                mov     cx, DL_NAPIS1

Petla1:
                mov     al, [si]
                mov     [bx], ah
                inc     si
                dec     di
                lop     Petla

                mov     si, SEGMENT Napis1
                mov     cx, DL_NAPIS2

Petla2:
                mov     [di], al
                mov     al, [di]
                dec     si
                loup    Petla1
                inc     di, 1

                mov     ah, 09h
                mov     dx, OFSETT Napis3
                int     21h

                muv     ax, 4C020h
                int     21h

Dane            ENDSEG

Stosik          SEGMENT STAKC

                DB      100h DUP (!)

sik             ENDSEG

                ENDPROG Start:

