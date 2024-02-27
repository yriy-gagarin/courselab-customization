<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:websoft="http://www.websoft.ru" version="1.0">
<!--
'*	v_rapid_005#.xsl
'*	Copyright (c) Websoft Ltd., Russia.  All rights reserved.
-->

<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>

<xsl:param name="moduleImagesFolder"></xsl:param>
<xsl:param name="imagesFolder"></xsl:param>
<xsl:param name="objectID"></xsl:param>
<xsl:param name="width"></xsl:param>
<xsl:param name="height"></xsl:param>

<msxsl:script language="JScript" implements-prefix="websoft">
function arrayElem(sArrayString, iIndex, sDivider) { var aArray = sArrayString.split(sDivider); var iIdx = parseInt(iIndex, 10); if(isNaN(iIdx)) return ''; iIdx = iIdx - 1; if(iIdx!=Math.abs(iIdx)) return ''; if(aArray[iIdx]==null) return ''; return trim(aArray[iIdx]); }
function trim(sString) { if(typeof sString != "string") return sString; var bStart = true; var bEnd = true; var bDblSpc = true; var bCRLF = true; var sReturn = sString; var sChar; if(bStart) { sChar = sReturn.substring(0, 1); while (sChar==" " || sChar=="\n" || sChar=="\r" || sChar=="\t") { sReturn = sReturn.substring(1, sReturn.length); sChar = sReturn.substring(0, 1); }}; if(bEnd) { sChar = sReturn.substring(sReturn.length-1, sReturn.length); while (sChar==" " || sChar=="\n" || sChar=="\r" || sChar=="\t") { sReturn = sReturn.substring(0, sReturn.length-1); sChar = sReturn.substring(sReturn.length-1, sReturn.length); }}; if(bCRLF) { while (sReturn.indexOf("\n") != -1) { sReturn = sReturn.substring(0, sReturn.indexOf("\n")) +" "+ sReturn.substring(sReturn.indexOf("\n")+1, sReturn.length); }; while (sReturn.indexOf("\r") != -1) { sReturn = sReturn.substring(0, sReturn.indexOf("\r")) + sReturn.substring(sReturn.indexOf("\r")+1, sReturn.length); }; while (sReturn.indexOf("\t") != -1) { sReturn = sReturn.substring(0, sReturn.indexOf("\t")) + sReturn.substring(sReturn.indexOf("\t") + 1, sReturn.length); }}; if(bDblSpc) { while (sReturn.indexOf("  ") != -1) { sReturn = sReturn.substring(0, sReturn.indexOf("  ")) + sReturn.substring(sReturn.indexOf("  ") + 1, sReturn.length); }}; return sReturn; }
</msxsl:script>

<xsl:template match="/"><xsl:apply-templates select="params"/></xsl:template>

<xsl:template match="params">

 	<xsl:variable name="tab-bg-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="tab_bg_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="tab-border-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="tab_border_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="tab-gradient-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="tab_gradient_color"/>
		</xsl:call-template>
	</xsl:variable>
 	<xsl:variable name="tab-bg-color-selected-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="tab_bg_color_selected"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="tab-border-color-selected-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="tab_border_color_selected"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="tab-gradient-color-selected-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="tab_gradient_color_selected"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="text-shadow-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="text_shadow_color"/>
		</xsl:call-template>
	</xsl:variable>
 	<xsl:variable name="ribbon-bg-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="ribbon_bg_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="ribbon-border-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="ribbon_border_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="ribbon-gradient-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="ribbon_gradient_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="ribbon-text-shadow-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="ribbon_text_shadow_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="desc-bg-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="desc_bg_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="desc-border-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="desc_border_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="desc-gradient-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="desc_gradient_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="desc-bg-color-custom-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="desc_bg_color_custom"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="bg-bg-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="bg_bg_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="bg-border-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="bg_border_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="bg-gradient-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="bg_gradient_color"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="main.arItemsToPreview">
		<xsl:for-each select="elements/item">
			<xsl:if test="display_first='yes'"><xsl:value-of select="position()"/>|</xsl:if>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="main.iItemToPreview">
		<xsl:choose>
			<xsl:when test="$main.arItemsToPreview='' and display_default_text='yes'">0</xsl:when>
			<xsl:when test="$main.arItemsToPreview='' and display_default_text='no'">1</xsl:when>
			<xsl:otherwise><xsl:value-of select="substring-before($main.arItemsToPreview,'|')"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="main.nBGWidth">
		<xsl:choose>
			<xsl:when test="display_bg='yes'"><xsl:value-of select="number($width)-2*(number(bg_padding)+number(bg_border_width))"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$width"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.nBGHeight">
		<xsl:choose>
			<xsl:when test="display_bg='yes'"><xsl:value-of select="number($height)-2*(number(bg_padding)+number(bg_border_width))"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$height"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.nInnerWidth" select="$main.nBGWidth"/>
	<xsl:variable name="main.nInnerHeight" select="$main.nBGHeight"/>

	<xsl:variable name="main.nHeaderWidth" select="$main.nInnerWidth"/>
	<xsl:variable name="main.nHeaderHeight" select="1.6*number(ribbon_font_size)"/>
	<xsl:variable name="main.nHeaderPadding">
		<xsl:choose>
			<xsl:when test="display_ribbon='yes'"><xsl:value-of select="round(0.1*number($main.nHeaderHeight))"/></xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.nHeaderTableHeight" select="$main.nHeaderHeight"/>
	<xsl:variable name="main.nBtnBorderWidth">1</xsl:variable>
	<xsl:variable name="main.nBtnRadius">15%</xsl:variable>
	<xsl:variable name="main.nBtnSize" select="number($main.nHeaderTableHeight) - 2*number($main.nBtnBorderWidth)"/>
	<xsl:variable name="main.nArrowBorderWidth"><xsl:value-of select="round(0.3*number($main.nBtnSize))"/></xsl:variable>

	<xsl:variable name="main.sShadowString">
		<xsl:call-template name="shadow_builder">
			<xsl:with-param name="sType">box</xsl:with-param>
			<xsl:with-param name="sColor"></xsl:with-param>
			<xsl:with-param name="sStrength" select="shadow_strength"/>
			<xsl:with-param name="sOpacity"></xsl:with-param>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="main.sBGColor1">
		<xsl:call-template name="define-color">
			<xsl:with-param name="sProfile" select="bg_color_scheme"/>
			<xsl:with-param name="sColorType">color1</xsl:with-param>
			<xsl:with-param name="sCustom" select="$bg-bg-color-fixed"/>
			<xsl:with-param name="sCustomGradient" select="$bg-gradient-color-fixed"/>
			<xsl:with-param name="sCustomBorder" select="$bg-border-color-fixed"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sBGColor2">
		<xsl:call-template name="define-color">
			<xsl:with-param name="sProfile" select="bg_color_scheme"/>
			<xsl:with-param name="sColorType">color2</xsl:with-param>
			<xsl:with-param name="sCustom" select="$bg-bg-color-fixed"/>
			<xsl:with-param name="sCustomGradient" select="$bg-gradient-color-fixed"/>
			<xsl:with-param name="sCustomBorder" select="$bg-border-color-fixed"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sBGBorderColor">
		<xsl:call-template name="define-color">
			<xsl:with-param name="sProfile" select="bg_color_scheme"/>
			<xsl:with-param name="sColorType">border</xsl:with-param>
			<xsl:with-param name="sCustom" select="$bg-bg-color-fixed"/>
			<xsl:with-param name="sCustomGradient" select="$bg-gradient-color-fixed"/>
			<xsl:with-param name="sCustomBorder" select="$bg-border-color-fixed"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="main.sRibbonColor1">
		<xsl:call-template name="define-color">
			<xsl:with-param name="sProfile" select="ribbon_color_scheme"/>
			<xsl:with-param name="sColorType">color1</xsl:with-param>
			<xsl:with-param name="sCustom" select="$ribbon-bg-color-fixed"/>
			<xsl:with-param name="sCustomGradient" select="$ribbon-gradient-color-fixed"/>
			<xsl:with-param name="sCustomBorder" select="$ribbon-border-color-fixed"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sRibbonColor2">
		<xsl:call-template name="define-color">
			<xsl:with-param name="sProfile" select="ribbon_color_scheme"/>
			<xsl:with-param name="sColorType">color2</xsl:with-param>
			<xsl:with-param name="sCustom" select="$ribbon-bg-color-fixed"/>
			<xsl:with-param name="sCustomGradient" select="$ribbon-gradient-color-fixed"/>
			<xsl:with-param name="sCustomBorder" select="$ribbon-border-color-fixed"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sRibbonBorderColor">
		<xsl:call-template name="define-color">
			<xsl:with-param name="sProfile" select="ribbon_color_scheme"/>
			<xsl:with-param name="sColorType">border</xsl:with-param>
			<xsl:with-param name="sCustom" select="$ribbon-bg-color-fixed"/>
			<xsl:with-param name="sCustomGradient" select="$ribbon-gradient-color-fixed"/>
			<xsl:with-param name="sCustomBorder" select="$ribbon-border-color-fixed"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sRibbonFontFamily">
		<xsl:choose>
			<xsl:when test="ribbon_font!='custom'"><xsl:call-template name="font_selector"><xsl:with-param name="sFontID" select="ribbon_font"/></xsl:call-template></xsl:when>
			<xsl:otherwise><xsl:value-of select="ribbon_font_custom"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.sRibbonFontShadow">
		<xsl:call-template name="shadow_builder">
			<xsl:with-param name="sType">text</xsl:with-param>
			<xsl:with-param name="sColor"><xsl:value-of select="$ribbon-text-shadow-color-fixed"/></xsl:with-param>
			<xsl:with-param name="sStrength"><xsl:value-of select="ribbon_text_shadow_strength"/></xsl:with-param>
			<xsl:with-param name="sOpacity"></xsl:with-param>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sRibbonFontWeight"><xsl:if test="ribbon_font_style='bold' or ribbon_font_style='bolditalic'">font-weight: bold;</xsl:if></xsl:variable>
	<xsl:variable name="main.sRibbonFontStyle"><xsl:if test="ribbon_font_style='italic' or ribbon_font_style='bolditalic'">font-style: italic;</xsl:if></xsl:variable>
	<xsl:variable name="main.sRibbonFontCSS">font-family: <xsl:value-of select="$main.sRibbonFontFamily"/>; font-size: <xsl:value-of select="ribbon_font_size"/>px; <xsl:if test="ribbon_text_shadow_strength!='none'">text-shadow: <xsl:value-of select="$main.sRibbonFontShadow"/>;</xsl:if> <xsl:value-of select="$main.sRibbonFontWeight"/><xsl:value-of select="$main.sRibbonFontStyle"/></xsl:variable>
	<xsl:variable name="main.sBtnColor1">
		<xsl:call-template name="define-color">
			<xsl:with-param name="sProfile" select="ribbon_color_scheme"/>
			<xsl:with-param name="sColorType">color1</xsl:with-param>
			<xsl:with-param name="sCustom" select="$ribbon-bg-color-fixed"/>
			<xsl:with-param name="sCustomGradient" select="$ribbon-gradient-color-fixed"/>
			<xsl:with-param name="sCustomBorder" select="$ribbon-border-color-fixed"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sBtnColor2">
		<xsl:call-template name="define-color">
			<xsl:with-param name="sProfile" select="ribbon_color_scheme"/>
			<xsl:with-param name="sColorType">color2</xsl:with-param>
			<xsl:with-param name="sCustom" select="$ribbon-bg-color-fixed"/>
			<xsl:with-param name="sCustomGradient" select="$ribbon-gradient-color-fixed"/>
			<xsl:with-param name="sCustomBorder" select="$ribbon-border-color-fixed"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sBtnColor3">
		<xsl:call-template name="getcolor">
			<xsl:with-param name="color.base" select="$main.sBtnColor1"/>
			<xsl:with-param name="color.base.type">color1</xsl:with-param>
			<xsl:with-param name="color.target.type">color3</xsl:with-param>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sBtnColor4">
		<xsl:call-template name="getcolor">
			<xsl:with-param name="color.base" select="$main.sBtnColor1"/>
			<xsl:with-param name="color.base.type">color1</xsl:with-param>
			<xsl:with-param name="color.target.type">color4</xsl:with-param>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sBtnColorBorder">
		<xsl:call-template name="define-color">
			<xsl:with-param name="sProfile" select="ribbon_color_scheme"/>
			<xsl:with-param name="sColorType">border</xsl:with-param>
			<xsl:with-param name="sCustom" select="$ribbon-bg-color-fixed"/>
			<xsl:with-param name="sCustomGradient" select="$ribbon-gradient-color-fixed"/>
			<xsl:with-param name="sCustomBorder" select="$ribbon-border-color-fixed"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sTabFontFamily">
		<xsl:choose>
			<xsl:when test="font!='custom'"><xsl:call-template name="font_selector"><xsl:with-param name="sFontID" select="font"/></xsl:call-template></xsl:when>
			<xsl:otherwise><xsl:value-of select="font_custom"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.sTabFontShadow">
		<xsl:call-template name="shadow_builder">
			<xsl:with-param name="sType">text</xsl:with-param>
			<xsl:with-param name="sColor"><xsl:value-of select="$text-shadow-color-fixed"/></xsl:with-param>
			<xsl:with-param name="sStrength"><xsl:value-of select="text_shadow_strength"/></xsl:with-param>
			<xsl:with-param name="sOpacity"></xsl:with-param>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sTabFontWeight"><xsl:if test="font_style='bold' or font_style='bolditalic'">font-weight: bold;</xsl:if></xsl:variable>
	<xsl:variable name="main.sTabFontStyle"><xsl:if test="font_style='italic' or font_style='bolditalic'">font-style: italic;</xsl:if></xsl:variable>
	<xsl:variable name="main.sTabFontCSS">font-family: <xsl:value-of select="$main.sTabFontFamily"/>; font-size: <xsl:value-of select="font_size"/>px; <xsl:if test="text_shadow_strength!='none'">text-shadow: <xsl:value-of select="$main.sTabFontShadow"/>;</xsl:if> <xsl:value-of select="$main.sTabFontWeight"/><xsl:value-of select="$main.sTabFontStyle"/></xsl:variable>

	<xsl:variable name="main.sTabColor1Pre">
		<xsl:call-template name="define-color">
			<xsl:with-param name="sProfile" select="tab_color_scheme"/>
			<xsl:with-param name="sColorType">color1</xsl:with-param>
			<xsl:with-param name="sCustom" select="$tab-bg-color-fixed"/>
			<xsl:with-param name="sCustomGradient" select="$tab-gradient-color-fixed"/>
			<xsl:with-param name="sCustomBorder" select="$tab-border-color-fixed"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sTabColor1">
		<xsl:call-template name="lighten">
			<xsl:with-param name="color.base" select="$main.sTabColor1Pre"/>
			<xsl:with-param name="ratio">1.2</xsl:with-param>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sTabColor2Pre">
		<xsl:call-template name="define-color">
			<xsl:with-param name="sProfile" select="tab_color_scheme"/>
			<xsl:with-param name="sColorType">color2</xsl:with-param>
			<xsl:with-param name="sCustom" select="$tab-bg-color-fixed"/>
			<xsl:with-param name="sCustomGradient" select="$tab-gradient-color-fixed"/>
			<xsl:with-param name="sCustomBorder" select="$tab-border-color-fixed"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sTabColor2">
		<xsl:call-template name="lighten">
			<xsl:with-param name="color.base" select="$main.sTabColor2Pre"/>
			<xsl:with-param name="ratio">1.2</xsl:with-param>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sTabColor3">
		<xsl:call-template name="getcolor">
			<xsl:with-param name="color.base" select="$main.sTabColor1"/>
			<xsl:with-param name="color.base.type">color1</xsl:with-param>
			<xsl:with-param name="color.target.type">color3</xsl:with-param>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sTabColor4">
		<xsl:call-template name="getcolor">
			<xsl:with-param name="color.base" select="$main.sTabColor1"/>
			<xsl:with-param name="color.base.type">color1</xsl:with-param>
			<xsl:with-param name="color.target.type">color4</xsl:with-param>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sTabColorBorder">
		<xsl:call-template name="define-color">
			<xsl:with-param name="sProfile" select="tab_color_scheme"/>
			<xsl:with-param name="sColorType">border</xsl:with-param>
			<xsl:with-param name="sCustom" select="$tab-bg-color-fixed"/>
			<xsl:with-param name="sCustomGradient" select="$tab-gradient-color-fixed"/>
			<xsl:with-param name="sCustomBorder" select="$tab-border-color-fixed"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sTabColorFont">
		<xsl:call-template name="define-color">
			<xsl:with-param name="sProfile" select="tab_color_scheme"/>
			<xsl:with-param name="sColorType">font</xsl:with-param>
			<xsl:with-param name="sCustom" select="$tab-bg-color-fixed"/>
			<xsl:with-param name="sCustomGradient" select="$tab-gradient-color-fixed"/>
			<xsl:with-param name="sCustomBorder" select="$tab-border-color-fixed"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="main.sTabColorSel1Pre">
		<xsl:call-template name="define-color">
			<xsl:with-param name="sProfile" select="tab_color_scheme_selected"/>
			<xsl:with-param name="sColorType">color1</xsl:with-param>
			<xsl:with-param name="sCustom" select="$tab-bg-color-selected-fixed"/>
			<xsl:with-param name="sCustomGradient" select="$tab-gradient-color-selected-fixed"/>
			<xsl:with-param name="sCustomBorder" select="$tab-border-color-selected-fixed"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sTabColorSel1">
		<xsl:call-template name="lighten">
			<xsl:with-param name="color.base" select="$main.sTabColorSel1Pre"/>
			<xsl:with-param name="ratio">1.2</xsl:with-param>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sTabColorSel2Pre">
		<xsl:call-template name="define-color">
			<xsl:with-param name="sProfile" select="tab_color_scheme_selected"/>
			<xsl:with-param name="sColorType">color2</xsl:with-param>
			<xsl:with-param name="sCustom" select="$tab-bg-color-selected-fixed"/>
			<xsl:with-param name="sCustomGradient" select="$tab-gradient-color-selected-fixed"/>
			<xsl:with-param name="sCustomBorder" select="$tab-border-color-selected-fixed"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sTabColorSel2">
		<xsl:call-template name="lighten">
			<xsl:with-param name="color.base" select="$main.sTabColorSel2Pre"/>
			<xsl:with-param name="ratio">1.2</xsl:with-param>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sTabColorSel3">
		<xsl:call-template name="getcolor">
			<xsl:with-param name="color.base" select="$main.sTabColorSel1"/>
			<xsl:with-param name="color.base.type">color1</xsl:with-param>
			<xsl:with-param name="color.target.type">color3</xsl:with-param>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sTabColorSel4">
		<xsl:call-template name="getcolor">
			<xsl:with-param name="color.base" select="$main.sTabColorSel1"/>
			<xsl:with-param name="color.base.type">color1</xsl:with-param>
			<xsl:with-param name="color.target.type">color4</xsl:with-param>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sTabColorSelBorder">
		<xsl:call-template name="define-color">
			<xsl:with-param name="sProfile" select="tab_color_scheme_selected"/>
			<xsl:with-param name="sColorType">border</xsl:with-param>
			<xsl:with-param name="sCustom" select="$tab-bg-color-selected-fixed"/>
			<xsl:with-param name="sCustomGradient" select="$tab-gradient-color-selected-fixed"/>
			<xsl:with-param name="sCustomBorder" select="$tab-border-color-selected-fixed"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sTabColorSelFont">
		<xsl:call-template name="define-color">
			<xsl:with-param name="sProfile" select="tab_color_scheme_selected"/>
			<xsl:with-param name="sColorType">font</xsl:with-param>
			<xsl:with-param name="sCustom" select="$tab-bg-color-selected-fixed"/>
			<xsl:with-param name="sCustomGradient" select="$tab-gradient-color-selected-fixed"/>
			<xsl:with-param name="sCustomBorder" select="$tab-border-color-selected-fixed"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="main.sDescColor1">
		<xsl:choose>
			<xsl:when test="desc_bg_override='yes'"><xsl:value-of select="$desc-bg-color-custom-fixed"/></xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="desc_color_scheme='level'"><xsl:value-of select="$main.sTabColorSel1"/></xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="define-color">
							<xsl:with-param name="sProfile" select="desc_color_scheme"/>
							<xsl:with-param name="sColorType">color1</xsl:with-param>
							<xsl:with-param name="sCustom" select="$desc-bg-color-fixed"/>
							<xsl:with-param name="sCustomGradient" select="$desc-gradient-color-fixed"/>
							<xsl:with-param name="sCustomBorder" select="$desc-border-color-fixed"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.sDescColor2">
		<xsl:choose>
			<xsl:when test="desc_bg_override='yes'"><xsl:value-of select="$desc-bg-color-custom-fixed"/></xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="desc_color_scheme='level'"><xsl:value-of select="$main.sTabColorSel2"/></xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="define-color">
							<xsl:with-param name="sProfile" select="desc_color_scheme"/>
							<xsl:with-param name="sColorType">color2</xsl:with-param>
							<xsl:with-param name="sCustom" select="$desc-bg-color-fixed"/>
							<xsl:with-param name="sCustomGradient" select="$desc-gradient-color-fixed"/>
							<xsl:with-param name="sCustomBorder" select="$desc-border-color-fixed"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.sDescBorderColor">
		<xsl:choose>
			<xsl:when test="desc_color_scheme='level'"><xsl:value-of select="$main.sTabColorSelBorder"/></xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="define-color">
					<xsl:with-param name="sProfile" select="desc_color_scheme"/>
					<xsl:with-param name="sColorType">border</xsl:with-param>
					<xsl:with-param name="sCustom" select="$desc-bg-color-fixed"/>
					<xsl:with-param name="sCustomGradient" select="$desc-gradient-color-fixed"/>
					<xsl:with-param name="sCustomBorder" select="$desc-border-color-fixed"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="main.nTabBlockHeight">
		<xsl:choose>
			<xsl:when test="display_ribbon='yes'"><xsl:value-of select="number($main.nInnerHeight) - number($main.nHeaderHeight) - 2*number($main.nHeaderPadding) - 1"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$main.nInnerHeight"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="main.nTabInnerHeight">
		<xsl:choose>
			<xsl:when test="tab_type='v'"><xsl:value-of select="round(1.2*number(font_size))"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="number($main.nTabBlockHeight) - 2*number(tab_border_width) - 2*number(tab_padding_tb)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.nTabInnerWidth">
		<xsl:choose>
			<xsl:when test="tab_type='v'"><xsl:value-of select="number($main.nInnerWidth) - 2*number(tab_border_width) - 2*number(tab_padding_lr)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="round(1.2*number(font_size))"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.nTabHeight">
		<xsl:choose>
			<xsl:when test="tab_type='v'"><xsl:value-of select="number($main.nTabInnerHeight)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="number($main.nTabBlockHeight) - 2*number(tab_border_width) - 2*number(tab_padding_tb)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.nTabWidth">
		<xsl:choose>
			<xsl:when test="tab_type='v'"><xsl:value-of select="number($main.nInnerWidth) - 2*number(tab_border_width) - 2*number(tab_padding_lr)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="number($main.nTabInnerWidth)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.nTabFullHeight">
		<xsl:choose>
			<xsl:when test="tab_type='v'"><xsl:value-of select="number($main.nTabInnerHeight) + 2*number(tab_border_width) + 2*number(tab_padding_tb)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="number($main.nTabBlockHeight)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.nTabFullWidth">
		<xsl:choose>
			<xsl:when test="tab_type='v'"><xsl:value-of select="number($main.nInnerWidth) - 2*number(tab_border_width) - 2*number(tab_padding_lr)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="number($main.nTabInnerWidth) + 2*number(tab_border_width) + 2*number(tab_padding_lr)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.nInterTab" select="round(0.4*number(font_size))"/>
	<xsl:variable name="main.nDescWidth">
		<xsl:choose>
			<xsl:when test="tab_type='v'"><xsl:value-of select="number($main.nInnerWidth) - 2*number(desc_border_width) - 2*number(desc_padding)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="number($main.nInnerWidth) - count(elements/item)*(number($main.nTabFullWidth) + number($main.nInterTab)) - 2*(number(desc_border_width) + number(desc_padding))"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.nDescHeight">
		<xsl:choose>
			<xsl:when test="tab_type='v'"><xsl:value-of select="number($main.nTabBlockHeight) - count(elements/item)*(number($main.nTabFullHeight) + number($main.nInterTab)) - 2*(number(desc_border_width) + number(desc_padding))"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="number($main.nTabBlockHeight) - 2*number(desc_border_width) - 2*number(desc_padding)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="main.arTabTopsIdle">
		<xsl:for-each select="elements/item"><xsl:if test="position()!=1">|</xsl:if><xsl:value-of select="(position()-1)*(number($main.nTabHeight) + 2*number(../../tab_border_width) + 2*number(../../tab_padding_tb) + number($main.nInterTab))"/></xsl:for-each>|<xsl:value-of select="(count(elements/item))*(number($main.nTabHeight) + 2*number(tab_border_width) + 2*number(tab_padding_tb) + number($main.nInterTab))"/>
	</xsl:variable>
	<xsl:variable name="main.arTabTops">
		<xsl:for-each select="elements/item"><xsl:if test="position()!=1">|</xsl:if>
			<xsl:choose>
				<xsl:when test="position() &gt; number($main.iItemToPreview)"><xsl:value-of select="(position()-1)*(number($main.nTabHeight) + 2*number(../../tab_border_width) + 2*number(../../tab_padding_tb) + number($main.nInterTab)) + number($main.nDescHeight) + 2*number(../../desc_border_width) + 2*number(../../desc_padding) + number($main.nInterTab)"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="(position()-1)*(number($main.nTabHeight) + 2*number(../../tab_border_width) + 2*number(../../tab_padding_tb) + number($main.nInterTab))"/></xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>|<xsl:value-of select="(count(elements/item))*(number($main.nTabHeight) + 2*number(tab_border_width) + 2*number(tab_padding_tb) + number($main.nInterTab))"/>
	</xsl:variable>

	<xsl:variable name="main.arTabLeftsIdle">
		<xsl:for-each select="elements/item"><xsl:if test="position()!=1">|</xsl:if><xsl:value-of select="(position()-1)*(number($main.nTabWidth) + 2*number(../../tab_border_width) + 2*number(../../tab_padding_lr) + number($main.nInterTab))"/></xsl:for-each>|<xsl:value-of select="(count(elements/item))*(number($main.nTabWidth) + 2*number(tab_border_width) + 2*number(tab_padding_tb) + number($main.nInterTab))"/>
	</xsl:variable>
	<xsl:variable name="main.arTabLefts">
		<xsl:for-each select="elements/item"><xsl:if test="position()!=1">|</xsl:if>
			<xsl:choose>
				<xsl:when test="position() &gt; number($main.iItemToPreview)"><xsl:value-of select="(position()-1)*(number($main.nTabWidth) + 2*number(../../tab_border_width) + 2*number(../../tab_padding_lr) + number($main.nInterTab)) + number($main.nDescWidth) + 2*number(../../desc_border_width) + 2*number(../../desc_padding) + number($main.nInterTab)"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="(position()-1)*(number($main.nTabWidth) + 2*number(../../tab_border_width) + 2*number(../../tab_padding_lr) + number($main.nInterTab))"/></xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>|<xsl:value-of select="(count(elements/item))*(number($main.nTabWidth) + 2*number(tab_border_width) + 2*number(tab_padding_tb) + number($main.nInterTab))"/>
	</xsl:variable>
	<xsl:variable name="main.nTabAngle">
		<xsl:choose>
			<xsl:when test="tab_type='v'">0</xsl:when>
			<xsl:otherwise>270</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>


	<xsl:variable name="main.arTabColors">
		<xsl:for-each select="elements/item">

			<xsl:variable name="spec-tab-bg-color-fixed">
				<xsl:call-template name="fix-color">
					<xsl:with-param name="color" select="spec_tabbg_color"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="spec-tab-border-color-fixed">
				<xsl:call-template name="fix-color">
					<xsl:with-param name="color" select="spec_tabborder_color"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="spec-tab-gradient-color-fixed">
				<xsl:call-template name="fix-color">
					<xsl:with-param name="color" select="spec_tabgradient_color"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="spec-tab-bg-color-selected-fixed">
				<xsl:call-template name="fix-color">
					<xsl:with-param name="color" select="spec_tabbg_color_selected"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="spec-tab-border-color-selected-fixed">
				<xsl:call-template name="fix-color">
					<xsl:with-param name="color" select="spec_tabborder_color_selected"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="spec-tab-gradient-color-selected-fixed">
				<xsl:call-template name="fix-color">
					<xsl:with-param name="color" select="spec_tabgradient_color_selected"/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:variable name="temp.sTabColor1Pre">
				<xsl:call-template name="define-color">
					<xsl:with-param name="sProfile" select="spec_tabcolor_scheme"/>
					<xsl:with-param name="sColorType">color1</xsl:with-param>
					<xsl:with-param name="sCustom" select="$spec-tab-bg-color-fixed"/>
					<xsl:with-param name="sCustomGradient" select="$spec-tab-gradient-color-fixed"/>
					<xsl:with-param name="sCustomBorder" select="$spec-tab-border-color-fixed"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="temp.sTabColor1">
				<xsl:call-template name="lighten">
					<xsl:with-param name="color.base" select="$temp.sTabColor1Pre"/>
					<xsl:with-param name="ratio">1.2</xsl:with-param>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="temp.sTabColor2Pre">
				<xsl:call-template name="define-color">
					<xsl:with-param name="sProfile" select="spec_tabcolor_scheme"/>
					<xsl:with-param name="sColorType">color2</xsl:with-param>
					<xsl:with-param name="sCustom" select="$spec-tab-bg-color-fixed"/>
					<xsl:with-param name="sCustomGradient" select="$spec-tab-gradient-color-fixed"/>
					<xsl:with-param name="sCustomBorder" select="$spec-tab-border-color-fixed"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="temp.sTabColor2">
				<xsl:call-template name="lighten">
					<xsl:with-param name="color.base" select="$temp.sTabColor2Pre"/>
					<xsl:with-param name="ratio">1.2</xsl:with-param>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="temp.sTabColor3">
				<xsl:call-template name="getcolor">
					<xsl:with-param name="color.base" select="$temp.sTabColor1"/>
					<xsl:with-param name="color.base.type">color1</xsl:with-param>
					<xsl:with-param name="color.target.type">color3</xsl:with-param>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="temp.sTabColor4">
				<xsl:call-template name="getcolor">
					<xsl:with-param name="color.base" select="$temp.sTabColor1"/>
					<xsl:with-param name="color.base.type">color1</xsl:with-param>
					<xsl:with-param name="color.target.type">color4</xsl:with-param>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="temp.sTabColorBorder">
				<xsl:call-template name="define-color">
					<xsl:with-param name="sProfile" select="spec_tabcolor_scheme"/>
					<xsl:with-param name="sColorType">border</xsl:with-param>
					<xsl:with-param name="sCustom" select="$spec-tab-bg-color-fixed"/>
					<xsl:with-param name="sCustomGradient" select="$spec-tab-gradient-color-fixed"/>
					<xsl:with-param name="sCustomBorder" select="$spec-tab-border-color-fixed"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="temp.sTabColorFont">
				<xsl:call-template name="define-color">
					<xsl:with-param name="sProfile" select="spec_tabcolor_scheme"/>
					<xsl:with-param name="sColorType">font</xsl:with-param>
					<xsl:with-param name="sCustom" select="$spec-tab-bg-color-fixed"/>
					<xsl:with-param name="sCustomGradient" select="$spec-tab-gradient-color-fixed"/>
					<xsl:with-param name="sCustomBorder" select="$spec-tab-border-color-fixed"/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:variable name="temp.sTabColorSel1Pre">
				<xsl:call-template name="define-color">
					<xsl:with-param name="sProfile" select="spec_tabcolor_scheme_selected"/>
					<xsl:with-param name="sColorType">color1</xsl:with-param>
					<xsl:with-param name="sCustom" select="$spec-tab-bg-color-selected-fixed"/>
					<xsl:with-param name="sCustomGradient" select="$spec-tab-gradient-color-selected-fixed"/>
					<xsl:with-param name="sCustomBorder" select="$spec-tab-border-color-selected-fixed"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="temp.sTabColorSel1">
				<xsl:call-template name="lighten">
					<xsl:with-param name="color.base" select="$temp.sTabColorSel1Pre"/>
					<xsl:with-param name="ratio">1.2</xsl:with-param>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="temp.sTabColorSel2Pre">
				<xsl:call-template name="define-color">
					<xsl:with-param name="sProfile" select="spec_tabcolor_scheme_selected"/>
					<xsl:with-param name="sColorType">color2</xsl:with-param>
					<xsl:with-param name="sCustom" select="$spec-tab-bg-color-selected-fixed"/>
					<xsl:with-param name="sCustomGradient" select="$spec-tab-gradient-color-selected-fixed"/>
					<xsl:with-param name="sCustomBorder" select="$spec-tab-border-color-selected-fixed"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="temp.sTabColorSel2">
				<xsl:call-template name="lighten">
					<xsl:with-param name="color.base" select="$temp.sTabColorSel2Pre"/>
					<xsl:with-param name="ratio">1.2</xsl:with-param>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="temp.sTabColorSel3">
				<xsl:call-template name="getcolor">
					<xsl:with-param name="color.base" select="$temp.sTabColorSel1"/>
					<xsl:with-param name="color.base.type">color1</xsl:with-param>
					<xsl:with-param name="color.target.type">color3</xsl:with-param>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="temp.sTabColorSel4">
				<xsl:call-template name="getcolor">
					<xsl:with-param name="color.base" select="$temp.sTabColorSel1"/>
					<xsl:with-param name="color.base.type">color1</xsl:with-param>
					<xsl:with-param name="color.target.type">color4</xsl:with-param>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="temp.sTabColorSelBorder">
				<xsl:call-template name="define-color">
					<xsl:with-param name="sProfile" select="spec_tabcolor_scheme_selected"/>
					<xsl:with-param name="sColorType">border</xsl:with-param>
					<xsl:with-param name="sCustom" select="$spec-tab-bg-color-selected-fixed"/>
					<xsl:with-param name="sCustomGradient" select="$spec-tab-gradient-color-selected-fixed"/>
					<xsl:with-param name="sCustomBorder" select="$spec-tab-border-color-selected-fixed"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="temp.sTabColorSelFont">
				<xsl:call-template name="define-color">
					<xsl:with-param name="sProfile" select="spec_tabcolor_scheme_selected"/>
					<xsl:with-param name="sColorType">font</xsl:with-param>
					<xsl:with-param name="sCustom" select="$spec-tab-bg-color-selected-fixed"/>
					<xsl:with-param name="sCustomGradient" select="$spec-tab-gradient-color-selected-fixed"/>
					<xsl:with-param name="sCustomBorder" select="$spec-tab-border-color-selected-fixed"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:if test="position()!=1">|</xsl:if><xsl:value-of select="$temp.sTabColor1"/>|<xsl:value-of select="$temp.sTabColor2"/>|<xsl:value-of select="$temp.sTabColor3"/>|<xsl:value-of select="$temp.sTabColor4"/>|<xsl:value-of select="$temp.sTabColorBorder"/>|<xsl:value-of select="$temp.sTabColorFont"/>|<xsl:value-of select="$temp.sTabColorSel1"/>|<xsl:value-of select="$temp.sTabColorSel2"/>|<xsl:value-of select="$temp.sTabColorSel3"/>|<xsl:value-of select="$temp.sTabColorSel4"/>|<xsl:value-of select="$temp.sTabColorSelBorder"/>|<xsl:value-of select="$temp.sTabColorSelFont"/>
		</xsl:for-each>
	</xsl:variable>

	<style>
		.cl-container { width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px; }
		.cl-bg { width: <xsl:value-of select="$main.nBGWidth"/>px; height: <xsl:value-of select="$main.nBGHeight"/>px; <xsl:if test="display_bg='yes'">padding: <xsl:value-of select="bg_padding"/>px; background-color: <xsl:value-of select="$main.sBGColor1"/>; <xsl:if test="$main.sBGColor1!=$main.sBGColor2">background-image: linear-gradient(<xsl:value-of select="bg_grad_angle"/>deg, <xsl:value-of select="$main.sBGColor1"/> 0%, <xsl:value-of select="$main.sBGColor2"/> 100%);</xsl:if> border-width: <xsl:value-of select="bg_border_width"/>px; border-color: <xsl:value-of select="$main.sBGBorderColor"/>; border-radius: <xsl:value-of select="bg_radius"/>px;<xsl:if test="shadow_strength!='none'">box-shadow: <xsl:value-of select="$main.sShadowString"/>;</xsl:if></xsl:if> }
        <xsl:if test="display_ribbon='yes'">
			.cl-header-part { border-color: <xsl:value-of select="$main.sRibbonBorderColor"/>; padding: 0 0 <xsl:value-of select="$main.nHeaderPadding"/>px 0; width: <xsl:value-of select="$main.nHeaderWidth"/>px; height: <xsl:value-of select="$main.nHeaderHeight"/>px; }
			.cl-header-table { width: <xsl:value-of select="$main.nHeaderWidth"/>px; height: <xsl:value-of select="$main.nHeaderTableHeight"/>px; }
			.cl-header-cell-name { width: <xsl:value-of select="number($main.nHeaderTableHeight) - 2*number($main.nHeaderTableHeight) - 4*number($main.nHeaderPadding)"/>px; height: <xsl:value-of select="$main.nHeaderTableHeight"/>px; padding: 0 <xsl:value-of select="2*number($main.nHeaderPadding)"/>px 0 0; }
			.cl-header-cell-btn { width: <xsl:value-of select="$main.nHeaderTableHeight"/>px; height: <xsl:value-of select="$main.nHeaderTableHeight"/>px; padding: 0 0 0 <xsl:value-of select="$main.nHeaderPadding"/>px; }
			.cl-header-btn { background-color: <xsl:value-of select="$main.sBtnColor1"/>; border-width: <xsl:value-of select="$main.nBtnBorderWidth"/>px; border-color: <xsl:value-of select="$main.sBtnColorBorder"/>; width: <xsl:value-of select="$main.nBtnSize"/>px; height: <xsl:value-of select="$main.nBtnSize"/>px; border-radius: <xsl:value-of select="$main.nBtnRadius"/>; }
			.cl-header-btn-idle { <xsl:if test="shadow_strength!='none'">box-shadow: <xsl:value-of select="$main.sShadowString"/>;</xsl:if> background-image: linear-gradient(0deg, <xsl:value-of select="$main.sBtnColor1"/> 10%, <xsl:value-of select="$main.sBtnColor3"/> 50%, <xsl:value-of select="$main.sBtnColor4"/> 50%, <xsl:value-of select="$main.sBtnColor2"/> 90%); }
			.cl-arrow-left { margin: -<xsl:value-of select="$main.nArrowBorderWidth"/>px 0 0 -<xsl:value-of select="round(0.66*number($main.nArrowBorderWidth))"/>px; border-width: <xsl:value-of select="$main.nArrowBorderWidth"/>px <xsl:value-of select="$main.nArrowBorderWidth"/>px <xsl:value-of select="$main.nArrowBorderWidth"/>px 0; }
			.cl-arrow-right { margin: -<xsl:value-of select="$main.nArrowBorderWidth"/>px 0 0 -<xsl:value-of select="round(0.33*number($main.nArrowBorderWidth))"/>px; border-width: <xsl:value-of select="$main.nArrowBorderWidth"/>px 0 <xsl:value-of select="$main.nArrowBorderWidth"/>px <xsl:value-of select="$main.nArrowBorderWidth"/>px; }
			.cl-header-title { width: <xsl:value-of select="number($main.nHeaderTableHeight) - 2*number($main.nHeaderTableHeight) - 4*number($main.nHeaderPadding)"/>px; color: <xsl:value-of select="$main.sRibbonBorderColor"/>; <xsl:value-of select="$main.sRibbonFontCSS"/> }
		</xsl:if>
		.cl-tab-block { margin: <xsl:value-of select="$main.nHeaderPadding"/>px 0 0 0; width: <xsl:value-of select="$main.nInnerWidth"/>px; height: <xsl:value-of select="$main.nTabBlockHeight"/>px; }
		.cl-tab { width: <xsl:value-of select="$main.nTabWidth"/>px; height: <xsl:value-of select="$main.nTabHeight"/>px; padding: <xsl:value-of select="tab_padding_tb"/>px <xsl:value-of select="tab_padding_lr"/>px; border-width: <xsl:value-of select="tab_border_width"/>px; border-radius: <xsl:value-of select="tab_radius"/>px; <xsl:if test="shadow_strength!='none'">box-shadow: <xsl:value-of select="$main.sShadowString"/>;</xsl:if>}
		.cl-tab-idle { <xsl:if test="tab_color_scheme!='spec'">background-color: <xsl:value-of select="$main.sTabColor1"/>; background-image: linear-gradient(<xsl:value-of select="$main.nTabAngle"/>deg, <xsl:value-of select="$main.sTabColor1"/> 10%, <xsl:value-of select="$main.sTabColor3"/> 50%, <xsl:value-of select="$main.sTabColor4"/> 50%, <xsl:value-of select="$main.sTabColor2"/> 90%); border-color: <xsl:value-of select="$main.sTabColorBorder"/>;</xsl:if> <xsl:if test="tab_shadow!='none'">box-shadow: <xsl:value-of select="$main.sShadowString"/>;</xsl:if> }
		.cl-tab-selected { <xsl:if test="tab_color_scheme_selected!='spec'">background-color: <xsl:value-of select="$main.sTabColorSel1"/>; background-image: linear-gradient(<xsl:value-of select="$main.nTabAngle"/>deg, <xsl:value-of select="$main.sTabColorSel1"/> 10%, <xsl:value-of select="$main.sTabColorSel3"/> 50%, <xsl:value-of select="$main.sTabColorSel4"/> 50%, <xsl:value-of select="$main.sTabColorSel2"/> 90%); border-color: <xsl:value-of select="$main.sTabColorSelBorder"/>;</xsl:if> }
		.cl-tab-table-cell { height: <xsl:value-of select="$main.nTabInnerHeight"/>px; width: <xsl:value-of select="$main.nTabInnerWidth"/>px; <xsl:value-of select="$main.sTabFontCSS"/> }
		.cl-tab-text-v { height: <xsl:value-of select="$main.nTabInnerHeight"/>px; width: <xsl:value-of select="$main.nTabInnerWidth"/>px; }
		.cl-tab-text-h { height: <xsl:value-of select="$main.nTabInnerWidth"/>px; width: <xsl:value-of select="$main.nTabInnerHeight"/>px; -webkit-transform-origin: left top; -webkit-transform: rotate(270deg) }
		.cl-tab-idle .cl-tab-table-cell { <xsl:if test="tab_color_scheme!='spec'">color: <xsl:value-of select="$main.sTabColorFont"/>;</xsl:if> }
		.cl-tab-selected .cl-tab-table-cell { <xsl:if test="tab_color_scheme_selected!='spec'">color: <xsl:value-of select="$main.sTabColorSelFont"/>;</xsl:if> }
		.cl-desc { width: <xsl:value-of select="$main.nDescWidth"/>px; height: <xsl:value-of select="$main.nDescHeight"/>px; padding: <xsl:value-of select="desc_padding"/>px; border-width: <xsl:value-of select="desc_border_width"/>px; border-color: <xsl:value-of select="$main.sDescBorderColor"/>; background-color: <xsl:value-of select="$main.sDescColor1"/>; background-image: linear-gradient(<xsl:value-of select="desc_bg_grad_angle"/>deg, <xsl:value-of select="$main.sDescColor1"/> 0%, <xsl:value-of select="$main.sDescColor2"/> 100%); border-radius: <xsl:value-of select="desc_radius"/>px; <xsl:if test="shadow_strength!='none'">box-shadow: <xsl:value-of select="$main.sShadowString"/>;</xsl:if> }
		.cl-desc-text { width: <xsl:value-of select="$main.nDescWidth"/>px; height: <xsl:value-of select="$main.nDescHeight"/>px;}
		<xsl:for-each select="elements/item">
			.cl-tab-<xsl:value-of select="position()"/> {<xsl:choose><xsl:when test="../../tab_type='v'">left: 0; top: <xsl:value-of select="websoft:arrayElem(string($main.arTabTops), position(), '|')"/>px;</xsl:when><xsl:otherwise>top: 0; left: <xsl:value-of select="websoft:arrayElem(string($main.arTabLefts), position(), '|')"/>px;</xsl:otherwise></xsl:choose> }
			.cl-desc-<xsl:value-of select="position()"/> { <xsl:choose><xsl:when test="../../tab_type='v'">left: 0; top: <xsl:value-of select="websoft:arrayElem(string($main.arTabTopsIdle), (position()+1), '|')"/>px;</xsl:when><xsl:otherwise>top: 0; left: <xsl:value-of select="websoft:arrayElem(string($main.arTabLeftsIdle), (position()+1), '|')"/>px;</xsl:otherwise></xsl:choose> }
			<xsl:if test="../../tab_color_scheme='spec'">
				.cl-tab-idle-<xsl:value-of select="position()"/> { background-color: <xsl:value-of select="websoft:arrayElem(string($main.arTabColors), (12*(position()-1)+1), '|')"/>; background-image: linear-gradient(0deg, <xsl:value-of select="websoft:arrayElem(string($main.arTabColors), (12*(position()-1)+1), '|')"/> 10%, <xsl:value-of select="websoft:arrayElem(string($main.arTabColors), (12*(position()-1)+3), '|')"/> 50%, <xsl:value-of select="websoft:arrayElem(string($main.arTabColors), (12*(position()-1)+4), '|')"/> 50%, <xsl:value-of select="websoft:arrayElem(string($main.arTabColors), (12*(position()-1)+2), '|')"/> 90%); border-color: <xsl:value-of select="websoft:arrayElem(string($main.arTabColors), (12*(position()-1)+5), '|')"/>; }
				.cl-tab-idle-<xsl:value-of select="position()"/> .cl-tab-table-cell { color: <xsl:value-of select="websoft:arrayElem(string($main.arTabColors), (12*(position()-1)+6), '|')"/>; }
			</xsl:if>
			<xsl:if test="../../tab_color_scheme_selected='spec'">
				.cl-tab-selected-<xsl:value-of select="position()"/> { background-color: <xsl:value-of select="websoft:arrayElem(string($main.arTabColors), (12*(position()-1)+7), '|')"/>; background-image: linear-gradient(0deg, <xsl:value-of select="websoft:arrayElem(string($main.arTabColors), (12*(position()-1)+7), '|')"/> 10%, <xsl:value-of select="websoft:arrayElem(string($main.arTabColors), (12*(position()-1)+9), '|')"/> 50%, <xsl:value-of select="websoft:arrayElem(string($main.arTabColors), (12*(position()-1)+10), '|')"/> 50%, <xsl:value-of select="websoft:arrayElem(string($main.arTabColors), (12*(position()-1)+8), '|')"/> 90%); border-color: <xsl:value-of select="websoft:arrayElem(string($main.arTabColors), (12*(position()-1)+11), '|')"/>; }
				.cl-tab-selected-<xsl:value-of select="position()"/> .cl-tab-table-cell { color: <xsl:value-of select="websoft:arrayElem(string($main.arTabColors), (12*(position()-1)+12), '|')"/>; }
			</xsl:if>
		</xsl:for-each>
	</style>

	<div>
		<xsl:attribute name="class">clo-v_rapid_005</xsl:attribute>
		<div>
			<xsl:attribute name="class">cl-container</xsl:attribute>
			<div>
				<xsl:attribute name="class">cl-bg</xsl:attribute>

				<xsl:if test="display_ribbon='yes'">
					<div>
						<xsl:attribute name="class">cl-header-part</xsl:attribute>
						<table>
							<xsl:attribute name="class">cl-header-table</xsl:attribute>
							<tr>
								<td>
									<xsl:attribute name="class">cl-header-cell-name</xsl:attribute>
									<div>
										<xsl:attribute name="class">cl-header-title unselectable</xsl:attribute>
										<xsl:value-of select="ribbon_text"/>
									</div>
								</td>
								<td>
									<xsl:attribute name="class">cl-header-cell-btn</xsl:attribute>
									<xsl:call-template name="btn"><xsl:with-param name="param.sDir">left</xsl:with-param></xsl:call-template>
								</td>
								<td>
									<xsl:attribute name="class">cl-header-cell-btn</xsl:attribute>
									<xsl:call-template name="btn"><xsl:with-param name="param.sDir">right</xsl:with-param></xsl:call-template>
								</td>
							</tr>
						</table>
					</div>
				</xsl:if>
				<div>
					<xsl:attribute name="class">cl-tab-block</xsl:attribute>
					<xsl:for-each select="elements/item">
						<xsl:call-template name="tab">
							<xsl:with-param name="param.iLevelNumber" select="position()"/>
							<xsl:with-param name="param.iLevelToPreview" select="$main.iItemToPreview"/>
						</xsl:call-template>
						<xsl:call-template name="desc">
							<xsl:with-param name="param.iLevelNumber" select="position()"/>
							<xsl:with-param name="param.iLevelToPreview" select="$main.iItemToPreview"/>
						</xsl:call-template>
					</xsl:for-each>
					<xsl:if test="display_default_text='yes' and number($main.iItemToPreview)=0">
						<xsl:call-template name="desc">
							<xsl:with-param name="param.iLevelNumber">0</xsl:with-param>
							<xsl:with-param name="param.iLevelToPreview" select="$main.iItemToPreview"/>
						</xsl:call-template>
					</xsl:if>
				</div>
			</div>
		</div>
	</div>

</xsl:template>
<xsl:template name="btn">
	<xsl:param name="param.sDir"/>
	<div>
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_HEADER_BTN_<xsl:value-of select="$param.sDir"/></xsl:attribute>
		<xsl:attribute name="class">cl-btn cl-header-btn cl-header-btn-idle cl-header-btn-<xsl:value-of select="$param.sDir"/> unselectable</xsl:attribute>
		<div>
			<xsl:attribute name="class">cl-arrow cl-arrow-<xsl:value-of select="$param.sDir"/></xsl:attribute>
			&#160;
		</div>
	</div>
</xsl:template>
<xsl:template name="tab">
	<xsl:param name="param.iLevelNumber"/>
	<xsl:param name="param.iLevelToPreview"/>

	<div>
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_TAB_<xsl:value-of select="$param.iLevelNumber"/></xsl:attribute>
		<xsl:attribute name="class">cl-tab <xsl:choose><xsl:when test="number($param.iLevelToPreview)=number($param.iLevelNumber)">cl-tab-selected cl-tab-selected-<xsl:value-of select="$param.iLevelNumber"/></xsl:when><xsl:otherwise>cl-tab-idle cl-tab-idle-<xsl:value-of select="$param.iLevelNumber"/></xsl:otherwise></xsl:choose> unselectable cl-tab-<xsl:value-of select="$param.iLevelNumber"/></xsl:attribute>
		<xsl:attribute name="style"></xsl:attribute>
		<xsl:attribute name="data-number"><xsl:value-of select="$param.iLevelNumber"/></xsl:attribute>
		<table>
			<xsl:attribute name="class">cl-tab-table</xsl:attribute>
			<tr>
				<td>
					<xsl:attribute name="class">cl-tab-table-cell</xsl:attribute>
					<div>
						<xsl:attribute name="class">cl-tab-text cl-tab-text-<xsl:value-of select="../../tab_type"/></xsl:attribute>
						<xsl:value-of select="tab_text"/>
					</div>
				</td>
			</tr>
		</table>
	</div>
</xsl:template>
<xsl:template name="desc">
	<xsl:param name="param.iLevelNumber"/>
	<xsl:param name="param.iLevelToPreview"/>
	<div>
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_DESC_<xsl:value-of select="$param.iLevelNumber"/></xsl:attribute>
		<xsl:attribute name="class">cl-desc cl-desc-<xsl:value-of select="$param.iLevelNumber"/></xsl:attribute>
		<xsl:attribute name="data-number"><xsl:value-of select="$param.iLevelNumber"/></xsl:attribute>
		<xsl:attribute name="style"><xsl:if test="number($param.iLevelNumber)!=number($param.iLevelToPreview)">display: none;</xsl:if></xsl:attribute>
		<div>
			<xsl:attribute name="class">cl-desc-text</xsl:attribute>
			<xsl:choose>
				<xsl:when test="number($param.iLevelNumber)=0"><xsl:value-of select="default_text" disable-output-escaping="yes"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="desc_text" disable-output-escaping="yes"/></xsl:otherwise>
			</xsl:choose>
		</div>
	</div>
</xsl:template>

<!-- COMMON TEMPLATES -->
<xsl:template name="define-color">
	<xsl:param name="sProfile"/>
	<xsl:param name="sColorType"/>
	<xsl:param name="sCustom"/>
	<xsl:param name="sCustomGradient"/>
	<xsl:param name="sCustomBorder"/>
	<xsl:choose>
		<xsl:when test="$sColorType='color1'">
			<xsl:choose>
				<xsl:when test="$sProfile='turquoise'">#53CFD7</xsl:when>
				<xsl:when test="$sProfile='lightblue'">#33CCFF</xsl:when>
				<xsl:when test="$sProfile='yellow'">#FFCC00</xsl:when>
				<xsl:when test="$sProfile='green'">#7EB83A</xsl:when>
				<xsl:when test="$sProfile='brown'">#BD865C</xsl:when>
				<xsl:when test="$sProfile='red'">#FA2C2C</xsl:when>
				<xsl:when test="$sProfile='deeppink'">#EC4E7A</xsl:when>
				<xsl:when test="$sProfile='olive'">#91A030</xsl:when>
				<xsl:when test="$sProfile='orange'">#FF9900</xsl:when>
				<xsl:when test="$sProfile='pink'">#FF61CE</xsl:when>
				<xsl:when test="$sProfile='grey'">#969696</xsl:when>
				<xsl:when test="$sProfile='bluegreen'">#357E7E</xsl:when>
				<xsl:when test="$sProfile='blue'">#3967AC</xsl:when>
				<xsl:when test="$sProfile='steelblue'">#6A84BF</xsl:when>
				<xsl:when test="$sProfile='violet'">#8C46C2</xsl:when>
				<xsl:when test="$sProfile='white'">#FFFFFF</xsl:when>
				<xsl:when test="$sProfile='black'">#000000</xsl:when>
				<xsl:when test="$sProfile='auto'"><xsl:value-of select="$sCustom"/></xsl:when>
				<xsl:when test="$sProfile='custom'"><xsl:value-of select="$sCustom"/></xsl:when>
			</xsl:choose>
		</xsl:when>
		<xsl:when test="$sColorType='color2'">
			<xsl:choose>
				<xsl:when test="$sProfile='turquoise'">#A6DEDE</xsl:when>
				<xsl:when test="$sProfile='lightblue'">#DFEFFF</xsl:when>
				<xsl:when test="$sProfile='yellow'">#FFFFCC</xsl:when>
				<xsl:when test="$sProfile='green'">#DDFFCC</xsl:when>
				<xsl:when test="$sProfile='brown'">#FAE1C8</xsl:when>
				<xsl:when test="$sProfile='red'">#FFE0E0</xsl:when>
				<xsl:when test="$sProfile='deeppink'">#FFDBE7</xsl:when>
				<xsl:when test="$sProfile='olive'">#F5F5CB</xsl:when>
				<xsl:when test="$sProfile='orange'">#FFE2C4</xsl:when>
				<xsl:when test="$sProfile='pink'">#FAE6FA</xsl:when>
				<xsl:when test="$sProfile='grey'">#E6E6E6</xsl:when>
				<xsl:when test="$sProfile='bluegreen'">#A8E3C2</xsl:when>
				<xsl:when test="$sProfile='blue'">#BED5F8</xsl:when>
				<xsl:when test="$sProfile='steelblue'">#E1E9F5</xsl:when>
				<xsl:when test="$sProfile='violet'">#EDDCFA</xsl:when>
				<xsl:when test="$sProfile='white'">#EEEEFF</xsl:when>
				<xsl:when test="$sProfile='black'">#333333</xsl:when>
				<xsl:when test="$sProfile='auto'">
					<xsl:call-template name="autogradient">
						<xsl:with-param name="color.base" select="$sCustom"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="$sProfile='custom'"><xsl:value-of select="$sCustomGradient"/></xsl:when>
			</xsl:choose>
		</xsl:when>
		<xsl:when test="$sColorType='border'">
			<xsl:choose>
				<xsl:when test="$sProfile='turquoise'">#53CFD7</xsl:when>
				<xsl:when test="$sProfile='lightblue'">#33CCFF</xsl:when>
				<xsl:when test="$sProfile='yellow'">#FFCC00</xsl:when>
				<xsl:when test="$sProfile='green'">#7EB83A</xsl:when>
				<xsl:when test="$sProfile='brown'">#BD865C</xsl:when>
				<xsl:when test="$sProfile='red'">#FA2C2C</xsl:when>
				<xsl:when test="$sProfile='deeppink'">#EC4E7A</xsl:when>
				<xsl:when test="$sProfile='olive'">#91A030</xsl:when>
				<xsl:when test="$sProfile='orange'">#FF9900</xsl:when>
				<xsl:when test="$sProfile='pink'">#FF61CE</xsl:when>
				<xsl:when test="$sProfile='grey'">#969696</xsl:when>
				<xsl:when test="$sProfile='bluegreen'">#357E7E</xsl:when>
				<xsl:when test="$sProfile='blue'">#3967AC</xsl:when>
				<xsl:when test="$sProfile='steelblue'">#6A84BF</xsl:when>
				<xsl:when test="$sProfile='violet'">#8C46C2</xsl:when>
				<xsl:when test="$sProfile='white'">#FFFFFF</xsl:when>
				<xsl:when test="$sProfile='black'">#000000</xsl:when>
				<xsl:when test="$sProfile='auto'">
					<xsl:call-template name="lighten">
						<xsl:with-param name="color.base" select="$sCustom"/>
						<xsl:with-param name="ratio">0.8</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="$sProfile='custom'"><xsl:value-of select="$sCustomBorder"/></xsl:when>
			</xsl:choose>
		</xsl:when>
		<xsl:when test="$sColorType='font'">
			<xsl:choose>
				<xsl:when test="$sProfile='turquoise'">#286266</xsl:when>
				<xsl:when test="$sProfile='lightblue'">#1f7a99</xsl:when>
				<xsl:when test="$sProfile='yellow'">#806600</xsl:when>
				<xsl:when test="$sProfile='green'">#466621</xsl:when>
				<xsl:when test="$sProfile='brown'">#664932</xsl:when>
				<xsl:when test="$sProfile='red'">#801717</xsl:when>
				<xsl:when test="$sProfile='deeppink'">#802a42</xsl:when>
				<xsl:when test="$sProfile='olive'">#5c661f</xsl:when>
				<xsl:when test="$sProfile='orange'">#804d00</xsl:when>
				<xsl:when test="$sProfile='pink'">#803066</xsl:when>
				<xsl:when test="$sProfile='grey'">#4d4d4d</xsl:when>
				<xsl:when test="$sProfile='bluegreen'">#204d4d</xsl:when>
				<xsl:when test="$sProfile='blue'">#223d66</xsl:when>
				<xsl:when test="$sProfile='steelblue'">#384666</xsl:when>
				<xsl:when test="$sProfile='violet'">#371c4d</xsl:when>
				<xsl:when test="$sProfile='white'">#999999</xsl:when>
				<xsl:when test="$sProfile='black'">#FFFFFF</xsl:when>
				<xsl:when test="$sProfile='auto'">
					<xsl:call-template name="lighten">
						<xsl:with-param name="color.base" select="$sCustom"/>
						<xsl:with-param name="ratio">0.5</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="$sProfile='custom'"><xsl:value-of select="$sCustomBorder"/></xsl:when>
			</xsl:choose>
		</xsl:when>
	</xsl:choose>
</xsl:template>
<xsl:template name="shadow_builder">
	<xsl:param name="sType"/>
	<xsl:param name="sStrength"/>
	<xsl:param name="sColor"/>
	<xsl:param name="sOpacity"/>
	<xsl:if test="$sStrength!='none'">
		<xsl:variable name="sHexColor">
			<xsl:choose>
				<xsl:when test="$sType='text'">
					<xsl:choose>
						<xsl:when test="string-length($sColor)!=0"><xsl:value-of select="$sColor"/></xsl:when>
						<xsl:otherwise>#FFFFFF</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$sStrength='extralight'">#CCCCCC</xsl:when>
						<xsl:when test="$sStrength='light'">#999999</xsl:when>
						<xsl:when test="$sStrength='normal'">#666666</xsl:when>
						<xsl:when test="$sStrength='dark'">#333333</xsl:when>
						<xsl:when test="$sStrength='extradark'">#000000</xsl:when>
						<xsl:otherwise>#666666</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="sOp">
			<xsl:choose>
				<xsl:when test="$sType='text'">
					<xsl:choose>
						<xsl:when test="string-length($sOpacity)=0">
							<xsl:choose>
								<xsl:when test="$sStrength='extralight'">0.3</xsl:when>
								<xsl:when test="$sStrength='light'">0.5</xsl:when>
								<xsl:when test="$sStrength='normal'">0.66</xsl:when>
								<xsl:when test="$sStrength='dark'">0.9</xsl:when>
								<xsl:when test="$sStrength='extradark'">1.0</xsl:when>
								<xsl:otherwise>0.66</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$sOpacity"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$sStrength='extralight'">0.3</xsl:when>
						<xsl:when test="$sStrength='light'">0.5</xsl:when>
						<xsl:when test="$sStrength='normal'">0.66</xsl:when>
						<xsl:when test="$sStrength='dark'">0.9</xsl:when>
						<xsl:when test="$sStrength='extradark'">1.0</xsl:when>
						<xsl:otherwise>0.66</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="sRGB">
			<xsl:call-template name="hex2rgb">
				<xsl:with-param name="hexcolor" select="$sHexColor"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="sOffset">
			<xsl:choose>
				<xsl:when test="$sType='text'">
					<xsl:choose>
						<xsl:when test="$sStrength='extralight'">1px 1px 2px</xsl:when>
						<xsl:when test="$sStrength='light'">1px 1px 2px</xsl:when>
						<xsl:when test="$sStrength='normal'">1px 1px 2px</xsl:when>
						<xsl:when test="$sStrength='dark'">2px 2px 3px</xsl:when>
						<xsl:when test="$sStrength='extradark'">2px 2px 4px</xsl:when>
						<xsl:otherwise>1px 1px 2px</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$sStrength='extralight'">1px 1px 2px</xsl:when>
						<xsl:when test="$sStrength='light'">2px 2px 4px</xsl:when>
						<xsl:when test="$sStrength='normal'">2px 2px 6px</xsl:when>
						<xsl:when test="$sStrength='dark'">3px 3px 6px</xsl:when>
						<xsl:when test="$sStrength='extradark'">3px 3px 8px</xsl:when>
						<xsl:otherwise>1px 1px 2px</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="concat($sOffset,' rgba(',$sRGB,',',$sOp,')')"/>
	</xsl:if>
</xsl:template>
<xsl:template name="font_selector">
	<xsl:param name="sFontID"/>
	<xsl:choose>
		<xsl:when test="$sFontID='Arial'">Arial,'Helvetica Neue',Helvetica,sans-serif</xsl:when>
		<xsl:when test="$sFontID='ArialBlack'">'Arial Black','Arial Bold',Gadget,sans-serif</xsl:when>
		<xsl:when test="$sFontID='ArialNarrow'">'Arial Narrow',Arial,sans-serif</xsl:when>
		<xsl:when test="$sFontID='Comic Sans MS'">'Comic Sans MS', cursive, sans-serif</xsl:when>
		<xsl:when test="$sFontID='CourierNew'">'Courier New',Courier,'Lucida Sans Typewriter','Lucida Typewriter',monospace</xsl:when>
		<xsl:when test="$sFontID='Georgia'">Georgia,Times,'Times New Roman',serif</xsl:when>
		<xsl:when test="$sFontID='Impact'">Impact,Haettenschweiler,'Franklin Gothic Bold',Charcoal,'Helvetica Inserat','Bitstream Vera Sans Bold','Arial Black',sans-serif</xsl:when>
		<xsl:when test="$sFontID='LucidaConsole'">'Lucida Console','Lucida Sans Typewriter',monaco,'Bitstream Vera Sans Mono',monospace</xsl:when>
		<xsl:when test="$sFontID='LucidaSansUnicode'">'Lucida Sans Unicode', 'Lucida Grande', sans-serif</xsl:when>
		<xsl:when test="$sFontID='Palatino'">Palatino,'Palatino Linotype','Palatino LT STD','Book Antiqua',Georgia,serif</xsl:when>
		<xsl:when test="$sFontID='Tahoma'">Tahoma,Verdana,Segoe,sans-serif</xsl:when>
		<xsl:when test="$sFontID='Times'">TimesNewRoman,'Times New Roman',Times,Baskerville,Georgia,serif</xsl:when>
		<xsl:when test="$sFontID='TrebuchetMS'">'Trebuchet MS','Lucida Grande','Lucida Sans Unicode','Lucida Sans',Tahoma,sans-serif</xsl:when>
		<xsl:when test="$sFontID='Verdana'">Verdana,Geneva,sans-serif</xsl:when>
		<xsl:when test="$sFontID='clear_sans_lightregular'">clear_sans_lightregular, 'Arial Narrow', sans-serif</xsl:when>
		<xsl:when test="$sFontID='clear_sans_mediumregular'">clear_sans_mediumregular, Arial, sans-serif</xsl:when>
		<xsl:when test="$sFontID='clear_sansregular'">clear_sansregular, Arial, sans-serif</xsl:when>
		<xsl:when test="$sFontID='clear_sans_thinregular'">clear_sans_thinregular, 'Arial Narrow', sans-serif</xsl:when>
		<xsl:when test="$sFontID='droid_sans_monoregular'">droid_sans_monoregular, 'Lucida Console', Monaco, monospace</xsl:when>
		<xsl:when test="$sFontID='droid_sansregular'">droid_sansregular, Verdana, sans-serif</xsl:when>
		<xsl:when test="$sFontID='droid_serifregular'">droid_serifregular, Georgia, serif</xsl:when>
		<xsl:when test="$sFontID='Fira_Mono'">Fira_Mono, 'Lucida Console', monospace</xsl:when>
		<xsl:when test="$sFontID='Fira_Sans'">Fira_Sans, Arial, sans-serif</xsl:when>
		<xsl:when test="$sFontID='FiraSansLight'">FiraSansLight, Arial, sans-serif</xsl:when>
		<xsl:when test="$sFontID='FiraSansMedium'">FiraSansMedium, Arial, sans-serif</xsl:when>
		<xsl:when test="$sFontID='Fregat_Sans'">Fregat_Sans, Arial, sans-serif</xsl:when>
		<xsl:when test="$sFontID='Lato_Sans'">Lato_Sans, Arial, sans-serif</xsl:when>
		<xsl:when test="$sFontID='LatoSansLight'">LatoSansLight, Arial, sans-serif</xsl:when>
		<xsl:when test="$sFontID='nerisblack'">nerisblack, 'Arial Black', sans-serif</xsl:when>
		<xsl:when test="$sFontID='nerislight'">nerislight, Arial, sans-serif</xsl:when>
		<xsl:when test="$sFontID='nerissemibold'">nerissemibold, Arial, sans-serif</xsl:when>
		<xsl:when test="$sFontID='neristhin'">neristhin, Arial, sans-serif</xsl:when>
		<xsl:when test="$sFontID='noto_sansregular'">noto_sansregular, Arial, sans-serif</xsl:when>
		<xsl:when test="$sFontID='noto_serifregular'">noto_serifregular, Georgia, serif</xsl:when>
		<xsl:when test="$sFontID='open_sanscondensed_light'">open_sanscondensed_light, 'Arial Narrow', sans-serif</xsl:when>
		<xsl:when test="$sFontID='open_sansextrabold'">open_sansextrabold, 'Arial Black', sans-serif</xsl:when>
		<xsl:when test="$sFontID='open_sanslight'">open_sanslight, Arial, sans-serif</xsl:when>
		<xsl:when test="$sFontID='open_sansregular'">open_sansregular, Arial, sans-serif</xsl:when>
		<xsl:when test="$sFontID='open_sanssemibold'">open_sanssemibold, Arial, sans-serif</xsl:when>
		<xsl:when test="$sFontID='permiansanstypefaceregular'">permiansanstypefaceregular, Arial, sans-serif</xsl:when>
		<xsl:when test="$sFontID='permianseriftypefaceregular'">permianseriftypefaceregular, Georgia, serif</xsl:when>
		<xsl:when test="$sFontID='permianslabseriftypefaceRg'">permianslabseriftypefaceRg, Georgia, serif</xsl:when>
		<xsl:when test="$sFontID='robotoblack'">robotoblack, 'Arial Black', Gadget, sans-serif</xsl:when>
		<xsl:when test="$sFontID='roboto_condensedregular'">roboto_condensedregular, 'Arial Narrow', sans-serif</xsl:when>
		<xsl:when test="$sFontID='roboto_condensedlight'">roboto_condensedlight, 'Arial Narrow', sans-serif</xsl:when>
		<xsl:when test="$sFontID='robotolight'">robotolight, Arial, Helvetica, sans-serif</xsl:when>
		<xsl:when test="$sFontID='robotomedium'">robotomedium, Arial, Helvetica, sans-serif</xsl:when>
		<xsl:when test="$sFontID='robotoregular'">robotoregular, Arial, Helvetica, sans-serif</xsl:when>
		<xsl:when test="$sFontID='robotothin'">robotothin, Arial, Helvetica, sans-serif</xsl:when>
		<xsl:when test="$sFontID='roboto_slablight'">roboto_slablight, Georgia, serif</xsl:when>
		<xsl:when test="$sFontID='roboto_slabregular'">roboto_slabregular, Georgia, serif</xsl:when>
		<xsl:when test="$sFontID='roboto_slabthin'">roboto_slabthin, Georgia, serif</xsl:when>
		<xsl:otherwise>robotoregular, Arial, Helvetica, sans-serif</xsl:otherwise>
	</xsl:choose>
</xsl:template>
<xsl:template name="fix-color">
	<xsl:param name="color"/>
	<xsl:choose>
		<xsl:when test="substring($color, 1, 1)='#'">
			<xsl:choose>
				<xsl:when test="string-length($color)=7"><xsl:value-of select="$color"/></xsl:when>
				<xsl:when test="string-length($color)=4">#<xsl:value-of select="substring($color, 2, 1)"/><xsl:value-of select="substring($color, 2, 1)"/><xsl:value-of select="substring($color, 3, 1)"/><xsl:value-of select="substring($color, 3, 1)"/><xsl:value-of select="substring($color, 4, 1)"/><xsl:value-of select="substring($color, 4, 1)"/></xsl:when>
				<xsl:otherwise>transparent</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>transparent</xsl:otherwise>
	</xsl:choose>
</xsl:template>
<!--
	COLOR CONVERSION START
	Templates:
		hex2rgb (hexcolor: 7-character hex color value, starts with #) = 7-character hex color value, starts with #, returns comma-separated values r,g,b
		autogradient (color.base: 7-character hex color value, starts with #) = 7-character hex color value, starts with #
		lighten (color.base: 7-character hex color value, starts with #, ratio - 0-1 - darken, 1+ - lighten) = 7-character hex color value, starts with #
		getcolor (color.base: 7-character hex color value, starts with #, color.base.type - string [color1|color2], color.target.type - string [color1|color2|color3|color4\stroke|font]) = 7-character hex color value, starts with #
		hex2todec (hex2: 2-character hex value) = integer decimal value
		hex1todec (hex: 1-character hex value) = integer decimal value
		dectohex2 (dec2: 0-255 decimal value) = 2-character hex value
		dectohex1 (dec: 0-15 decimal value) = 1-character hex value
		hue (hexcolor: 7-character hex color value, starts with #) = 0-360 degrees integer decimal hue value
		saturation (hexcolor: 7-character hex color value, starts with #) = 0-100 percents integer decimal saturation value
		brightness (hexcolor: 7-character hex color value, starts with #) = 0-100 percents integer decimal brightness value
		inverted (hexcolor: 7-character hex color value, starts with #) = 7-character hex color value, starts with #
		max (C1,C2,C3: decimal values) = maximal from these 3 values
		min (C1,C2,C3: decimal values) = minimal from these 3 values
		RGBtoHex (R,G,B: decimal 0-255 color values) = 7-character hex color value, starts with #
		HSBtoHex (H: 0-360 degrees integer decimal hue value,S,B: decimal 0-100 percent saturation and brightness values) = 7-character hex color value, starts with #
-->
<xsl:template match="*" name="hex2rgb">
	<xsl:param name="hexcolor"/>
	<xsl:variable name="rhex" select="substring($hexcolor, 2, 2)"/>
	<xsl:variable name="ghex" select="substring($hexcolor, 4, 2)"/>
	<xsl:variable name="bhex" select="substring($hexcolor, 6, 2)"/>
	<xsl:variable name="rdec">
		<xsl:call-template name="hex2todec">
			<xsl:with-param name="hex2" select="$rhex"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="gdec">
		<xsl:call-template name="hex2todec">
			<xsl:with-param name="hex2" select="$ghex"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="bdec">
		<xsl:call-template name="hex2todec">
			<xsl:with-param name="hex2" select="$bhex"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:value-of select="$rdec"/>,<xsl:value-of select="$gdec"/>,<xsl:value-of select="$bdec"/>
</xsl:template>
<xsl:template match="*" name="autogradient">

	<xsl:param name="color.base"/>
	<xsl:variable name="ratio">2</xsl:variable>
	<xsl:variable name="base.H">
		<xsl:call-template name="hue">
			<xsl:with-param name="hexcolor" select="$color.base"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="base.S">
		<xsl:call-template name="saturation">
			<xsl:with-param name="hexcolor" select="$color.base"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="base.B">
		<xsl:call-template name="brightness">
			<xsl:with-param name="hexcolor" select="$color.base"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="target.B">
		<xsl:choose>
			<xsl:when test="(number($base.B)*number($ratio)) &gt; 100">100</xsl:when>
			<xsl:otherwise><xsl:value-of select="round(number($base.B)*number($ratio))"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="target.S">
		<xsl:choose>
			<xsl:when test="number($target.B)=100"><xsl:value-of select="0.35*number($base.S)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="0.5*number($base.S)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:call-template name="HSBtoHex">
		<xsl:with-param name="H" select="$base.H"/>
		<xsl:with-param name="S" select="$target.S"/>
		<xsl:with-param name="B" select="$target.B"/>
	</xsl:call-template>
</xsl:template>
<xsl:template match="*" name="lighten">

	<xsl:param name="color.base"/>
	<xsl:param name="ratio"/>
	<xsl:variable name="base.H">
		<xsl:call-template name="hue">
			<xsl:with-param name="hexcolor" select="$color.base"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="base.S">
		<xsl:call-template name="saturation">
			<xsl:with-param name="hexcolor" select="$color.base"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="base.B">
		<xsl:call-template name="brightness">
			<xsl:with-param name="hexcolor" select="$color.base"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="target.B">
		<xsl:choose>
			<xsl:when test="(number($base.B)*number($ratio)) &gt; 100">100</xsl:when>
			<xsl:otherwise><xsl:value-of select="round(number($base.B)*number($ratio))"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:call-template name="HSBtoHex">
		<xsl:with-param name="H" select="$base.H"/>
		<xsl:with-param name="S" select="$base.S"/>
		<xsl:with-param name="B" select="$target.B"/>
	</xsl:call-template>
</xsl:template>

<xsl:template match="*" name="getcolor">

	<xsl:param name="color.base"/>
	<xsl:param name="color.base.type"/>
	<xsl:param name="color.target.type"/>

	<xsl:variable name="base.H">
		<xsl:call-template name="hue">
			<xsl:with-param name="hexcolor" select="$color.base"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="base.S">
		<xsl:call-template name="saturation">
			<xsl:with-param name="hexcolor" select="$color.base"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="base.B">
		<xsl:call-template name="brightness">
			<xsl:with-param name="hexcolor" select="$color.base"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="target.H" select="$base.H"/>
	<xsl:variable name="target.S">
		<xsl:choose>
			<xsl:when test="$color.base.type='color1'">
				<xsl:choose>
					<xsl:when test="$color.target.type='color2'"><xsl:value-of select="round(0.35*number($base.S))"/></xsl:when>
					<xsl:when test="$color.target.type='color3'"><xsl:value-of select="round(0.67 * number($base.S))"/></xsl:when>
					<xsl:when test="$color.target.type='color4'"><xsl:value-of select="round(0.56 * number($base.S))"/></xsl:when>
					<xsl:when test="$color.target.type='stroke' or $color.target.type='font'">
						<xsl:choose>
							<xsl:when test="round(1.2*number($base.S)) &gt; 100">100</xsl:when>
							<xsl:otherwise><xsl:value-of select="round(1.2*number($base.S))"/></xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise><xsl:value-of select="$base.S"/></xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$color.base.type='color2'">
				<xsl:choose>
					<xsl:when test="$color.target.type='color1'">
						<xsl:choose>
							<xsl:when test="(2.8*number($base.S)) &gt; 100">100</xsl:when>
							<xsl:otherwise><xsl:value-of select="round(2.8*number($base.S))"/></xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$color.target.type='color3'">
						<xsl:choose>
							<xsl:when test="(1.56*number($base.S)) &gt; 100">100</xsl:when>
							<xsl:otherwise><xsl:value-of select="round(1.56 * number($base.S))"/></xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$color.target.type='color4'">
						<xsl:choose>
							<xsl:when test="(1.88*number($base.S)) &gt; 100">100</xsl:when>
							<xsl:otherwise><xsl:value-of select="round(1.88 * number($base.S))"/></xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$color.target.type='stroke'">
						<xsl:choose>
							<xsl:when test="round(3.38*number($base.S)) &gt; 100">100</xsl:when>
							<xsl:otherwise><xsl:value-of select="round(3.38*number($base.S))"/></xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$color.target.type='font'">
						<xsl:choose>
							<xsl:when test="round(3.38*number($base.S)) &gt; 100">100</xsl:when>
							<xsl:otherwise><xsl:value-of select="round(3.38*number($base.S))"/></xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise><xsl:value-of select="$base.S"/></xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="$base.S"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="target.B">
		<xsl:choose>
			<xsl:when test="$color.base.type='color1'">
				<xsl:choose>
					<xsl:when test="$color.target.type='color2'">
						<xsl:choose>
							<xsl:when test="number($base.B) &lt; 70">
								<xsl:choose>
									<xsl:when test="(number($base.B)*1.4) &gt; 100">100</xsl:when>
									<xsl:otherwise><xsl:value-of select="round(number($base.B)*1.4)"/></xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="(number($base.B)*1.2) &gt; 100">100</xsl:when>
									<xsl:otherwise><xsl:value-of select="round(number($base.B)*1.2)"/></xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$color.target.type='color3'">
						<xsl:choose>
							<xsl:when test="(number($base.B)*1.09) &gt; 100">100</xsl:when>
							<xsl:otherwise><xsl:value-of select="round(number($base.B)*1.08)"/></xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$color.target.type='color4'">
						<xsl:choose>
							<xsl:when test="(number($base.B)*1.13) &gt; 100">100</xsl:when>
							<xsl:otherwise><xsl:value-of select="round(number($base.B)*1.13)"/></xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$color.target.type='stroke'"><xsl:value-of select="round(0.75*number($base.B))"/></xsl:when>
					<xsl:when test="$color.target.type='font'"><xsl:value-of select="round(0.5*number($base.B))"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="$base.B"/></xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$color.base.type='color2'">
				<xsl:choose>
					<xsl:when test="$color.target.type='color1'"><xsl:value-of select="round(0.83*number($base.B))"/></xsl:when>
					<xsl:when test="$color.target.type='color3'"><xsl:value-of select="round(0.91*number($base.B))"/></xsl:when>
					<xsl:when test="$color.target.type='color4'"><xsl:value-of select="round(0.94*number($base.B))"/></xsl:when>
					<xsl:when test="$color.target.type='stroke'"><xsl:value-of select="round(0.62*number($base.B))"/></xsl:when>
					<xsl:when test="$color.target.type='font'"><xsl:value-of select="round(0.53*number($base.B))"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="$base.B"/></xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="$base.B"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:call-template name="HSBtoHex">
		<xsl:with-param name="H" select="$target.H"/>
		<xsl:with-param name="S" select="$target.S"/>
		<xsl:with-param name="B" select="$target.B"/>
	</xsl:call-template>
</xsl:template>
<xsl:template match="*" name="hex2todec">
	<xsl:param name="hex2"/>
	<xsl:variable name="d1">
		<xsl:call-template name="hex1todec">
			<xsl:with-param name="hex" select="substring(string($hex2), 1, 1)"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="d2">
		<xsl:call-template name="hex1todec">
			<xsl:with-param name="hex" select="substring(string($hex2), 2, 1)"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:value-of select="number($d1)*16 + number($d2)"/>
</xsl:template>
<xsl:template match="*" name="hex1todec">
	<xsl:param name="hex"/>
	<xsl:choose>
		<xsl:when test="$hex='A' or $hex='a'">10</xsl:when>
		<xsl:when test="$hex='B' or $hex='b'">11</xsl:when>
		<xsl:when test="$hex='C' or $hex='c'">12</xsl:when>
		<xsl:when test="$hex='D' or $hex='d'">13</xsl:when>
		<xsl:when test="$hex='E' or $hex='e'">14</xsl:when>
		<xsl:when test="$hex='F' or $hex='f'">15</xsl:when>
		<xsl:otherwise>
			<xsl:choose>
				<xsl:when test="string(number($hex))='NaN'">0</xsl:when>
				<xsl:otherwise><xsl:value-of select="$hex"/></xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>
<xsl:template match="*" name="dectohex2">
	<xsl:param name="dec2"/>
	<xsl:variable name="d1" select="floor(number($dec2) div 16)"/>
	<xsl:variable name="d2" select="number($dec2) - (number($d1)*16)"/>
	<xsl:variable name="h1">
		<xsl:call-template name="dectohex1">
			<xsl:with-param name="dec" select="$d1"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="h2">
		<xsl:call-template name="dectohex1">
			<xsl:with-param name="dec" select="$d2"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:value-of select="concat(string($h1), string($h2))"/>
</xsl:template>
<xsl:template match="*" name="dectohex1">
	<xsl:param name="dec"/>
	<xsl:choose>
		<xsl:when test="number($dec)=10">A</xsl:when>
		<xsl:when test="number($dec)=11">B</xsl:when>
		<xsl:when test="number($dec)=12">C</xsl:when>
		<xsl:when test="number($dec)=13">D</xsl:when>
		<xsl:when test="number($dec)=14">E</xsl:when>
		<xsl:when test="number($dec)=15">F</xsl:when>
		<xsl:otherwise>
			<xsl:choose>
				<xsl:when test="string(number($dec))='NaN'">0</xsl:when>
				<xsl:otherwise><xsl:value-of select="$dec"/></xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>
<xsl:template match="*" name="hue">
	<xsl:param name="hexcolor"/>
	<xsl:choose>
		<xsl:when test="string-length($hexcolor)=7">
			<xsl:choose>
				<xsl:when test="substring($hexcolor, 1, 1)='#'">
					<xsl:variable name="rhex" select="substring($hexcolor, 2, 2)"/>
					<xsl:variable name="ghex" select="substring($hexcolor, 4, 2)"/>
					<xsl:variable name="bhex" select="substring($hexcolor, 6, 2)"/>
					<xsl:variable name="rdec">
						<xsl:call-template name="hex2todec">
							<xsl:with-param name="hex2" select="$rhex"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="gdec">
						<xsl:call-template name="hex2todec">
							<xsl:with-param name="hex2" select="$ghex"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="bdec">
						<xsl:call-template name="hex2todec">
							<xsl:with-param name="hex2" select="$bhex"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="Rn" select="number($rdec) div 255"/>
					<xsl:variable name="Gn" select="number($gdec) div 255"/>
					<xsl:variable name="Bn" select="number($bdec) div 255"/>
					<xsl:variable name="Cmax">
						<xsl:call-template name="max">
							<xsl:with-param name="C1" select="$Rn"/>
							<xsl:with-param name="C2" select="$Gn"/>
							<xsl:with-param name="C3" select="$Bn"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="Cmin">
						<xsl:call-template name="min">
							<xsl:with-param name="C1" select="$Rn"/>
							<xsl:with-param name="C2" select="$Gn"/>
							<xsl:with-param name="C3" select="$Bn"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="Cdif" select="number($Cmax) - number($Cmin)"/>
					<xsl:choose>
						<xsl:when test="$Cdif='0'">0</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="(number($Cmax)=number($Rn)) and (number($Gn) &gt;= number($Bn))">
									<xsl:value-of select="round(60 * (number($Gn) - number($Bn)) div number($Cdif))"/>
								</xsl:when>
								<xsl:when test="(number($Cmax)=number($Rn)) and (number($Gn) &lt; number($Bn))">
									<xsl:value-of select="round(60 * (number($Gn) - number($Bn)) div number($Cdif)) + 360"/>
								</xsl:when>
								<xsl:when test="number($Cmax)=number($Gn)">
									<xsl:value-of select="round(60 * (number($Bn) - number($Rn)) div number($Cdif)) + 120"/>
								</xsl:when>
								<xsl:when test="number($Cmax)=number($Bn)">
									<xsl:value-of select="round(60 * (number($Rn) - number($Gn)) div number($Cdif)) + 240"/>
								</xsl:when>
								<xsl:otherwise>0</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>0</xsl:otherwise>
	</xsl:choose>
</xsl:template>
<xsl:template match="*" name="saturation">
	<xsl:param name="hexcolor"/>
	<xsl:choose>
		<xsl:when test="string-length($hexcolor)=7">
			<xsl:choose>
				<xsl:when test="substring($hexcolor, 1, 1)='#'">
					<xsl:variable name="rhex" select="substring($hexcolor, 2, 2)"/>
					<xsl:variable name="ghex" select="substring($hexcolor, 4, 2)"/>
					<xsl:variable name="bhex" select="substring($hexcolor, 6, 2)"/>
					<xsl:variable name="rdec">
						<xsl:call-template name="hex2todec">
							<xsl:with-param name="hex2" select="$rhex"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="gdec">
						<xsl:call-template name="hex2todec">
							<xsl:with-param name="hex2" select="$ghex"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="bdec">
						<xsl:call-template name="hex2todec">
							<xsl:with-param name="hex2" select="$bhex"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="Rn" select="number($rdec) div 255"/>
					<xsl:variable name="Gn" select="number($gdec) div 255"/>
					<xsl:variable name="Bn" select="number($bdec) div 255"/>
					<xsl:variable name="Cmax">
						<xsl:call-template name="max">
							<xsl:with-param name="C1" select="$Rn"/>
							<xsl:with-param name="C2" select="$Gn"/>
							<xsl:with-param name="C3" select="$Bn"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="Cmin">
						<xsl:call-template name="min">
							<xsl:with-param name="C1" select="$Rn"/>
							<xsl:with-param name="C2" select="$Gn"/>
							<xsl:with-param name="C3" select="$Bn"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:choose>
						<xsl:when test="(number($Cmax) - number($Cmin))=0">0</xsl:when>
						<xsl:otherwise><xsl:value-of select="round(100*(1 - (number($Cmin) div number($Cmax))))"/></xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>0</xsl:otherwise>
	</xsl:choose>
</xsl:template>
<xsl:template match="*" name="brightness">
	<xsl:param name="hexcolor"/>
	<xsl:choose>
		<xsl:when test="string-length($hexcolor)=7">
			<xsl:choose>
				<xsl:when test="substring($hexcolor, 1, 1)='#'">
					<xsl:variable name="rhex" select="substring($hexcolor, 2, 2)"/>
					<xsl:variable name="ghex" select="substring($hexcolor, 4, 2)"/>
					<xsl:variable name="bhex" select="substring($hexcolor, 6, 2)"/>
					<xsl:variable name="rdec">
						<xsl:call-template name="hex2todec">
							<xsl:with-param name="hex2" select="$rhex"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="gdec">
						<xsl:call-template name="hex2todec">
							<xsl:with-param name="hex2" select="$ghex"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="bdec">
						<xsl:call-template name="hex2todec">
							<xsl:with-param name="hex2" select="$bhex"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="Rn" select="number($rdec) div 255"/>
					<xsl:variable name="Gn" select="number($gdec) div 255"/>
					<xsl:variable name="Bn" select="number($bdec) div 255"/>
					<xsl:variable name="Cmax">
						<xsl:call-template name="max">
							<xsl:with-param name="C1" select="$Rn"/>
							<xsl:with-param name="C2" select="$Gn"/>
							<xsl:with-param name="C3" select="$Bn"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="Cmin">
						<xsl:call-template name="min">
							<xsl:with-param name="C1" select="$Rn"/>
							<xsl:with-param name="C2" select="$Gn"/>
							<xsl:with-param name="C3" select="$Bn"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="round(100*number($Cmax))"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>0</xsl:otherwise>
	</xsl:choose>
</xsl:template>
<xsl:template match="*" name="inverted">
	<xsl:param name="hexcolor"/>
	<xsl:choose>
		<xsl:when test="string-length($hexcolor)=7">
			<xsl:choose>
				<xsl:when test="substring($hexcolor, 1, 1)='#'">
					<xsl:variable name="rhex" select="substring($hexcolor, 2, 2)"/>
					<xsl:variable name="ghex" select="substring($hexcolor, 4, 2)"/>
					<xsl:variable name="bhex" select="substring($hexcolor, 6, 2)"/>
					<xsl:variable name="rdec">
						<xsl:call-template name="hex2todec">
							<xsl:with-param name="hex2" select="$rhex"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="gdec">
						<xsl:call-template name="hex2todec">
							<xsl:with-param name="hex2" select="$ghex"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="bdec">
						<xsl:call-template name="hex2todec">
							<xsl:with-param name="hex2" select="$bhex"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:call-template name="RGBtoHex">
						<xsl:with-param name="R" select="255 - number($rdec)"/>
						<xsl:with-param name="G" select="255 - number($gdec)"/>
						<xsl:with-param name="B" select="255 - number($bdec)"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>#000000</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>#000000</xsl:otherwise>
	</xsl:choose>
</xsl:template>
<xsl:template match="*" name="max">
	<xsl:param name="C1"/>
	<xsl:param name="C2"/>
	<xsl:param name="C3"/>
	<xsl:choose>
		<xsl:when test="number($C1) &gt;= number($C2)">
			<xsl:choose>
				<xsl:when test="number($C1) &gt;= number($C3)"><xsl:value-of select="$C1"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="$C3"/></xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:when test="number($C2) &gt;= number($C3)"><xsl:value-of select="$C2"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="$C3"/></xsl:otherwise>
	</xsl:choose>
</xsl:template>
<xsl:template match="*" name="min">
	<xsl:param name="C1"/>
	<xsl:param name="C2"/>
	<xsl:param name="C3"/>
	<xsl:choose>
		<xsl:when test="(number($C1) &lt;= number($C2)) and (number($C1) &lt;= number($C3))"><xsl:value-of select="$C1"/></xsl:when>
		<xsl:when test="(number($C2) &lt;= number($C1)) and (number($C2) &lt;= number($C3))"><xsl:value-of select="$C2"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="$C3"/></xsl:otherwise>
	</xsl:choose>
</xsl:template>
<xsl:template match="*" name="RGBtoHex">
	<xsl:param name="R"/>
	<xsl:param name="G"/>
	<xsl:param name="B"/>
	<xsl:variable name="Rhex">
		<xsl:call-template name="dectohex2">
			<xsl:with-param name="dec2" select="$R"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="Ghex">
		<xsl:call-template name="dectohex2">
			<xsl:with-param name="dec2" select="$G"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="Bhex">
		<xsl:call-template name="dectohex2">
			<xsl:with-param name="dec2" select="$B"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:value-of select="concat('#',$Rhex,$Ghex,$Bhex)"/>
</xsl:template>
<xsl:template match="*" name="HSBtoHex">
	<xsl:param name="H"/>
	<xsl:param name="S"/>
	<xsl:param name="B"/>
	<xsl:variable name="hsector" select="floor(number($H) div 60)"/>
	<xsl:variable name="hdiff" select="(number($H) div 60) - number($hsector)"/>
	<xsl:variable name="sdec" select="number($S) div 100"/>
	<xsl:variable name="bdec" select="number($B) div 100"/>
	<xsl:variable name="c1" select="number($bdec) * (1 - number($sdec))"/>
	<xsl:variable name="c2" select="number($bdec) * (1 - (number($sdec) * number($hdiff)))"/>
	<xsl:variable name="c3" select="number($bdec) * (1 - ((1 - number($hdiff)) * number($sdec)))"/>
	<xsl:choose>
		<xsl:when test="number($hsector)=0">
			<xsl:call-template name="RGBtoHex">
				<xsl:with-param name="R" select="round(number($bdec) * 255)"/>
				<xsl:with-param name="G" select="round(number($c3) * 255)"/>
				<xsl:with-param name="B" select="round(number($c1) * 255)"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="number($hsector)=1">
			<xsl:call-template name="RGBtoHex">
				<xsl:with-param name="R" select="round(number($c2) * 255)"/>
				<xsl:with-param name="G" select="round(number($bdec) * 255)"/>
				<xsl:with-param name="B" select="round(number($c1) * 255)"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="number($hsector)=2">
			<xsl:call-template name="RGBtoHex">
				<xsl:with-param name="R" select="round(number($c1) * 255)"/>
				<xsl:with-param name="G" select="round(number($bdec) * 255)"/>
				<xsl:with-param name="B" select="round(number($c3) * 255)"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="number($hsector)=3">
			<xsl:call-template name="RGBtoHex">
				<xsl:with-param name="R" select="round(number($c1) * 255)"/>
				<xsl:with-param name="G" select="round(number($c2) * 255)"/>
				<xsl:with-param name="B" select="round(number($bdec) * 255)"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="number($hsector)=4">
			<xsl:call-template name="RGBtoHex">
				<xsl:with-param name="R" select="round(number($c3) * 255)"/>
				<xsl:with-param name="G" select="round(number($c1) * 255)"/>
				<xsl:with-param name="B" select="round(number($bdec) * 255)"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="number($hsector)=5">
			<xsl:call-template name="RGBtoHex">
				<xsl:with-param name="R" select="round(number($bdec) * 255)"/>
				<xsl:with-param name="G" select="round(number($c1) * 255)"/>
				<xsl:with-param name="B" select="round(number($c2) * 255)"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="RGBtoHex">
				<xsl:with-param name="R" select="round(number($bdec) * 255)"/>
				<xsl:with-param name="G" select="round(number($c3) * 255)"/>
				<xsl:with-param name="B" select="round(number($c1) * 255)"/>
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>
<!--COLOR CONVERSION END-->
</xsl:stylesheet>
