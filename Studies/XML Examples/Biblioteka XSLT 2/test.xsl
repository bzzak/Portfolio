<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:output method="xml" standalone="no"/>

<xsl:template match="/">
<raport>
<spis>
<xsl:apply-templates/>
</spis>
</raport>
</xsl:template>

<xsl:template match="dzial">
<xsl:for-each select="ksiazka">
<ksiazka>
<isbn><xsl:value-of select="@isbn"/></isbn>
<xsl:copy-of select="tytul"/>
<xsl:copy-of select="autor"/>
<gatunek><xsl:value-of select="$nazwa_dzialu"/></gatunek>
<wydawca><xsl:value-of select="/biblioteka/wydawnictwa/wydawnictwo[@id=$id_wyd]/nazwa"/></wydawca>
<xsl:copy-of select="rok_wydania"/>
<cena><xsl:choose><xsl:when test="@na_sprzedaz='true'"><xsl:value-of select="cena"/></xsl:when><xsl:otherwise>0</xsl:otherwise></xsl:choose></cena>
<na_stanie><xsl:choose><xsl:when test="@wypozyczona='false'">TAK</xsl:when><xsl:otherwise>NIE</xsl:otherwise></xsl:choose></na_stanie>
</ksiazka>
</xsl:for-each>
</xsl:template>

<xsl:template match="klienci">
</xsl:template>

<xsl:template match="autor_dokumentu">
</xsl:template>

<xsl:template match="wydawnictwa">
</xsl:template>

</xsl:stylesheet>