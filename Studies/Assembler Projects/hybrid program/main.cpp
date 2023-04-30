//=============================================================================//
//                                                                             //
// Plik           : main.cpp - modul glowny                                    //
// Format         : EXE                                                        //
// Cwiczenie      : Program hybrydowy                                          //
// Autorzy        : Bartosz Zak, grupa 4, sroda, 12:30                         //
// Data zaliczenia: 12.05.2021                                                 //
// Uwagi          : Program liczacy srednia liczb rzeczywistych z tablicy      //
//                  wczytanej przez uzytkownika oraz zliczajacy ilosc          //
//                  wystapien wybranego znaku w lancuchu wczytanym przez       //
//                  uzytkownika.                                               //
//=============================================================================//

#include <iostream.h>
#include <conio.h>
#include <string.h>
#include <stdlib.h>
// #include <sstream.h>


// using namespace std;

void end(int &);
void task1(void);
void task2(void);
extern "C" double array_average(double *, int);             // Mowimy kompilatorowi ze te funkcje znajduja sie w innym module i bede dostepne dopiero na etapie
extern "C" unsigned int char_search(char *, char);          // konsolidacji. Dzieki temu na etapie kompilacji nie wyskoczy nam blad. Dodatkowo mowimy by modyfikowal
                                                            // nazwy tych funkcji zgodnie z konwencja jezyka C, a nie zgodnie z konwencja jezyka C++.

int main () {

int quit = 0;

do {
    cout << "Program hybrydowy realizujacy poszczegolne zadania za pomoca" << endl
         << "funkcji znajdujacych sie w osobnym module asemblerowym." << endl
         << "Wcisnij klawisz 1, 2 lub 3 aby wybrac odpowiednie zadanie lub wyjsc z programu." << endl << endl;

    cout << "1) Oblicza srednia wartosc elementow tablicy liczb rzeczywistych wczesniej zdefiniowanej przez uzytkownika." << endl
         << "2) Oblicza ile razy podany znak wystapil w lancuchu znakow wprowadzonym przez uzytkownika." << endl
         << "3) Wyjscie z programu." << endl;

    char s = getch();
    system("cls");

    switch(s) {
        case '1':
        task1();
        end(quit);
        break;
        case '2':
        task2();
        end(quit);
        break;
        case '3':
        quit= 1;
        break;
    }

}while(!quit);
    return 0;
}

void end(int &q) {
    int fail;
    char choose;
    do{
        fail = 0;
        cout << "Wyjsc z programu? (t/n): ";
        choose = getche();
        cout << endl;
        if(choose =='t') q = 1;
        else if(choose == 'n') q = 0;
        else {
            fail = 1;
            cout << "Bledna opcja - wprowadz t lub n...";
            getch();
        }
        system("cls");
        }while(fail);
}

void task1() {
        int size;
        int fail;
		// char cancel = 0;
        do{
        fail = 0;
        cout << "Podaj liczbe elementow tablicy: ";

        // string s;
        // cin >> s;

        // stringstream ss;
        // ss << s;


        // int num = 0;
        // ss >> num;

        // if (ss.good() || (num == 0 && s[0] != '0') || num <= 0) 
        // {
            // cin.clear();
            // fail = 1;
            // cout << "Zostala wprowadzona nieprawidlowa wartosc!\nWprowadz liczbe...";
            // getch();
        // } else size = num;
        

        if (!(cin >> size) || size <= 0)
        {
            cin.clear();
            fail = 1;
            cout << "Zostala wprowadzona nieprawidlowa wartosc!\r\nWprowadz liczbe dodatnia...";
            getch();
        } else
		{
			cout << "Wprowadziles/as: " << size << endl;
			cout << "1) Wprowadz wartosc ponownie." << endl;
			cout << "2) Cofnij wprowadzanie i wroc do menu." << endl;
			cout << "Albo wcisnij dowolny inny klawisz aby kontynuowac..." << endl;
			char s = getch();
			switch(s)
			{
				case '1':
				fail = 1;
				break;
				case '2':
				cin.ignore(10000,'\n');
				system("cls");
				return ;
				default:
				break;
			}
			
		}
        cin.ignore(10000,'\n');
        system("cls");
        }while(fail);

        double *fdigits = new double [size];

        for(int i = 0; i < size; i++)
        {
            do{
                fail = 0;
                cout << "Wprowadz wartosc indeksu " << i << ": ";

                // string s;
                // cin >> s;

                // stringstream ss;
                // ss << s;

                // double num = 0;
                // ss >> num;

                // if (ss.good() || (num == 0 && s[0] != '0')) 
                // {
                    // cin.clear();
                    // fail = 1;
                    // cout << "Zostala wprowadzona nieprawidlowa wartosc!\nWprowadz liczbe...";
                    // getch();
                // } else fdigits[i] = num;
                


                if (!(cin >> fdigits[i]))
                {
                cin.clear();
                fail = 1;
                cout << "Zostala wprowadzona nieprawidlowa wartosc!\r\nWprowadz liczbe...";
                getch();
                } else
				{
					cout << "Wprowadziles/as: " << fdigits[i] << endl;
					cout << "1) Wprowadz wartosc ponownie." << endl;
					cout << "2) Cofnij wprowadzanie i wroc do menu." << endl;
					cout << "Albo wcisnij dowolny inny klawisz aby kontynuowac..." << endl;
					char s = getch();
					switch(s)
					{
						case '1':
						fail = 1;
						break;
						case '2':
						delete [] fdigits;
						cin.ignore(10000,'\n');
						system("cls");
						return ;
						default:
						break;
					}
				}
            cin.ignore(10000,'\n');
            system("cls");

            }while(fail);
        }

        cout << "Liczba elementow tablicy: " << size << endl;
		

        for ( int j = 0; j < size; j++)
        {
            cout << "Liczba " << j + 1 << ": " << fdigits[j] << endl;
        }
        
        cout << "Srednia wartosc elementow tablicy wynosi: " << array_average(fdigits,size) << endl;

        delete  [] fdigits;
        cout << "Wcisnij dowolny klawisz aby kontynuowac..." << endl;
        getch();
        system("cls");
}

void task2() {
		char string [2048];
		int fail;
		char c, s, b = '\n';
		
		do
		{
			fail = 0;
			cout << "Prosze wprowadzic lancuch znakow: ";
			if(!(cin.get(string,2048).good()) || strlen(string) == 0)
			// if(!(cin >> string) || strlen(string) == 0)
			{
				fail = 1;
				cin.clear();
				cout << "Wprowadziles/as pusty albo zbyt dlugi lancuch.\r\nProsze wprowadzic nowy!" << endl;
				cout << "Wcisnij dowolny klawisz aby kontynuowac..." << endl;
				getch();
			} else
			{
				cout << "Wprowadziles/as: " << string << endl;
				cout << "1) Wprowadz lancuch ponownie." << endl;
				cout << "2) Cofnij wprowadzanie i wroc do menu." << endl;
				cout << "Albo wcisnij dowolny inny klawisz aby kontynuowac..." << endl;
				// cin.get();
				// cin.get();
				// getch();
				// cin.ignore(10000,'\n');
				// cin.clear();
				// cin.sync();
				
			    s = getch();
				switch(s)
				{
					case '1':
					fail = 1;
					break;
					case '2':
					cin.ignore(10000,'\n');
					system("cls");
					return ;
					default:
					break;
				}
			
			}
			cin.ignore (10000,'\n');
			system("cls");
		}while(fail);
		
		do
		{
			fail = 0;
			cout << "Podaj znak, ktorego liczbe wystapien w lancuchu chcesz poznac: ";
			c = getche();
			cout << endl;
			
			if(c>32)
			{
				cout << "Wprowadziles/as nastepujacy znak: " << c << endl;
			}else
			{
				cout << "Wprowadziles/as bialy znak o nastepujacym kodzie ASCII: " << int(c) << endl;
			}
			
			cout << "1) Wprowadz znak ponownie." << endl;
			cout << "2) Cofnij wprowadzanie i wroc do menu." << endl;
			cout << "Albo wcisnij dowolny inny klawisz aby kontynuowac..." << endl;
			cin.putback(b);
		    s = getch();
			switch(s)
			{
				case '1':
				fail = 1;
				break;
				case '2':
				cin.ignore(10000,'\n');
				system("cls");
				return ;
				default:
				break;
			}
			
			cin.ignore (10000,'\n');
			system("cls");
		}while(fail);
		
		cout << "Lancuch znakow: " << string << endl;
		if(c>32)
		{
			cout << "Szukany znak w lancuchu: " << c << endl;
		} else
		{
			cout << "Szukany znak w lancuchu(kod ASCII): " << int(c) << endl;
		}
		unsigned int count = char_search(string,c);
		if(c>32)
		{
			if(count == 0)
			{
				cout << "Znak " << c << " nie wystepuje w podanym lancuchu znakow." << endl;
			} else if(count == 1)
			{
				cout << "Znak " << c << " wystepuje w podanym lancuchu znakow 1 raz." << endl;
			} else
			{
				cout << "Znak " << c << " wystepuje w podanym lancuchu znakow " << count << " razy." << endl;
			}
		} else
		{
			if(count == 0)
			{
				cout << "Znak o kodzie ASCII " << int(c) << " nie wystepuje w podanym lancuchu znakow." << endl;
			} else if(count == 1)
			{
				cout << "Znak o kodzie ASCII " << int(c) << " wystepuje w podanym lancuchu znakow 1 raz." << endl;
			} else
			{
				cout << "Znak o kodzie ASCII " << int(c) << " wystepuje w podanym lancuchu znakow " << count << " razy." << endl;
			}
		}
        cout << "Wcisnij dowolny klawisz aby kontynuowac..." << endl;
        getch();
        system("cls");
}