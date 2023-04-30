<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/">
        <xsl:for-each select="MuzycznyRaport/Album">
            <xsl:text>_____________________________________________________________________________________________________________&#xA;</xsl:text>
            <xsl:text>|   Nazwa albumu     |  Gatunek  | Data wydania w Polsce |  Ocena  |   Dlugosc albumu |       Wydawca       | </xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>|********************|***********|***********************|*********|******************|*********************|</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:value-of
                    select="concat('    ',@Nazwa,substring('                  ',1,20-string-length(@Nazwa)),'  ',@Gatunek,substring('              ',1,14-string-length(@Gatunek)),' ',@Data_wydania_w_Polsce,'          ',@Ocena,substring('    ',1,11-string-length(@Ocena)),'   ',@Dlugosc_albumu,'     ',@Wydawca)"/>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>------------------------------------------------------------------------------------------------------------|</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>      Piosenka                            Dlugosc</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:for-each select="Piosenki/Piosenka">
                <xsl:value-of select="concat('    ',@Nazwa,substring('                                  ',1,36-string-length(@Nazwa)),'  ',@Dlugosc)"/>
                <xsl:text>&#xA;</xsl:text>
            </xsl:for-each>

            <xsl:text>&#xA;</xsl:text>
            <xsl:text>------------------------------------------------------------------------------------------------------------|</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
            <xsl:text>&#xA;</xsl:text>
        </xsl:for-each>



        <xsl:text>&#xA;&#xA;                Podsumowanie:&#xA;</xsl:text>
        <xsl:text>___________________________________________________&#xA;&#xA;</xsl:text>
        <xsl:text>Liczba albumów: </xsl:text><xsl:value-of
            select="MuzycznyRaport/Podsumowanie_informacji/Liczba_Albumow"/><xsl:text>&#xA;</xsl:text>
        <xsl:text>Laczna liczba piosenek: </xsl:text><xsl:value-of
            select="MuzycznyRaport/Podsumowanie_informacji/Laczna_liczba_piosenek"/><xsl:text>&#xA;</xsl:text>
        <xsl:text>Liczba albumów rockowych: </xsl:text><xsl:value-of
            select="MuzycznyRaport/Podsumowanie_informacji/Liczba_albumow_rockowych"/><xsl:text>&#xA;</xsl:text>
        <xsl:text>Liczba albumów rapowych: </xsl:text><xsl:value-of
            select="MuzycznyRaport/Podsumowanie_informacji/Liczba_albumow_rapowych"/><xsl:text>&#xA;</xsl:text>
        <xsl:text>Liczba albumów bluesowych: </xsl:text><xsl:value-of
            select="MuzycznyRaport/Podsumowanie_informacji/Liczba_albumow_bluesowych"/><xsl:text>&#xA;</xsl:text>
        <xsl:text>Liczba albumów funkowych: </xsl:text><xsl:value-of
            select="MuzycznyRaport/Podsumowanie_informacji/Liczba_albumow_funkowych"/><xsl:text>&#xA;</xsl:text>
        <xsl:text>Liczba albumów jazzowych: </xsl:text><xsl:value-of
            select="MuzycznyRaport/Podsumowanie_informacji/Liczba_albumow_jazzowych"/><xsl:text>&#xA;</xsl:text>
        <xsl:text>Liczba albumów metalowych: </xsl:text><xsl:value-of
            select="MuzycznyRaport/Podsumowanie_informacji/Liczba_albumow_metalowych"/><xsl:text>&#xA;</xsl:text>
        <xsl:text>Najwyższa ocena albumu: </xsl:text><xsl:value-of
            select="MuzycznyRaport/Podsumowanie_informacji/Najwyzsza_ocena_albumu"/><xsl:text>&#xA;</xsl:text>
        <xsl:text>Najwyżej oceniany album: </xsl:text><xsl:value-of
            select="MuzycznyRaport/Podsumowanie_informacji/Najwyzej_oceniany_album"/><xsl:text>&#xA;</xsl:text>
        <xsl:text>Należność w PLN za zamówienie: </xsl:text><xsl:value-of
            select="MuzycznyRaport/Podsumowanie_informacji/Naleznosc_w_POLSKICH_ZLOTYCH_za_zamowienie"/><xsl:text>&#xA;</xsl:text>
        <xsl:text>Należność w GBP za zamówienie: </xsl:text><xsl:value-of
            select="MuzycznyRaport/Podsumowanie_informacji/Naleznosc_w_FUNTACH_za_zamowienie"/><xsl:text>&#xA;</xsl:text>
        <xsl:text>Należność w EURO za zamówienie: </xsl:text><xsl:value-of
            select="MuzycznyRaport/Podsumowanie_informacji/Naleznosc_w_EURO_za_zamowienie"/><xsl:text>&#xA;</xsl:text>
        <xsl:text>Należność w USD za zamówienie: </xsl:text><xsl:value-of
            select="MuzycznyRaport/Podsumowanie_informacji/Naleznosc_w_DOLARACH_za_zamowienie"/><xsl:text>&#xA;</xsl:text>
        <xsl:text>VAT odprowadzony od zamówienia: </xsl:text><xsl:value-of
            select="MuzycznyRaport/Podsumowanie_informacji/VAT_odprowadzony_od_zamowienia"/><xsl:text>&#xA;</xsl:text>
        <xsl:text>Data Raportu: </xsl:text><xsl:value-of
            select="MuzycznyRaport/Podsumowanie_informacji/Data_Raportu"/><xsl:text>&#xA;</xsl:text>

    </xsl:template>
</xsl:stylesheet>
