;=============================================================================;
;                                                                             ;
; Plik           : arch3.asm - modul dodatkowy                                ;
; Format         : EXE                                                        ; 
; Cwiczenie      : Program hybrydowy                                          ;
; Autorzy        : Bartosz Zak, grupa 4, sroda, 12:30                         ;
; Data zaliczenia: 12.05.2021                                                 ;
; Uwagi          : Program liczacy srednia liczb rzeczywistych z tablicy      ;
;                  wczytanej przez uzytkownika oraz zliczajacy ilosc          ;
;                  wystapien wybranego znaku w lancuchu wczytanym przez       ;
;                  uzytkownika.                                               ;
;=============================================================================;
				.MODEL SMALL, C          ; poza okresleniem modelu mowimy kompilatorowi aby modyfikowal nazwy funkcji zgodnie z konwencja obowiazujaca w jezyku c
				
				PUBLIC array_average     ; umozliwiamy modulowi glownemu korzystanie z funkcji array_average
				PUBLIC char_search       ; umozliwiamy modulowi glownemu korzystanie z funkcji char_search
				
				.CODE                    ; deklaracja segmentu kodu dyrektywa uproszczona - kompilator nadaje taka sama nazwe segmentowi kodu jak w module glownym napisanym w c++
				
;FUNKCJA--ARRAY_AVERAGE--ZWRACAJACA--SREDNIA--ARYTMETYCZNA--ELEMENTOW--TABLICY--LICZB--RZECZYWISTYCH------------------------------------------------------------------------------
array_average:  
				PUSH   bp                ; zapamietanie aktualnej zawartosci rejestru bp
				MOV    bp,sp             ; zapisanie w rejestrze bp aktualnego wierzcholka stosu - od teraz mozna latwo odwolywac sie do parametrow i zmiennych lokalnych
				SUB    sp,2              ; alokacja pamieci na zmienne lokalne
				;Tutaj ewentualnie zapamietujemy aktualne wartosci rejestrow, ktorych bedziemy uzywac w funkcji (poza ax)---------------------------------------------------------
				PUSH   cx
				PUSH   bx
				;-----------------------------------------------------------------------------------------------------------------------------------------------------------------
				MOV    cx,[bp+6]         ; przypisanie rozmiaru tablicy liczb rzeczywistych do licznika petli zawartego w rejestrze cx
				DEC    cx                ; zmniejszenie licznika petli o 1 poniewaz aby dodac do siebie wszystkie elementy musimy wykonac size-1 operacji
				MOV    word ptr [bp-2],8 ; zaladowanie zmiennej lokalnej wielkoscia typu doubule w c++
				MOV    bx,[bp+4]         ; przypisanie adresu fdigits[0] do rejestru bx
				FLD    QWORD PTR [bx]    ; zaladowanie rejestru ST(0) pierwsza liczba z tablicy fdigits
calc_av:
				ADD    bx,[bp-2]         ; przejscie na kolejna liczbe w tablicy
				FLD    QWORD PTR [bx]    ; zaladowanie rejestru ST(1) kolejnymi liczbami z tablicy fdigits
				FADDP                    ; ST(1) = ST(0)+ST(1) nastepnie zdejmij ST(0) ze stosu. Teraz ST(0) = ST(1)
				LOOP   calc_av
				FIDIV  word ptr [bp+6]   ; ST(0) = ST(0)/size
				
				;Tutaj przywracamy pierwotne wartosci rejestrow, ktorych uzywalismy (poza ax)------------------------------------------------------------------------------------
				POP    bx
				POP    cx
				;----------------------------------------------------------------------------------------------------------------------------------------------------------------
				ADD    sp,2              ; czyszczenie pamieci uzytej na zmienne
				POP    bp                ; przywrocenie pierwotnej wartosci rejestru bp
				RET                      ; powrot do modulu glownego i zwrot wyniku w ST(0)
;KONIEC--FUNKCJI--ARRAY_AVERAGE--------------------------------------------------------------------------------------------------------------------------------------------------

;FUNKCJA--CHAR_SEARCH--ZWRACAJACA--ILOSC--WYSTAPIEN--DANEGO--ZNAKU--W--LANCUCHU--ZNAKOW------------------------------------------------------------------------------------------
char_search:   
				PUSH   bp                ; zapamietanie aktualnej zawartosci rejestru bp
				MOV    bp,sp             ; zapisanie w rejestrze bp aktualnego wierzcholka stosu - od teraz mozna latwo odwolywac sie do parametrow i zmiennych lokalnych
				SUB    sp,2              ; alokacja pamieci na zmienne lokalne
				;Tutaj ewentualnie zapamietujemy aktualne wartosci rejestrow, ktorych bedziemy uzywac w funkcji (poza ax)--------------------------------------------------------
				PUSH   bx
				;----------------------------------------------------------------------------------------------------------------------------------------------------------------
				XOR    ax,ax             ; zerujemy rejestr ax
				MOV    [bp-2],ax         ; zerujemy zmienna lokalna
				MOV    bx,[bp+4]         ; ladujemy rejestr bx adresem pierwszego znaku
char_check:
				MOV    al,[bx]           ; przenosimy znak z lancucha do rejestru al
				CMP    al,[bp+6]         ; porownujemy ten znak ze wzorcowym znakiem przekazanym do funkcji 
				JNE    not_equal         ; jesli nie jest to ten sam znak pomijamy nastepna instrukcje
				INC    word ptr [bp-2]   ; zwiekszamy nasz licznik wystapien wzorcowego znaku zawarty w zmiennej lokalnej o 1
not_equal:
				INC    bx                ; ustawiamy rejestr bx tak aby wskazywal kolejny znak z przekazanego lancucha
				TEST   ax,ax             ; sprawdzamy czy aby znak, ktory obecnie porownujemy nie jest znakiem NULL co oznaczaloby koniec lancucha znakow w stylu c
				JNE    char_check        ; jesli znak nie jest NULLem kontynuuj porownywanie kolejnych znakow ze wzorcem, a jesli jest to NULL zakoncz petle
				MOV    ax,[bp-2]         ; przenies liczbe wystapien znaku wzorcowego w przekazanym lancuchu znakow do rejestru ax
				;Tutaj przywracamy pierwotne wartosci rejestrow, ktorych uzywalismy (poza ax)-----------------------------------------------------------------------------------
				POP    bx
				;---------------------------------------------------------------------------------------------------------------------------------------------------------------
				ADD    sp,2              ; czyszczenie pamieci uzytej na zmienne
				POP    bp                ; przywrocenie pierwotnej wartosci rejestru bp
				RET                      ; powrot do modulu glownego i zwrot wyniku w ax
;KONIEC--FUNKCJI--CHAR_SEARCH---------------------------------------------------------------------------------------------------------------------------------------------------
				END