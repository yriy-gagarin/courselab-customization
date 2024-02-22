<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:websoft="http://www.websoft.ru"
                version="1.0">
<!--
'*    nav_0000_btn_universal#.xsl
'*    Copyright (c) Websoft Ltd. Russia.  All rights reserved.
-->
<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="objectID"></xsl:param>
<xsl:param name="imagesFolder"></xsl:param>
<xsl:param name="moduleImagesFolder"></xsl:param>
<xsl:param name="width"/>
<xsl:param name="height"/>

<xsl:template match="/"><xsl:apply-templates select="params"/></xsl:template>

<xsl:template match="params">
	<style>
		.cl-btn { width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px; }
	</style>
	<div>
		<xsl:attribute name="class">clo-nav_0000_btn_universal</xsl:attribute>
		<div>
			<xsl:attribute name="class">cl-container</xsl:attribute>
			<xsl:choose>
				<xsl:when test="n1_img!='' and n2_img!='' and n3_img!=''">
					<div>
						<xsl:attribute name="class">cl-btn cl-idle</xsl:attribute>
						<img border="0">
							<xsl:attribute name="class">cl-img-idle</xsl:attribute>
							<xsl:attribute name="src"><xsl:value-of select="substring-before($moduleImagesFolder,'images\')"/><xsl:value-of select="translate(n1_img,'/','\')"/></xsl:attribute>
						</img>
					</div>
				</xsl:when>
				<xsl:otherwise>
					<div>
						<xsl:attribute name="style">position:absolute; top: 0px; left: 0px; width: <xsl:value-of select="number($width)-2"/>px; height: <xsl:value-of select="number($height)-2"/>px; border: dotted 1px #0000FF; background-color: #EEEEEE;</xsl:attribute>
						<table width="100%" height="100%" border="0">
							<tr>
								<td style="vertical-align: middle; text-align: center; font-family: Tahoma, sans-serif; font-size: 10px; color: #0000CC;"><xsl:value-of select="hidden_noimg"/></td>
							</tr>
						</table>
					</div>
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</div>
</xsl:template>
</xsl:stylesheet>
