<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:template match="/">
		<html>
			<head>
				<link rel="stylesheet" href="style.css"/> 
			</head>
			<body>
				<h2>Lista Wypożyczeń Klientów</h2>
				<table class="minimalistBlack">
					<thead>
						<tr>
							<th>PESEL</th>
							<th>Imię</th>
							<th>Nazwisko</th>
							<th>ISBN</th>
							<th>Wypożyczenie</th>
							<th>Zwrot</th>
							<th>Opóźnienie</th>
							<th>Okres</th>
							<th>Zwrot terminowy</th>
						</tr>
					</thead>
					<tbody>
						<xsl:for-each select="//pozycja">
						<xsl:sort select="../preceding-sibling::imie" order="descending"/>
							<tr>
								<td>
									<xsl:value-of select="../preceding-sibling::pesel"/>
								</td>
								<td>
									<xsl:value-of select="../preceding-sibling::imie"/>
								</td>
								<td>
									<xsl:value-of select="../preceding-sibling::nazwisko"/>
								</td>
								<td>
									<xsl:value-of select="@id"/>
								</td>
								<td>
									<xsl:value-of select="data_wypozyczenia"/>
								</td>
								<td>
									<xsl:value-of select="data_zwrotu"/>
								</td>
								<td>
									<xsl:value-of select="opoznienie"/>
								</td>
								<td>
									<xsl:value-of select="@okres_wypozyczenia"/>
								</td>
								<xsl:choose>
									<xsl:when test="@zwrot_terminowy = 'true'">
									  <td style="color: green;">
									  <xsl:value-of select="@zwrot_terminowy"/>
									  </td>
									</xsl:when>
									<xsl:when test="@zwrot_terminowy = 'false'">
									  <td style="color: red;">
									  <xsl:value-of select="@zwrot_terminowy"/>
									  </td>
									</xsl:when>
									<xsl:otherwise>
									<td>
									  <xsl:value-of select="@zwrot_terminowy"/>
									</td>
									</xsl:otherwise>
								</xsl:choose>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>