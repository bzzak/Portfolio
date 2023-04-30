#include <iostream>
#include <algorithm>
#include <fstream>
#include <vector>
#include <string>
#include <iomanip>

using namespace std;

struct Irys {
    double dlugosc_dzialki;
    double szerokosc_dzialki;
    double dlugosc_platka;
    double szerokosc_platka;
    int gatunek;
};

bool wczytajDane(vector<Irys>*, string, int);
void wyswietl_wyniki(double, double, double, double, double, double, double);
double potega(double, int);
double pierwiastek_kwadratowy(double, int);
int cyfry(double);

int main()
{
    vector<Irys> irysy;
    vector<double> dlugosc_dzialki;
    vector<double> szerokosc_dzialki;
    vector<double> dlugosc_platka;
    vector<double> szerokosc_platka;
    wczytajDane(&irysy, "data.csv", 5);
    double setosa = 0,versicolor = 0,virginica = 0;
    double min1 = 0,min2 = 0,min3 = 0,min4 = 0,maks1 = 0,maks2 = 0,maks3 = 0,maks4 = 0;
    double suma1 = 0, suma2 = 0, suma3 = 0, suma4 = 0;
    double suma1_odchylenie = 0, suma2_odchylenie = 0, suma3_odchylenie = 0, suma4_odchylenie = 0;
    double srednia1, srednia2, srednia3, srednia4;
    double odchylenie1, odchylenie2, odchylenie3, odchylenie4;
    double polowa = irysy.size()/2.0;
    double cwiartka = irysy.size()/4.0;
    double mediana1, mediana2, mediana3, mediana4;
    double kwartylD1 = 0, kwartylD2 = 0, kwartylD3 = 0, kwartylD4 = 0;
    double kwartylG1 = 0, kwartylG2 = 0, kwartylG3 = 0, kwartylG4 = 0;

    for(int i = 0; i < irysy.size(); i++) {
        if(irysy[i].gatunek == 0) setosa++;
        else if(irysy[i].gatunek == 1) versicolor++;
        else virginica++;
        suma1 += irysy[i].dlugosc_dzialki;
        suma2 += irysy[i].szerokosc_dzialki;
        suma3 += irysy[i].dlugosc_platka;
        suma4 += irysy[i].szerokosc_platka;
        dlugosc_dzialki.push_back(irysy[i].dlugosc_dzialki);
        szerokosc_dzialki.push_back(irysy[i].szerokosc_dzialki);
        dlugosc_platka.push_back(irysy[i].dlugosc_platka);
        szerokosc_platka.push_back(irysy[i].szerokosc_platka);
    }

    sort(dlugosc_dzialki.begin(),dlugosc_dzialki.end());
    sort(szerokosc_dzialki.begin(),szerokosc_dzialki.end());
    sort(dlugosc_platka.begin(),dlugosc_platka.end());
    sort(szerokosc_platka.begin(),szerokosc_platka.end());

    min1 = dlugosc_dzialki[0];
    maks1 = dlugosc_dzialki[irysy.size()-1];
    min2 = szerokosc_dzialki[0];
    maks2 = szerokosc_dzialki[irysy.size()-1];
    min3 = dlugosc_platka[0];
    maks3 = dlugosc_platka[irysy.size()-1];
    min4 = szerokosc_platka[0];
    maks4 = szerokosc_platka[irysy.size()-1];

    if(irysy.size()%2 == 0) {
        mediana1 = (dlugosc_dzialki[polowa]+dlugosc_dzialki[polowa-1])/2;
        mediana2 = (szerokosc_dzialki[polowa]+szerokosc_dzialki[polowa-1])/2;
        mediana3 = (dlugosc_platka[polowa]+dlugosc_platka[polowa-1])/2;
        mediana4 = (szerokosc_platka[polowa]+szerokosc_platka[polowa-1])/2;

    } else {
        mediana1 = dlugosc_dzialki[polowa];
        mediana2 = szerokosc_dzialki[polowa];
        mediana3 = dlugosc_platka[polowa];
        mediana4 = szerokosc_platka[polowa];
    }
    if(irysy.size()%4 == 0) {
        kwartylD1 = (dlugosc_dzialki[cwiartka]+dlugosc_dzialki[cwiartka+1])/2;
        kwartylD2 = (szerokosc_dzialki[cwiartka]+szerokosc_dzialki[cwiartka+1])/2;
        kwartylD3 = (dlugosc_platka[cwiartka]+dlugosc_platka[cwiartka+1])/2;
        kwartylD4 = (szerokosc_platka[cwiartka]+szerokosc_platka[cwiartka+1])/2;
        kwartylG1 = (dlugosc_dzialki[irysy.size()-1-cwiartka]+dlugosc_dzialki[irysy.size()-cwiartka])/2;
        kwartylG2 = (szerokosc_dzialki[irysy.size()-1-cwiartka]+szerokosc_dzialki[irysy.size()-cwiartka])/2;
        kwartylG3 = (dlugosc_platka[irysy.size()-1-cwiartka]+dlugosc_platka[irysy.size()-cwiartka])/2;
        kwartylG4 = (szerokosc_platka[irysy.size()-1-cwiartka]+szerokosc_platka[irysy.size()-cwiartka])/2;
    } else {
        kwartylD1 = dlugosc_dzialki[cwiartka];
        kwartylD2 = szerokosc_dzialki[cwiartka];
        kwartylD3 = dlugosc_platka[cwiartka];
        kwartylD4 = szerokosc_platka[cwiartka];
        kwartylG1 = dlugosc_dzialki[irysy.size()-1-cwiartka];
        kwartylG2 = szerokosc_dzialki[irysy.size()-1-cwiartka];
        kwartylG3 = dlugosc_platka[irysy.size()-1-cwiartka];
        kwartylG4 = szerokosc_platka[irysy.size()-1-cwiartka];
    }

    srednia1 = suma1/irysy.size();
    srednia2 = suma2/irysy.size();
    srednia3 = suma3/irysy.size();
    srednia4 = suma4/irysy.size();

    for(int i = 0; i < irysy.size(); i++) {
        suma1_odchylenie += potega(irysy[i].dlugosc_dzialki - srednia1,2);
        suma2_odchylenie += potega(irysy[i].szerokosc_dzialki - srednia2,2);
        suma3_odchylenie += potega(irysy[i].dlugosc_platka - srednia3,2);
        suma4_odchylenie += potega(irysy[i].szerokosc_platka - srednia4,2);
    }

    odchylenie1 = pierwiastek_kwadratowy(suma1_odchylenie/(irysy.size()-1),10);
    odchylenie2 = pierwiastek_kwadratowy(suma2_odchylenie/(irysy.size()-1),10);
    odchylenie3 = pierwiastek_kwadratowy(suma3_odchylenie/(irysy.size()-1),10);
    odchylenie4 = pierwiastek_kwadratowy(suma4_odchylenie/(irysy.size()-1),10);

    cout << "Liczebnosc" << endl;
    cout << "    Setosa: " << " " << setosa << "(" << fixed << setprecision(1) << (setosa/irysy.size())*100 << "%)" << endl;
    cout << fixed << setprecision(0);
    cout << "Versicolor: " << " " << versicolor << "(" << fixed << setprecision(1) << (versicolor/irysy.size())*100 << "%)" << endl;
    cout << fixed << setprecision(0);
    cout << " Virginica: " << " " << virginica << "(" << fixed << setprecision(1) << (virginica/irysy.size())*100 << "%)" << endl;
    cout << "     Razem: " << irysy.size() << "(100.0%)" << endl << endl;

    cout << "Dlugosc dzialki kielicha(cm)" << endl;
    wyswietl_wyniki(min1,maks1,srednia1, odchylenie1, mediana1, kwartylD1, kwartylG1);
    cout << "Szerokosc dzialki kielicha(cm)" << endl;
    wyswietl_wyniki(min2,maks2,srednia2, odchylenie2, mediana2, kwartylD2, kwartylG2);
    cout << "Dlugosc platka(cm)" << endl;
    wyswietl_wyniki(min3,maks3,srednia3, odchylenie3, mediana3, kwartylD3, kwartylG3);
    cout << "Szerokosc platka(cm)" << endl;
    wyswietl_wyniki(min4,maks4,srednia4, odchylenie4, mediana4, kwartylD4, kwartylG4);



    return 0;
}

bool wczytajDane(vector<Irys>* dane, string nazwaPliku, int kolumny) {
    ifstream plik;
    plik.open( nazwaPliku.c_str() );
    if( !plik.good() )
         return false;
     while( true ) {
       vector<double> tmp;
       bool endOfFile = false;
        if( !plik.fail() ) {
            for(int i = 0; i < kolumny; i++) {
                string linia;
                double tmpValue;
                if(i == kolumny - 1)
                getline(plik, linia);
                else {
                getline(plik, linia, ',');
                }
               if(!linia.empty()){
                    tmpValue = stod(linia);
               } else {
                   endOfFile = true;
                   break;
               }
              tmp.push_back(tmpValue);
            }


            if(!endOfFile) dane->push_back({tmp[0],tmp[1],tmp[2],tmp[3],tmp[4]});
        } else  break;

    }
    plik.close();
return true;
  }

void wyswietl_wyniki(double minn, double maxx, double srednia, double odchylenie, double mediana, double kwartyl_dolny, double kwartyl_gorny) {
    cout << fixed << setprecision(2);
    cout << "                     Minimum: " << minn << endl;
    cout << "  Sr. arytm.(+/-odch.stand.): " << srednia << "(+/- " << odchylenie << ")" << endl;
    cout << "              Mediana(Q1-Q3): " << mediana << "(" << kwartyl_dolny << " - " << kwartyl_gorny << ")" << endl;
    cout << "                    Maksimum: " << maxx << endl;
    cout << endl;
}

double potega(double x, int wykladnik) {
    if(wykladnik >= 1)return x * potega(x, wykladnik-1);
    else if(wykladnik == 0) return 1;
    else return 1.0/potega(x,wykladnik*(-1));
}

double pierwiastek_kwadratowy(double x, int precyzja) {
    int n;
    double x0, pierwiastek, epsilon;
    if(x < 0) x *= (-1);
    if(x == 0) return 0;
    if(x == 1) return 1;
    if(x > 1) {
        int d = cyfry(x);
        if(d%2 == 0) {
            n = d/2;
            x0 = 6 * potega(10,n);
        } else {
            n = (d-1)/2;
            x0 = 2 * potega(10,n);
        }
    }
    if(x < 1) {
        if(precyzja%2 == 0) {
            n = precyzja/2;
            x0 = 6 * potega(10,n);
        } else {
            n = (precyzja-1)/2;
            x0 = 2 * potega(10,n);
        }
    }
    do {
        pierwiastek = (x0 + (x/x0))/2;
        epsilon = pierwiastek - x0;
        if(epsilon < 0) epsilon *= (-1);
        x0 = pierwiastek;
    }while(epsilon > 0.1/potega(10,precyzja-1));
    return pierwiastek;
}

int cyfry(double x) {
    int licznik = 0;
    if(x < 1) return 1;
    while(x > 1) {
        x /= 10;
        licznik++;
    }
return licznik;
}


