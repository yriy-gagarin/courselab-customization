<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:websoft="http://www.websoft.ru"
				version="1.0">
<!--
'*	form_004_checkbox.xsl
'*	Copyright (c) Websoft.  All rights reserved.
-->
<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="moduleImagesFolder"></xsl:param>
<xsl:param name="imagesFolder"></xsl:param>
<xsl:param name="objectID"></xsl:param>
<xsl:param name="width"></xsl:param>
<xsl:param name="height"></xsl:param>

<xsl:template match="/"><xsl:apply-templates select="params"/></xsl:template>
<xsl:template match="params">

	<div class="cl-audio-files-list" style="display: none">
		<xsl:if test="sound_click='custom'"><span><xsl:value-of select="sound_click_file_custom"/></span></xsl:if>
	</div>

	<xsl:variable name="css-cl-label-cell">padding: 0 <xsl:value-of select="input_margin" />px; text-align: <xsl:choose><xsl:when test="input_where='left'">right</xsl:when><xsl:otherwise>left</xsl:otherwise></xsl:choose>;</xsl:variable>

	<div>
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_CONTAINER</xsl:attribute>
		<xsl:attribute name="class">cl-container unselectable</xsl:attribute>
		<xsl:choose>
			<xsl:when test="input_showtext='yes'">
				<table>
					<xsl:attribute name="class">cl-checkbox-table</xsl:attribute>
					<tr>
						<xsl:if test="input_where='left'">
							<td>
								<xsl:attribute name="class">cl-label-cell</xsl:attribute>
								<xsl:attribute name="style"><xsl:value-of select="$css-cl-label-cell"/></xsl:attribute>
								<xsl:value-of select="input_text" disable-output-escaping="yes"/>
							</td>
						</xsl:if>
						<td>
							<input type="checkbox">
								<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_FLD</xsl:attribute>
								<xsl:attribute name="class">cl-fld</xsl:attribute>
								<xsl:attribute name="value"><xsl:choose><xsl:when test="initial_state='yes'"><xsl:value-of select="input_value" /></xsl:when><xsl:otherwise><xsl:value-of select="input_value_not" /></xsl:otherwise></xsl:choose></xsl:attribute>
								<xsl:if test="initial_state='yes'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
							</input>
						</td>
						<xsl:if test="input_where='right'">
							<td>
								<xsl:attribute name="class">cl-label-cell</xsl:attribute>
								<xsl:attribute name="style"><xsl:value-of select="$css-cl-label-cell"/></xsl:attribute>
								<xsl:value-of select="input_text" disable-output-escaping="yes"/>
							</td>
						</xsl:if>
					</tr>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<input type="checkbox">
					<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_FLD</xsl:attribute>
					<xsl:attribute name="class">cl-fld</xsl:attribute>
					<xsl:attribute name="value"><xsl:choose><xsl:when test="initial_state='yes'"><xsl:value-of select="input_value" /></xsl:when><xsl:otherwise><xsl:value-of select="input_value_not" /></xsl:otherwise></xsl:choose></xsl:attribute>
					<xsl:if test="initial_state='yes'"><xsl:attribute name="checked">checked</xsl:attribute></xsl:if>
				</input>
			</xsl:otherwise>
		</xsl:choose>
	</div>
</xsl:template>
</xsl:stylesheet>
