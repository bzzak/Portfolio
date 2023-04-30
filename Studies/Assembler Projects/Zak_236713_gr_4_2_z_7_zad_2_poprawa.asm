;=============================================================================;
;                                                                             ;
; Plik           : arch2.asm                                               ;
; Format         : COM                                                        ; 
; Cwiczenie      : Kod uzupelnieniowy do dwoch                                ;
; Autorzy        : Bartosz Zak, grupa 4, sroda, 12:30                         ;
; Data zaliczenia: 21.04.2021                                                 ;
; Uwagi          : Program dokonujacy dodania dwoch liczb z przedzialu        ;
;                  [-32768...32767] wczytanych z klawiatury i wypisujacy      ;
;                  wynik na konsole                                           ;
;=============================================================================;
			    .386p
				.MODEL TINY
;---------------STALE---------------------------------------------------------------------------------------------------------------				
MINUS           EQU        45
PLUS            EQU        43
MIN             EQU        48
MAX             EQU        57
;---------------KONIEC-STALYCH-------------------------------------------------------------------------------------------------------			
				
Kod			    SEGMENT USE16
			    
				ORG        100h
				ASSUME     CS:Kod, DS:Kod, SS:Kod
				
Start:		    
			    jmp        Poczatek
;---------------------------DANE-PROGRAMU--------------------------------------------------------------------------------------------
Bufor1          DB         7            ;
                DB         0            ;Dane dla funkcji 0Ah przerwania 21h (wczytaj co najwyzej 7 znakow z klawiatury i zapisz do zmiennej Napis1)
Napis1          DB         9h DUP ('$') ;

Bufor2          DB         7            ;
                DB         0            ;Dane dla funkcji 0Ah przerwania 21h (wczytaj co najwyzej 7 znakow z klawiatury i zapisz do zmiennej Napis2)
Napis2          DB         9h DUP ('$') ;

Ujemna          DB         0            ; Flaga znaku liczby

Zero            DB         0            ; Flaga zera ustawiana gdy uzytkownik wprowadzi liczbe zaczynajaca sie od 0 i nie bedaca zerem

BladNaN         DB         "To nie sa liczby!",13,10,"$"

BladOf          DB         "Jedna z wprowadzonych danych lub wynik przekroczyla dopuszczalny zakres!",13,10,"$"  ;

Liczba1         DW         0

Liczba2         DW         0

Wynik           DD         ?

WynikNapis      DB         0Ah DUP ('$')
;---------------------------KONIEC-DANYCH-PROGRAMU------------------------------------------------------------------------------------
Poczatek:      
			    XOR        ax, ax                ;  ^
				MOV        ah, 0Ah               ;  |
				XOR        dx, dx                ; Wczytanie pierwszej liczby do zmiennej Napis1
				MOV        dx, OFFSET Bufor1     ;  |
				INT        21h                   ;  v
				
				MOV        bl, [Bufor1+1]        ;  ^
				MOV        al, 10                ;  |
				MOV        [Napis1+bx+1], al     ;  |
				XOR        ax, ax                ; Wypisanie napisu zawartego w zmiennej Napis1 na ekran i przejscie do nowej linii
				MOV        ah, 09h               ;  |
				MOV        dx, OFFSET Napis1     ;  |
				INT        21h                   ;  v
				
				MOV        ah, 0Ah               ;  ^
				MOV        dx, OFFSET Bufor2     ; Wczytanie drugiej liczby do zmiennej Napis2
				INT        21h                   ;  v
				
				MOV        bl, [Bufor2+1]        ;  ^
				MOV        al, 10                ;  |
				MOV        [Napis2+bx+1], al     ;  |
				XOR        ax, ax                ; Wypisanie napisu zawartego w zmiennej Napis2 na ekran i przejscie do nowej linii
				MOV        ah, 09h               ;  |
				MOV        dx, OFFSET Napis2     ;  |
				INT        21h                   ;  v
;---------------LOGIKA-PROGRAMU----------------------------------------------------------------------------------------------------------
			   
				MOV        si, OFFSET Napis1     ;
				MOV        di, OFFSET Liczba1    ; Ustawienie wskaznikow na odpowiednie dane napisu 1
				MOV        bp, OFFSET Bufor1     ;
				MOV        dx, 2                 ; Licznik wykonania petli Kontrola--->Zapis
				
Kontrola:
			    MOV        ax, [di]              ; Zaladowanie adresu odpowiedniej liczby do rejestru ax
				CMP        byte ptr [si], MINUS  ; sprawdzenie czy pierwszy znak to "-"
				JNE        ZnakPlus              ;
				
				MOV        bl, 1                 ;
				MOV        [Ujemna], bl          ;
				INC        si                    ; Przejscie do petli konwersji NapisDoLiczby z
				XOR        cx, cx                ; odpowiednio ustawionymi rejestrami si i cx
				MOV        cl, [bp+1]            ; dla przypadku gdy pierwszy wykryty znak to "-"
				DEC        cx                    ;
				JMP        NapisDoLiczby
ZnakPlus:
			    CMP        byte ptr [si], PLUS   ; Sprawdzenie czy pierwszy znak to "+"
				JNE        BezZnaku              ;
				
			    XOR        bx, bx                ;
				MOV        [Ujemna], bl          ;
				INC        si                    ; Przejscie do petli konwersji NapisDoLiczby z
				XOR        cx, cx                ; odpowiednio ustawionymi rejestrami si i cx
				MOV        cl, [bp+1]            ; dla przypadku gdy pierwszy wykryty znak to "+"
				DEC        cx                    ;
				JMP        NapisDoLiczby         ;
BezZnaku:
				CMP        byte ptr [si], MAX    ;
				JA         NieLiczba             ;  Sprawdza czy przypadkiem pierwszy znak nie jest
				CMP        byte ptr [si], MIN    ;  ani cyfra ani znkiem "+" lub "-". Jesli tak jest 
				JB         NieLiczba             ;  konczy program z odpowiednim komunikatem. Jesli pierwszy
				XOR        bx, bx                ;  znak jest cyfra to przechodzi do petli NapisDoLiczby 
				MOV        [Ujemna], bl          ;  z odpowiednio ustawionymi rejestrami si i cx
				XOR        cx, cx                ;
				MOV        cl, [bp+1]            ;
				
NapisDoLiczby:
			    CMP        [Zero], 1             ; konczy program z odpowiednim komunikatem gdy po
				JE         NieLiczba             ; pierwszym przejsciu petli w rejestrze ax znajduje sie 0
				                                 ;(oznacza to, ze uzytkownik probuje wpisac liczbe lub inny napis zaczynajacy sie od 0 i nie bedacy liczba 0)
				
				CMP        byte ptr [si], MAX    ;
				JA         NieLiczba             ; Sprawdzenie czy dany znak jest cyfra.
				CMP        byte ptr [si], MIN    ; Jesli nie konczy program.
				JB         NieLiczba             ;
				
				XOR        bx, bx                ;
				MOV        bx, ax                ;
				IMUL       ax, bx, 10            ; Algorytm konwersji napisu do liczby
				JO         Przepelnienie         ; z kontrola przepelnienia po mnozeniu
				XOR        bh, bh                ;
				MOV        bl, [si]              ;
				SUB        bl, MIN               ;
				
				ADD        ax, bx                ;
				CMP        byte ptr [Ujemna], 1  ;
				JNE        Domyslnie1            ; Obsluga wyjatku umozliwiajaca wpisanie przez
				SUB        ax, bx                ; uzytkownika liczby -32768 polegajaca na
				ADD        ax, bx                ; zrezygnowania kontroli przepelnienia
				CMP        ax, 32768             ;
				JE         Wyjatek               ;
				
Domyslnie1:		
			    SUB        ax, bx                ;
				ADD        ax, bx                ; Dodawanie z kontrola przepelnienia
				JO         Przepelnienie         ;
				JMP        Domyslnie2            ;
Wyjatek:
			    SUB        ax, bx                ; Dodawanie bez kontroli przepelnienia
			    ADD        ax, bx                ;
Domyslnie2:
				TEST       ax, ax                ;
				JNE        KoniecPetli           ; Ustawienie flagi Zera gdy w rejestrze ax znajduje sie 0
				INC        [Zero]                ;
				
KoniecPetli:
			    INC        si                    ; Koniec petli NapisDoLiczby
				LOOP       NapisDoLiczby         ;
				
				CMP        byte ptr [Ujemna], 1  ; Zamiana przekonwertowanej z napisu liczby na ujemna
				JNE        Zapis                 ; gdy pierwszym znakiem napisu byl "-"
				NEG        ax                    ;
				
Zapis:
				MOV        [di], ax              ; Zapis liczby do odpowiedniej zmiennej Liczba
				
				MOV        byte ptr [Zero], 0    ; Wyzerowanie zmiennej zero (nie ma w oryginalnym programie) !!!!
				
				DEC        dx                    ; Powtarza instrukcje Kontrola-->Zapis
				TEST       dx, dx                ; dla drugiego napisu jesli jeszcze nie
				JE         KonwersjaLiczba1      ; zostalo to zrobione
				
				MOV        si, OFFSET Napis2     ;
				MOV        di, OFFSET Liczba2    ; Ustawienie odpowiednich rejestrow dla Napisu2
				MOV        bp, OFFSET Bufor2     ; i przejscie ponownie do kontroli i petli konwersji
				JMP        Kontrola              ; napisu do liczby

KonwersjaLiczba1:
			    XOR        eax, eax
				XOR        ebx, ebx
				
				MOV        ax, [Liczba1]         ;
				CMP        word ptr [Liczba1], 0 ;
				JNS        KonwersjaLiczba2      ; Zapisanie 16-bitowych liczb zapisanych
				NEG        ax                    ; w zmiennych Liczba1 oraz Liczb2 
				NEG        eax                   ; do rejestrow 32-bitowych eax i ebx
KonwersjaLiczba2:                                ;
			    MOV        bx, [Liczba2]         ;
				CMP        word ptr [Liczba2], 0 ;
				JNS        Suma                  ;
				NEG        bx                    ;
				NEG        ebx                   ;
Suma:
				ADD        eax, ebx              ; Dodanie obu wczytanych liczb z kontrola przepelnienia
				JO         Przepelnienie         ; i zapisanie wyniku do 32-bitowej zmiennej Wynik
				MOV        [Wynik], eax          ;
				
				MOV        ebx, 10               ; Ustawienie rejestrow potrzebnych
				MOV        bp, sp                ; do algorytmu konwersji liczby do napisu
				
				MOV        byte ptr [Ujemna], 0  ;
			    CMP        dword ptr [Wynik], 0  ; Ustawienie flagi znaku gdy wynik jest ujemny
				JNS        LiczbaDoNapisu        ; oraz konwersja na liczbe dodatnia
				MOV        byte ptr [Ujemna], 1  ;
				NEG        eax                   ;
				
LiczbaDoNapisu:
			    CDQ                              ;
				IDIV       ebx                   ; Algorytm konwersji liczby zapisanej w zmiennej Wynik
				ADD        edx, MIN              ; do napisu
				PUSH       dx                    ;
				TEST       eax,eax               ;
				JNZ        LiczbaDoNapisu        ;
				
				CMP        byte ptr [ujemna], 1  ; 
				JNE        WczytywanieZeStosu    ; Wrzucenie na stos dodatkowo znaku "-"
				MOV        dx, MINUS             ; gdy liczba jest ujemna
				PUSH       dx                    ;
WczytywanieZeStosu:
			    MOV        si, OFFSET WynikNapis ; Ustawienie wsakznika na zmienna WynikNapis
PetlaWczytywania:
				POP        ax                    ;
				MOV        [si], al              ; Wczytanie znakow ze stosu do zmiennej
				INC        si                    ; WynikNapis i zakonczenie wczytywania
				CMP        bp, sp                ; gdy wskaznik stosu bedzie wskazywac jego
				JNE        PetlaWczytywania      ; spod
WyswietlenieWyniku:
			    XOR        ax, ax                ;
				XOR        dx, dx                ;
				MOV        ah, 09h               ; Wypisanie napisu zawartego w zmiennej WynikNapis na ekran
				MOV        dx, OFFSET WynikNapis ; i zakonczenie programu
				INT        21h                   ;
				JMP        Koniec
;---------------BLEDY-I-ZAKONCZENIE-------------------------------------------------------------------------------------------------------
NieLiczba:
			    XOR        ax, ax                ;
				MOV        ah, 09h               ; Wypisanie napisu zawartego w zmiennej BladNaN na ekran i przejscie do nowej linii
				MOV        dx, OFFSET BladNaN    ;
				INT        21h                   ;
				JMP        Koniec
Przepelnienie:
				XOR        ax, ax                ;
				MOV        ah, 09h               ; Wypisanie napisu zawartego w zmiennej BladOf na ekran i przejscie do nowej linii
				MOV        dx, OFFSET BladOf     ;
				INT        21h                   ;
		   
Koniec:         MOV        ax, 4C00h             ; Zakonczenie Programu z kodem wyjscia 0
                INT        21h                   ;
			   
Kod             ENDS

                END        Start