<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">

<xsl:text>                                                                     SPIS KSIĄŻEK                                                                                 </xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:text>__________________________________________________________________________________________________________________________________________________________________</xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:text>|         ISBN        |                   Tytuł              |          Autor         |         Gatunek        |   Wydawca    |  Wydanie  |   Cena   | Na Stanie |</xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:text>|*********************|**************************************|************************|************************|**************|***********|**********|***********|</xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:for-each select="//ksiazka">
<xsl:sort select="tytul"/>
<xsl:value-of select="concat('|  ',string(isbn),'     ',string(tytul),substring('                                        ',1,40-string-length(string(tytul))),string(autor),substring('                         ',1,25-string-length(string(autor))),string(gatunek),substring('                         ',1,25-string-length(string(gatunek))),string(wydawca),substring('               ',1,15-string-length(string(wydawca))),string(rok_wydania),substring('            ',1,12-string-length(string(rok_wydania))),string(cena),substring('           ',1,11-string-length(string(cena))),string(na_stanie),'     |')"/><xsl:text>&#xA;</xsl:text>
</xsl:for-each>
<xsl:text>|________________________________________________________________________________________________________________________________________________________________|</xsl:text><xsl:text>&#xA;</xsl:text><xsl:text>&#xA;</xsl:text>

<xsl:text>                                                                    WYPOŻYCZENIA                                                                                </xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:text>__________________________________________________________________________________________________________________________________________________________________</xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:text>|        Wypożyczający      |     PESEL     |         ISBN        |                   Tytuł              |          Autor         |  Wypożyczono  |   Zwrócono   |</xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:text>|***************************|***************|*********************|**************************************|************************|***************|**************|</xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:for-each select="//pozycja">
<xsl:sort select="tytul"/>
<xsl:value-of select="concat('|  ',substring(wypozyczajacy,1,string-length(wypozyczajacy)-12),substring('                            ',1,27-string-length(substring(wypozyczajacy,1,string-length(wypozyczajacy)-12))),substring(wypozyczajacy,string-length(wypozyczajacy)-11),'     ',isbn,'     ',string(tytul),substring('                                        ',1,39-string-length(string(tytul))),string(autor),substring('                         ',1,25-string-length(string(autor))),string(data_wypozyczenia),substring('                ',1,16-string-length(string(data_wypozyczenia))),string(data_zwrotu),substring('          ',1,10-string-length(string(data_zwrotu))),'  |')"/><xsl:text>&#xA;</xsl:text>
</xsl:for-each>
<xsl:text>|________________________________________________________________________________________________________________________________________________________________|</xsl:text><xsl:text>&#xA;</xsl:text><xsl:text>&#xA;</xsl:text>

<xsl:text>                             KLIENCI                                </xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:text>____________________________________________________________________</xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:text>|     PESEL     |     Imię     |   Nazwisko   |  Ilość Wypożyczeń  |</xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:text>|***************|**************|**************|********************|</xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:for-each select="//klient">
<xsl:sort select="imie"/>
<xsl:value-of select="concat('|  ',pesel,'     ',imie,substring('               ',1,15-string-length(imie)),nazwisko,substring('                      ',1,22-string-length(nazwisko)),ilosc_wypozyczen,substring('            ',1,11-string-length(ilosc_wypozyczen)),'|')"/><xsl:text>&#xA;</xsl:text>
</xsl:for-each>
<xsl:text>|__________________________________________________________________|</xsl:text><xsl:text>&#xA;</xsl:text><xsl:text>&#xA;</xsl:text>

<xsl:text>                             WYDAWNICTWA                                </xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:text>_________________________________________________________________________</xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:text>|     ID     |     Nazwa     |         E-mail         |  Ilość Książek  |</xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:text>|************|***************|************************|*****************|</xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:for-each select="//wydawnictwo">
<xsl:sort select="imie"/>
<xsl:variable name='nazwa' select='nazwa'/>
<xsl:value-of select="concat('|   ',id,substring('             ',1,12-string-length(id)),nazwa,substring('                ',1,16-string-length(nazwa)),email,substring('                               ',1,31-string-length(email)),ancestor::raport//ilosc_ksiazek/child::*[name()= translate($nazwa, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') ],'        |')"/><xsl:text>&#xA;</xsl:text>
</xsl:for-each>
<xsl:text>|_______________________________________________________________________|</xsl:text><xsl:text>&#xA;</xsl:text><xsl:text>&#xA;</xsl:text>


<xsl:text>PODSUMOWANIE</xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:text>_________________________________________________________________________</xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:text>Ilość kryminałów                   : </xsl:text>
<xsl:value-of select="//ilosc_ksiazek/kryminal"/><xsl:text>&#xA;</xsl:text>
<xsl:text>Ilość fantastyki                   : </xsl:text>
<xsl:value-of select="//ilosc_ksiazek/fantastyka"/><xsl:text>&#xA;</xsl:text>
<xsl:text>Ilość poradników                   : </xsl:text>
<xsl:value-of select="//ilosc_ksiazek/poradnik"/><xsl:text>&#xA;</xsl:text>
<xsl:text>Ilość horrorów                     : </xsl:text>
<xsl:value-of select="//ilosc_ksiazek/horror"/><xsl:text>&#xA;</xsl:text>
<xsl:text>Ilość książek na stanie            : </xsl:text>
<xsl:value-of select="//ilosc_ksiazek/na_stanie"/><xsl:text>&#xA;</xsl:text>
<xsl:text>Ilość książek obecnie wypożyczonych: </xsl:text>
<xsl:value-of select="//ilosc_ksiazek/wypozyczone"/><xsl:text>&#xA;</xsl:text>
<xsl:text>Ilość książek                      : </xsl:text>
<xsl:value-of select="//ilosc_ksiazek/razem"/><xsl:text>&#xA;</xsl:text>
<xsl:text>Wartość kryminałów                 : </xsl:text>
<xsl:value-of select="//wartosc_ksiazek/kryminal"/><xsl:text>&#xA;</xsl:text>
<xsl:text>Wartość fantastyki                 : </xsl:text>
<xsl:value-of select="//wartosc_ksiazek/fantastyka"/><xsl:text>&#xA;</xsl:text>
<xsl:text>Wartość poradników                 : </xsl:text>
<xsl:value-of select="//wartosc_ksiazek/poradnik"/><xsl:text>&#xA;</xsl:text>
<xsl:text>Wartość horrorów                   : </xsl:text>
<xsl:value-of select="//wartosc_ksiazek/horror"/><xsl:text>&#xA;</xsl:text>
<xsl:text>Wartość książek                    : </xsl:text>
<xsl:value-of select="//wartosc_ksiazek/razem"/><xsl:text>&#xA;</xsl:text>
<xsl:text>Średnia wartość kryminałów         : </xsl:text>
<xsl:value-of select="//srednie/kryminal"/><xsl:text>&#xA;</xsl:text>
<xsl:text>Średnia wartość fantastyki         : </xsl:text>
<xsl:value-of select="//srednie/fantastyka"/><xsl:text>&#xA;</xsl:text>
<xsl:text>Średnia wartość poradników         : </xsl:text>
<xsl:value-of select="//srednie/poradnik"/><xsl:text>&#xA;</xsl:text>
<xsl:text>Średnia wartość horrorów           : </xsl:text>
<xsl:value-of select="//srednie/horror"/><xsl:text>&#xA;</xsl:text>
<xsl:text>Średnia wartość książek            : </xsl:text>
<xsl:value-of select="//srednie/razem"/><xsl:text>&#xA;</xsl:text>
<xsl:text>Najdroższa książka                 : </xsl:text>
<xsl:value-of select="//ranking/najdrozsza"/><xsl:text>&#xA;</xsl:text>
<xsl:text>Najtansza książka                  : </xsl:text>
<xsl:value-of select="//ranking/najtansza"/><xsl:text>&#xA;</xsl:text>

<xsl:text>_________________________________________________________________________</xsl:text><xsl:text>&#xA;</xsl:text><xsl:text>&#xA;</xsl:text>


<xsl:text>AUTOR</xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:text>_________________________________________________________________________</xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:value-of select="concat('Imię    : ',//autor/imie,'&#xA;','Nazwisko: ',//autor/nazwisko,'&#xA;','Indeks  : ',//autor/indeks,'&#xA;')"/>
<xsl:text>_________________________________________________________________________</xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:text>Data wygenerowania raportu: </xsl:text>
<xsl:value-of select="//data"/>

</xsl:template>

</xsl:stylesheet>