<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" indent="yes"/>
<xsl:template match="/">
<xsl:apply-templates select="grupaStudentow"/>
<xsl:apply-templates select="/osoby/grupaStudentow/student[3]"/>


<xsl:text>Zadanie 2</xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:text>A. Elementy student o wieku powyżej 21 lat                             : </xsl:text><xsl:for-each select="//student[wiek>21]"><xsl:value-of select="."/></xsl:for-each><xsl:text>&#xA;</xsl:text>
<xsl:text>B. Wszystkie elementy student, ktore maja atrybut "plec" o wartosci "k": </xsl:text><xsl:for-each select="//student[@plec='k']"><xsl:value-of select="."/></xsl:for-each><xsl:text>&#xA;</xsl:text>
<xsl:text>C. Wszyscy pracownicy, ktorzy sa mezczyznami                           : </xsl:text><xsl:for-each select="//pracownik[@plec='m']"><xsl:value-of select="."/></xsl:for-each><xsl:text>&#xA;</xsl:text>
<xsl:text>D. Wszyscy pracownicy, ktorych numer jest wiekszy od 40000             : </xsl:text><xsl:for-each select="//pracownik[nr_prac>40000]"><xsl:value-of select="."/></xsl:for-each><xsl:text>&#xA;</xsl:text><xsl:text>&#xA;</xsl:text>

<xsl:text>Zadanie 3</xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:text>A. Drugie wystapienie elementu student                                 : </xsl:text><xsl:value-of select="//student[position() = 2]"/><xsl:text>&#xA;</xsl:text>
<xsl:text>B. Trzecie i kolejne wystapienie elementu student                      : </xsl:text><xsl:for-each select="//student[position() = 3 or position() = 4]"><xsl:value-of select="."/></xsl:for-each><xsl:text>&#xA;</xsl:text>
<xsl:text>C. Wszystkich poza drugim wystapieniem elementu student                : </xsl:text><xsl:for-each select="//student[not(position() = 2)]"><xsl:value-of select="."/></xsl:for-each><xsl:text>&#xA;</xsl:text>
<xsl:text>D. Wszystkie elementy, ktore sa drugim dzieckiem swojego ojca          : </xsl:text><xsl:for-each select="//*[position() = 2]"><xsl:value-of select="."/></xsl:for-each><xsl:text>&#xA;</xsl:text>
<xsl:text>E. Przedostatniego studenta oraz pracownika                            : </xsl:text><xsl:for-each select="//student[position() = last()-1] | //pracownik[position() = last()-1]"><xsl:value-of select="."/></xsl:for-each><xsl:text>&#xA;</xsl:text>
<xsl:text>F. Od drugiego wlacznie pracownika                                     : </xsl:text><xsl:for-each select="//pracownik[position() >= 2]"><xsl:value-of select="."/></xsl:for-each><xsl:text>&#xA;</xsl:text><xsl:text>&#xA;</xsl:text>

<xsl:text>Zadanie 4</xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:text>A. Wszystkie wartosci wiek korzystajac z funkcji text()                : </xsl:text><xsl:for-each select="//wiek"><xsl:value-of select="text()"/></xsl:for-each><xsl:text>&#xA;</xsl:text>
<xsl:text>B. Sume wartosci wiek wszystkich pracownikow                           : </xsl:text><xsl:value-of select="sum(//pracownik/wiek)"/><xsl:text>&#xA;</xsl:text>
<xsl:text>C. Srednia wieku mezczyzn                                              : </xsl:text><!--<xsl:value-of select="avg(//*[@plec='m']/wiek)"/>--><xsl:text>&#xA;</xsl:text><!-- Poprawne tylko dla XPath 2.0. Przy braku wsparcie translacja sie nie dokona! -->
<xsl:text>D. Lancuch znakow imie oraz nazwisko rozdzielone spacja                : </xsl:text><xsl:for-each select="//student | //pracownik"><xsl:value-of select="concat(imie,' ',nazwisko,' ')"/></xsl:for-each><xsl:text>&#xA;</xsl:text>
<xsl:text>E. Najmlodszego studenta i pracownika                                  : </xsl:text><!--<xsl:for-each select="//student[wiek= min(//student/wiek)] | //pracownik[wiek= min(//pracownik/wiek)]"><xsl:value-of select="."/></xsl:for-each>--><xsl:text>&#xA;</xsl:text><!-- Poprawne tylko dla XPath 2.0. Przy braku wsparcie translacja sie nie dokona! -->
<xsl:text>F. Liczbe kobiet i mezczyzn(zarowno studentow, jak i pracownikow)      : </xsl:text><xsl:value-of select="concat(count(//student[@plec='k'] | //pracownik[@plec='k']),' ', count(//student[@plec='m'] | //pracownik[@plec='m']))"/><xsl:text>&#xA;</xsl:text>
<xsl:text>G. Liczbe kobiet i mezczyzn dla poszczegolnych grup osobno             : </xsl:text><xsl:value-of select="concat('(',count(//student[@plec='k']),',',count(//student[@plec='m']),')',' (',count(//pracownik[@plec='k']),',',count(//pracownik[@plec='m']),')')"/><xsl:text>&#xA;</xsl:text>
<xsl:text>H. Najmniejsza i najwieksza liczbe zdobytych punktow przez studentow   : </xsl:text><!--<xsl:value-of select="concat(min(//student/zdobytePunkty),' ',max(//student/zdobytePunkty))"/>--><xsl:text>&#xA;</xsl:text><!-- Poprawne tylko dla XPath 2.0. Przy braku wsparcie translacja sie nie dokona! -->
<xsl:text>I. Srednia liczbe punktow zdobytych przez studentow                    : </xsl:text><!--<xsl:value-of select="avg(//student/zdobytePunkty)"/>--><xsl:text>&#xA;</xsl:text><!-- Poprawne tylko dla XPath 2.0. Przy braku wsparcie translacja sie nie dokona! -->
<xsl:text>J. Liczbe studentow, ktorzy zdali czyli zyskali powyzej 50 punktow     : </xsl:text><xsl:value-of select="count(//student[zdobytePunkty > 50])"/><xsl:text>&#xA;</xsl:text><xsl:text>&#xA;</xsl:text>

</xsl:template>

<xsl:template match="/osoby/grupaStudentow/student[3]">
<xsl:text>Zadanie 1</xsl:text><xsl:text>&#xA;</xsl:text>
<xsl:text>A. Nazwisko biezacego elementu                                   : </xsl:text><xsl:value-of select="child::nazwisko"/><xsl:text>&#xA;</xsl:text>
<xsl:text>B. Element biezacy student wraz z podelementami                  : </xsl:text><xsl:value-of select="self::node()"/><xsl:text>&#xA;</xsl:text>
<xsl:text>C. Element o nazwie grupaPracownikow                             : </xsl:text><xsl:value-of select="parent::grupaStudentow/following-sibling::grupaPracownikow"/><xsl:text>&#xA;</xsl:text>
<xsl:text>D. Punkty studenta o imieniu Stefania                            : </xsl:text><xsl:value-of select="parent::grupaStudentow/child::student[imie='Stefania']/child::zdobytePunkty"/><xsl:text>&#xA;</xsl:text>
<xsl:text>E. NrAlbumu i wiek biezacego elementu student                    : </xsl:text><xsl:for-each select="child::nrAlbumu | child::wiek"><xsl:value-of select="self::node()"/></xsl:for-each><xsl:text>&#xA;</xsl:text>
<xsl:text>F. Wiek studenta o imieniu Aleksandra                            : </xsl:text><xsl:value-of select="parent::grupaStudentow/child::student[imie='Aleksandra']/child::wiek"/><xsl:text>&#xA;</xsl:text>
<xsl:text>G. Numery wszystkich pracownikow                                 : </xsl:text><xsl:for-each select="following::nr_prac"><xsl:value-of select="self::node()"/></xsl:for-each><xsl:text>&#xA;</xsl:text>
<xsl:text>H. Plec studentow Aleksandra i Teofil oraz wszystkich pracownikow: </xsl:text><xsl:for-each select="ancestor::osoby/descendant::student[imie='Aleksandra' or imie='Teofil']/attribute::plec | ancestor::osoby/descendant::pracownik/attribute::plec "><xsl:value-of select="self::node()"/></xsl:for-each><xsl:text>&#xA;</xsl:text><xsl:text>&#xA;</xsl:text>
</xsl:template>

<xsl:template match="grupaStudentow">
</xsl:template>
</xsl:stylesheet>