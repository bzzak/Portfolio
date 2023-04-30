<?xml version="1.0" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:template match="MuzycznyRaport">
		
		<svg width="80cm" height="45cm"  xmlns="http://www.w3.org/2000/svg">
		
		<rect width="100%" height="100%" fill="#303030"/>

	<script type="text/ecmascript"> <![CDATA[
		    function cColor(evt) {
		      var rect = evt.target;
		      var Fill = rect.getAttribute("fill");
		      var Height = rect.getAttribute("height");
		      var Height 2 = 2*Height;
		      var audio = new Audio('hajs.mp3');
		      
		      if (Fill=="#ff3d3d")
		        {rect.setAttribute("fill", "#ff7a85");
				rec.setAttribute("height","Height*2"}
		      
		      if (Fill=="#ff7a85")
		        {rect.setAttribute("fill", "#ff3d3d");
		        audio.play();}
		   }
		  ]]> </script>

		<text x="055" y="055" font-family="sans-serif" fill="#ffffff" font-size="50" >
			Albumy muzyczne:
		</text>
		<text x="055" y="855" font-family="sans-serif" fill="#ffffff" font-size="30" >
			Koszta:
		</text>
    	<xsl:for-each select="Album">
    		<xsl:variable name="album" select="(position()-1) * 75"/>
    		<xsl:variable name="pos" select="(position()-1) * 600"/>
    		<xsl:variable name="nazwa" select="@Nazwa"/>
    		<xsl:variable name="ocena" select="number(substring(@Ocena,0,3))"/>
    		<xsl:variable name="dl_albumu" select="number(substring(@Dlugosc_albumu,4,2))*60+number(substring(@Dlugosc_albumu,7,2))"/>	
			<rect x="{$pos + 100}" y="100" height="705" width="520" fill="#202020" stroke="black" stroke-width="5"/>
							<text writing-mode="horizontal-tb"  x="{$pos + 119}" y="149" font-family="sans-serif" font-size="40" fill="#000000">
							  <xsl:value-of select="$nazwa"/>
							 </text>
							  <text writing-mode="horizontal-tb"  x="{$pos + 115}" y="145" font-family="sans-serif" font-size="40" fill="#ff3d3d">
							  <xsl:value-of select="$nazwa"/>
							</text>
							<text writing-mode="horizontal-tb"  x="{$pos + 335}" y="145" font-family="sans-serif" font-size="40" fill="#0000000">
							  <xsl:value-of select="@Wykonawca"/>
							</text>
							<text x="{$pos + 525}" y="200" font-family="sans-serif" font-size="40" fill="#000000">
							  <xsl:value-of select="@Ocena"/>
							</text>

							<rect x="{$pos + 115}" y="170" height="30" width="0" fill="#000000" 
							stroke="black" stroke-width="2">
							<animate attributeType="XML" attributeName="width" from="0" to="{400}"
							dur="1s" fill="freeze"/>
							</rect>
							<rect x="{$pos + 115}" y="170" height="30" width="0" fill="#ff3d3d" 
							stroke="black" stroke-width="2">
							<animate attributeType="XML" attributeName="width" from="0" to="{$ocena*4}"
							dur="1s" fill="freeze"/>
							</rect>
								<xsl:for-each select="Piosenki/Piosenka">
								<xsl:variable name="pos2" select="(position()-1) * 45"/>
								<text x="{115 + $pos}" y="{230 + $pos2 - 5}" font-family="sans-serif" font-size="20" fill="#abcdef">
								<xsl:value-of select="@Nazwa"/>
								</text>
								<rect x="{115 + $pos}" y="{230 + $pos2}" height="17" width="0" fill="cccccc" stroke="black" stroke-width="2" >
								<animate attributeType="XML" attributeName="width" from="0" to="{number(substring(@Dlugosc,4,2))*60+number(substring(@Dlugosc,7,2))}" dur="1s" fill="freeze"/>
								</rect>
								<text x="{115 + $pos}" y="{230 + $pos2 + 16}" font-family="sans-serif" font-size="20" fill="#fffff0">
								<xsl:value-of select="substring(@Dlugosc,4,5)"/>
								</text>
								</xsl:for-each>
							<xsl:variable name="anchor" select="(360 + (position()-1) * 45)"/>
							<xsl:variable name="nazwaPLN" select="@Cena"/>
							<xsl:variable name="nazwaEURO" select="@CenaEURO"/>
							<xsl:variable name="nazwaDOLAR" select="@CenaDOLLAR"/>
							<xsl:variable name="nazwaFUNT" select="@CenaFUNT"/>
							<xsl:variable name="hajs" select="number(substring(@Cena,0,3))"/>
							<xsl:variable name="hajs2" select="number(substring(@CenaEURO,0,3))"/>
							<xsl:variable name="hajs3" select="number(substring(@CenaDOLLAR,0,3))"/>
							<xsl:variable name="hajs4" select="number(substring(@CenaFUNT,0,3))"/>
							<text x="{$anchor + 100}" y="{620-$hajs+300}" font-family="sans-serif" font-size="20" fill="#ff3d3d">
							<xsl:value-of select="@Cena"/>
							</text>
							<rect  x="{$anchor + 100}" y="{750-$hajs*3+300}" height="0" width="30" fill="#ff3d3d" 
							stroke="black" stroke-width="2" onclick="cColor(evt)">
							<animate attributeType="XML" attributeName="height" from="0" to="{$hajs*3}"
							dur="2s" fill="freeze"/>
							</rect>
							<text writing-mode="tb-rl"  x="{$anchor + 115}" y="1060" font-family="sans-serif" font-size="20" fill="#ff3d3d">
							<xsl:value-of select="@Nazwa"/>
							</text>
							
							<text x="{$anchor + 400}" y="{750-$hajs+300}" font-family="sans-serif" font-size="20" fill="#ff3d3d">
							<xsl:value-of select="@CenaEURO"/>
							</text>
							<rect  x="{$anchor + 400}" y="{750-$hajs2*3+300}" height="0" width="30" fill="#ff3d3d" 
							stroke="black" stroke-width="2" onclick="cColor(evt)">
							<animate attributeType="XML" attributeName="height" from="0" to="{$hajs2*3}"
							dur="2s" fill="freeze"/>
							</rect>
							<text writing-mode="tb-rl"  x="{$anchor + 415}" y="1060" font-family="sans-serif" font-size="20" fill="#ff3d3d">
							<xsl:value-of select="@Nazwa"/>
							</text>
							
							<text x="{$anchor + 700}" y="{730-$hajs+300}" font-family="sans-serif" font-size="20" fill="#ff3d3d">
							<xsl:value-of select="@CenaDOLLAR"/>
							</text>
							<rect  x="{$anchor + 700}" y="{750-$hajs3*3+300}" height="0" width="30" fill="#ff3d3d" 
							stroke="black" stroke-width="2" onclick="cColor(evt)">
							<animate attributeType="XML" attributeName="height" from="0" to="{$hajs3*3}"
							dur="2s" fill="freeze"/>
							</rect>
							<text writing-mode="tb-rl"  x="{$anchor + 715}" y="1060" font-family="sans-serif" font-size="20" fill="#ff3d3d">
							<xsl:value-of select="@Nazwa"/>
							</text>
							
							<text x="{$anchor + 1000}" y="{730-$hajs+300}" font-family="sans-serif" font-size="20" fill="#ff3d3d">
							<xsl:value-of select="@CenaFUNT"/>
							</text>
							<rect  x="{$anchor + 1000}" y="{750-$hajs4*3+300}" height="0" width="30" fill="#ff3d3d" 
							stroke="black" stroke-width="2" onclick="cColor(evt)">
							<animate attributeType="XML" attributeName="height" from="0" to="{$hajs4*3}"
							dur="2s" fill="freeze"/>
							</rect>
							<text writing-mode="tb-rl"  x="{$anchor + 1015}" y="1060" font-family="sans-serif" font-size="20" fill="#ff3d3d">
							<xsl:value-of select="@Nazwa"/>
							</text>
							
							
    	</xsl:for-each>  
    	
	</svg>
	
  </xsl:template>	
</xsl:stylesheet>