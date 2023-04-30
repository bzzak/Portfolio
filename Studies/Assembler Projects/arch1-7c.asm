;=============================================================================;
;                                                                             ;
; Plik           : arch1-7c.asm                                               ;
; Format         : COM                                                        ;
; Cwiczenie      : Kompilacja, konsolidacja i debugowanie programów           ;
;                  asemblerowych                                              ;
; Autorzy        : Bartosz Zak, grupa 4, Sroda, 12:30                         ;
; Data zaliczenia: 17.03.2021                                                 ;
; Uwagi          : Program obliczajacy wzor: (b*b-4*a)/d                      ;
;                                                                             ;
;=============================================================================;

                .MODEL  TINY
				

d               EQU     3                       ; c=3

Kod             SEGMENT                         ; rozpoczecie segmentu o nazwie "Kod"

                ORG     100h                    ; przesuniecie o 256 bajtow od poczatku segmentu kodu
                ASSUME  CS:Kod, DS:Kod, SS:Kod  ; zaloz, ze w cs, ds i ss znajduje sie segment Kod

Start:          jmp    Poczatek                 ; przeskocz obszar danych

a               DB      20                      ; a=20
b               DB      10                      ; b=10
;c              DB      7                       (prawdopodobnie w tresci zadania powinien byc wzor (b*c-4*a)/d tak to sta³a c jest niepotrzebna)

Wynik           DB      ?                       ; deklaracja zmiennej bez inicjalizacji

Poczatek:
                mov     al, a                   ; al=a
				mov     ah, 4                   ; ah=4
                mul     ah                      ; ax=ah*al (ax=4*a)
                mov     bx, ax                  ; bx=ax (bx=4*a)
				mov     al, b                   ; al=b
				mul     al                      ; ax=al*al (ax=b*b)
                sub     ax, bx                  ; ax=ax-bx (ax=b*b-4*a)
                mov     bl, d                   ; bl=d
                div     bl                      ; al = ax / bl (al=(b*b-4*a)/d) i ah=ax%bl

                mov     Wynik, al               ;w rejestrze al jest wynik dzielenie zas w rejestrze ah reszta z dzielenia dlatego Wynik=al da porzadany efekt

Wyjscie:        mov     ax, 4C00h               ; zakoncz program z kodem powrotu
                int     21h                     ; zakonczenia poprawnego
				
Kod             ENDS                            ; koniec segmentu o nazwie "Kod"

                END    Start

