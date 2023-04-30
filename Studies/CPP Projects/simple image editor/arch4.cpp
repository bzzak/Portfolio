//=============================================================================//
//                                                                             //
// Plik           : arch4.cpp                                                  //
// Format         : EXE                                                        // 
// Cwiczenie      : Tryb Graficzny                                             //
// Autorzy        : Bartosz Zak, grupa 4, sroda, 12:30                         //
// Data zaliczenia: 10.06.2021                                                 //
// Uwagi          : Program wyswietla obrazy zawarte w folderze "obrazki"      //
//                  dolaczonym do archiwum zip w trybie graficznym 13h, a      //
//                  nastepnie daje mozliwosc modyfikacji jasnosci, progowania, //
//                  kontrastu oraz zastosowania negatywu.                      //
//=============================================================================//

#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <dos.h>
#include <iostream.h>
#include <string.h>

//--DEFINICJE--TYPOW---------------------------------------------------//

typedef unsigned char BYTE;
typedef unsigned int  WORD;
typedef unsigned int  UINT;
typedef unsigned long DWORD;
typedef unsigned long LONG;

//--ZMIENNE--GLOBALNE-------------------------------------------------//

BYTE *video_bufor;
BYTE *video_bufor2;
BYTE aero[] = "obrazki/aero.bmp";
BYTE boat[] = "obrazki/boat.BMP";
BYTE bridge[] = "obrazki/bridge.BMP";
BYTE lena[] = "obrazki/lena.bmp";
BYTE obrazek[20];
int max = 260;
int value = 0;
double cRatio = 1;
BYTE neg = 0;
BYTE end = 0;

//--STRUKTURY--BITMAPY-------------------------------------------------//
struct BITMAPFILEHEADER
{
 UINT  bfType;
 DWORD bfSize;
 UINT  bfReserved1;
 UINT  bfReserved2;
 DWORD bfOffBits;
};

struct BITMAPINFOHEADER
{
 DWORD biSize;
 LONG  biWidth;
 LONG  biHeight;
 WORD  biPlanes;
 WORD  biBitCount;
 DWORD biCompression;
 DWORD biSizeImage;
 LONG  biXPelsPerMeter;
 LONG  biYPelsPerMeter;
 DWORD biClrUsed;
 DWORD biClrImportant;
};

struct RGBQUAD
{
 BYTE rgbBlue;
 BYTE rgbGreen;
 BYTE rgbRed;
 BYTE rgbReserved;
};

//--ZMIENNE--ZWIAZANE--Z--PLIKIEM--BITMAPY----------------------------------------//

BITMAPFILEHEADER bmfh;
BITMAPINFOHEADER bmih;
RGBQUAD palette[256];
BYTE far *video_memory = (BYTE far *)0xA0000000L;
FILE *bitmap_file;

//--ALGORYTM--ZMIANY--TRYBU--WYSWIETLANIA----------------------------------------//

void set_video_mode(int mode)
{
 REGPACK regs;
 regs.r_ax = mode;
 intr(0x10, &regs);
}

//--ALGORYTMY--POPRAWNEJ--ORIENTACJI--OBRAZU-------------------------------------//

void rotate180(BYTE  *vm)
{
	int j = 0;
	for(int i = bmih.biWidth*bmih.biHeight-1; i>(bmih.biWidth*bmih.biHeight-1)/2;i--)
	{
		BYTE buff = vm[j];
		vm[j] = vm[i];
		vm[i] = buff;
		j++;
	}
}

void mirror(BYTE  *vm)
{
	int k;
	for(int i = 0; i<bmih.biHeight;i++)
	{
		k = 0;
		for(int j = bmih.biWidth-1; j>(bmih.biWidth-1)/2;j--)
		{
		BYTE buff = vm[i*bmih.biWidth+k];
		vm[i*bmih.biWidth+k] = vm[i*bmih.biWidth+j];
		vm[i*bmih.biWidth+j] = buff;
		k++;
		}
	}
}
//--USTAWIANIE--PALETY------------------------------------------------------//
void set_video_palette()
{
 outportb(0x03C8, 0);
 for (int i = 0; i < bmih.biClrUsed; i++)
 {
  outp(0x03C9, palette[i].rgbRed   * 63 / 255);
  outp(0x03C9, palette[i].rgbGreen * 63 / 255);                              
  outp(0x03C9, palette[i].rgbBlue  * 63 / 255);
 }
}
//--ALGORYTM--INICJUJACY--STRUKTURY--I--ODPOWIEDNIE--BUFORY------------------//
void display_image_data(char *file_name)
{
 bitmap_file = fopen(file_name, "rb");
 fread(&bmfh, sizeof(bmfh), 1, bitmap_file);
 fread(&bmih, sizeof(bmih), 1, bitmap_file);
 fread(&palette[0], bmih.biClrUsed * sizeof(RGBQUAD),  1, bitmap_file);
 video_bufor = new BYTE [bmih.biWidth*bmih.biHeight];
 video_bufor2 = new BYTE [bmih.biWidth*bmih.biHeight];
 fread(&video_bufor[0], bmih.biWidth * bmih.biHeight, 1, bitmap_file);
 memcpy(video_bufor2,video_bufor,bmih.biWidth*bmih.biHeight);
 fclose(bitmap_file);
}

//--ALGORYTMY--MODYFIKACJI--OBRAZU------------------------------------------//
void negative(BYTE *vb, WORD size)
{
	for(int i=0; i<size; i++)
	{
		vb[i]= ~vb[i];
	}
}

void brightness(BYTE *vb, int val, WORD size)
{
	if(value > 255) value = 255;
	else if(value < -255) value = -255; 
	for(int i=0; i<size; i++)
	{
		int buff = vb[i];
		buff+=val;
		if(buff>=255) vb[i]=255;
		else if(buff<=0) vb[i]=0;
		else vb[i]=buff;	
	}
}


void tresholding(BYTE *vb, int max, WORD size)
{
	if(max>260) max=260;
	if(max<0) max=0;
	for(int i=0; i<size; i++)
	{
		if(vb[i]>=max)vb[i] = 0;
	}
}

void contrast(BYTE *vb, double ratio, WORD size){
	if(ratio<0) ratio = 0;
	for(int i=0; i<size; i++)
	{
		double buff = ratio*(vb[i]-255/2.0)+255/2.0;
		if(buff>=255) vb[i]=255;
		else if(buff<=0) vb[i]=0;
		else vb[i]=(int)buff;	
	}
	
}

void reset() {
	max = 260;
	value = 0;
	neg = 0;
	end = 0;
	cRatio = 1;
}
//--PROGRAM--GLOWNY-----------------------------------------------------------------------//
int main(){
	system("cls");
	do{
		cout << "Program wyswietlajacy obrazy zapisane w rozszerzeniu bmp w trybie graficznym 13.";
		cout << "Uzytkownik moze za pomoca odpowiednich przyciskow na klawiaturze sterowac" << endl;
		cout << "odpowiednio jasnoscia obrazu, progowaniem oraz negatywem. Obrazy dostepne sa" << endl;
		cout << "jedynie w skali szarosci, a uzytkownik moze wybrac, ktory obraz chce wyswietlic i modyfikowac." << endl;
		cout << "Sterowanie: " << endl;
		cout << "[strzalka w lewo] - przyciemnianie obrazu." << endl;
		cout << "[strzalka w prawo] - rozjasnianie obrazu." << endl;
		cout << "[strzalka w gore] - zwiekszenie progu obrazu." << endl;
		cout << "[strzalka w dol] - zmniejszenie progu obrazu." << endl;
		cout << "[.] - zwieksz kontrast." << endl;
		cout << "[,] - zmniejsz kontrast." << endl;
		cout << "[n] - wlacz/wylacz negatyw." << endl;
		cout << "[r] - resetuje obraz do poczatkowych wartosci." << endl;
		cout << "[kazdy inny klawisz] - powrot do tego menu." << endl << endl;

		cout << "Wybierz obraz lub wyjdz z programu(wcisnij 1,2,3,4 lub 5): " << endl;
		cout << "1) aero.bmp " << endl;
		cout << "2) boat.bmp" << endl;
		cout << "3) bridge.bmp" << endl;
		cout << "4) lena.bmp" << endl;
		cout << "5) Wyjscie z programu." << endl;

		BYTE ch;
		int flag = 0;
		do{
			ch = getch();
			switch(ch){
				case '1':
				strcpy(obrazek,aero);
				break;
				case '2':
				strcpy(obrazek,boat);
				break;
				case '3':
				strcpy(obrazek,bridge);
				break;
				case '4':
				strcpy(obrazek,lena);
				break;
				case '5':
				return 0;
				default:
				break;
			}
			flag = ( ch == '1' || ch == '2' || ch == '3' || ch == '4') ? 1 : 0;
		}while(!flag);
		 
		system("cls");
		display_image_data(obrazek); 
		set_video_mode(0x13);  
		rotate180(video_bufor); 
		mirror(video_bufor);
		rotate180(video_bufor2); 
		mirror(video_bufor2);    
		set_video_palette();  
		memcpy(video_memory,video_bufor,bmih.biWidth*bmih.biHeight);  
		 
		 flag = 0;
		 do{
			 ch = getch();
			 if(ch == 0) {
					ch = getch();

					switch(ch){
						case 'H':
						   //arrow up
							max -= 5;
							break;
						case 'K':
							//arrow left
							value -= 5;
							break;
						case 'P':
						   //arrow down
							max += 5;
							break;
						case 'M':
							//arrow right
							value += 5;
							break;
						default:
						end = 1;
						break;
					}
				flag = ( ch == 'H' || ch == 'K' || ch == 'P' || ch == 'M') ? 1 : 0;
				} else {
					switch(ch) {
						 case 'n':
						 neg = (neg == 0) ? 1 : 0;
						 break;
						 case ',':
						 cRatio += 0.1;
						 break;
						 case '.':
						 cRatio -= 0.1;
						 break;
						 case 'r':
						 reset();
						 break;
						 default:
						 end = 1;
						 break;
					}
				flag = (ch == 'n' || ch == 'r' || ch == ',' || ch == '.') ? 1 : 0;
				}
			 memcpy(video_bufor2,video_bufor,bmih.biWidth*bmih.biHeight); 
			 brightness(video_bufor2, value, bmih.biWidth*bmih.biHeight);
			 contrast(video_bufor2, cRatio, bmih.biWidth*bmih.biHeight);
			 if(neg) negative(video_bufor2,bmih.biWidth*bmih.biHeight);
			 tresholding(video_bufor2, max, bmih.biWidth*bmih.biHeight);
			 if(!end) memcpy(video_memory,video_bufor2, bmih.biWidth*bmih.biHeight);
		 }while(flag);
		 set_video_mode(0x03);
		 delete [] video_bufor;
		 delete [] video_bufor2;
		 reset();
	}while(1);
}