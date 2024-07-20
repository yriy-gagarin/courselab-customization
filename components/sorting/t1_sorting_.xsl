<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:websoft="http://www.websoft.ru" 
				version="1.0">
<!--
'*	v_q_0001#.xsl
'*	Copyright (c) Websoft Ltd., Russia.  All rights reserved.
-->

<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="moduleImagesFolder"></xsl:param>
<xsl:param name="imagesFolder"></xsl:param>
<xsl:param name="objectID"></xsl:param>
<xsl:param name="width"></xsl:param>
<xsl:param name="height"></xsl:param>

<xsl:template match="/"><xsl:apply-templates select="params"/></xsl:template>

<xsl:template match="params">
	<div>
		<xsl:attribute name="style">width: <xsl:value-of select="number($width)-2"/>px; height: <xsl:value-of select="number($height)-2"/>px; border: dotted 1px #369;</xsl:attribute>
		<table>
			<xsl:attribute name="style">width: <xsl:value-of select="number($width)-2"/>px; height: <xsl:value-of select="number($height)-2"/>px; border-spacing: 0;</xsl:attribute>
			<tr>
				<td>
					<xsl:attribute name="style">width: <xsl:value-of select="number($width)-12"/>px; height: <xsl:value-of select="number($height)-12"/>px; padding: 5px; color: #369; font-family: sans-serif; font-size: 10px; text-align: center; vertical-align: middle;</xsl:attribute>
					<xsl:value-of select="hidden.object"/>
				</td>
			</tr>
		</table>
	</div>
</xsl:template>

</xsl:stylesheet>
