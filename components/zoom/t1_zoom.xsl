<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:websoft="http://www.websoft.ru" version="1.0">
<!--
'*    Based on v_block_005.xsl
'*    Copyright (c) Websoft, 2010.  All rights reserved.
-->

<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>

<xsl:param name="objectID"></xsl:param>
<xsl:param name="imagesFolder"></xsl:param>
<xsl:param name="moduleImagesFolder"></xsl:param>
<xsl:param name="width"></xsl:param>
<xsl:param name="height"></xsl:param>

<xsl:template match="/"><xsl:apply-templates select="params"/></xsl:template>

<xsl:template match="params">

	<xsl:variable name="bg-color-custom-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="bg_color_custom"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="button-color-custom-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="button_color_custom"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="main.sButtonColor">
		<xsl:call-template name="define-color">
			<xsl:with-param name="sProfile" select="button_color_profile"/>
			<xsl:with-param name="sColorType">color1</xsl:with-param>
			<xsl:with-param name="sCustom" select="$button-color-custom-fixed"/>
			<xsl:with-param name="sCustomGradient" select="$button-color-custom-fixed"/>
			<xsl:with-param name="sCustomBorder" select="$button-color-custom-fixed"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sBGColor">
		<xsl:call-template name="define-color">
			<xsl:with-param name="sProfile" select="bg_color_profile"/>
			<xsl:with-param name="sColorType">color1</xsl:with-param>
			<xsl:with-param name="sCustom" select="$bg-color-custom-fixed"/>
			<xsl:with-param name="sCustomGradient" select="$bg-color-custom-fixed"/>
			<xsl:with-param name="sCustomBorder" select="$bg-color-custom-fixed"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="main.sShadowString">
		<xsl:if test="shadow_strength!='none'">
			<xsl:call-template name="shadow_builder">
				<xsl:with-param name="sType">block</xsl:with-param>
				<xsl:with-param name="sColor"></xsl:with-param>
				<xsl:with-param name="sStrength" select="shadow_strength"/>
				<xsl:with-param name="sOpacity"></xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:variable>
	<div class="style-custom" style="display: none">
		<div class="rule">
			<xsl:attribute name="data-name">#<xsl:value-of select="$objectID"/> .cl-container</xsl:attribute>
			<span class="rule-static">width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px;</span>
		</div>
		<div class="rule">
			<xsl:attribute name="data-name">#<xsl:value-of select="$objectID"/> .cl-box</xsl:attribute>
			<span class="rule-static">width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px; background-color: <xsl:value-of select="$main.sBGColor"/>;</span>
			<xsl:if test="number(radius)!=0">
				<span class="rule-dynamic">
					<xsl:attribute name="data-type">border-radius</xsl:attribute>
					<xsl:attribute name="data-value"><xsl:value-of select="radius"/>px</xsl:attribute>
				</span>
			</xsl:if>
			<xsl:if test="shadow_strength!='none'">
				<span class="rule-dynamic">
					<xsl:attribute name="data-type">box-shadow</xsl:attribute>
					<xsl:attribute name="data-value"><xsl:value-of select="$main.sShadowString"/></xsl:attribute>
				</span>
			</xsl:if>
		</div>
		<xsl:if test="imagefile=''">
			<div class="rule">
				<xsl:attribute name="data-name">#<xsl:value-of select="$objectID"/> .cl-noimg-table</xsl:attribute>
				<span class="rule-static">width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px;</span>
			</div>
			<div class="rule">
				<xsl:attribute name="data-name">#<xsl:value-of select="$objectID"/> .cl-noimg-table td</xsl:attribute>
				<span class="rule-static">width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px; color: <xsl:value-of select="$main.sButtonColor"/>;</span>
			</div>
		</xsl:if>
		<xsl:if test="imagefile!=''">
			<div class="rule">
				<xsl:attribute name="data-name">#<xsl:value-of select="$objectID"/> .cl-box img</xsl:attribute>
				<span class="rule-static">width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px;</span>
				<xsl:if test="number(radius)!=0">
					<span class="rule-dynamic">
						<xsl:attribute name="data-type">border-radius</xsl:attribute>
						<xsl:attribute name="data-value"><xsl:value-of select="radius"/>px</xsl:attribute>
					</span>
				</xsl:if>
			</div>
			<div class="rule">
				<xsl:attribute name="data-name">#<xsl:value-of select="$objectID"/> .cl-magnify-svg</xsl:attribute>
				<span class="rule-static">fill: <xsl:value-of select="$main.sButtonColor"/>;</span>
			</div>
			<div class="rule">
				<xsl:attribute name="data-name">#<xsl:value-of select="$objectID"/>_ZOOM</xsl:attribute>
				<span class="rule-static">position: absolute; left: -10000px; top: -10000px; background-color: <xsl:value-of select="$main.sBGColor"/>;</span>
				<xsl:if test="number(radius)!=0">
					<span class="rule-dynamic">
						<xsl:attribute name="data-type">border-radius</xsl:attribute>
						<xsl:attribute name="data-value"><xsl:value-of select="radius"/>px</xsl:attribute>
					</span>
				</xsl:if>
				<xsl:if test="$main.sShadowString!=''">
					<span class="rule-dynamic">
						<xsl:attribute name="data-type">box-shadow</xsl:attribute>
						<xsl:attribute name="data-value"><xsl:value-of select="$main.sShadowString"/></xsl:attribute>
					</span>
				</xsl:if>
			</div>
			<div class="rule">
				<xsl:attribute name="data-name">#<xsl:value-of select="$objectID"/>_ZOOM .cl-zoom-box</xsl:attribute>
				<span class="rule-static">position: relative; width: inherit; height: inherit; background-repeat: no-repeat; background-size: contain; background-position: center center;</span>
			</div>
			<div class="rule">
				<xsl:attribute name="data-name">#<xsl:value-of select="$objectID"/>_BTN_CLOSE</xsl:attribute>
				<span class="rule-static">cursor: pointer; position: absolute; right: 20px; top: 20px; width: 32px; height: 32px;</span>
			</div>
			<div class="rule">
				<xsl:attribute name="data-name">#<xsl:value-of select="$objectID"/>_BTN_CLOSE .cl-close-svg</xsl:attribute>
				<span class="rule-static">position: relative; width: 32px; height: 32px; fill: <xsl:value-of select="$main.sButtonColor"/>;</span>
			</div>
		</xsl:if>
	</div>
	<div>
		<xsl:attribute name="class">cl-container unselectable</xsl:attribute>
		<div>
			<xsl:attribute name="class">cl-box</xsl:attribute>
			<xsl:choose>
				<xsl:when test="imagefile!=''">
					<img>
						<xsl:attribute name="src"><xsl:value-of select="imagefile"/></xsl:attribute>
					</img>
						<div>
							<xsl:attribute name="class">cl-btn cl-btn-magnify</xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="tooltip_zoomin"/></xsl:attribute>
							<svg viewBox="0 0 512 512" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
								<xsl:attribute name="class">cl-magnify-svg</xsl:attribute>
								<g>
									<path d="M497.913,497.914c-18.782,18.781-49.226,18.781-68.008,0l-84.862-84.864c-34.89,22.366-76.131,35.718-120.66,35.718  C100.468,448.768,0,348.314,0,224.384C0,100.454,100.468,0,224.383,0c123.931,0,224.384,100.453,224.384,224.384  c0,44.529-13.353,85.771-35.718,120.675l84.863,84.849C516.695,448.689,516.695,479.131,497.913,497.914z M224.383,64.11  c-88.511,0-160.274,71.763-160.274,160.274c0,88.526,71.764,160.274,160.274,160.274c88.526,0,160.273-71.748,160.273-160.274  C384.656,135.873,312.909,64.11,224.383,64.11z M256.438,320.548h-64.108v-64.109H128.22V192.33h64.109v-64.11h64.108v64.11h64.11  v64.109h-64.11V320.548z"/>
								</g>
							</svg>
						</div>
				</xsl:when>
				<xsl:otherwise>
					<table>
						<xsl:attribute name="class">cl-noimg-table</xsl:attribute>
						<tr>
							<td>
								<xsl:value-of select="hidden_noimg"/>
							</td>
						</tr>
					</table>
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</div>

    <div>
        <xsl:attribute name="id"><xsl:value-of select="$objectID"/>_ZOOM</xsl:attribute>
		<xsl:attribute name="class">cl-zoom</xsl:attribute>
        <div>
            <xsl:attribute name="id"><xsl:value-of select="$objectID"/>_ZOOM_IMGDIV</xsl:attribute>
			<xsl:attribute name="class">cl-zoom-box <xsl:if test="hide_onclick='yes'">cl-close-on-img</xsl:if></xsl:attribute>
			<xsl:attribute name="style">background-image: url(<xsl:value-of select="imagefile"/>);</xsl:attribute>
				<xsl:if test="hide_onclick='yes'"><xsl:attribute name="title"><xsl:value-of select="tooltip_close"/></xsl:attribute></xsl:if>
        </div>
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_BTN_CLOSE</xsl:attribute>
            <xsl:attribute name="class">cl-btn cl-btn-close</xsl:attribute>
			<xsl:attribute name="title"><xsl:value-of select="tooltip_close"/></xsl:attribute>
			<svg viewBox="0 0 512 512" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
				<xsl:attribute name="class">cl-close-svg</xsl:attribute>
				<g>
					<path d="M74.966,437.013c-99.97-99.97-99.97-262.065,0-362.037c100.002-99.97,262.066-99.97,362.067,0  c99.971,99.971,99.971,262.067,0,362.037C337.032,536.998,174.968,536.998,74.966,437.013z M391.782,120.227  c-75.001-74.985-196.564-74.985-271.534,0c-75.001,74.985-75.001,196.55,0,271.535c74.97,74.986,196.533,74.986,271.534,0  C466.754,316.775,466.754,195.212,391.782,120.227z M188.124,369.137l-45.251-45.266l67.876-67.877l-67.876-67.876l45.251-45.267  L256,210.743l67.877-67.892l45.25,45.267l-67.876,67.876l67.876,67.877l-45.25,45.266L256,301.245L188.124,369.137z"/>
				</g>
			</svg>
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
