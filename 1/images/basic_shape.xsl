<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:websoft="http://www.websoft.ru" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.0">
<!--
'*	basic_shape.xsl
'*	CourseLab 3
'*	Copyright (c) Websoft Ltd., Russia.  All rights reserved.
-->
<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="objectID"/>
<xsl:param name="width"/>
<xsl:param name="height"/>
<xsl:param name="imagesFolder"/>
<xsl:param name="moduleImagesFolder"/>
<xsl:param name="currentState"/>

<msxsl:script language="JScript" implements-prefix="websoft">
function cos(angle) { return Math.cos(angle*Math.PI/180); }
function sin(angle) { return Math.sin(angle*Math.PI/180); }
function tan(angle) { return Math.tan(angle*Math.PI/180); }
function atan(value) { return Math.atan(value); }
function xcos(angle) { return Math.cos(angle); }
function xsin(angle) { return Math.sin(angle); }
function cotan(angle) { return Math.cos(angle*Math.PI/180)/Math.sin(angle*Math.PI/180); }
function radius(offset, height) { var nAngle = Math.atan(0.5*height/offset); var nCos = Math.cos(nAngle); return (0.5*offset/(nCos*nCos)); }
function catet(hyp, cat) { return Math.sqrt(hyp*hyp-cat*cat); }
function ellipse(a, b, x) { return b*Math.sqrt(1 - (x*x)/(a*a)); }
function ellipse_x(a, b, alpha) { var nAngle = 2*Math.PI*alpha/360; return (a*Math.cos( Math.atan( (a/b)*Math.tan(nAngle) ) )); }
function ellipse_y(a, b, alpha) { var nAngle = 2*Math.PI*alpha/360; return (b*Math.sin( Math.atan( (a/b)*Math.tan(nAngle) ) )); }
function ellipse_x_rad(a, b, alpha) { var nAngle = alpha; return (a*Math.cos( Math.atan( (a/b)*Math.tan(nAngle) ) )); }
function ellipse_y_rad(a, b, alpha) { var nAngle = alpha; return (b*Math.sin( Math.atan( (a/b)*Math.tan(nAngle) ) )); }
</msxsl:script>


<xsl:template match="/">
	<xsl:apply-templates select="params"/>
</xsl:template>

<xsl:template match="params">

	<div class="cl-audio-files-list" style="display: none">
		<xsl:if test="sound_click='custom'"><span><xsl:value-of select="sound_click_file_custom"/></span></xsl:if>
		<xsl:if test="sound_over='custom'"><span><xsl:value-of select="sound_over_file_custom"/></span></xsl:if>
	</div>

	<xsl:variable name="bDesign">no</xsl:variable>

	<xsl:variable name="bg-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="bg_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="border-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="border_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="gradient-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="gradient_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="glow-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="glow_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="font-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="font_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="text-shadow-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="text_shadow_color"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="main.halfborderwidth">
		<xsl:choose>
			<xsl:when test="number(border_width)!=0"><xsl:value-of select="0.5*number(border_width)"/></xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="main.width" select="1.2*number($width)"/>
	<xsl:variable name="main.height" select="1.2*number($height)"/>
	<xsl:variable name="main.x0" select="0.1*number($width)"/>
	<xsl:variable name="main.y0" select="0.1*number($height)"/>

	<xsl:variable name="_btn_font">
		<xsl:choose>
			<xsl:when test="font!='custom'"><xsl:call-template name="font_selector"><xsl:with-param name="sFontID" select="font"/></xsl:call-template></xsl:when>
			<xsl:otherwise><xsl:value-of select="font_custom"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="_text_shadow">
		<xsl:if test="text_shadow_strength!='none'">
			<xsl:call-template name="shadow_builder">
				<xsl:with-param name="sType">text</xsl:with-param>
				<xsl:with-param name="sColor" select="$text-shadow-color-fixed"/>
				<xsl:with-param name="sStrength" select="text_shadow_strength"/>
				<xsl:with-param name="sOpacity"></xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:variable>
	<xsl:variable name="_css_font_style">
		<xsl:choose>
			<xsl:when test="font_style='bold'">font-weight: bold;</xsl:when>
			<xsl:when test="font_style='italic'">font-style: italic;</xsl:when>
			<xsl:when test="font_style='bolditalic'">font-weight: bold; font-style: italic;</xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="_css_font">font-family: <xsl:value-of select="$_btn_font"/>; font-size: <xsl:value-of select="font_size"/>px; color: <xsl:value-of select="$font-color-fixed"/>; <xsl:if test="$_text_shadow!=''">text-shadow: <xsl:value-of select="$_text_shadow"/>;</xsl:if><xsl:value-of select="$_css_font_style"/></xsl:variable>
	<xsl:variable name="txt.align">
		<xsl:choose>
			<xsl:when test="text_position='LT' or text_position='LM' or text_position='LB'">left</xsl:when>
			<xsl:when test="text_position='RT' or text_position='RM' or text_position='RB'">right</xsl:when>
			<xsl:otherwise>center</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="txt.valign">
		<xsl:choose>
			<xsl:when test="text_position='LT' or text_position='CT' or text_position='RT'">top</xsl:when>
			<xsl:when test="text_position='LB' or text_position='CB' or text_position='RB'">bottom</xsl:when>
			<xsl:otherwise>middle</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="onimg.position">
		<xsl:choose>
			<xsl:when test="on_btn_img_position='LT'">left top</xsl:when>
			<xsl:when test="on_btn_img_position='CT'">center top</xsl:when>
			<xsl:when test="on_btn_img_position='RT'">right top</xsl:when>
			<xsl:when test="on_btn_img_position='LM'">left center</xsl:when>
			<xsl:when test="on_btn_img_position='CM'">center center</xsl:when>
			<xsl:when test="on_btn_img_position='RM'">right center</xsl:when>
			<xsl:when test="on_btn_img_position='LB'">left bottom</xsl:when>
			<xsl:when test="on_btn_img_position='CB'">center bottom</xsl:when>
			<xsl:when test="on_btn_img_position='RB'">right bottom</xsl:when>
			<xsl:when test="on_btn_img_position='custom'"><xsl:value-of select="on_btn_img_position_custom"/></xsl:when>
			<xsl:otherwise>center center</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="_css_onimg_bg">
		<xsl:choose>
			<xsl:when test="content='image' or content='textimage'">background-image: url('<xsl:if test="$bDesign='yes'">file:///<xsl:value-of select="translate(substring-before($moduleImagesFolder,'images\'),'\','/')"/></xsl:if><xsl:value-of select="on_btn_img"/>'); background-repeat: no-repeat; background-position: <xsl:value-of select="$onimg.position"/>;</xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="pre.offset">
		<xsl:choose>
			<xsl:when test="number($width)=0 or number($height)=0">0</xsl:when>
			<xsl:when test="number(offset) &lt; 1">1</xsl:when>
			<xsl:when test="number(offset) &gt; 49">49</xsl:when>
			<xsl:otherwise><xsl:value-of select="number(offset)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="chevron.offset">
		<xsl:choose>
			<xsl:when test="number($width)=0 or number($height)=0">0</xsl:when>
			<xsl:when test="chevron_type='full_E' or chevron_type='full_W' or chevron_type='half_E' or chevron_type='half_W'"><xsl:value-of select="0.01*number($pre.offset)*number($width)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="0.01*number($pre.offset)*number($height)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.offset">
		<xsl:choose>
			<xsl:when test="number($width)=0 or number($height)=0">0</xsl:when>
			<xsl:when test="shape='capsule'"><xsl:value-of select="0.005*number(offset)*number($width)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="0.01*number(offset)*number($height)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="pre.corner.radius">
		<xsl:choose>
			<xsl:when test="number(corner_radius) &lt; 0">0</xsl:when>
			<xsl:when test="number(corner_radius) &gt; 40">40</xsl:when>
			<xsl:otherwise><xsl:value-of select="corner_radius"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="rrect.radius">
		<xsl:choose>
			<xsl:when test="number($width)=0 or number($height)=0">0</xsl:when>
			<xsl:when test="number($width) &gt; number($height)"><xsl:value-of select="0.01*number($pre.corner.radius)*number($height)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="0.01*number($pre.corner.radius)*number($width)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="pre.arrow.width">
		<xsl:choose>
			<xsl:when test="number(arrow_width) &lt; 1">1</xsl:when>
			<xsl:when test="number(arrow_width) &gt; 49">49</xsl:when>
			<xsl:otherwise><xsl:value-of select="arrow_width"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.arrow_width">
		<xsl:choose>
			<xsl:when test="number($width)=0 or number($height)=0">10</xsl:when>
			<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr' or arrow='bl' or arrow='bc' or arrow='br'"><xsl:value-of select="0.005*number($pre.arrow.width)*number($width)"/></xsl:when>
			<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb' or arrow='rt' or arrow='rm' or arrow='rb'"><xsl:value-of select="0.005*number($pre.arrow.width)*number($height)"/></xsl:when>
			<xsl:otherwise>10</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="pre.arrow.length">
		<xsl:choose>
			<xsl:when test="number(arrow_length) &lt; 1">1</xsl:when>
			<xsl:when test="number(arrow_length) &gt; 49">49</xsl:when>
			<xsl:otherwise><xsl:value-of select="arrow_length"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.arrow_length">
		<xsl:choose>
			<xsl:when test="number($width)=0 or number($height)=0">10</xsl:when>
			<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr' or arrow='bl' or arrow='bc' or arrow='br'"><xsl:value-of select="0.01*number($pre.arrow.length)*number($height)"/></xsl:when>
			<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb' or arrow='rt' or arrow='rm' or arrow='rb'"><xsl:value-of select="0.01*number($pre.arrow.length)*number($width)"/></xsl:when>
			<xsl:otherwise>10</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="pre.arrow.offset">
		<xsl:choose>
			<xsl:when test="number(arrow_offset) &lt; 0">0</xsl:when>
			<xsl:when test="number(arrow_offset) &gt; 49">49</xsl:when>
			<xsl:otherwise><xsl:value-of select="arrow_offset"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.arrowoffset">
		<xsl:choose>
			<xsl:when test="shape='rect' and corners='plain'">
				<xsl:choose>
					<xsl:when test="number($width)=0 or number($height)=0">0</xsl:when>
					<xsl:when test="arrow='tl' or arrow='tr' or arrow='bl' or arrow='br'"><xsl:value-of select="0.005*number($pre.arrow.offset)*number($width)"/></xsl:when>
					<xsl:when test="arrow='lt' or arrow='lb' or arrow='rt' or arrow='rb'"><xsl:value-of select="0.005*number($pre.arrow.offset)*number($height)"/></xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="shape='rect' and corners!='plain'">
				<xsl:choose>
					<xsl:when test="number($width)=0 or number($height)=0">0</xsl:when>
					<xsl:when test="arrow='tl' or arrow='tr' or arrow='bl' or arrow='br'"><xsl:value-of select="number($rrect.radius) + 0.005*number($pre.arrow.offset)*(number($width) - 2*number($rrect.radius))"/></xsl:when>
					<xsl:when test="arrow='lt' or arrow='lb' or arrow='rt' or arrow='rb'"><xsl:value-of select="number($rrect.radius) + 0.005*number($pre.arrow.offset)*(number($height) - 2*number($rrect.radius))"/></xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				0
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>


	<xsl:variable name="pre.capsule.offset">
		<xsl:choose>
			<xsl:when test="capsule_type='h'"><xsl:value-of select="0.005*number($pre.offset)*number($width)"/></xsl:when>
			<xsl:when test="capsule_type='v'"><xsl:value-of select="0.005*number($pre.offset)*number($height)"/></xsl:when>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.capsule_radius">
		<xsl:choose>
			<xsl:when test="capsule_type='h' and (arrow='tl' or arrow='tc' or arrow='tr' or arrow='bl' or arrow='bc' or arrow='br')"><xsl:value-of select="websoft:radius((number($pre.capsule.offset)),(number($height) - number($main.arrow_length) - number(border_width)))"/></xsl:when>
			<xsl:when test="capsule_type='h' and (arrow='lt' or arrow='lm' or arrow='lb' or arrow='rt' or arrow='rm' or arrow='rb')"><xsl:value-of select="websoft:radius((number($pre.capsule.offset)),(number($height) - number(border_width)))"/></xsl:when>
			<xsl:when test="capsule_type='v' and (arrow='tl' or arrow='tc' or arrow='tr' or arrow='bl' or arrow='bc' or arrow='br')"><xsl:value-of select="websoft:radius((number($pre.capsule.offset)),(number($width) - number(border_width)))"/></xsl:when>
			<xsl:when test="capsule_type='v' and (arrow='lt' or arrow='lm' or arrow='lb' or arrow='rt' or arrow='rm' or arrow='rb')"><xsl:value-of select="websoft:radius((number($pre.capsule.offset)),(number($width) - number($main.arrow_length) - number(border_width)))"/></xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="capsule_type='h'"><xsl:value-of select="websoft:radius((number($pre.capsule.offset)),(number($height)-number(border_width)))"/></xsl:when>
					<xsl:when test="capsule_type='v'"><xsl:value-of select="websoft:radius((number($pre.capsule.offset)),(number($width)-number(border_width)))"/></xsl:when>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.capsule.offset">
		<xsl:choose>
			<xsl:when test="number($pre.capsule.offset) &gt; number($main.capsule_radius)"><xsl:value-of select="$main.capsule_radius"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$pre.capsule.offset"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="main.ellipse.a">
		<xsl:choose>
			<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb' or arrow='rt' or arrow='rm' or arrow='rb'"><xsl:value-of select="0.5*(number($width) - number($main.arrow_length))"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="0.5*number($width)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.ellipse.b">
		<xsl:choose>
			<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr' or arrow='bl' or arrow='bc' or arrow='br'"><xsl:value-of select="0.5*(number($height) - number($main.arrow_length))"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="0.5*number($height)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.ellipse.x1" select="0.05*number($width)"/>
	<xsl:variable name="main.ellipse.x2" select="number($main.ellipse.x1) + number($main.arrow_width)"/>
	<xsl:variable name="main.ellipse.pre_y1" select="websoft:ellipse(number($main.ellipse.a), number($main.ellipse.b), (number($main.ellipse.a)-number($main.ellipse.x1)) )"/>
	<xsl:variable name="main.ellipse.pre_y2" select="websoft:ellipse(number($main.ellipse.a), number($main.ellipse.b), (number($main.ellipse.a)-number($main.ellipse.x2)))"/>
	<xsl:variable name="main.ellipse.pre_y3" select="websoft:ellipse(number($main.ellipse.a), number($main.ellipse.b), 0.5*number($main.arrow_width))"/>
	<xsl:variable name="main.ellipse.pre_x3" select="websoft:ellipse(number($main.ellipse.b), number($main.ellipse.a), 0.5*number($main.arrow_width))"/>
	<xsl:variable name="main.ellipse.y1" select="number($main.ellipse.b) - number($main.ellipse.pre_y1)"/>
	<xsl:variable name="main.ellipse.y2" select="number($main.ellipse.b) - number($main.ellipse.pre_y2)"/>
	<xsl:variable name="main.ellipse.y3" select="number($main.ellipse.b) - number($main.ellipse.pre_y3)"/>
	<xsl:variable name="main.ellipse.x3" select="number($main.ellipse.a) - number($main.ellipse.pre_x3)"/>

	<xsl:variable name="main.ellipse.inner.a" select="0.01*(100-number($pre.offset))*number($main.ellipse.a)"/>
	<xsl:variable name="main.ellipse.inner.b" select="0.01*(100-number($pre.offset))*number($main.ellipse.b)"/>

	<xsl:variable name="main.sweepflag">
		<xsl:choose>
			<xsl:when test="corners='rounded'">1</xsl:when>
			<xsl:when test="corners='clipped'">0</xsl:when>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.radial.cx">
		<xsl:choose>
			<xsl:when test="shape='rect' or shape='multi_star' or shape='capsule' or shape='ellipse' or shape='cloud'">
				<xsl:choose>
					<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="100*((number($main.x0) + 0.5*(number($width) + number($main.arrow_length))) div number($main.width))"/></xsl:when>
					<xsl:when test="arrow='rt' or arrow='rm' or arrow='rb'"><xsl:value-of select="100*((number($main.x0) + 0.5*(number($width) - number($main.arrow_length))) div number($main.width))"/></xsl:when>
					<xsl:otherwise>50</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="shape='chevron'">
				<xsl:choose>
					<xsl:when test="chevron_type='full_E'"><xsl:value-of select="100*((number($main.x0) + 0.5*(number($width) + number($chevron.offset))) div number($main.width))"/></xsl:when>
					<xsl:when test="chevron_type='full_W'"><xsl:value-of select="100*((number($main.x0) + 0.5*(number($width) - number($chevron.offset))) div number($main.width))"/></xsl:when>
					<xsl:when test="chevron_type='half_E'"><xsl:value-of select="100*((number($main.x0) + 0.5*(number($width) - 0.5*number($chevron.offset))) div number($main.width))"/></xsl:when>
					<xsl:when test="chevron_type='half_W'"><xsl:value-of select="100*((number($main.x0) + 0.5*(number($width) + 0.5*number($chevron.offset))) div number($main.width))"/></xsl:when>
					<xsl:otherwise>50</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="shape='triangle'">
				<xsl:choose>
					<xsl:when test="triangle_type='rect_NE' or triangle_type='rect_SE'"><xsl:value-of select="100*((number($main.x0) + 0.75*(number($width))) div number($main.width))"/></xsl:when>
					<xsl:when test="triangle_type='rect_NW' or triangle_type='rect_SW'"><xsl:value-of select="100*((number($main.x0) + 0.25*(number($width))) div number($main.width))"/></xsl:when>
					<xsl:otherwise>50</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>50</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.radial.cy">
		<xsl:choose>
			<xsl:when test="shape='rect' or shape='multi_star' or shape='capsule' or shape='ellipse' or shape='cloud'">
				<xsl:choose>
					<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="100*((number($main.y0) + 0.5*(number($height) + number($main.arrow_length))) div number($main.height))"/></xsl:when>
					<xsl:when test="arrow='bl' or arrow='bc' or arrow='br'"><xsl:value-of select="100*((number($main.y0) + 0.5*(number($height) - number($main.arrow_length))) div number($main.height))"/></xsl:when>
					<xsl:otherwise>50</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="shape='chevron'">
				<xsl:choose>
					<xsl:when test="chevron_type='full_N'"><xsl:value-of select="100*((number($main.y0) + 0.5*(number($height) - number($chevron.offset))) div number($main.height))"/></xsl:when>
					<xsl:when test="chevron_type='full_S'"><xsl:value-of select="100*((number($main.y0) + 0.5*(number($height) + number($chevron.offset))) div number($main.height))"/></xsl:when>
					<xsl:when test="chevron_type='half_N'"><xsl:value-of select="100*((number($main.y0) + 0.5*(number($height) + 0.5*number($chevron.offset))) div number($main.height))"/></xsl:when>
					<xsl:when test="chevron_type='half_S'"><xsl:value-of select="100*((number($main.y0) + 0.5*(number($height) - 0.5*number($chevron.offset))) div number($main.height))"/></xsl:when>
					<xsl:otherwise>50</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="shape='triangle'">
				<xsl:choose>
					<xsl:when test="triangle_type='rect_NE' or triangle_type='rect_NW'"><xsl:value-of select="100*((number($main.y0) + 0.25*(number($height))) div number($main.height))"/></xsl:when>
					<xsl:when test="triangle_type='rect_SE' or triangle_type='rect_SW'"><xsl:value-of select="100*((number($main.y0) + 0.75*(number($height))) div number($main.height))"/></xsl:when>
					<xsl:otherwise>50</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>50</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="main.ellipse.diag" select="websoft:atan( number($main.ellipse.b) div number($main.ellipse.a) )"/>
	<xsl:variable name="main.ellipse.diag.x" select="websoft:ellipse_x_rad( number($main.ellipse.a), number($main.ellipse.b), number($main.ellipse.diag))"/>
	<xsl:variable name="main.ellipse.diag.y" select="websoft:ellipse_y_rad( number($main.ellipse.a), number($main.ellipse.b), number($main.ellipse.diag))"/>
	<xsl:variable name="main.ellipse.inner.diag" select="websoft:atan( number($main.ellipse.inner.b) div number($main.ellipse.inner.a) )"/>
	<xsl:variable name="main.ellipse.inner.diag.x" select="websoft:ellipse_x_rad( number($main.ellipse.inner.a), number($main.ellipse.inner.b), number($main.ellipse.inner.diag))"/>
	<xsl:variable name="main.ellipse.inner.diag.y" select="websoft:ellipse_y_rad( number($main.ellipse.inner.a), number($main.ellipse.b), number($main.ellipse.inner.diag))"/>
	<xsl:variable name="cloud.x0">
		<xsl:choose>
			<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="cloud.y0">
		<xsl:choose>
			<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="cloud.width">
		<xsl:choose>
			<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb' or arrow='rt' or arrow='rm' or arrow='rb'"><xsl:value-of select="number($width) - number($main.arrow_length) - 2*number($main.halfborderwidth)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="number($width) - 2*number($main.halfborderwidth)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="cloud.height">
		<xsl:choose>
			<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr' or arrow='bl' or arrow='bc' or arrow='br'"><xsl:value-of select="number($height) - number($main.arrow_length) - 2*number($main.halfborderwidth)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="number($height) - 2*number($main.halfborderwidth)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="main.text.x1">
		<xsl:choose>
			<xsl:when test="content_bounds='container'"><xsl:value-of select="$main.x0"/></xsl:when>
			<xsl:when test="content_bounds='bounds'">
				<xsl:choose>
					<xsl:when test="shape='rect'">
						<xsl:choose>
							<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'">
								<xsl:choose>
									<xsl:when test="corners='plain'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth) + number($main.arrow_length)"/></xsl:when>
									<xsl:when test="corners='rounded'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth) + 0.293*number($rrect.radius) + number($main.arrow_length)"/></xsl:when>
									<xsl:when test="corners='clipped'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth) + 0.707*number($rrect.radius) + number($main.arrow_length)"/></xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="corners='plain'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="corners='rounded'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth) + 0.293*number($rrect.radius)"/></xsl:when>
									<xsl:when test="corners='clipped'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth) + 0.707*number($rrect.radius)"/></xsl:when>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="shape='chevron'">
						<xsl:choose>
							<xsl:when test="chevron_type='full_E'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth) + number($chevron.offset)"/></xsl:when>
							<xsl:when test="chevron_type='full_W'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth) + number($chevron.offset)"/></xsl:when>
							<xsl:when test="chevron_type='full_N'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="chevron_type='full_S'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="chevron_type='half_E'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="chevron_type='half_W'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth) + number($chevron.offset)"/></xsl:when>
							<xsl:when test="chevron_type='half_N'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="chevron_type='half_S'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth)"/></xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="shape='triangle'">
						<xsl:choose>
							<xsl:when test="triangle_type='iso_E'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="triangle_type='iso_W'"><xsl:value-of select="number($main.x0) + 0.34*number($width) - number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="triangle_type='iso_N'"><xsl:value-of select="number($main.x0) + 0.25*number($width)"/></xsl:when>
							<xsl:when test="triangle_type='iso_S'"><xsl:value-of select="number($main.x0) + 0.25*number($width)"/></xsl:when>
							<xsl:when test="triangle_type='rect_NE'"><xsl:value-of select="number($main.x0) + 0.34*number($width)"/></xsl:when>
							<xsl:when test="triangle_type='rect_NW'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="triangle_type='rect_SE'"><xsl:value-of select="number($main.x0) + 0.34*number($width)"/></xsl:when>
							<xsl:when test="triangle_type='rect_SW'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth)"/></xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="shape='capsule'">
						<xsl:choose>
							<xsl:when test="capsule_type='h'">
								<xsl:choose>
									<xsl:when test="arrow='none' or arrow='no'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='tl'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='tc'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='tr'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='bl'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='bc'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='br'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='rt'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='rm'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='rb'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='lt'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.arrow_length) + number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='lm'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.arrow_length) + number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.arrow_length) + number($main.capsule.offset)"/></xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="capsule_type='v'">
								<xsl:choose>
									<xsl:when test="arrow='none' or arrow='no'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='tl'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='tc'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='tr'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='bl'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='bc'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='br'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='rt'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='rm'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='rb'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='lt'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth) + number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='lm'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth) + number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='lb'"><xsl:value-of select="number($main.x0) + 2*number($main.halfborderwidth) + number($main.arrow_length)"/></xsl:when>
								</xsl:choose>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="shape='polygon'">
						<xsl:choose>
							<xsl:when test="polygon_type='4'"><xsl:value-of select="number($main.x0) + 0.25*number($width)"/></xsl:when>
							<xsl:when test="polygon_type='5'"><xsl:value-of select="number($main.x0) + 0.14*number($width)"/></xsl:when>
							<xsl:when test="polygon_type='6'"><xsl:value-of select="number($main.x0) + 0.14*number($width)"/></xsl:when>
							<xsl:when test="polygon_type='8'"><xsl:value-of select="number($main.x0) + 0.125*number($width)"/></xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="shape='ellipse'">
						<xsl:choose>
							<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.ellipse.a) - number($main.ellipse.diag.x)"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($main.ellipse.diag.x)"/></xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="shape='cloud'"><xsl:value-of select="number($cloud.x0) + 0.1*number($cloud.width)"/></xsl:when>
					<xsl:when test="shape='multi_star'">
						<xsl:choose>
							<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.ellipse.a) - number($main.ellipse.inner.diag.x)"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($main.ellipse.inner.diag.x)"/></xsl:otherwise>
						</xsl:choose>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.text.y1">
		<xsl:choose>
			<xsl:when test="content_bounds='container'"><xsl:value-of select="$main.y0"/></xsl:when>
			<xsl:when test="content_bounds='bounds'">
				<xsl:choose>
					<xsl:when test="shape='rect'">
						<xsl:choose>
							<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'">
								<xsl:choose>
									<xsl:when test="corners='plain'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth) + number($main.arrow_length)"/></xsl:when>
									<xsl:when test="corners='rounded'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth) + 0.293*number($rrect.radius) + number($main.arrow_length)"/></xsl:when>
									<xsl:when test="corners='clipped'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth) + 0.707*number($rrect.radius) + number($main.arrow_length)"/></xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="corners='plain'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="corners='rounded'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth) + 0.293*number($rrect.radius)"/></xsl:when>
									<xsl:when test="corners='clipped'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth) + 0.707*number($rrect.radius)"/></xsl:when>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="shape='chevron'">
						<xsl:choose>
							<xsl:when test="chevron_type='full_E'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="chevron_type='full_W'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="chevron_type='full_N'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth) + number($chevron.offset)"/></xsl:when>
							<xsl:when test="chevron_type='full_S'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth) + number($chevron.offset)"/></xsl:when>
							<xsl:when test="chevron_type='half_E'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="chevron_type='half_W'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="chevron_type='half_N'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth) + number($chevron.offset)"/></xsl:when>
							<xsl:when test="chevron_type='half_S'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth)"/></xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="shape='triangle'">
						<xsl:choose>
							<xsl:when test="triangle_type='iso_E'"><xsl:value-of select="number($main.y0) + 0.33*number($height)"/></xsl:when>
							<xsl:when test="triangle_type='iso_W'"><xsl:value-of select="number($main.y0) + 0.33*number($height)"/></xsl:when>
							<xsl:when test="triangle_type='iso_N'"><xsl:value-of select="number($main.y0) + 0.5*number($height) - number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="triangle_type='iso_S'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="triangle_type='rect_NE'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="triangle_type='rect_NW'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="triangle_type='rect_SE'"><xsl:value-of select="number($main.y0) + 0.66*number($height) - number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="triangle_type='rect_SW'"><xsl:value-of select="number($main.y0) + 0.66*number($height) - number($main.halfborderwidth)"/></xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="shape='capsule'">
						<xsl:choose>
							<xsl:when test="capsule_type='h'">
								<xsl:choose>
									<xsl:when test="arrow='none' or arrow='no'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='tl'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth) + number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='tc'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth) + number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='tr'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth) + number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='bl'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='bc'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='br'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='rt'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='rm'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='rb'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='lt'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='lm'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='lb'"><xsl:value-of select="number($main.y0) + 2*number($main.halfborderwidth)"/></xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="capsule_type='v'">
								<xsl:choose>
									<xsl:when test="arrow='none' or arrow='no'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth) + number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='tl'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth) + number($main.capsule.offset) + number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth) + number($main.capsule.offset) + number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth) + number($main.capsule.offset) + number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='bl'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth) + number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='bc'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth) + number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='br'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth) + number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='rt'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth) + number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='rm'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth) + number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='rb'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth) + number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='lt'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth) + number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='lm'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth) + number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='lb'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth) + number($main.capsule.offset)"/></xsl:when>
								</xsl:choose>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="shape='polygon'">
						<xsl:choose>
							<xsl:when test="polygon_type='4'"><xsl:value-of select="number($main.x0) + 0.25*number($height)"/></xsl:when>
							<xsl:when test="polygon_type='5'"><xsl:value-of select="number($main.y0) + 0.305*number($height)"/></xsl:when>
							<xsl:when test="polygon_type='6'"><xsl:value-of select="number($main.x0) + 0.25*number($width)"/></xsl:when>
							<xsl:when test="polygon_type='8'"><xsl:value-of select="number($main.x0) + 0.125*number($width)"/></xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="shape='ellipse'">
						<xsl:choose>
							<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.ellipse.b) - number($main.ellipse.diag.y)"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($main.ellipse.diag.y)"/></xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="shape='cloud'"><xsl:value-of select="number($cloud.y0) + 0.19*number($cloud.height)"/></xsl:when>
					<xsl:when test="shape='multi_star'">
						<xsl:choose>
							<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.ellipse.b) - number($main.ellipse.inner.diag.y)"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($main.ellipse.inner.diag.y)"/></xsl:otherwise>
						</xsl:choose>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.text.w">
		<xsl:choose>
			<xsl:when test="content_bounds='container'"><xsl:value-of select="$width"/></xsl:when>
			<xsl:when test="content_bounds='bounds'">
				<xsl:choose>
					<xsl:when test="shape='rect'">
						<xsl:choose>
							<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb' or arrow='rt' or arrow='rm' or arrow='rb'">
								<xsl:choose>
									<xsl:when test="corners='plain'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="corners='rounded'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth) - 0.586*number($rrect.radius) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="corners='clipped'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth) - 1.414*number($rrect.radius) - number($main.arrow_length)"/></xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="corners='plain'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="corners='rounded'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth) - 0.586*number($rrect.radius)"/></xsl:when>
									<xsl:when test="corners='clipped'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth) - 1.414*number($rrect.radius)"/></xsl:when>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="shape='chevron'">
						<xsl:choose>
							<xsl:when test="chevron_type='full_E'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth) - 2*number($chevron.offset)"/></xsl:when>
							<xsl:when test="chevron_type='full_W'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth) - 2*number($chevron.offset)"/></xsl:when>
							<xsl:when test="chevron_type='full_N'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="chevron_type='full_S'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="chevron_type='half_E'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth) - number($chevron.offset)"/></xsl:when>
							<xsl:when test="chevron_type='half_W'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth) - number($chevron.offset)"/></xsl:when>
							<xsl:when test="chevron_type='half_N'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="chevron_type='half_S'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth)"/></xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="shape='triangle'">
						<xsl:choose>
							<xsl:when test="triangle_type='iso_E'"><xsl:value-of select="0.66*number($width) - number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="triangle_type='iso_W'"><xsl:value-of select="0.66*number($width) - number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="triangle_type='iso_N'"><xsl:value-of select="0.5*number($width)"/></xsl:when>
							<xsl:when test="triangle_type='iso_S'"><xsl:value-of select="0.5*number($width)"/></xsl:when>
							<xsl:when test="triangle_type='rect_NE'"><xsl:value-of select="0.66*number($width) - 2*number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="triangle_type='rect_NW'"><xsl:value-of select="0.66*number($width) - 2*number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="triangle_type='rect_SE'"><xsl:value-of select="0.66*number($width) - 2*number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="triangle_type='rect_SW'"><xsl:value-of select="0.66*number($width) - 2*number($main.halfborderwidth)"/></xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="shape='capsule'">
						<xsl:choose>
							<xsl:when test="capsule_type='h'">
								<xsl:choose>
									<xsl:when test="arrow='none' or arrow='no'"><xsl:value-of select="number($width) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='tl'"><xsl:value-of select="number($width) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='tc'"><xsl:value-of select="number($width) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='tr'"><xsl:value-of select="number($width) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='bl'"><xsl:value-of select="number($width) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='bc'"><xsl:value-of select="number($width) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='br'"><xsl:value-of select="number($width) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='rt'"><xsl:value-of select="number($width) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='rm'"><xsl:value-of select="number($width) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='rb'"><xsl:value-of select="number($width) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='lt'"><xsl:value-of select="number($width) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='lm'"><xsl:value-of select="number($width) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='lb'"><xsl:value-of select="number($width) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset) - number($main.arrow_length)"/></xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="capsule_type='v'">
								<xsl:choose>
									<xsl:when test="arrow='none' or arrow='no'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='tl'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='tc'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='tr'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='bl'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='bc'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='br'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='rt'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='rm'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='rb'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='lt'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='lm'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='lb'"><xsl:value-of select="number($width) - 4*number($main.halfborderwidth) - number($main.arrow_length)"/></xsl:when>
								</xsl:choose>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="shape='polygon'">
						<xsl:choose>
							<xsl:when test="polygon_type='4'"><xsl:value-of select="0.5*number($width)"/></xsl:when>
							<xsl:when test="polygon_type='5'"><xsl:value-of select="0.72*number($width)"/></xsl:when>
							<xsl:when test="polygon_type='6'"><xsl:value-of select="0.72*number($width)"/></xsl:when>
							<xsl:when test="polygon_type='8'"><xsl:value-of select="0.75*number($width)"/></xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="shape='ellipse'"><xsl:value-of select="2*number($main.ellipse.diag.x)"/></xsl:when>
					<xsl:when test="shape='cloud'"><xsl:value-of select="0.74*number($cloud.width)"/></xsl:when>
					<xsl:when test="shape='multi_star'"><xsl:value-of select="2*number($main.ellipse.inner.diag.x)"/></xsl:when>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.text.h">
		<xsl:choose>
			<xsl:when test="content_bounds='container'"><xsl:value-of select="$height"/></xsl:when>
			<xsl:when test="content_bounds='bounds'">
				<xsl:choose>
					<xsl:when test="shape='rect'">
						<xsl:choose>
							<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr' or arrow='bl' or arrow='bc' or arrow='br'">
								<xsl:choose>
									<xsl:when test="corners='plain'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="corners='rounded'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth) - 0.586*number($rrect.radius) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="corners='clipped'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth) - 1.414*number($rrect.radius) - number($main.arrow_length)"/></xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="corners='plain'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="corners='rounded'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth) - 0.586*number($rrect.radius)"/></xsl:when>
									<xsl:when test="corners='clipped'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth) - 1.414*number($rrect.radius)"/></xsl:when>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="shape='chevron'">
						<xsl:choose>
							<xsl:when test="chevron_type='full_E'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="chevron_type='full_W'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="chevron_type='full_N'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth) - 2*number($chevron.offset)"/></xsl:when>
							<xsl:when test="chevron_type='full_S'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth) - 2*number($chevron.offset)"/></xsl:when>
							<xsl:when test="chevron_type='half_E'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="chevron_type='half_W'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="chevron_type='half_N'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth) - number($chevron.offset)"/></xsl:when>
							<xsl:when test="chevron_type='half_S'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth) - number($chevron.offset)"/></xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="shape='triangle'">
						<xsl:choose>
							<xsl:when test="triangle_type='iso_E'"><xsl:value-of select="0.34*number($height)"/></xsl:when>
							<xsl:when test="triangle_type='iso_W'"><xsl:value-of select="0.34*number($height)"/></xsl:when>
							<xsl:when test="triangle_type='iso_N'"><xsl:value-of select="0.5*number($height) - number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="triangle_type='iso_S'"><xsl:value-of select="0.5*number($height) - number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="triangle_type='rect_NE'"><xsl:value-of select="0.34*number($height) - number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="triangle_type='rect_NW'"><xsl:value-of select="0.34*number($height) - number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="triangle_type='rect_SE'"><xsl:value-of select="0.34*number($height) - number($main.halfborderwidth)"/></xsl:when>
							<xsl:when test="triangle_type='rect_SW'"><xsl:value-of select="0.34*number($height) - number($main.halfborderwidth)"/></xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="shape='capsule'">
						<xsl:choose>
							<xsl:when test="capsule_type='h'">
								<xsl:choose>
									<xsl:when test="arrow='none' or arrow='no'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='tl'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='tc'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='tr'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='bl'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='bc'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='br'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='rt'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='rm'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='rb'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='lt'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='lm'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth)"/></xsl:when>
									<xsl:when test="arrow='lb'"><xsl:value-of select="number($height) - 4*number($main.halfborderwidth)"/></xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="capsule_type='v'">
								<xsl:choose>
									<xsl:when test="arrow='none' or arrow='no'"><xsl:value-of select="number($height) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='tl'"><xsl:value-of select="number($height) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='tc'"><xsl:value-of select="number($height) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='tr'"><xsl:value-of select="number($height) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='bl'"><xsl:value-of select="number($height) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='bc'"><xsl:value-of select="number($height) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='br'"><xsl:value-of select="number($height) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset) - number($main.arrow_length)"/></xsl:when>
									<xsl:when test="arrow='rt'"><xsl:value-of select="number($height) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='rm'"><xsl:value-of select="number($height) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='rb'"><xsl:value-of select="number($height) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='lt'"><xsl:value-of select="number($height) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='lm'"><xsl:value-of select="number($height) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset)"/></xsl:when>
									<xsl:when test="arrow='lb'"><xsl:value-of select="number($height) - 2*number($main.halfborderwidth) - 2*number($main.capsule.offset)"/></xsl:when>
								</xsl:choose>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="shape='polygon'">
						<xsl:choose>
							<xsl:when test="polygon_type='4'"><xsl:value-of select="0.5*number($height)"/></xsl:when>
							<xsl:when test="polygon_type='5'"><xsl:value-of select="0.5*number($height)"/></xsl:when>
							<xsl:when test="polygon_type='6'"><xsl:value-of select="0.5*number($height)"/></xsl:when>
							<xsl:when test="polygon_type='8'"><xsl:value-of select="0.75*number($height)"/></xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="shape='ellipse'"><xsl:value-of select="2*number($main.ellipse.diag.y)"/></xsl:when>
					<xsl:when test="shape='cloud'"><xsl:value-of select="0.64*number($cloud.height)"/></xsl:when>
					<xsl:when test="shape='multi_star'"><xsl:value-of select="2*number($main.ellipse.inner.diag.y)"/></xsl:when>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="main.path">
		<xsl:choose>
			<xsl:when test="shape='rect'">
				<xsl:choose>
					<xsl:when test="corners='plain'">
						<xsl:choose>
							<xsl:when test="arrow='none' or arrow='no'">
								M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='lt'">
								M<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrowoffset) + number($main.arrow_width) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrowoffset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='lm'">
								M<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height) + 0.5*number($main.arrow_width) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height) - 0.5*number($main.arrow_width) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='lb'">
								M<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrowoffset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrowoffset) - number($main.arrow_width) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='rt'">
								M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrowoffset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrowoffset) + number($main.arrow_width) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='rm'">
								M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height) - 0.5*number($main.arrow_width) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height) + 0.5*number($main.arrow_width) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='rb'">
								M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0)  + number($height) - number($main.arrowoffset) - number($main.arrow_width) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrowoffset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='tl'">
								M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrowoffset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrowoffset) + number($main.arrow_width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='tc'">
								M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + 0.5*number($width) - 0.5*number($main.arrow_width) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + 0.5*number($width)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + 0.5*number($width) + 0.5*number($main.arrow_width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='tr'">
								M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrowoffset) - number($main.arrow_width) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrowoffset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='bl'">
								M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrowoffset) + number($main.arrow_width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrowoffset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='bc'">
								M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + 0.5*number($width) + 0.5*number($main.arrow_width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + 0.5*number($width)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + 0.5*number($width) - 0.5*number($main.arrow_width) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='br'">
								M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrowoffset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrowoffset) - number($main.arrow_width) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="corners!='plain'">
						<xsl:choose>
							<xsl:when test="arrow='none' or arrow='no'">
								M<xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth) + number($rrect.radius)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($rrect.radius) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='lt'">
								M<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth) + number($rrect.radius)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrowoffset) + number($main.arrow_width) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrowoffset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($rrect.radius) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='lm'">
								M<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth) + number($rrect.radius)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height) + 0.5*number($main.arrow_width) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height) - 0.5*number($main.arrow_width) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($rrect.radius) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='lb'">
								M<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth) + number($rrect.radius)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrowoffset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0)  + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrowoffset) - number($main.arrow_width) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($rrect.radius) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='rt'">
								M<xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth) + number($rrect.radius)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrowoffset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrowoffset) + number($main.arrow_width) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($rrect.radius) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='rm'">
								M<xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth) + number($rrect.radius)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height) - 0.5*number($main.arrow_width) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height) + 0.5*number($main.arrow_width) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($rrect.radius) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='rb'">
								M<xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth) + number($rrect.radius)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrowoffset) - number($main.arrow_width) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrowoffset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($rrect.radius) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='tl'">
								M<xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrowoffset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrowoffset) + number($main.arrow_width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth) + number($rrect.radius)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($rrect.radius) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='tc'">
								M<xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + 0.5*number($width) - 0.5*number($main.arrow_width) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + 0.5*number($width)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + 0.5*number($width) + 0.5*number($main.arrow_width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth) + number($rrect.radius)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($rrect.radius) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='tr'">
								M<xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrowoffset) - number($main.arrow_width) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrowoffset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth) + number($rrect.radius)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($rrect.radius) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='bl'">
								M<xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth) + number($rrect.radius)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrowoffset) + number($main.arrow_width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrowoffset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($rrect.radius) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='bc'">
								M<xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth) + number($rrect.radius)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + 0.5*number($width) + 0.5*number($main.arrow_width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + 0.5*number($width)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + 0.5*number($width) - 0.5*number($main.arrow_width) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($rrect.radius) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='br'">
								M<xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth) + number($rrect.radius)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($rrect.radius) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrowoffset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrowoffset) - number($main.arrow_width) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($rrect.radius) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($rrect.radius) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$rrect.radius"/>,<xsl:value-of select="$rrect.radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,<xsl:value-of select="$main.sweepflag"/><xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($rrect.radius) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
						</xsl:choose>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="shape='chevron'">
				<xsl:choose>
					<xsl:when test="chevron_type='full_E'">
						M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth) - number($chevron.offset)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth) - number($chevron.offset)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($chevron.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="chevron_type='full_W'">
						M<xsl:value-of select="number($main.x0) + number($chevron.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth) - number($chevron.offset)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($chevron.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="chevron_type='full_N'">
						M<xsl:value-of select="number($main.x0) + 0.5*number($width)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($chevron.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + 0.5*number($width)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth) - number($chevron.offset)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($chevron.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="chevron_type='full_S'">
						M<xsl:value-of select="number($main.x0) + 0.5*number($width)"/>,<xsl:value-of select="number($main.y0) + number($chevron.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth) - number($chevron.offset)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + 0.5*number($width)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth) - number($chevron.offset)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="chevron_type='half_E'">
						M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth) - number($chevron.offset)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth) - number($chevron.offset)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="chevron_type='half_W'">
						M<xsl:value-of select="number($main.x0) + number($chevron.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($chevron.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="chevron_type='half_N'">
						M<xsl:value-of select="number($main.x0) + 0.5*number($width)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($chevron.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($chevron.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="chevron_type='half_S'">
						M<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth) - number($chevron.offset)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + 0.5*number($width)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth) - number($chevron.offset)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="shape='triangle'">
				<xsl:choose>
					<xsl:when test="triangle_type='iso_E'">
						M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="triangle_type='iso_W'">
						M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="triangle_type='iso_N'">
						M<xsl:value-of select="number($main.x0) + 0.5*number($width)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="triangle_type='iso_S'">
						M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + 0.5*number($width)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="triangle_type='rect_SW'">
						M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="triangle_type='rect_SE'">
						M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="triangle_type='rect_NE'">
						M<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="triangle_type='rect_NW'">
						M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
				</xsl:choose>
			</xsl:when>

			<xsl:when test="shape='capsule'">
				<xsl:choose>
					<xsl:when test="capsule_type='h'">
						<xsl:variable name="temp.fi" select="websoft:atan((0.5*number($height) div (number($main.capsule_radius) + number($main.arrow_length))))"/>
						<xsl:variable name="temp.alpha" select="number($main.arrow_width) div number($main.capsule_radius)"/>
						<xsl:variable name="temp.x1" select="number($main.arrow_length) + number($main.capsule_radius)*(1 - websoft:xcos(( number($temp.fi) - 0.5*number($temp.alpha) )))"/>
						<xsl:variable name="temp.x2" select="number($main.arrow_length) + number($main.capsule_radius)*(1 - websoft:xcos(( number($temp.fi) + 0.5*number($temp.alpha) )))"/>
						<xsl:variable name="temp.y1" select="0.5*number($height) - number($main.capsule_radius)*websoft:xsin(( number($temp.fi) - 0.5*number($temp.alpha) ))"/>
						<xsl:variable name="temp.y2" select="0.5*number($height) - number($main.capsule_radius)*websoft:xsin(( number($temp.fi) + 0.5*number($temp.alpha) ))"/>
						<xsl:variable name="temp.xc" select="number($main.capsule_radius)*(1 - websoft:xcos(( 0.5*number($temp.alpha) )))"/>
						<xsl:variable name="temp.yc" select="number($main.capsule_radius)*websoft:xsin(( 0.5*number($temp.alpha) ))"/>
						<xsl:choose>
							<xsl:when test="arrow='none' or arrow='no'">
								M<xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='tl'">
								M<xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.arrow_width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='tc'">
								M<xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + 0.5*number($width) - 0.5*number($main.arrow_width) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + 0.5*number($width)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + 0.5*number($width) + 0.5*number($main.arrow_width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='tr'">
								M<xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.capsule.offset) - number($main.arrow_width) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='bl'">
								M<xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.arrow_width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='bc'">
								M<xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + 0.5*number($width) + 0.5*number($main.arrow_width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + 0.5*number($width)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + 0.5*number($width) - 0.5*number($main.arrow_width) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='br'">
								M<xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.capsule.offset) - number($main.arrow_width) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='lt'">
								M<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($temp.x1)"/>,<xsl:value-of select="number($main.y0) + number($temp.y1)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($temp.x2)"/>,<xsl:value-of select="number($main.y0) + number($temp.y2)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='lm'">
								M<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($temp.xc)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height) + number($temp.yc)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($temp.xc)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height) - number($temp.yc)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='lb'">
								M<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($temp.x2)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($temp.y2)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($temp.x1)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($temp.y1)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='rt'">
								M<xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($temp.x2)"/>,<xsl:value-of select="number($main.y0) + number($temp.y2)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($temp.x1)"/>,<xsl:value-of select="number($main.y0) + number($temp.y1)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='rm'">
								M<xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($temp.xc)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height) - number($temp.yc)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($temp.xc)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height) + number($temp.yc)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='rb'">
								M<xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($temp.x1)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($temp.y1)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($temp.x2)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($temp.y2)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.capsule.offset) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.capsule.offset) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="capsule_type='v'">
						<xsl:variable name="temp.fi" select="websoft:atan((0.34*number($width) div (number($main.capsule_radius) + number($main.arrow_length))))"/>
						<xsl:variable name="temp.alpha" select="number($main.arrow_width) div number($main.capsule_radius)"/>
						<xsl:variable name="temp.x1" select="0.5*number($width) - number($main.capsule_radius)*websoft:xsin(( number($temp.fi) + 0.5*number($temp.alpha) ))"/>
						<xsl:variable name="temp.x2" select="0.5*number($width) - number($main.capsule_radius)*websoft:xsin(( number($temp.fi) - 0.5*number($temp.alpha) ))"/>
						<xsl:variable name="temp.y1" select="number($main.arrow_length) + number($main.capsule_radius)*(1 - websoft:xcos(( number($temp.fi) + 0.5*number($temp.alpha) )))"/>
						<xsl:variable name="temp.y2" select="number($main.arrow_length) + number($main.capsule_radius)*(1 - websoft:xcos(( number($temp.fi) - 0.5*number($temp.alpha) )))"/>
						<xsl:variable name="temp.yc" select="number($main.capsule_radius)*(1 - websoft:xcos(( 0.5*number($temp.alpha) )))"/>
						<xsl:variable name="temp.xc" select="number($main.capsule_radius)*websoft:xsin(( 0.5*number($temp.alpha) ))"/>
						<xsl:choose>
							<xsl:when test="arrow='none' or arrow='no'">
								M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='tl'">
								M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.capsule.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($temp.x1)"/>,<xsl:value-of select="number($main.y0) + number($temp.y1)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($temp.x2)"/>,<xsl:value-of select="number($main.y0) + number($temp.y2)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth) + number($main.arrow_length)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='tc'">
								M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.capsule.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + 0.5*number($width) - number($temp.xc)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($temp.yc)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + 0.5*number($width)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + 0.5*number($width) + 0.5*number($temp.xc)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($temp.yc)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth) + number($main.arrow_length)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='tr'">
								M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.capsule.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($temp.x2)"/>,<xsl:value-of select="number($main.y0) + number($temp.y2)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($temp.x1)"/>,<xsl:value-of select="number($main.y0) + number($temp.y1)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth) + number($main.arrow_length)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='bl'">
								M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth) - number($main.arrow_length)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($temp.x2)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($temp.y2)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($temp.x1)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($temp.y1)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth) - number($main.arrow_length)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='bc'">
								M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth) - number($main.arrow_length)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + 0.5*number($width) + number($temp.xc)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($temp.yc)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + 0.5*number($width)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + 0.5*number($width) - number($temp.xc)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($temp.yc)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth) - number($main.arrow_length)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='br'">
								M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth) - number($main.arrow_length)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($temp.x1)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($temp.y1)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($temp.x2)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($temp.y2)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth) - number($main.arrow_length)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='lt'">
								M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.arrow_length)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.arrow_length)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.arrow_length)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) - number($main.halfborderwidth) + number($main.arrow_width)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='lm'">
								M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.arrow_length)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.arrow_length)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.arrow_length)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height) + 0.5*number($main.arrow_width) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.arrow_length)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height) - 0.5*number($main.arrow_width) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='lb'">
								M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.arrow_length)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.arrow_length)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.arrow_length)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) + number($main.halfborderwidth) - number($main.arrow_width)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='rt'">
								M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth) - number($main.arrow_length)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth) - number($main.arrow_length)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth) + number($main.arrow_width)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth) - number($main.arrow_length)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='rm'">
								M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth) - number($main.arrow_length)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth) - number($main.arrow_length)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height) - 0.5*number($main.arrow_width) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth) - number($main.arrow_length)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height) + 0.5*number($main.arrow_width) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth) - number($main.arrow_length)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
							<xsl:when test="arrow='rb'">
								M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth) - number($main.arrow_length)"/>,<xsl:value-of select="number($main.y0) + number($main.capsule.offset) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth) - number($main.arrow_length)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) + number($main.halfborderwidth) - number($main.arrow_width)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth) - number($main.arrow_length)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								A<xsl:value-of select="$main.capsule_radius"/>,<xsl:value-of select="$main.capsule_radius"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.capsule.offset) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
								Z
							</xsl:when>
						</xsl:choose>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="shape='ellipse'">
				<xsl:choose>
					<xsl:when test="arrow='none' or arrow='no'">
						M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='tl'">
						M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.ellipse.x1)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.ellipse.y1)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.ellipse.x2)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.ellipse.y2)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='tc'">
						M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + 0.5*number($width) - 0.5*number($main.arrow_width)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.ellipse.y3)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + 0.5*number($width)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + 0.5*number($width) + 0.5*number($main.arrow_width)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.ellipse.y3)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='tr'">
						M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.ellipse.x2)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.ellipse.y2)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.ellipse.x1)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.ellipse.y1)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='bl'">
						M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.ellipse.x2)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.ellipse.y2)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.ellipse.x1)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.ellipse.y1)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='bc'">
						M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + 0.5*number($width) + 0.5*number($main.arrow_width)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.ellipse.y3)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + 0.5*number($width)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + 0.5*number($width) - 0.5*number($main.arrow_width)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.ellipse.y3)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='br'">
						M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.ellipse.x1)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.ellipse.y1)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.ellipse.x2)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.ellipse.y2)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='lt'">
						M<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.ellipse.x1)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.y1) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.ellipse.x2)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.y2) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='lm'">
						M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.ellipse.x3) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b) - 0.5*number($main.arrow_width)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.ellipse.x3) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b) + 0.5*number($main.arrow_width)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='lb'">
						M<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.ellipse.x2)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.ellipse.y2) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.ellipse.x1)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.ellipse.y1) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='rt'">
						M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.ellipse.x2)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.y2) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.ellipse.x1)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.y1) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='rm'">
						M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.ellipse.x3) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b) - 0.5*number($main.arrow_width)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.ellipse.x3) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b) + 0.5*number($main.arrow_width)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='rb'">
						M<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.ellipse.x1)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.ellipse.y1) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.arrow_length) - number($main.ellipse.x2)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.ellipse.y2) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="number($main.ellipse.a) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.ellipse.b) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="shape='multi_star'">
				<xsl:choose>
					<xsl:when test="multi_star_type='8' or multi_star_type='8p'">
						<xsl:variable name="star8.outer.pre_x" select="websoft:ellipse_x(number($main.ellipse.a), number($main.ellipse.b), 45)"/>
						<xsl:variable name="star8.outer.pre_y" select="websoft:ellipse_y(number($main.ellipse.a), number($main.ellipse.b), 45)"/>
						<xsl:variable name="star8.inner.pre_x2" select="websoft:ellipse_x(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 22.5)"/>
						<xsl:variable name="star8.inner.pre_y2" select="websoft:ellipse_y(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 22.5)"/>
						<xsl:variable name="star8.inner.pre_x1" select="websoft:ellipse_x(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 67.5)"/>
						<xsl:variable name="star8.inner.pre_y1" select="websoft:ellipse_y(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 67.5)"/>

						<xsl:variable name="star8.outer.x1">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.ellipse.a)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.outer.y1">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.outer.x2">
							<xsl:choose>
								<xsl:when test="arrow='tr' or arrow='rt'"><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.ellipse.a) + number($star8.outer.pre_x)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star8.outer.pre_x)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.outer.y2">
							<xsl:choose>
								<xsl:when test="arrow='tr' or arrow='rt'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tl' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.ellipse.b) - number($star8.outer.pre_y)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star8.outer.pre_y)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.outer.x3">
							<xsl:choose>
								<xsl:when test="arrow='rt' or arrow='rb'"><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth) - number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.outer.y3">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.outer.x4">
							<xsl:choose>
								<xsl:when test="arrow='br' or arrow='rb'"><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.ellipse.a) + number($star8.outer.pre_x)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star8.outer.pre_x)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.outer.y4">
							<xsl:choose>
								<xsl:when test="arrow='br' or arrow='rb'"><xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.ellipse.b) + number($star8.outer.pre_y)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star8.outer.pre_y)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.outer.x5" select="$star8.outer.x1"/>
						<xsl:variable name="star8.outer.y5">
							<xsl:choose>
								<xsl:when test="arrow='bl' or arrow='br'"><xsl:value-of select="number($main.y0) + number($height) - number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.outer.x6">
							<xsl:choose>
								<xsl:when test="arrow='bl' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lt' or arrow='lm'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.ellipse.a) - number($star8.outer.pre_x)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star8.outer.pre_x)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.outer.y6">
							<xsl:choose>
								<xsl:when test="arrow='bl' or arrow='lb'"><xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.ellipse.b) + number($star8.outer.pre_y)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star8.outer.pre_y)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.outer.x7">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.outer.y7" select="$star8.outer.y3"/>
						<xsl:variable name="star8.outer.x8">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='tl'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.ellipse.a) - number($star8.outer.pre_x)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star8.outer.pre_x)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.outer.y8">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='tl'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.ellipse.b) - number($star8.outer.pre_y)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star8.outer.pre_y)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>

						<xsl:variable name="star8.inner.x1">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star8.inner.pre_x1) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star8.inner.pre_x1)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.inner.y1">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star8.inner.pre_y1) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star8.inner.pre_y1)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.inner.x2">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star8.inner.pre_x2) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star8.inner.pre_x2)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.inner.y2">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star8.inner.pre_y2) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star8.inner.pre_y2)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.inner.x3">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star8.inner.pre_x2) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star8.inner.pre_x2)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.inner.y3">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star8.inner.pre_y2) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star8.inner.pre_y2)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.inner.x4">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star8.inner.pre_x1) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star8.inner.pre_x1)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.inner.y4">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star8.inner.pre_y1) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star8.inner.pre_y1)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.inner.x5">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star8.inner.pre_x1) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star8.inner.pre_x1)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.inner.y5">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star8.inner.pre_y1) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star8.inner.pre_y1)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.inner.x6">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star8.inner.pre_x2) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star8.inner.pre_x2)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.inner.y6">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star8.inner.pre_y2) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star8.inner.pre_y2)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.inner.x7">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star8.inner.pre_x2) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star8.inner.pre_x2)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.inner.y7">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star8.inner.pre_y2) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star8.inner.pre_y2)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.inner.x8">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star8.inner.pre_x1) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star8.inner.pre_x1)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star8.inner.y8">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star8.inner.pre_y1) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star8.inner.pre_y1)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						M<xsl:value-of select="$star8.outer.x1"/>,<xsl:value-of select="$star8.outer.y1"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star8.inner.x1"/>,<xsl:value-of select="$star8.inner.y1"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star8.outer.x2"/>,<xsl:value-of select="$star8.outer.y2"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star8.inner.x2"/>,<xsl:value-of select="$star8.inner.y2"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star8.outer.x3"/>,<xsl:value-of select="$star8.outer.y3"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star8.inner.x3"/>,<xsl:value-of select="$star8.inner.y3"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star8.outer.x4"/>,<xsl:value-of select="$star8.outer.y4"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star8.inner.x4"/>,<xsl:value-of select="$star8.inner.y4"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star8.outer.x5"/>,<xsl:value-of select="$star8.outer.y5"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star8.inner.x5"/>,<xsl:value-of select="$star8.inner.y5"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star8.outer.x6"/>,<xsl:value-of select="$star8.outer.y6"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star8.inner.x6"/>,<xsl:value-of select="$star8.inner.y6"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star8.outer.x7"/>,<xsl:value-of select="$star8.outer.y7"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star8.inner.x7"/>,<xsl:value-of select="$star8.inner.y7"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star8.outer.x8"/>,<xsl:value-of select="$star8.outer.y8"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star8.inner.x8"/>,<xsl:value-of select="$star8.inner.y8"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="multi_star_type='16' or multi_star_type='16p'">
						<xsl:variable name="star16.outer.pre_x1" select="websoft:ellipse_x(number($main.ellipse.a), number($main.ellipse.b), 22.5)"/>
						<xsl:variable name="star16.outer.pre_y1" select="websoft:ellipse_y(number($main.ellipse.a), number($main.ellipse.b), 22.5)"/>
						<xsl:variable name="star16.outer.pre_x2" select="websoft:ellipse_x(number($main.ellipse.a), number($main.ellipse.b), 45)"/>
						<xsl:variable name="star16.outer.pre_y2" select="websoft:ellipse_y(number($main.ellipse.a), number($main.ellipse.b), 45)"/>
						<xsl:variable name="star16.outer.pre_x3" select="websoft:ellipse_x(number($main.ellipse.a), number($main.ellipse.b), 67.5)"/>
						<xsl:variable name="star16.outer.pre_y3" select="websoft:ellipse_y(number($main.ellipse.a), number($main.ellipse.b), 67.5)"/>

						<xsl:variable name="star16.inner.pre_x1" select="websoft:ellipse_x(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 11.25)"/>
						<xsl:variable name="star16.inner.pre_y1" select="websoft:ellipse_y(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 11.25)"/>
						<xsl:variable name="star16.inner.pre_x2" select="websoft:ellipse_x(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 33.75)"/>
						<xsl:variable name="star16.inner.pre_y2" select="websoft:ellipse_y(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 33.75)"/>
						<xsl:variable name="star16.inner.pre_x3" select="websoft:ellipse_x(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 56.25)"/>
						<xsl:variable name="star16.inner.pre_y3" select="websoft:ellipse_y(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 56.25)"/>
						<xsl:variable name="star16.inner.pre_x4" select="websoft:ellipse_x(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 78.75)"/>
						<xsl:variable name="star16.inner.pre_y4" select="websoft:ellipse_y(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 78.75)"/>

						<xsl:variable name="star16.outer.x0">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.ellipse.a)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.outer.y0">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.outer.x1">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($star16.outer.pre_x3) + number($main.ellipse.a) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star16.outer.pre_x3) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.outer.y1">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star16.outer.pre_y3) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star16.outer.pre_y3) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.outer.x2">
							<xsl:choose>
								<xsl:when test="arrow='tr' or arrow='rt'"><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($star16.outer.pre_x2) + number($main.ellipse.a) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star16.outer.pre_x2) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.outer.y2">
							<xsl:choose>
								<xsl:when test="arrow='tr' or arrow='rt'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tl' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star16.outer.pre_y2) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star16.outer.pre_y2) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.outer.x3">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($star16.outer.pre_x1) + number($main.ellipse.a) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star16.outer.pre_x1) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.outer.y3">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star16.outer.pre_y1) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star16.outer.pre_y1) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.outer.x4">
							<xsl:choose>
								<xsl:when test="arrow='rt' or arrow='rb'"><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth) - number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.outer.y4">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.outer.x5" select="$star16.outer.x3"/>
						<xsl:variable name="star16.outer.y5">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star16.outer.pre_y1) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star16.outer.pre_y1) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.outer.x6">
							<xsl:choose>
								<xsl:when test="arrow='br' or arrow='rb'"><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($star16.outer.pre_x2) + number($main.ellipse.a) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star16.outer.pre_x2) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.outer.y6">
							<xsl:choose>
								<xsl:when test="arrow='br' or arrow='rb'"><xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star16.outer.pre_y2) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star16.outer.pre_y2) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.outer.x7" select="$star16.outer.x1"/>
						<xsl:variable name="star16.outer.y7">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star16.outer.pre_y3) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star16.outer.pre_y3) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.outer.x8" select="$star16.outer.x0"/>
						<xsl:variable name="star16.outer.y8">
							<xsl:choose>
								<xsl:when test="arrow='bl' or arrow='br'"><xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth) - number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.outer.x9">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star16.outer.pre_x3) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star16.outer.pre_x3) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.outer.y9" select="$star16.outer.y7"/>
						<xsl:variable name="star16.outer.x10">
							<xsl:choose>
								<xsl:when test="arrow='bl' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lt' or arrow='lm'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star16.outer.pre_x2) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star16.outer.pre_x2) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.outer.y10">
							<xsl:choose>
								<xsl:when test="arrow='bl' or arrow='lb'"><xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star16.outer.pre_y2) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star16.outer.pre_y2)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.outer.x11">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star16.outer.pre_x1) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star16.outer.pre_x1) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.outer.y11" select="$star16.outer.y5"/>
						<xsl:variable name="star16.outer.x12">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.outer.y12" select="$star16.outer.y4"/>
						<xsl:variable name="star16.outer.x13" select="$star16.outer.x11"/>
						<xsl:variable name="star16.outer.y13" select="$star16.outer.y3"/>
						<xsl:variable name="star16.outer.x14">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='lt'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star16.outer.pre_x2) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star16.outer.pre_x2) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.outer.y14">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='lt'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star16.outer.pre_y2) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star16.outer.pre_y2) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.outer.x15" select="$star16.outer.x9"/>
						<xsl:variable name="star16.outer.y15" select="$star16.outer.y1"/>

						<xsl:variable name="star16.inner.x0">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star16.inner.pre_x4) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star16.inner.pre_x4)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.inner.y0">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star16.inner.pre_y4) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star16.inner.pre_y4)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.inner.x1">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star16.inner.pre_x3) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star16.inner.pre_x3)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.inner.y1">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star16.inner.pre_y3) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star16.inner.pre_y3)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.inner.x2">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star16.inner.pre_x2) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star16.inner.pre_x2)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.inner.y2">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star16.inner.pre_y2) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star16.inner.pre_y2)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.inner.x3">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star16.inner.pre_x1) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star16.inner.pre_x1)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.inner.y3">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star16.inner.pre_y1) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star16.inner.pre_y1)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.inner.x4" select="$star16.inner.x3"/>
						<xsl:variable name="star16.inner.y4">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star16.inner.pre_y1) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star16.inner.pre_y1)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.inner.x5" select="$star16.inner.x2"/>
						<xsl:variable name="star16.inner.y5">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star16.inner.pre_y2) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star16.inner.pre_y2)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.inner.x6" select="$star16.inner.x1"/>
						<xsl:variable name="star16.inner.y6">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star16.inner.pre_y3) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star16.inner.pre_y3)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.inner.x7" select="$star16.inner.x0"/>
						<xsl:variable name="star16.inner.y7">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star16.inner.pre_y4) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star16.inner.pre_y4)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.inner.x8">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star16.inner.pre_x4) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star16.inner.pre_x4)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.inner.y8" select="$star16.inner.y7"/>
						<xsl:variable name="star16.inner.x9">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star16.inner.pre_x3) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star16.inner.pre_x3)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.inner.y9" select="$star16.inner.y6"/>
						<xsl:variable name="star16.inner.x10">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star16.inner.pre_x2) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star16.inner.pre_x2)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.inner.y10" select="$star16.inner.y5"/>
						<xsl:variable name="star16.inner.x11">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star16.inner.pre_x1) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star16.inner.pre_x1)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star16.inner.y11" select="$star16.inner.y4"/>
						<xsl:variable name="star16.inner.x12" select="$star16.inner.x11"/>
						<xsl:variable name="star16.inner.y12" select="$star16.inner.y3"/>
						<xsl:variable name="star16.inner.x13" select="$star16.inner.x10"/>
						<xsl:variable name="star16.inner.y13" select="$star16.inner.y2"/>
						<xsl:variable name="star16.inner.x14" select="$star16.inner.x9"/>
						<xsl:variable name="star16.inner.y14" select="$star16.inner.y1"/>
						<xsl:variable name="star16.inner.x15" select="$star16.inner.x8"/>
						<xsl:variable name="star16.inner.y15" select="$star16.inner.y0"/>

						M<xsl:value-of select="$star16.outer.x0"/>,<xsl:value-of select="$star16.outer.y0"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.inner.x0"/>,<xsl:value-of select="$star16.inner.y0"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.outer.x1"/>,<xsl:value-of select="$star16.outer.y1"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.inner.x1"/>,<xsl:value-of select="$star16.inner.y1"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.outer.x2"/>,<xsl:value-of select="$star16.outer.y2"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.inner.x2"/>,<xsl:value-of select="$star16.inner.y2"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.outer.x3"/>,<xsl:value-of select="$star16.outer.y3"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.inner.x3"/>,<xsl:value-of select="$star16.inner.y3"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.outer.x4"/>,<xsl:value-of select="$star16.outer.y4"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.inner.x4"/>,<xsl:value-of select="$star16.inner.y4"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.outer.x5"/>,<xsl:value-of select="$star16.outer.y5"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.inner.x5"/>,<xsl:value-of select="$star16.inner.y5"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.outer.x6"/>,<xsl:value-of select="$star16.outer.y6"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.inner.x6"/>,<xsl:value-of select="$star16.inner.y6"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.outer.x7"/>,<xsl:value-of select="$star16.outer.y7"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.inner.x7"/>,<xsl:value-of select="$star16.inner.y7"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.outer.x8"/>,<xsl:value-of select="$star16.outer.y8"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.inner.x8"/>,<xsl:value-of select="$star16.inner.y8"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.outer.x9"/>,<xsl:value-of select="$star16.outer.y9"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.inner.x9"/>,<xsl:value-of select="$star16.inner.y9"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.outer.x10"/>,<xsl:value-of select="$star16.outer.y10"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.inner.x10"/>,<xsl:value-of select="$star16.inner.y10"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.outer.x11"/>,<xsl:value-of select="$star16.outer.y11"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.inner.x11"/>,<xsl:value-of select="$star16.inner.y11"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.outer.x12"/>,<xsl:value-of select="$star16.outer.y12"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.inner.x12"/>,<xsl:value-of select="$star16.inner.y12"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.outer.x13"/>,<xsl:value-of select="$star16.outer.y13"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.inner.x13"/>,<xsl:value-of select="$star16.inner.y13"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.outer.x14"/>,<xsl:value-of select="$star16.outer.y14"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.inner.x14"/>,<xsl:value-of select="$star16.inner.y14"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.outer.x15"/>,<xsl:value-of select="$star16.outer.y15"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star16.inner.x15"/>,<xsl:value-of select="$star16.inner.y15"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="multi_star_type='24' or multi_star_type='24p'">
						<xsl:variable name="star24.outer.pre_x1" select="websoft:ellipse_x(number($main.ellipse.a), number($main.ellipse.b), 15)"/>
						<xsl:variable name="star24.outer.pre_y1" select="websoft:ellipse_y(number($main.ellipse.a), number($main.ellipse.b), 15)"/>
						<xsl:variable name="star24.outer.pre_x2" select="websoft:ellipse_x(number($main.ellipse.a), number($main.ellipse.b), 30)"/>
						<xsl:variable name="star24.outer.pre_y2" select="websoft:ellipse_y(number($main.ellipse.a), number($main.ellipse.b), 30)"/>
						<xsl:variable name="star24.outer.pre_x3" select="websoft:ellipse_x(number($main.ellipse.a), number($main.ellipse.b), 45)"/>
						<xsl:variable name="star24.outer.pre_y3" select="websoft:ellipse_y(number($main.ellipse.a), number($main.ellipse.b), 45)"/>
						<xsl:variable name="star24.outer.pre_x4" select="websoft:ellipse_x(number($main.ellipse.a), number($main.ellipse.b), 60)"/>
						<xsl:variable name="star24.outer.pre_y4" select="websoft:ellipse_y(number($main.ellipse.a), number($main.ellipse.b), 60)"/>
						<xsl:variable name="star24.outer.pre_x5" select="websoft:ellipse_x(number($main.ellipse.a), number($main.ellipse.b), 75)"/>
						<xsl:variable name="star24.outer.pre_y5" select="websoft:ellipse_y(number($main.ellipse.a), number($main.ellipse.b), 75)"/>

						<xsl:variable name="star24.inner.pre_x1" select="websoft:ellipse_x(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 7.5)"/>
						<xsl:variable name="star24.inner.pre_y1" select="websoft:ellipse_y(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 7.5)"/>
						<xsl:variable name="star24.inner.pre_x2" select="websoft:ellipse_x(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 22.5)"/>
						<xsl:variable name="star24.inner.pre_y2" select="websoft:ellipse_y(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 22.5)"/>
						<xsl:variable name="star24.inner.pre_x3" select="websoft:ellipse_x(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 37.5)"/>
						<xsl:variable name="star24.inner.pre_y3" select="websoft:ellipse_y(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 37.5)"/>
						<xsl:variable name="star24.inner.pre_x4" select="websoft:ellipse_x(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 52.5)"/>
						<xsl:variable name="star24.inner.pre_y4" select="websoft:ellipse_y(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 52.5)"/>
						<xsl:variable name="star24.inner.pre_x5" select="websoft:ellipse_x(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 67.5)"/>
						<xsl:variable name="star24.inner.pre_y5" select="websoft:ellipse_y(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 67.5)"/>
						<xsl:variable name="star24.inner.pre_x6" select="websoft:ellipse_x(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 82.5)"/>
						<xsl:variable name="star24.inner.pre_y6" select="websoft:ellipse_y(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 82.5)"/>

						<xsl:variable name="star24.outer.x0">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.ellipse.a)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.y0">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.x1">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($star24.outer.pre_x5) + number($main.ellipse.a) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star24.outer.pre_x5) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.y1">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.outer.pre_y5) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.outer.pre_y5) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.x2">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($star24.outer.pre_x4) + number($main.ellipse.a) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star24.outer.pre_x4) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.y2">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.outer.pre_y4) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.outer.pre_y4) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.x3">
							<xsl:choose>
								<xsl:when test="arrow='tr'"><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($star24.outer.pre_x3) + number($main.ellipse.a) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star24.outer.pre_x3) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.y3">
							<xsl:choose>
								<xsl:when test="arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tl' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.outer.pre_y3) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.outer.pre_y3) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.x4">
							<xsl:choose>
								<xsl:when test="arrow='rt'"><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($star24.outer.pre_x2) + number($main.ellipse.a) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star24.outer.pre_x2) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.y4">
							<xsl:choose>
								<xsl:when test="arrow='rt'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.outer.pre_y2) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.outer.pre_y2) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.x5">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($star24.outer.pre_x1) + number($main.ellipse.a) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star24.outer.pre_x1) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.y5">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.outer.pre_y1) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.outer.pre_y1) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.x6">
							<xsl:choose>
								<xsl:when test="arrow='rt' or arrow='rb'"><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth) - number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.y6">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.x7" select="$star24.outer.x5"/>
						<xsl:variable name="star24.outer.y7">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.outer.pre_y1) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.outer.pre_y1) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.x8">
							<xsl:choose>
								<xsl:when test="arrow='rb'"><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($star24.outer.pre_x2) + number($main.ellipse.a) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star24.outer.pre_x2) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.y8">
							<xsl:choose>
								<xsl:when test="arrow='rb'"><xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.outer.pre_y2) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.outer.pre_y2) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.x9">
							<xsl:choose>
								<xsl:when test="arrow='br'"><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($star24.outer.pre_x3) + number($main.ellipse.a) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star24.outer.pre_x3) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.y9">
							<xsl:choose>
								<xsl:when test="arrow='br'"><xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.outer.pre_y3) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.outer.pre_y3) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.x10" select="$star24.outer.x2"/>
						<xsl:variable name="star24.outer.y10">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.outer.pre_y4) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.outer.pre_y4) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.x11" select="$star24.outer.x1"/>
						<xsl:variable name="star24.outer.y11">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.outer.pre_y5) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.outer.pre_y5) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.x12" select="$star24.outer.x0"/>
						<xsl:variable name="star24.outer.y12">
							<xsl:choose>
								<xsl:when test="arrow='bl' or arrow='br'"><xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth) - number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.x13">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.outer.pre_x5) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.outer.pre_x5) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.y13" select="$star24.outer.y11"/>
						<xsl:variable name="star24.outer.x14">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.outer.pre_x4) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.outer.pre_x4) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.y14" select="$star24.outer.y10"/>
						<xsl:variable name="star24.outer.x15">
							<xsl:choose>
								<xsl:when test="arrow='bl'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.outer.pre_x3) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.outer.pre_x3) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.y15">
							<xsl:choose>
								<xsl:when test="arrow='bl'"><xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.outer.pre_y3) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.outer.pre_y3)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.x16">
							<xsl:choose>
								<xsl:when test="arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lt' or arrow='lm'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.outer.pre_x2) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.outer.pre_x2) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.y16">
							<xsl:choose>
								<xsl:when test="arrow='lb'"><xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.outer.pre_y2) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.outer.pre_y2) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.x17">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.outer.pre_x1) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.outer.pre_x1) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.y17" select="$star24.outer.y7"/>
						<xsl:variable name="star24.outer.x18">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.y18" select="$star24.outer.y6"/>
						<xsl:variable name="star24.outer.x19" select="$star24.outer.x17"/>
						<xsl:variable name="star24.outer.y19" select="$star24.outer.y5"/>
						<xsl:variable name="star24.outer.x20">
							<xsl:choose>
								<xsl:when test="arrow='lt'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lb' or arrow='lm'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.outer.pre_x2) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.outer.pre_x2) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.y20">
							<xsl:choose>
								<xsl:when test="arrow='lt'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.outer.pre_y2) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.outer.pre_y2) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.x21">
							<xsl:choose>
								<xsl:when test="arrow='tl'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.outer.pre_x3) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.outer.pre_x3) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.y21">
							<xsl:choose>
								<xsl:when test="arrow='tl'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.outer.pre_y3) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.outer.pre_y3) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.outer.x22" select="$star24.outer.x14"/>
						<xsl:variable name="star24.outer.y22" select="$star24.outer.y2"/>
						<xsl:variable name="star24.outer.x23" select="$star24.outer.x13"/>
						<xsl:variable name="star24.outer.y23" select="$star24.outer.y1"/>

						<xsl:variable name="star24.inner.x0">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star24.inner.pre_x6) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star24.inner.pre_x6)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.y0">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.inner.pre_y6) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.inner.pre_y6)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.x1">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star24.inner.pre_x5) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star24.inner.pre_x5)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.y1">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.inner.pre_y5) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.inner.pre_y5)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.x2">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star24.inner.pre_x4) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star24.inner.pre_x4)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.y2">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.inner.pre_y4) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.inner.pre_y4)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.x3">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star24.inner.pre_x3) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star24.inner.pre_x3)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.y3">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.inner.pre_y3) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.inner.pre_y3)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.x4">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star24.inner.pre_x2) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star24.inner.pre_x2)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.y4">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.inner.pre_y2) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.inner.pre_y2)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.x5">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star24.inner.pre_x1) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star24.inner.pre_x1)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.y5">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.inner.pre_y1) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star24.inner.pre_y1)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.x6" select="$star24.inner.x5"/>
						<xsl:variable name="star24.inner.y6">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.inner.pre_y1) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.inner.pre_y1)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.x7" select="$star24.inner.x4"/>
						<xsl:variable name="star24.inner.y7">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.inner.pre_y2) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.inner.pre_y2)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.x8" select="$star24.inner.x3"/>
						<xsl:variable name="star24.inner.y8">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.inner.pre_y3) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.inner.pre_y3)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.x9" select="$star24.inner.x2"/>
						<xsl:variable name="star24.inner.y9">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.inner.pre_y4) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.inner.pre_y4)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.x10" select="$star24.inner.x1"/>
						<xsl:variable name="star24.inner.y10">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.inner.pre_y5) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.inner.pre_y5)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.x11" select="$star24.inner.x0"/>
						<xsl:variable name="star24.inner.y11">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.inner.pre_y6) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star24.inner.pre_y6)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.x12">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.inner.pre_x6) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.inner.pre_x6)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.y12" select="$star24.inner.y11"/>
						<xsl:variable name="star24.inner.x13">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.inner.pre_x5) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.inner.pre_x5)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.y13" select="$star24.inner.y10"/>
						<xsl:variable name="star24.inner.x14">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.inner.pre_x4) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.inner.pre_x4)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.y14" select="$star24.inner.y9"/>
						<xsl:variable name="star24.inner.x15">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.inner.pre_x3) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.inner.pre_x3)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.y15" select="$star24.inner.y8"/>
						<xsl:variable name="star24.inner.x16">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.inner.pre_x2) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.inner.pre_x2)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.y16" select="$star24.inner.y7"/>
						<xsl:variable name="star24.inner.x17">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.inner.pre_x1) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star24.inner.pre_x1)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star24.inner.y17" select="$star24.inner.y6"/>
						<xsl:variable name="star24.inner.x18" select="$star24.inner.x17"/>
						<xsl:variable name="star24.inner.y18" select="$star24.inner.y5"/>
						<xsl:variable name="star24.inner.x19" select="$star24.inner.x16"/>
						<xsl:variable name="star24.inner.y19" select="$star24.inner.y4"/>
						<xsl:variable name="star24.inner.x20" select="$star24.inner.x15"/>
						<xsl:variable name="star24.inner.y20" select="$star24.inner.y3"/>
						<xsl:variable name="star24.inner.x21" select="$star24.inner.x14"/>
						<xsl:variable name="star24.inner.y21" select="$star24.inner.y2"/>
						<xsl:variable name="star24.inner.x22" select="$star24.inner.x13"/>
						<xsl:variable name="star24.inner.y22" select="$star24.inner.y1"/>
						<xsl:variable name="star24.inner.x23" select="$star24.inner.x12"/>
						<xsl:variable name="star24.inner.y23" select="$star24.inner.y0"/>

						M<xsl:value-of select="$star24.outer.x0"/>,<xsl:value-of select="$star24.outer.y0"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x0"/>,<xsl:value-of select="$star24.inner.y0"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.outer.x1"/>,<xsl:value-of select="$star24.outer.y1"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x1"/>,<xsl:value-of select="$star24.inner.y1"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.outer.x2"/>,<xsl:value-of select="$star24.outer.y2"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x2"/>,<xsl:value-of select="$star24.inner.y2"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.outer.x3"/>,<xsl:value-of select="$star24.outer.y3"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x3"/>,<xsl:value-of select="$star24.inner.y3"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.outer.x4"/>,<xsl:value-of select="$star24.outer.y4"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x4"/>,<xsl:value-of select="$star24.inner.y4"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.outer.x5"/>,<xsl:value-of select="$star24.outer.y5"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x5"/>,<xsl:value-of select="$star24.inner.y5"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.outer.x6"/>,<xsl:value-of select="$star24.outer.y6"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x6"/>,<xsl:value-of select="$star24.inner.y6"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.outer.x7"/>,<xsl:value-of select="$star24.outer.y7"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x7"/>,<xsl:value-of select="$star24.inner.y7"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.outer.x8"/>,<xsl:value-of select="$star24.outer.y8"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x8"/>,<xsl:value-of select="$star24.inner.y8"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.outer.x9"/>,<xsl:value-of select="$star24.outer.y9"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x9"/>,<xsl:value-of select="$star24.inner.y9"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.outer.x10"/>,<xsl:value-of select="$star24.outer.y10"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x10"/>,<xsl:value-of select="$star24.inner.y10"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.outer.x11"/>,<xsl:value-of select="$star24.outer.y11"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x11"/>,<xsl:value-of select="$star24.inner.y11"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.outer.x12"/>,<xsl:value-of select="$star24.outer.y12"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x12"/>,<xsl:value-of select="$star24.inner.y12"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.outer.x13"/>,<xsl:value-of select="$star24.outer.y13"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x13"/>,<xsl:value-of select="$star24.inner.y13"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.outer.x14"/>,<xsl:value-of select="$star24.outer.y14"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x14"/>,<xsl:value-of select="$star24.inner.y14"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.outer.x15"/>,<xsl:value-of select="$star24.outer.y15"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x15"/>,<xsl:value-of select="$star24.inner.y15"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.outer.x16"/>,<xsl:value-of select="$star24.outer.y16"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x16"/>,<xsl:value-of select="$star24.inner.y16"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.outer.x17"/>,<xsl:value-of select="$star24.outer.y17"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x17"/>,<xsl:value-of select="$star24.inner.y17"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.outer.x18"/>,<xsl:value-of select="$star24.outer.y18"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x18"/>,<xsl:value-of select="$star24.inner.y18"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.outer.x19"/>,<xsl:value-of select="$star24.outer.y19"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x19"/>,<xsl:value-of select="$star24.inner.y19"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.outer.x20"/>,<xsl:value-of select="$star24.outer.y20"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x20"/>,<xsl:value-of select="$star24.inner.y20"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.outer.x21"/>,<xsl:value-of select="$star24.outer.y21"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x21"/>,<xsl:value-of select="$star24.inner.y21"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.outer.x22"/>,<xsl:value-of select="$star24.outer.y22"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x22"/>,<xsl:value-of select="$star24.inner.y22"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.outer.x23"/>,<xsl:value-of select="$star24.outer.y23"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star24.inner.x23"/>,<xsl:value-of select="$star24.inner.y23"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="multi_star_type='32' or multi_star_type='32p'">
						<xsl:variable name="star32.outer.pre_x1" select="websoft:ellipse_x(number($main.ellipse.a), number($main.ellipse.b), 11.25)"/>
						<xsl:variable name="star32.outer.pre_y1" select="websoft:ellipse_y(number($main.ellipse.a), number($main.ellipse.b), 11.25)"/>
						<xsl:variable name="star32.outer.pre_x2" select="websoft:ellipse_x(number($main.ellipse.a), number($main.ellipse.b), 22.5)"/>
						<xsl:variable name="star32.outer.pre_y2" select="websoft:ellipse_y(number($main.ellipse.a), number($main.ellipse.b), 22.5)"/>
						<xsl:variable name="star32.outer.pre_x3" select="websoft:ellipse_x(number($main.ellipse.a), number($main.ellipse.b), 33.75)"/>
						<xsl:variable name="star32.outer.pre_y3" select="websoft:ellipse_y(number($main.ellipse.a), number($main.ellipse.b), 33.75)"/>
						<xsl:variable name="star32.outer.pre_x4" select="websoft:ellipse_x(number($main.ellipse.a), number($main.ellipse.b), 45)"/>
						<xsl:variable name="star32.outer.pre_y4" select="websoft:ellipse_y(number($main.ellipse.a), number($main.ellipse.b), 45)"/>
						<xsl:variable name="star32.outer.pre_x5" select="websoft:ellipse_x(number($main.ellipse.a), number($main.ellipse.b), 56.25)"/>
						<xsl:variable name="star32.outer.pre_y5" select="websoft:ellipse_y(number($main.ellipse.a), number($main.ellipse.b), 56.25)"/>
						<xsl:variable name="star32.outer.pre_x6" select="websoft:ellipse_x(number($main.ellipse.a), number($main.ellipse.b), 67.5)"/>
						<xsl:variable name="star32.outer.pre_y6" select="websoft:ellipse_y(number($main.ellipse.a), number($main.ellipse.b), 67.5)"/>
						<xsl:variable name="star32.outer.pre_x7" select="websoft:ellipse_x(number($main.ellipse.a), number($main.ellipse.b), 78.75)"/>
						<xsl:variable name="star32.outer.pre_y7" select="websoft:ellipse_y(number($main.ellipse.a), number($main.ellipse.b), 78.75)"/>

						<xsl:variable name="star32.inner.pre_x1" select="websoft:ellipse_x(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 5.625)"/>
						<xsl:variable name="star32.inner.pre_y1" select="websoft:ellipse_y(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 5.625)"/>
						<xsl:variable name="star32.inner.pre_x2" select="websoft:ellipse_x(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 16.875)"/>
						<xsl:variable name="star32.inner.pre_y2" select="websoft:ellipse_y(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 16.875)"/>
						<xsl:variable name="star32.inner.pre_x3" select="websoft:ellipse_x(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 28.125)"/>
						<xsl:variable name="star32.inner.pre_y3" select="websoft:ellipse_y(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 28.125)"/>
						<xsl:variable name="star32.inner.pre_x4" select="websoft:ellipse_x(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 39.375)"/>
						<xsl:variable name="star32.inner.pre_y4" select="websoft:ellipse_y(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 39.375)"/>
						<xsl:variable name="star32.inner.pre_x5" select="websoft:ellipse_x(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 50.625)"/>
						<xsl:variable name="star32.inner.pre_y5" select="websoft:ellipse_y(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 50.625)"/>
						<xsl:variable name="star32.inner.pre_x6" select="websoft:ellipse_x(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 61.875)"/>
						<xsl:variable name="star32.inner.pre_y6" select="websoft:ellipse_y(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 61.875)"/>
						<xsl:variable name="star32.inner.pre_x7" select="websoft:ellipse_x(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 73.125)"/>
						<xsl:variable name="star32.inner.pre_y7" select="websoft:ellipse_y(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 73.125)"/>
						<xsl:variable name="star32.inner.pre_x8" select="websoft:ellipse_x(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 84.375)"/>
						<xsl:variable name="star32.inner.pre_y8" select="websoft:ellipse_y(number($main.ellipse.inner.a), number($main.ellipse.inner.b), 84.375)"/>

						<xsl:variable name="star32.outer.x0">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($main.ellipse.a)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.y0">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.x1">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($star32.outer.pre_x7) + number($main.ellipse.a) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.outer.pre_x7) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.y1">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.outer.pre_y7) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.outer.pre_y7) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.x2">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($star32.outer.pre_x6) + number($main.ellipse.a) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.outer.pre_x6) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.y2">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.outer.pre_y6) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.outer.pre_y6) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.x3">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($star32.outer.pre_x5) + number($main.ellipse.a) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.outer.pre_x5) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.y3">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.outer.pre_y5) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.outer.pre_y5) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.x4">
							<xsl:choose>
								<xsl:when test="arrow='tr'"><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($star32.outer.pre_x4) + number($main.ellipse.a) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.outer.pre_x4) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.y4">
							<xsl:choose>
								<xsl:when test="arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tl' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.outer.pre_y4) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.outer.pre_y4) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.x5">
							<xsl:choose>
								<xsl:when test="arrow='rt'"><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($star32.outer.pre_x3) + number($main.ellipse.a) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.outer.pre_x3) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.y5">
							<xsl:choose>
								<xsl:when test="arrow='rt'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.outer.pre_y3) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.outer.pre_y3) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.x6">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($star32.outer.pre_x2) + number($main.ellipse.a) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.outer.pre_x2) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.y6">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.outer.pre_y2) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.outer.pre_y2) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.x7">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($star32.outer.pre_x1) + number($main.ellipse.a) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.outer.pre_x1) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.y7">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.outer.pre_y1) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.outer.pre_y1) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.x8">
							<xsl:choose>
								<xsl:when test="arrow='rt' or arrow='rb'"><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth) - number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.y8">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.x9" select="$star32.outer.x7"/>
						<xsl:variable name="star32.outer.y9">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.outer.pre_y1) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.outer.pre_y1) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.x10" select="$star32.outer.x6"/>
						<xsl:variable name="star32.outer.y10">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.outer.pre_y2) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.outer.pre_y2) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.x11">
							<xsl:choose>
								<xsl:when test="arrow='rb'"><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.arrow_length) + number($star32.outer.pre_x3) + number($main.ellipse.a) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.outer.pre_x3) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.y11">
							<xsl:choose>
								<xsl:when test="arrow='rb'"><xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.outer.pre_y3) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.outer.pre_y3) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.x12">
							<xsl:choose>
								<xsl:when test="arrow='br'"><xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($star32.outer.pre_x4) + number($main.ellipse.a) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.outer.pre_x4) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.y12">
							<xsl:choose>
								<xsl:when test="arrow='br'"><xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.outer.pre_y4) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.outer.pre_y4) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.x13" select="$star32.outer.x3"/>
						<xsl:variable name="star32.outer.y13">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.outer.pre_y5) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.outer.pre_y5) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.x14" select="$star32.outer.x2"/>
						<xsl:variable name="star32.outer.y14">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.outer.pre_y6) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.outer.pre_y6) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.x15" select="$star32.outer.x1"/>
						<xsl:variable name="star32.outer.y15">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.outer.pre_y7) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.outer.pre_y7) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.x16" select="$star32.outer.x0"/>
						<xsl:variable name="star32.outer.y16">
							<xsl:choose>
								<xsl:when test="arrow='bl' or arrow='br'"><xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth) - number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.x17">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.outer.pre_x7) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.outer.pre_x7) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.y17" select="$star32.outer.y15"/>
						<xsl:variable name="star32.outer.x18">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.outer.pre_x6) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.outer.pre_x6) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.y18" select="$star32.outer.y14"/>
						<xsl:variable name="star32.outer.x19">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.outer.pre_x5) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.outer.pre_x5) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.y19" select="$star32.outer.y13"/>
						<xsl:variable name="star32.outer.x20">
							<xsl:choose>
								<xsl:when test="arrow='bl'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.outer.pre_x4) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.outer.pre_x4) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.y20">
							<xsl:choose>
								<xsl:when test="arrow='bl'"><xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.outer.pre_y4) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.outer.pre_y4)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.x21">
							<xsl:choose>
								<xsl:when test="arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lt' or arrow='lm'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.outer.pre_x3) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.outer.pre_x3) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.y21">
							<xsl:choose>
								<xsl:when test="arrow='lb'"><xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.outer.pre_y3) + number($main.arrow_length) - number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.outer.pre_y3) - number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.x22">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.outer.pre_x2) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.outer.pre_x2) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.y22" select="$star32.outer.y10"/>
						<xsl:variable name="star32.outer.x23">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.outer.pre_x1) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.outer.pre_x1) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.y23" select="$star32.outer.y9"/>
						<xsl:variable name="star32.outer.x24">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.y24" select="$star32.outer.y8"/>
						<xsl:variable name="star32.outer.x25" select="$star32.outer.x23"/>
						<xsl:variable name="star32.outer.y25" select="$star32.outer.y7"/>
						<xsl:variable name="star32.outer.x26" select="$star32.outer.x22"/>
						<xsl:variable name="star32.outer.y26" select="$star32.outer.y6"/>
						<xsl:variable name="star32.outer.x27">
							<xsl:choose>
								<xsl:when test="arrow='lt'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lb' or arrow='lm'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.outer.pre_x3) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.outer.pre_x3) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.y27">
							<xsl:choose>
								<xsl:when test="arrow='lt'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tl' or arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.outer.pre_y3) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.outer.pre_y3) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.x28">
							<xsl:choose>
								<xsl:when test="arrow='tl'"><xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.outer.pre_x4) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.outer.pre_x4) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.y28">
							<xsl:choose>
								<xsl:when test="arrow='tl'"><xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:when test="arrow='tr' or arrow='tc'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.outer.pre_y4) + number($main.arrow_length) + number($main.halfborderwidth)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.outer.pre_y4) + number($main.halfborderwidth)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.outer.x29" select="$star32.outer.x19"/>
						<xsl:variable name="star32.outer.y29" select="$star32.outer.y3"/>
						<xsl:variable name="star32.outer.x30" select="$star32.outer.x18"/>
						<xsl:variable name="star32.outer.y30" select="$star32.outer.y2"/>
						<xsl:variable name="star32.outer.x31" select="$star32.outer.x17"/>
						<xsl:variable name="star32.outer.y31" select="$star32.outer.y1"/>

						<xsl:variable name="star32.inner.x0">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.inner.pre_x8) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.inner.pre_x8)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.y0">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.inner.pre_y8) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.inner.pre_y8)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.x1">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.inner.pre_x7) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.inner.pre_x7)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.y1">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.inner.pre_y7) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.inner.pre_y7)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.x2">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.inner.pre_x6) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.inner.pre_x6)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.y2">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.inner.pre_y6) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.inner.pre_y6)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.x3">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.inner.pre_x5) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.inner.pre_x5)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.y3">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.inner.pre_y5) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.inner.pre_y5)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.x4">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.inner.pre_x4) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.inner.pre_x4)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.y4">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.inner.pre_y4) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.inner.pre_y4)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.x5">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.inner.pre_x3) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.inner.pre_x3)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.y5">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.inner.pre_y3) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.inner.pre_y3)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.x6">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.inner.pre_x2) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.inner.pre_x2)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.y6">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.inner.pre_y2) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.inner.pre_y2)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.x7">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.inner.pre_x1) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) + number($star32.inner.pre_x1)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.y7">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.inner.pre_y1) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) - number($star32.inner.pre_y1)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.x8" select="$star32.inner.x7"/>
						<xsl:variable name="star32.inner.y8">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.inner.pre_y1) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.inner.pre_y1)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.x9" select="$star32.inner.x6"/>
						<xsl:variable name="star32.inner.y9">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.inner.pre_y2) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.inner.pre_y2)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.x10" select="$star32.inner.x5"/>
						<xsl:variable name="star32.inner.y10">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.inner.pre_y3) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.inner.pre_y3)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.x11" select="$star32.inner.x4"/>
						<xsl:variable name="star32.inner.y11">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.inner.pre_y4) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.inner.pre_y4)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.x12" select="$star32.inner.x3"/>
						<xsl:variable name="star32.inner.y12">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.inner.pre_y5) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.inner.pre_y5)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.x13" select="$star32.inner.x2"/>
						<xsl:variable name="star32.inner.y13">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.inner.pre_y6) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.inner.pre_y6)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.x14" select="$star32.inner.x1"/>
						<xsl:variable name="star32.inner.y14">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.inner.pre_y7) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.inner.pre_y7)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.x15" select="$star32.inner.x0"/>
						<xsl:variable name="star32.inner.y15">
							<xsl:choose>
								<xsl:when test="arrow='tl' or arrow='tc' or arrow='tr'"><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.inner.pre_y8) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.y0) + number($main.ellipse.b) + number($star32.inner.pre_y8)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.x16">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.inner.pre_x8) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.inner.pre_x8)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.y16" select="$star32.inner.y15"/>
						<xsl:variable name="star32.inner.x17">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.inner.pre_x7) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.inner.pre_x7)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.y17" select="$star32.inner.y14"/>
						<xsl:variable name="star32.inner.x18">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.inner.pre_x6) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.inner.pre_x6)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.y18" select="$star32.inner.y13"/>
						<xsl:variable name="star32.inner.x19">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.inner.pre_x5) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.inner.pre_x5)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.y19" select="$star32.inner.y12"/>
						<xsl:variable name="star32.inner.x20">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.inner.pre_x4) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.inner.pre_x4)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.y20" select="$star32.inner.y11"/>
						<xsl:variable name="star32.inner.x21">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.inner.pre_x3) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.inner.pre_x3)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.y21" select="$star32.inner.y10"/>
						<xsl:variable name="star32.inner.x22">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.inner.pre_x2) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.inner.pre_x2)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.y22" select="$star32.inner.y9"/>
						<xsl:variable name="star32.inner.x23">
							<xsl:choose>
								<xsl:when test="arrow='lt' or arrow='lm' or arrow='lb'"><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.inner.pre_x1) + number($main.arrow_length)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="number($main.x0) + number($main.ellipse.a) - number($star32.inner.pre_x1)"/></xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="star32.inner.y23" select="$star32.inner.y8"/>
						<xsl:variable name="star32.inner.x24" select="$star32.inner.x23"/>
						<xsl:variable name="star32.inner.y24" select="$star32.inner.y7"/>
						<xsl:variable name="star32.inner.x25" select="$star32.inner.x22"/>
						<xsl:variable name="star32.inner.y25" select="$star32.inner.y6"/>
						<xsl:variable name="star32.inner.x26" select="$star32.inner.x21"/>
						<xsl:variable name="star32.inner.y26" select="$star32.inner.y5"/>
						<xsl:variable name="star32.inner.x27" select="$star32.inner.x20"/>
						<xsl:variable name="star32.inner.y27" select="$star32.inner.y4"/>
						<xsl:variable name="star32.inner.x28" select="$star32.inner.x19"/>
						<xsl:variable name="star32.inner.y28" select="$star32.inner.y3"/>
						<xsl:variable name="star32.inner.x29" select="$star32.inner.x18"/>
						<xsl:variable name="star32.inner.y29" select="$star32.inner.y2"/>
						<xsl:variable name="star32.inner.x30" select="$star32.inner.x17"/>
						<xsl:variable name="star32.inner.y30" select="$star32.inner.y1"/>
						<xsl:variable name="star32.inner.x31" select="$star32.inner.x16"/>
						<xsl:variable name="star32.inner.y31" select="$star32.inner.y0"/>

						M<xsl:value-of select="$star32.outer.x0"/>,<xsl:value-of select="$star32.outer.y0"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x0"/>,<xsl:value-of select="$star32.inner.y0"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x1"/>,<xsl:value-of select="$star32.outer.y1"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x1"/>,<xsl:value-of select="$star32.inner.y1"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x2"/>,<xsl:value-of select="$star32.outer.y2"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x2"/>,<xsl:value-of select="$star32.inner.y2"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x3"/>,<xsl:value-of select="$star32.outer.y3"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x3"/>,<xsl:value-of select="$star32.inner.y3"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x4"/>,<xsl:value-of select="$star32.outer.y4"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x4"/>,<xsl:value-of select="$star32.inner.y4"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x5"/>,<xsl:value-of select="$star32.outer.y5"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x5"/>,<xsl:value-of select="$star32.inner.y5"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x6"/>,<xsl:value-of select="$star32.outer.y6"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x6"/>,<xsl:value-of select="$star32.inner.y6"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x7"/>,<xsl:value-of select="$star32.outer.y7"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x7"/>,<xsl:value-of select="$star32.inner.y7"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x8"/>,<xsl:value-of select="$star32.outer.y8"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x8"/>,<xsl:value-of select="$star32.inner.y8"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x9"/>,<xsl:value-of select="$star32.outer.y9"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x9"/>,<xsl:value-of select="$star32.inner.y9"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x10"/>,<xsl:value-of select="$star32.outer.y10"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x10"/>,<xsl:value-of select="$star32.inner.y10"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x11"/>,<xsl:value-of select="$star32.outer.y11"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x11"/>,<xsl:value-of select="$star32.inner.y11"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x12"/>,<xsl:value-of select="$star32.outer.y12"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x12"/>,<xsl:value-of select="$star32.inner.y12"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x13"/>,<xsl:value-of select="$star32.outer.y13"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x13"/>,<xsl:value-of select="$star32.inner.y13"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x14"/>,<xsl:value-of select="$star32.outer.y14"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x14"/>,<xsl:value-of select="$star32.inner.y14"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x15"/>,<xsl:value-of select="$star32.outer.y15"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x15"/>,<xsl:value-of select="$star32.inner.y15"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x16"/>,<xsl:value-of select="$star32.outer.y16"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x16"/>,<xsl:value-of select="$star32.inner.y16"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x17"/>,<xsl:value-of select="$star32.outer.y17"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x17"/>,<xsl:value-of select="$star32.inner.y17"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x18"/>,<xsl:value-of select="$star32.outer.y18"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x18"/>,<xsl:value-of select="$star32.inner.y18"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x19"/>,<xsl:value-of select="$star32.outer.y19"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x19"/>,<xsl:value-of select="$star32.inner.y19"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x20"/>,<xsl:value-of select="$star32.outer.y20"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x20"/>,<xsl:value-of select="$star32.inner.y20"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x21"/>,<xsl:value-of select="$star32.outer.y21"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x21"/>,<xsl:value-of select="$star32.inner.y21"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x22"/>,<xsl:value-of select="$star32.outer.y22"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x22"/>,<xsl:value-of select="$star32.inner.y22"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x23"/>,<xsl:value-of select="$star32.outer.y23"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x23"/>,<xsl:value-of select="$star32.inner.y23"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x24"/>,<xsl:value-of select="$star32.outer.y24"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x24"/>,<xsl:value-of select="$star32.inner.y24"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x25"/>,<xsl:value-of select="$star32.outer.y25"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x25"/>,<xsl:value-of select="$star32.inner.y25"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x26"/>,<xsl:value-of select="$star32.outer.y26"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x26"/>,<xsl:value-of select="$star32.inner.y26"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x27"/>,<xsl:value-of select="$star32.outer.y27"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x27"/>,<xsl:value-of select="$star32.inner.y27"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x28"/>,<xsl:value-of select="$star32.outer.y28"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x28"/>,<xsl:value-of select="$star32.inner.y28"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x29"/>,<xsl:value-of select="$star32.outer.y29"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x29"/>,<xsl:value-of select="$star32.inner.y29"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x30"/>,<xsl:value-of select="$star32.outer.y30"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x30"/>,<xsl:value-of select="$star32.inner.y30"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.outer.x31"/>,<xsl:value-of select="$star32.outer.y31"/><xsl:text> </xsl:text>
						L<xsl:value-of select="$star32.inner.x31"/>,<xsl:value-of select="$star32.inner.y31"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="shape='cloud'">
				<xsl:choose>
					<xsl:when test="arrow='none' or arrow='no'">
						M<xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.198*number($cloud.width)"/>,<xsl:value-of select="0.248*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.608*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.128*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.9*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.316*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.183*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.854*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.744*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.562*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.91*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.182*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.252*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.862*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.161*number($cloud.width)"/>,<xsl:value-of select="0.202*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.066*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.552*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.184*number($cloud.width)"/>,<xsl:value-of select="0.23*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='tl'">
						M<xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.198*number($cloud.width)"/>,<xsl:value-of select="0.248*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.608*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.128*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.9*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.316*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.183*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.854*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.744*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.562*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.91*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.182*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.252*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.862*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.161*number($cloud.width)"/>,<xsl:value-of select="0.202*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.066*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.552*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.184*number($cloud.width)"/>,<xsl:value-of select="0.23*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.09*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.185*number($cloud.height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($cloud.x0) + 0.16*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.184*number($cloud.width)"/>,<xsl:value-of select="0.23*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='tc'">
						M<xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.198*number($cloud.width)"/>,<xsl:value-of select="0.248*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.47*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.02*number($cloud.height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + 0.5*number($width)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($cloud.x0) + 0.53*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.04*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.198*number($cloud.width)"/>,<xsl:value-of select="0.248*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.608*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.128*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.9*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.316*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.183*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.854*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.744*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.562*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.91*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.182*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.252*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.862*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.161*number($cloud.width)"/>,<xsl:value-of select="0.202*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.066*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.552*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.184*number($cloud.width)"/>,<xsl:value-of select="0.23*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='tr'">
						M<xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.198*number($cloud.width)"/>,<xsl:value-of select="0.248*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.608*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.128*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.82*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.06*number($cloud.height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($cloud.x0) + 0.88*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.12*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.9*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.316*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.183*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.854*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.744*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.562*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.91*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.182*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.252*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.862*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.161*number($cloud.width)"/>,<xsl:value-of select="0.202*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.066*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.552*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.184*number($cloud.width)"/>,<xsl:value-of select="0.23*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='bl'">
						M<xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.198*number($cloud.width)"/>,<xsl:value-of select="0.248*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.608*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.128*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.9*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.316*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.183*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.854*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.744*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.562*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.91*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.182*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.252*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.862*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.161*number($cloud.width)"/>,<xsl:value-of select="0.202*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.14*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.88*number($cloud.height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($cloud.x0) + 0.09*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.84*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.161*number($cloud.width)"/>,<xsl:value-of select="0.202*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.066*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.552*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.184*number($cloud.width)"/>,<xsl:value-of select="0.23*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='bc'">
						M<xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.198*number($cloud.width)"/>,<xsl:value-of select="0.248*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.608*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.128*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.9*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.316*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.183*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.854*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.744*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.562*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.91*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.182*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.53*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.94*number($cloud.height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + 0.5*number($width)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($cloud.x0) + 0.47*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.98*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.182*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.252*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.862*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.161*number($cloud.width)"/>,<xsl:value-of select="0.202*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.066*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.552*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.184*number($cloud.width)"/>,<xsl:value-of select="0.23*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='br'">
						M<xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.198*number($cloud.width)"/>,<xsl:value-of select="0.248*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.608*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.128*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.9*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.316*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.183*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.854*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.744*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.83*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.86*number($cloud.height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($cloud.x0) + 0.76*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.94*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.562*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.91*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.182*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.252*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.862*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.161*number($cloud.width)"/>,<xsl:value-of select="0.202*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.066*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.552*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.184*number($cloud.width)"/>,<xsl:value-of select="0.23*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='lt'">
						M<xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.198*number($cloud.width)"/>,<xsl:value-of select="0.248*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.608*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.128*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.9*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.316*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.183*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.854*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.744*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.562*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.91*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.182*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.252*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.862*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.161*number($cloud.width)"/>,<xsl:value-of select="0.202*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.066*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.552*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.184*number($cloud.width)"/>,<xsl:value-of select="0.23*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.03*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.25*number($cloud.height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($cloud.x0) + 0.09*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.185*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.184*number($cloud.width)"/>,<xsl:value-of select="0.23*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='lm'">
						M<xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.198*number($cloud.width)"/>,<xsl:value-of select="0.248*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.608*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.128*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.9*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.316*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.183*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.854*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.744*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.562*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.91*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.182*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.252*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.862*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.161*number($cloud.width)"/>,<xsl:value-of select="0.202*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.066*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.552*number($cloud.height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($cloud.x0) + 0.02*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.47*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.184*number($cloud.width)"/>,<xsl:value-of select="0.23*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='lb'">
						M<xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.198*number($cloud.width)"/>,<xsl:value-of select="0.248*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.608*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.128*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.9*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.316*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.183*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.854*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.744*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.562*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.91*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.182*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.252*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.862*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.161*number($cloud.width)"/>,<xsl:value-of select="0.202*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.09*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.84*number($cloud.height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($cloud.x0) + 0.04*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.77*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.161*number($cloud.width)"/>,<xsl:value-of select="0.202*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.066*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.552*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.184*number($cloud.width)"/>,<xsl:value-of select="0.23*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='rt'">
						M<xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.198*number($cloud.width)"/>,<xsl:value-of select="0.248*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.608*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.128*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.88*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.12*number($cloud.height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($cloud.x0) + 0.91*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.19*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.9*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.316*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.183*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.854*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.744*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.562*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.91*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.182*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.252*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.862*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.161*number($cloud.width)"/>,<xsl:value-of select="0.202*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.066*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.552*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.184*number($cloud.width)"/>,<xsl:value-of select="0.23*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='rm'">
						M<xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.198*number($cloud.width)"/>,<xsl:value-of select="0.248*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.608*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.128*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.9*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.316*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.183*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.99*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.46*number($cloud.height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($cloud.x0) + 0.99*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.54*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.183*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.854*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.744*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.562*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.91*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.182*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.252*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.862*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.161*number($cloud.width)"/>,<xsl:value-of select="0.202*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.066*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.552*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.184*number($cloud.width)"/>,<xsl:value-of select="0.23*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="arrow='rb'">
						M<xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.198*number($cloud.width)"/>,<xsl:value-of select="0.248*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.608*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.128*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.9*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.316*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.183*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.854*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.744*number($cloud.height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($cloud.x0) + 0.84*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.86*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.178*number($cloud.width)"/>,<xsl:value-of select="0.222*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.562*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.91*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.182*number($cloud.width)"/>,<xsl:value-of select="0.232*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.252*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.862*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.161*number($cloud.width)"/>,<xsl:value-of select="0.202*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.066*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.552*number($cloud.height)"/><xsl:text> </xsl:text>
						A<xsl:value-of select="0.184*number($cloud.width)"/>,<xsl:value-of select="0.23*number($cloud.height)"/><xsl:text> </xsl:text>0<xsl:text> </xsl:text>0,1<xsl:text> </xsl:text><xsl:value-of select="number($cloud.x0) + 0.247*number($cloud.width)"/>,<xsl:value-of select="number($cloud.y0) + 0.165*number($cloud.height)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="shape='polygon'">
				<xsl:choose>
					<xsl:when test="polygon_type='4'">
						M<xsl:value-of select="number($main.x0) + 0.5*number($width)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + 0.5*number($width)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height)"/>
						Z
					</xsl:when>
					<xsl:when test="polygon_type='5'">
						M<xsl:value-of select="number($main.x0) + 0.5*number($width)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.417*number($height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + 0.7915*number($width)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + 0.2085*number($width)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.417*number($height)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="polygon_type='6'">
						M<xsl:value-of select="number($main.x0) + 0.2917*number($width)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + 0.7083*number($width)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + 0.7083*number($width)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + 0.2917*number($width)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.5*number($height)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
					<xsl:when test="polygon_type='8'">
						M<xsl:value-of select="number($main.x0) + 0.25*number($width)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + 0.75*number($width)"/>,<xsl:value-of select="number($main.y0) + number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.25*number($height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($width) - number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.75*number($height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + 0.75*number($width)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + 0.25*number($width)"/>,<xsl:value-of select="number($main.y0) + number($height) - number($main.halfborderwidth)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.75*number($height)"/><xsl:text> </xsl:text>
						L<xsl:value-of select="number($main.x0) + number($main.halfborderwidth)"/>,<xsl:value-of select="number($main.y0) + 0.25*number($height)"/><xsl:text> </xsl:text>
						Z
					</xsl:when>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.glow_path" select="$main.path"/>

	<xsl:variable name="css-cl-btn-container">position: absolute; left: -<xsl:value-of select="$main.x0"/>px; top: -<xsl:value-of select="$main.y0"/>px; width: <xsl:value-of select="$main.width"/>px; height: <xsl:value-of select="$main.height"/>px;</xsl:variable>
	<xsl:variable name="css-cl-btn-svg">position: absolute; width: <xsl:value-of select="$main.width"/>px; height: <xsl:value-of select="$main.height"/>px;</xsl:variable>
	<xsl:variable name="css-cl-btn-shape"><xsl:if test="shadow_strength!='none'">filter: url('#<xsl:value-of select="$objectID"/>_<xsl:value-of select="$currentState"/>_SHADOW');</xsl:if> <xsl:choose><xsl:when test="bg_type='transparent'">fill: none;</xsl:when><xsl:when test="bg_type='gradient'">fill: url('#<xsl:value-of select="$objectID"/>_<xsl:value-of select="$currentState"/>_GRADIENT');</xsl:when><xsl:when test="bg_type='image'">fill: url('#<xsl:value-of select="$objectID"/>_<xsl:value-of select="$currentState"/>_IMG'); fill-opacity: <xsl:value-of select="0.01*number(bg_img_opacity)"/>;</xsl:when><xsl:otherwise>fill: <xsl:value-of select="$bg-color-fixed"/>;</xsl:otherwise></xsl:choose>;  stroke: <xsl:choose><xsl:when test="border_style='none'">none</xsl:when><xsl:otherwise><xsl:value-of select="$border-color-fixed"/></xsl:otherwise></xsl:choose>; stroke-width: <xsl:value-of select="border_width"/>px; <xsl:choose><xsl:when test="border_style='dotted'">stroke-dasharray: <xsl:value-of select="border_width"/>,<xsl:value-of select="border_width"/>;</xsl:when><xsl:when test="border_style='dashed'">stroke-dasharray: <xsl:value-of select="3*number(border_width)"/>,<xsl:value-of select="border_width"/>;</xsl:when></xsl:choose></xsl:variable>
	<xsl:variable name="css-cl-btn-glow"><xsl:if test="glow!='none'">filter: url('#<xsl:value-of select="$objectID"/>_<xsl:value-of select="$currentState"/>_GLOW');</xsl:if> fill: <xsl:choose><xsl:when test="bg_type='transparent' or bg_type='image'">none</xsl:when><xsl:otherwise><xsl:value-of select="$glow-color-fixed"/></xsl:otherwise></xsl:choose>;  stroke: <xsl:choose><xsl:when test="border_style='none'">2px</xsl:when><xsl:otherwise><xsl:value-of select="$glow-color-fixed"/></xsl:otherwise></xsl:choose>; stroke-width: <xsl:value-of select="number(border_width) + 2"/>px; <xsl:choose><xsl:when test="border_style='dotted'">stroke-dasharray: <xsl:value-of select="border_width"/>,<xsl:value-of select="border_width"/>;</xsl:when><xsl:when test="border_style='dashed'">stroke-dasharray: <xsl:value-of select="3*number(border_width)"/>,<xsl:value-of select="border_width"/>;</xsl:when></xsl:choose></xsl:variable>
	<xsl:variable name="css-cl-btn-text-container">left: <xsl:value-of select="$main.text.x1"/>px; top: <xsl:value-of select="$main.text.y1"/>px; width: <xsl:value-of select="$main.text.w"/>px; height: <xsl:value-of select="$main.text.h"/>px;</xsl:variable>
	<xsl:variable name="css-cl-btn-text">padding: <xsl:value-of select="text_margin_top"/>px <xsl:value-of select="text_margin_right"/>px <xsl:value-of select="text_margin_bottom"/>px <xsl:value-of select="text_margin_left"/>px; vertical-align: <xsl:value-of select="$txt.valign"/>; text-align: <xsl:value-of select="$txt.align"/>; width: <xsl:value-of select="number($main.text.w) - number(text_margin_left) - number(text_margin_right)"/>px; height: <xsl:value-of select="number($main.text.h) - number(text_margin_top) - number(text_margin_bottom)"/>px; <xsl:value-of select="$_css_font"/> <xsl:value-of select="$_css_onimg_bg"/></xsl:variable>
	<xsl:variable name="css-cl-btn-event-svg">width: <xsl:value-of select="$main.width"/>px; height: <xsl:value-of select="$main.height"/>px;</xsl:variable>
	<xsl:variable name="css-cl-btn-event-shape">stroke-width: <xsl:value-of select="border_width"/>px;</xsl:variable>

		<div>
			<xsl:attribute name="class">cl-container</xsl:attribute>
			<div>
				<xsl:attribute name="class">cl-btn-container</xsl:attribute>
			<xsl:attribute name="style"><xsl:value-of select="$css-cl-btn-container"/></xsl:attribute>
				<svg>
					<xsl:attribute name="class">cl-btn-svg</xsl:attribute>
				<xsl:attribute name="style"><xsl:value-of select="$css-cl-btn-svg"/></xsl:attribute>
					<xsl:attribute name="viewBox">0 0 <xsl:value-of select="$main.width"/><xsl:text> </xsl:text><xsl:value-of select="$main.height"/></xsl:attribute>
					<g>
						<defs>
							<xsl:if test="bg_type='gradient'">
								<xsl:choose>
									<xsl:when test="gradient_type='linear'">
										<xsl:variable name="grad.tan" select="websoft:tan(number(gradient_angle))"/>
										<xsl:variable name="grad.ctan" select="websoft:cotan(number(gradient_angle))"/>
										<xsl:variable name="grad.x1">
											<xsl:choose>
												<xsl:when test="number(gradient_angle)=0 or number(gradient_angle)=180">50</xsl:when>
												<xsl:when test="number(gradient_angle) &gt;= 45 and number(gradient_angle) &lt;= 135">0</xsl:when>
												<xsl:when test="number(gradient_angle) &gt;= 225 and number(gradient_angle) &lt;= 315">100</xsl:when>
												<xsl:when test="(number(gradient_angle) &gt; 0 and number(gradient_angle) &lt; 45) or number(gradient_angle) &gt; 315"><xsl:value-of select="50*(1 - number($grad.tan))"/></xsl:when>
												<xsl:when test="number(gradient_angle) &gt; 135 and number(gradient_angle) &lt; 225"><xsl:value-of select="50*(1 + number($grad.tan))"/></xsl:when>
												<xsl:otherwise>0</xsl:otherwise>
											</xsl:choose>
										</xsl:variable>
										<xsl:variable name="grad.y1">
											<xsl:choose>
												<xsl:when test="number(gradient_angle)=90 or number(gradient_angle)=270">50</xsl:when>
												<xsl:when test="number(gradient_angle) &gt; 45 and number(gradient_angle) &lt; 135"><xsl:value-of select="50*(1 + number($grad.ctan))"/></xsl:when>
												<xsl:when test="number(gradient_angle) &gt; 225 and number(gradient_angle) &lt; 315"><xsl:value-of select="50*(1 - number($grad.ctan))"/></xsl:when>
												<xsl:when test="(number(gradient_angle) &gt;= 0 and number(gradient_angle) &lt;= 45) or number(gradient_angle) &gt;= 315">100</xsl:when>
												<xsl:when test="number(gradient_angle) &gt;= 135 and number(gradient_angle) &lt;= 225">0</xsl:when>
												<xsl:otherwise>100</xsl:otherwise>
											</xsl:choose>
										</xsl:variable>
										<xsl:variable name="grad.x2">
											<xsl:choose>
												<xsl:when test="number(gradient_angle)=0 or number(gradient_angle)=180">50</xsl:when>
												<xsl:when test="number(gradient_angle) &gt;= 45 and number(gradient_angle) &lt;= 135">100</xsl:when>
												<xsl:when test="number(gradient_angle) &gt;= 225 and number(gradient_angle) &lt;= 315">0</xsl:when>
												<xsl:when test="(number(gradient_angle) &gt; 0 and number(gradient_angle) &lt; 45) or number(gradient_angle) &gt; 315"><xsl:value-of select="50*(1 + number($grad.tan))"/></xsl:when>
												<xsl:when test="number(gradient_angle) &gt; 135 and number(gradient_angle) &lt; 225"><xsl:value-of select="50*(1 - number($grad.tan))"/></xsl:when>
												<xsl:otherwise>100</xsl:otherwise>
											</xsl:choose>
										</xsl:variable>
										<xsl:variable name="grad.y2">
											<xsl:choose>
												<xsl:when test="number(gradient_angle)=90 or number(gradient_angle)=270">50</xsl:when>
												<xsl:when test="number(gradient_angle) &gt; 45 and number(gradient_angle) &lt; 135"><xsl:value-of select="50*(1 - number($grad.ctan))"/></xsl:when>
												<xsl:when test="number(gradient_angle) &gt; 225 and number(gradient_angle) &lt; 315"><xsl:value-of select="50*(1 + number($grad.ctan))"/></xsl:when>
												<xsl:when test="(number(gradient_angle) &gt;= 0 and number(gradient_angle) &lt;= 45) or number(gradient_angle) &gt;= 315">0</xsl:when>
												<xsl:when test="number(gradient_angle) &gt;= 135 and number(gradient_angle) &lt;= 225">100</xsl:when>
												<xsl:otherwise>100</xsl:otherwise>
											</xsl:choose>
										</xsl:variable>
										<linearGradient>
											<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_<xsl:value-of select="$currentState"/>_GRADIENT</xsl:attribute>
											<xsl:attribute name="x1"><xsl:value-of select="$grad.x1"/>%</xsl:attribute>
											<xsl:attribute name="y1"><xsl:value-of select="$grad.y1"/>%</xsl:attribute>
											<xsl:attribute name="x2"><xsl:value-of select="$grad.x2"/>%</xsl:attribute>
											<xsl:attribute name="y2"><xsl:value-of select="$grad.y2"/>%</xsl:attribute>
											<xsl:attribute name="spreadMethod">pad</xsl:attribute>
											<stop>
												<xsl:attribute name="offset">10%</xsl:attribute>
												<xsl:attribute name="stop-color"><xsl:value-of select="$bg-color-fixed"/></xsl:attribute>
												<xsl:attribute name="stop-opacity">1</xsl:attribute>
											</stop>
											<stop>
												<xsl:attribute name="offset">90%</xsl:attribute>
												<xsl:attribute name="stop-color"><xsl:value-of select="$gradient-color-fixed"/></xsl:attribute>
												<xsl:attribute name="stop-opacity">1</xsl:attribute>
											</stop>
										</linearGradient>
									</xsl:when>
									<xsl:when test="gradient_type='radial'">
										<radialGradient>
											<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_<xsl:value-of select="$currentState"/>_GRADIENT</xsl:attribute>
											<xsl:attribute name="cx"><xsl:value-of select="$main.radial.cx"/>%</xsl:attribute>
											<xsl:attribute name="cy"><xsl:value-of select="$main.radial.cy"/>%</xsl:attribute>
											<xsl:attribute name="fx"><xsl:value-of select="$main.radial.cx"/>%</xsl:attribute>
											<xsl:attribute name="fy"><xsl:value-of select="$main.radial.cy"/>%</xsl:attribute>
											<xsl:attribute name="r">50%</xsl:attribute>
											<xsl:attribute name="spreadMethod">pad</xsl:attribute>
											<stop>
												<xsl:attribute name="offset">1%</xsl:attribute>
												<xsl:attribute name="stop-color"><xsl:value-of select="$bg-color-fixed"/></xsl:attribute>
												<xsl:attribute name="stop-opacity">1</xsl:attribute>
											</stop>
											<stop>
												<xsl:attribute name="offset">99%</xsl:attribute>
												<xsl:attribute name="stop-color"><xsl:value-of select="$gradient-color-fixed"/></xsl:attribute>
												<xsl:attribute name="stop-opacity">1</xsl:attribute>
											</stop>
										</radialGradient>
									</xsl:when>
								</xsl:choose>
							</xsl:if>
							<xsl:if test="bg_type='image'">
								<pattern>
									<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_<xsl:value-of select="$currentState"/>_IMG</xsl:attribute>
									<xsl:attribute name="patternUnits">userSpaceOnUse</xsl:attribute>
									<xsl:attribute name="width">100%</xsl:attribute>
									<xsl:attribute name="height">100%</xsl:attribute>
									<image>
										<xsl:attribute name="xlink:href"><xsl:if test="$bDesign='yes'">file:///<xsl:value-of select="translate(substring-before($moduleImagesFolder,'images\'),'\','/')"/></xsl:if><xsl:value-of select="bg_img"/></xsl:attribute>
										<xsl:attribute name="x">0</xsl:attribute>
										<xsl:attribute name="y">0</xsl:attribute>
										<xsl:attribute name="width">100%</xsl:attribute>
										<xsl:attribute name="height">100%</xsl:attribute>
										<xsl:attribute name="preserveAspectRatio">none</xsl:attribute>
									</image>
								</pattern>
							</xsl:if>
							<xsl:if test="shadow_strength!='none'">
								<xsl:variable name="shadow.offset">
									<xsl:choose>
										<xsl:when test="number($width) &gt; number($height)"><xsl:value-of select="0.01*number($height)"/></xsl:when>
										<xsl:otherwise><xsl:value-of select="0.01*number($width)"/></xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:variable name="shadow.dev">
									<xsl:choose>
										<xsl:when test="shadow_strength='extralight'">2</xsl:when>
										<xsl:when test="shadow_strength='light'">2</xsl:when>
										<xsl:when test="shadow_strength='normal'">3</xsl:when>
										<xsl:when test="shadow_strength='dark'">4</xsl:when>
										<xsl:when test="shadow_strength='extradark'">5</xsl:when>
									</xsl:choose>
								</xsl:variable>
								<xsl:variable name="shadow.opacity">
									<xsl:choose>
										<xsl:when test="shadow_strength='extralight'">0.2</xsl:when>
										<xsl:when test="shadow_strength='light'">0.4</xsl:when>
										<xsl:when test="shadow_strength='normal'">0.6</xsl:when>
										<xsl:when test="shadow_strength='dark'">0.75</xsl:when>
										<xsl:when test="shadow_strength='extradark'">0.9</xsl:when>
									</xsl:choose>
								</xsl:variable>
								<filter>
									<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_<xsl:value-of select="$currentState"/>_SHADOW</xsl:attribute>
									<feOffset>
										<xsl:attribute name="in">SourceAlpha</xsl:attribute>
										<xsl:attribute name="dx"><xsl:value-of select="$shadow.offset"/></xsl:attribute>
										<xsl:attribute name="dy"><xsl:value-of select="$shadow.offset"/></xsl:attribute>
										<xsl:attribute name="result"><xsl:value-of select="$objectID"/>_<xsl:value-of select="$currentState"/>_OFFSET</xsl:attribute>
									</feOffset>
									<feGaussianBlur>
										<xsl:attribute name="in"><xsl:value-of select="$objectID"/>_<xsl:value-of select="$currentState"/>_OFFSET</xsl:attribute>
										<xsl:attribute name="stdDeviation"><xsl:value-of select="$shadow.dev"/></xsl:attribute>
										<xsl:attribute name="result"><xsl:value-of select="$objectID"/>_<xsl:value-of select="$currentState"/>_BLUR</xsl:attribute>
									</feGaussianBlur>
									<feComponentTransfer>
										<feFuncA>
											<xsl:attribute name="type">linear</xsl:attribute>
											<xsl:attribute name="slope"><xsl:value-of select="$shadow.opacity"/></xsl:attribute>
										</feFuncA>
									</feComponentTransfer>
									<feMerge>
										<feMergeNode/>
										<feMergeNode in="SourceGraphic"/>
									</feMerge>
									<feBlend>
										<xsl:attribute name="in">SourceGraphic</xsl:attribute>
										<xsl:attribute name="x">-10%</xsl:attribute>
										<xsl:attribute name="y">-10%</xsl:attribute>
										<xsl:attribute name="width">120%</xsl:attribute>
										<xsl:attribute name="height">120%</xsl:attribute>
									</feBlend>
								</filter>
							</xsl:if>
							<xsl:if test="glow!='none'">
								<xsl:variable name="glow.stdev">
									<xsl:choose>
										<xsl:when test="glow='light'">2</xsl:when>
										<xsl:when test="glow='dark'">6</xsl:when>
										<xsl:otherwise>4</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<filter>
									<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_<xsl:value-of select="$currentState"/>_GLOW</xsl:attribute>
									<feGaussianBlur>
										<xsl:attribute name="in">SourceGraphic</xsl:attribute>
										<xsl:attribute name="stdDeviation"><xsl:value-of select="$glow.stdev"/></xsl:attribute>
									</feGaussianBlur>
								</filter>
							</xsl:if>
						</defs>
						<xsl:if test="glow!='none'">
							<path>
								<xsl:attribute name="class">cl-btn-glow</xsl:attribute>
							<xsl:attribute name="style"><xsl:value-of select="$css-cl-btn-glow"/></xsl:attribute>
								<xsl:attribute name="d"><xsl:value-of select="$main.glow_path"/></xsl:attribute>
							</path>
						</xsl:if>
						<path>
							<xsl:attribute name="class">cl-btn-shape</xsl:attribute>
						<xsl:attribute name="style"><xsl:value-of select="$css-cl-btn-shape"/></xsl:attribute>
							<xsl:attribute name="d"><xsl:value-of select="$main.path"/></xsl:attribute>
						</path>
					</g>
				</svg>
				<div>
					<xsl:attribute name="class">cl-btn-text-container unselectable</xsl:attribute>
				<xsl:attribute name="style"><xsl:value-of select="$css-cl-btn-text-container"/></xsl:attribute>
					<table>
						<xsl:attribute name="class">cl-btn-text-table</xsl:attribute>
						<tr>
							<td>
								<xsl:attribute name="class">cl-btn-text</xsl:attribute>
							<xsl:attribute name="style"><xsl:value-of select="$css-cl-btn-text"/></xsl:attribute>
								<xsl:choose>
									<xsl:when test="content='html'"><xsl:value-of select="text_main" disable-output-escaping="yes"/></xsl:when>
									<xsl:when test="content='image'">&#160;</xsl:when>
									<xsl:otherwise><xsl:value-of select="text_plain"/></xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
					</table>
				</div>

				<svg>
					<xsl:attribute name="class">cl-btn-event-svg</xsl:attribute>
				<xsl:attribute name="style"><xsl:value-of select="$css-cl-btn-event-svg"/></xsl:attribute>
					<xsl:attribute name="viewBox">0 0 <xsl:value-of select="$main.width"/><xsl:text> </xsl:text><xsl:value-of select="$main.height"/></xsl:attribute>
					<path>
						<xsl:attribute name="class">cl-btn-event-shape</xsl:attribute>
					<xsl:attribute name="style"><xsl:value-of select="$css-cl-btn-event-shape"/></xsl:attribute>
						<xsl:attribute name="d"><xsl:value-of select="$main.path"/></xsl:attribute>
					</path>
				</svg>
			</div>
		</div>

</xsl:template>

<!-- COMMON TEMPLATES -->
<xsl:template name="shadow_builder">
	<xsl:param name="sType"/>
	<xsl:param name="sStrength"/>
	<xsl:param name="sColor"/>
	<xsl:param name="sOpacity"/>
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
</xsl:template>
<xsl:template match="*" name="font_selector">
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
