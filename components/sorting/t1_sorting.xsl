<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:websoft="http://www.websoft.ru" 
                version="1.0">
<!--
'*    v_q_0000.xsl
'*    Copyright (c) Websoft Ltd., Russia.  All rights reserved.
-->

<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="moduleImagesFolder"></xsl:param>
<xsl:param name="imagesFolder"></xsl:param>
<xsl:param name="objectID"></xsl:param>
<xsl:param name="width"></xsl:param>
<xsl:param name="height"></xsl:param>

<xsl:template match="/"><xsl:apply-templates select="params"/></xsl:template>

<xsl:template match="params">
    <div class="cl-audio-files-list">
        <xsl:if test="sound_click='custom'"><span><xsl:value-of select="sound_click_file_custom"/></span></xsl:if>
        <xsl:if test="sound_over='custom'"><span><xsl:value-of select="sound_over_file_custom"/></span></xsl:if>
        <xsl:if test="sound_success='custom'"><span><xsl:value-of select="sound_success_file_custom"/></span></xsl:if>
        <xsl:if test="sound_failure='custom'"><span><xsl:value-of select="sound_failure_file_custom"/></span></xsl:if>
        &#160;
    </div>
</xsl:template>

</xsl:stylesheet>
