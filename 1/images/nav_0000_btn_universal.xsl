<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:websoft="http://www.websoft.ru"
                version="1.0">
<!--
'*    nav_0000_btn_universal.xsl
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
	
	<xsl:if test="sound_click='custom'"><div style="display: none;"><xsl:attribute name="preload"><xsl:value-of select="sound_click_file_custom"/></xsl:attribute>.</div></xsl:if>
	<xsl:if test="sound_over='custom'"><div style="display: none;"><xsl:attribute name="preload"><xsl:value-of select="sound_over_file_custom"/></xsl:attribute>.</div></xsl:if>

	<div class="style-custom" style="display: none">
		<div class="rule">
			<xsl:attribute name="data-name">#<xsl:value-of select="$objectID"/> .cl-btn</xsl:attribute>
			<span class="rule-static">width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px;</span>
		</div>
	</div>
	<div>
		<xsl:attribute name="class">cl-container unselectable</xsl:attribute>
		<xsl:choose>
			<xsl:when test="n1_img!='' and n2_img!='' and n3_img!=''">
				<div>
					<xsl:attribute name="class">cl-btn idle</xsl:attribute>
					<img border="0">
						<xsl:attribute name="class">cl-img-idle</xsl:attribute>
						<xsl:attribute name="src"><xsl:value-of select="n1_img"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="alt_enabled"/></xsl:attribute>
					</img>
					<img border="0">
						<xsl:attribute name="class">cl-img-over</xsl:attribute>
						<xsl:attribute name="src"><xsl:value-of select="n2_img"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="alt_enabled"/></xsl:attribute>
					</img>
					<img border="0">
						<xsl:attribute name="class">cl-img-disabled</xsl:attribute>
						<xsl:attribute name="src"><xsl:value-of select="n3_img"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="alt_disabled"/></xsl:attribute>
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

</xsl:template>
</xsl:stylesheet>
