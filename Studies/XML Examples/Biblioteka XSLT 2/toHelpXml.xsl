<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:output method="xml" standalone="no"/>

<xsl:template match="/">
<xsl:text>&#xA;</xsl:text>
<raport><xsl:text>&#xA;</xsl:text>
<spis><xsl:text>&#xA;</xsl:text>
<xsl:apply-templates select="//dzial"/>
</spis><xsl:text>&#xA;</xsl:text>
<klienci><xsl:text>&#xA;</xsl:text>
<xsl:apply-templates select="//klienci"/>
</klienci><xsl:text>&#xA;</xsl:text>
<wypozyczenia><xsl:text>&#xA;</xsl:text>
<xsl:apply-templates select="//wypozyczenia"/>
</wypozyczenia><xsl:text>&#xA;</xsl:text>
<wydawnictwa><xsl:text>&#xA;</xsl:text>
<xsl:apply-templates select="//wydawnictwa"/>
</wydawnictwa><xsl:text>&#xA;</xsl:text>
<autor><xsl:text>&#xA;</xsl:text>
<xsl:apply-templates select="//autor_dokumentu"/>
</autor><xsl:text>&#xA;</xsl:text>
<podsumowanie><xsl:text>&#xA;</xsl:text>
<ilosc_ksiazek><xsl:text>&#xA;</xsl:text>
<kryminal><xsl:value-of select="count(//ksiazka[parent::dzial/@id = '_001'])"/></kryminal><xsl:text>&#xA;</xsl:text>
<fantastyka><xsl:value-of select="count(//ksiazka[parent::dzial/@id = '_002'])"/></fantastyka><xsl:text>&#xA;</xsl:text>
<poradnik><xsl:value-of select="count(//ksiazka[parent::dzial/@id = '_003'])"/></poradnik><xsl:text>&#xA;</xsl:text>
<horror><xsl:value-of select="count(//ksiazka[parent::dzial/@id = '_004'])"/></horror><xsl:text>&#xA;</xsl:text>
<arktus><xsl:value-of select="count(//ksiazka[wydawca/@id = '_32412'])"/></arktus><xsl:text>&#xA;</xsl:text>
<obram><xsl:value-of select="count(//ksiazka[wydawca/@id = '_3821'])"/></obram><xsl:text>&#xA;</xsl:text>
<astralis><xsl:value-of select="count(//ksiazka[wydawca/@id = '_276412'])"/></astralis><xsl:text>&#xA;</xsl:text>
<na_stanie><xsl:value-of select="count(//ksiazka[@wypozyczona= 'false'])"/></na_stanie><xsl:text>&#xA;</xsl:text>
<wypozyczone><xsl:value-of select="count(//ksiazka[@wypozyczona= 'true'])"/></wypozyczone><xsl:text>&#xA;</xsl:text>
<razem><xsl:value-of select="count(//ksiazka)"/></razem><xsl:text>&#xA;</xsl:text>
</ilosc_ksiazek><xsl:text>&#xA;</xsl:text>
<wartosc_ksiazek><xsl:text>&#xA;</xsl:text>
<kryminal><xsl:value-of select="round(sum(//ksiazka[parent::dzial/@id = '_001']/cena) * 100) div 100"/></kryminal><xsl:text>&#xA;</xsl:text>
<fantastyka><xsl:value-of select="round(sum(//ksiazka[parent::dzial/@id = '_002']/cena) * 100) div 100"/></fantastyka><xsl:text>&#xA;</xsl:text>
<poradnik><xsl:value-of select="round(sum(//ksiazka[parent::dzial/@id = '_003']/cena) * 100) div 100"/></poradnik><xsl:text>&#xA;</xsl:text>
<horror><xsl:value-of select="round(sum(//ksiazka[parent::dzial/@id = '_004']/cena) * 100) div 100"/></horror><xsl:text>&#xA;</xsl:text>
<razem><xsl:value-of select="round(sum(//ksiazka/cena) * 100) div 100"/></razem><xsl:text>&#xA;</xsl:text>
</wartosc_ksiazek><xsl:text>&#xA;</xsl:text>
<srednie><xsl:text>&#xA;</xsl:text>
<kryminal><xsl:value-of select="round(sum(//ksiazka[parent::dzial/@id = '_001']/cena) div count(//ksiazka[parent::dzial/@id = '_001']/cena) * 100) div 100"/></kryminal><xsl:text>&#xA;</xsl:text>
<fantastyka><xsl:value-of select="round(sum(//ksiazka[parent::dzial/@id = '_002']/cena) div count(//ksiazka[parent::dzial/@id = '_002']/cena) * 100) div 100"/></fantastyka><xsl:text>&#xA;</xsl:text>
<poradnik><xsl:value-of select="round(sum(//ksiazka[parent::dzial/@id = '_003']/cena) div count(//ksiazka[parent::dzial/@id = '_003']/cena) * 100) div 100"/></poradnik><xsl:text>&#xA;</xsl:text>
<horror><xsl:value-of select="round(sum(//ksiazka[parent::dzial/@id = '_004']/cena) div count(//ksiazka[parent::dzial/@id = '_004']/cena) * 100) div 100"/></horror><xsl:text>&#xA;</xsl:text>
<razem><xsl:value-of select="round(sum(//ksiazka/cena) div count(//ksiazka/cena) * 100) div 100"/></razem><xsl:text>&#xA;</xsl:text>
</srednie><xsl:text>&#xA;</xsl:text>
</podsumowanie><xsl:text>&#xA;</xsl:text>
<ranking><xsl:text>&#xA;</xsl:text>
<najdrozsza><xsl:value-of select="//ksiazka[cena = max(//ksiazka/cena)]/tytul"/></najdrozsza><xsl:text>&#xA;</xsl:text>
<najtansza><xsl:value-of select="//ksiazka[cena = min(//ksiazka/cena)]/tytul"/></najtansza><xsl:text>&#xA;</xsl:text>
</ranking><xsl:text>&#xA;</xsl:text>
<data><xsl:value-of select="substring(string(current-date()),1,string-length(string(current-date()))-1)"/></data><xsl:text>&#xA;</xsl:text>
</raport><xsl:text>&#xA;</xsl:text>
</xsl:template>

<xsl:template match="//dzial">
<xsl:variable name="nazwa_dzialu" select="@nazwa"/>
<xsl:for-each select="ksiazka">
<xsl:sort select="tytul"/>
<xsl:variable name="id_wyd" select="wydawca/@id"/>
<ksiazka><xsl:text>&#xA;</xsl:text>
<isbn><xsl:value-of select="substring(@isbn,2)"/></isbn><xsl:text>&#xA;</xsl:text>
<tytul><xsl:value-of select="tytul"/></tytul><xsl:text>&#xA;</xsl:text>
<autor><xsl:value-of select="autor"/></autor><xsl:text>&#xA;</xsl:text>
<gatunek><xsl:value-of select="$nazwa_dzialu"/></gatunek><xsl:text>&#xA;</xsl:text>
<wydawca><xsl:value-of select="/biblioteka/wydawnictwa/wydawnictwo[@id=$id_wyd]/nazwa"/></wydawca><xsl:text>&#xA;</xsl:text>
<rok_wydania><xsl:value-of select="rok_wydania"/></rok_wydania><xsl:text>&#xA;</xsl:text>
<cena><xsl:choose><xsl:when test="@na_sprzedaz='true'"><xsl:value-of select="cena"/></xsl:when><xsl:otherwise><xsl:text>0</xsl:text></xsl:otherwise></xsl:choose></cena><xsl:text>&#xA;</xsl:text>
<na_stanie><xsl:choose><xsl:when test="@wypozyczona='false'"><xsl:text>TAK</xsl:text></xsl:when><xsl:otherwise><xsl:text>NIE</xsl:text></xsl:otherwise></xsl:choose></na_stanie><xsl:text>&#xA;</xsl:text>
</ksiazka><xsl:text>&#xA;</xsl:text>
</xsl:for-each>
</xsl:template>

<xsl:template match="//klienci">
<xsl:for-each select="klient">
<klient><xsl:text>&#xA;</xsl:text>
<imie><xsl:value-of select="imie"/></imie><xsl:text>&#xA;</xsl:text>
<nazwisko><xsl:value-of select="nazwisko"/></nazwisko><xsl:text>&#xA;</xsl:text>
<pesel><xsl:value-of select="pesel"/></pesel><xsl:text>&#xA;</xsl:text>
<ilosc_wypozyczen><xsl:value-of select="count(wypozyczenia/pozycja)"/></ilosc_wypozyczen><xsl:text>&#xA;</xsl:text>
</klient><xsl:text>&#xA;</xsl:text>
</xsl:for-each>
</xsl:template>

<xsl:template match="//wypozyczenia">
<xsl:for-each select="pozycja">
<xsl:variable name="isbn" select="@id"/>
<pozycja><xsl:text>&#xA;</xsl:text>
<wypozyczajacy><xsl:value-of select="concat(ancestor::klient/imie,' ',ancestor::klient/nazwisko,' ',ancestor::klient/pesel)"/></wypozyczajacy><xsl:text>&#xA;</xsl:text>
<autor><xsl:value-of select="/biblioteka//ksiazka[@isbn=$isbn]/autor"/></autor><xsl:text>&#xA;</xsl:text>
<tytul><xsl:value-of select="/biblioteka//ksiazka[@isbn=$isbn]/tytul"/></tytul><xsl:text>&#xA;</xsl:text>
<isbn><xsl:value-of select="substring(@id,2)"/></isbn><xsl:text>&#xA;</xsl:text>
<data_wypozyczenia><xsl:value-of select="data_wypozyczenia"/></data_wypozyczenia><xsl:text>&#xA;</xsl:text>
<data_zwrotu><xsl:choose><xsl:when test="data_zwrotu"><xsl:value-of select="data_zwrotu"/></xsl:when><xsl:otherwise><xsl:text>-</xsl:text></xsl:otherwise></xsl:choose></data_zwrotu><xsl:text>&#xA;</xsl:text>
</pozycja><xsl:text>&#xA;</xsl:text>
</xsl:for-each>
</xsl:template>

<xsl:template match="//autor_dokumentu">
<imie><xsl:value-of select="imie"/></imie><xsl:text>&#xA;</xsl:text>
<nazwisko><xsl:value-of select="nazwisko"/></nazwisko><xsl:text>&#xA;</xsl:text>
<indeks><xsl:value-of select="indeks"/></indeks><xsl:text>&#xA;</xsl:text>
</xsl:template>

<xsl:template match="//wydawnictwa">
<xsl:for-each select="wydawnictwo">
<wydawnictwo><xsl:text>&#xA;</xsl:text>
<id><xsl:value-of select="substring(@id,2)"/></id><xsl:text>&#xA;</xsl:text>
<nazwa><xsl:value-of select="nazwa"/></nazwa><xsl:text>&#xA;</xsl:text>
<email><xsl:value-of select="email"/></email><xsl:text>&#xA;</xsl:text>
</wydawnictwo><xsl:text>&#xA;</xsl:text>
</xsl:for-each>
</xsl:template>

</xsl:stylesheet>