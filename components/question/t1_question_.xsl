<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:websoft="http://www.websoft.ru"
				version="1.0">
<!--
'*	q_0000#.xsl
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

	<xsl:variable name="_bDesign">yes</xsl:variable>

	<xsl:call-template name="styles">
		<xsl:with-param name="bDesign" select="$_bDesign"/>
	</xsl:call-template>

	<div class="clo-q_0000">
		<xsl:call-template name="question-main">
			<xsl:with-param name="bDesign" select="$_bDesign"/>
		</xsl:call-template>
	</div>
</xsl:template>
<xsl:template name="styles">
	<xsl:param name="bDesign"/>

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
	<xsl:variable name="base-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="base_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="timer-color-1-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="timer_color_1"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="timer-color-2-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="timer_color_2"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="timer-color-3-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="timer_color_3"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="spot-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="spot_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="font-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="font_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="q-fb-correct-color-bg-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="q_fb_correct_color_bg"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="q-fb-correct-color-border-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="q_fb_correct_color_border"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="q-fb-correct-color-close-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="q_fb_correct_color_close"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="q-fb-incorrect-color-bg-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="q_fb_incorrect_color_bg"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="q-fb-incorrect-color-border-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="q_fb_incorrect_color_border"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="q-fb-incorrect-color-close-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="q_fb_incorrect_color_close"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="q-fb-lastattempt-color-bg-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="q_fb_lastattempt_color_bg"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="q-fb-lastattempt-color-border-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="q_fb_lastattempt_color_border"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="q-fb-lastattempt-color-close-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="q_fb_lastattempt_color_close"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="q-fb-exceed-color-bg-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="q_fb_exceed_color_bg"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="q-fb-exceed-color-border-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="q_fb_exceed_color_border"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="q-fb-exceed-color-close-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="q_fb_exceed_color_close"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="q-fb-timeout-color-bg-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="q_fb_timeout_color_bg"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="q-fb-timeout-color-border-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="q_fb_timeout_color_border"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="q-fb-timeout-color-close-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="q_fb_timeout_color_close"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="button-bg-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="button_bg_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="button-bg-color-over-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="button_bg_color_over"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="button-border-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="button_border_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="button-border-color-over-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="button_border_color_over"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="button-font-color-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="button_font_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="button-font-color-over-fixed">
		<xsl:call-template name="fix-color">
			<xsl:with-param name="color" select="button_font_color_over"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="_shadow_string">
		<xsl:choose>
			<xsl:when test="shadow_strength='extralight'">2px 2px 6px #ccc</xsl:when>
			<xsl:when test="shadow_strength='light'">2px 2px 6px #999</xsl:when>
			<xsl:when test="shadow_strength='normal'">2px 2px 6px #666</xsl:when>
			<xsl:when test="shadow_strength='dark'">2px 2px 6px #333</xsl:when>
			<xsl:when test="shadow_strength='extradark'">2px 2px 6px #000</xsl:when>
			<xsl:otherwise>2px 2px 6px #666</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="_fill_color" select="$bg-color-fixed"/>
	<xsl:variable name="_gradient_color">
		<xsl:call-template name="autogradient">
			<xsl:with-param name="color.base" select="$_fill_color"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="_font_color">
		<xsl:choose>
			<xsl:when test="font_color_switch='yes'"><xsl:value-of select="$font-color-fixed"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$border-color-fixed"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="_border_gradient_color">
		<xsl:call-template name="autogradient">
			<xsl:with-param name="color.base" select="$border-color-fixed"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="main.sSpotColor">
		<xsl:choose>
			<xsl:when test="spot_color_switch='yes'"><xsl:value-of select="$spot-color-fixed"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$border-color-fixed"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="_spot_gradient_color">
		<xsl:call-template name="autogradient">
			<xsl:with-param name="color.base" select="$main.sSpotColor"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="_timer_gradient_color">
		<xsl:call-template name="autogradient">
			<xsl:with-param name="color.base" select="$timer-color-1-fixed"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="_btn_gradient_color">
		<xsl:call-template name="autogradient">
			<xsl:with-param name="color.base" select="$button-bg-color-fixed"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="_basic_font_family">
		<xsl:choose>
			<xsl:when test="basic_font='custom'"><xsl:value-of select="basic_font_custom"/></xsl:when>
			<xsl:otherwise><xsl:call-template name="font_selector"><xsl:with-param name="sFontID" select="basic_font"/></xsl:call-template></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="_button_font_family">
		<xsl:choose>
			<xsl:when test="q_custombutton='yes' and q_button_type='HTML'">
				<xsl:choose>
					<xsl:when test="button_font='custom'"><xsl:value-of select="button_font_custom"/></xsl:when>
					<xsl:otherwise><xsl:call-template name="font_selector"><xsl:with-param name="sFontID" select="button_font"/></xsl:call-template></xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="$_basic_font_family"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="_css_timer_gradient">background-image: linear-gradient(0deg, <xsl:value-of select="$timer-color-1-fixed"/>, <xsl:value-of select="$_spot_gradient_color"/>);</xsl:variable>
	<xsl:variable name="_css_btn_gradient">background-image: linear-gradient(0deg, <xsl:value-of select="$button-bg-color-fixed"/>, <xsl:value-of select="$_btn_gradient_color"/>);</xsl:variable>
	<xsl:variable name="main.fb_left">
		<xsl:choose>
			<xsl:when test="q_fb_position='yes'"><xsl:value-of select="q_fb_left"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="round(0.5*(100-number(q_fb_box_width)))"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="main.fb_top">
		<xsl:choose>
			<xsl:when test="q_fb_position='yes'"><xsl:value-of select="q_fb_top"/></xsl:when>
			<xsl:otherwise>30</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<style>
		.cl-container { width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px; }
		.cl-q-credit { font-family: <xsl:value-of select="$_basic_font_family"/>; color: <xsl:value-of select="$_font_color"/>; }
		.cl-q-question-goal { font-family: <xsl:value-of select="$_basic_font_family"/>; color: <xsl:value-of select="$_font_color"/>; }
		.cl-q-area { background-color: <xsl:value-of select="$base-color-fixed"/>; }
		.cl-q-question-txt { font-family: <xsl:value-of select="$_basic_font_family"/>; color: <xsl:value-of select="$_font_color"/>; background-color: <xsl:value-of select="$_fill_color"/>;  }
		.cl-q-vars { font-family: <xsl:value-of select="$_basic_font_family"/>; background-color: <xsl:value-of select="$base-color-fixed"/>; color: <xsl:value-of select="$_font_color"/>; }
		.cl-q-timer { font-family: <xsl:value-of select="$_basic_font_family"/>; color: <xsl:value-of select="$_font_color"/>; }
		.cl-q-timer-indicator { background-color: <xsl:value-of select="$timer-color-1-fixed"/>; }
		.cl-q-manager { font-family: <xsl:value-of select="$_basic_font_family"/>; color: <xsl:value-of select="$_font_color"/>; }
		.cl-btn-cell { font-family: <xsl:value-of select="$_button_font_family"/>; }
		.cl-btn-html { width: <xsl:value-of select="q_button_width"/>px; height: <xsl:value-of select="q_button_height"/>px; border-style: <xsl:value-of select="button_border_style"/>; border-width: <xsl:value-of select="button_border_width"/>px; border-color: <xsl:value-of select="$button-border-color-fixed"/>; <xsl:if test="number(button_radius)!=0">border-radius: <xsl:value-of select="button_radius"/>px;</xsl:if> background-color: <xsl:value-of select="$button-bg-color-fixed"/>; font-family: <xsl:value-of select="$_button_font_family"/>; font-size: <xsl:value-of select="button_font_size"/>px; <xsl:if test="button_font_style='italc' or button_font_style='bolditalic'">font-style: italic;</xsl:if><xsl:if test="button_font_style='bold' or button_font_style='bolditalic'">font-weight: bold;</xsl:if> color: <xsl:value-of select="$button-font-color-fixed"/>; text-align: <xsl:value-of select="button_text_align"/>; <xsl:value-of select="$_css_btn_gradient"/>  }
		.cl-q-feedback { width: <xsl:value-of select="q_fb_box_width"/>%; left: <xsl:value-of select="$main.fb_left"/>%; top: <xsl:value-of select="$main.fb_top"/>%; padding: 15px; border-style: solid; border-width: 1px ; box-shadow: <xsl:value-of select="$_shadow_string"/>; }
		.cl-q-feedback-correct { background-color: <xsl:value-of select="$q-fb-correct-color-bg-fixed"/>; border-color: <xsl:value-of select="$q-fb-correct-color-border-fixed"/>; color: <xsl:value-of select="$q-fb-correct-color-close-fixed"/>; }
		.cl-q-feedback-lastattempt { background-color: <xsl:value-of select="$q-fb-lastattempt-color-bg-fixed"/>; border-color: <xsl:value-of select="$q-fb-lastattempt-color-border-fixed"/>; color: <xsl:value-of select="$q-fb-lastattempt-color-close-fixed"/>; }
		.cl-q-feedback-incorrect { background-color: <xsl:value-of select="$q-fb-incorrect-color-bg-fixed"/>; border-color: <xsl:value-of select="$q-fb-incorrect-color-border-fixed"/>; color: <xsl:value-of select="$q-fb-incorrect-color-close-fixed"/>; }
		.cl-q-feedback-exceed { background-color: <xsl:value-of select="$q-fb-exceed-color-bg-fixed"/>; border-color: <xsl:value-of select="$q-fb-exceed-color-border-fixed"/>; color: <xsl:value-of select="q-fb-exceed-color-close-fixed"/>; }
		.cl-q-feedback-timeout { background-color: <xsl:value-of select="$q-fb-timeout-color-bg-fixed"/>; border-color: <xsl:value-of select="$q-fb-timeout-color-border-fixed"/>; color: <xsl:value-of select="$q-fb-timeout-color-close-fixed"/>; }
		.cl-q-feedback-btn { font-family: <xsl:value-of select="$_basic_font_family"/>; font-size: 24px; }
		<xsl:if test="q_img!='none'">
			.cl-q-img-cell { width: <xsl:value-of select="0.01*number(q_img_width)*(number($width)-30) + 10"/>px; }
			.cl-q-img-container { width: <xsl:value-of select="0.01*number(q_img_width)*(number($width)-30)"/>px; }
			.cl-q-img { width: <xsl:value-of select="0.01*number(q_img_width)*(number($width)-30)"/>px; }
		</xsl:if>
		<xsl:choose>
			<xsl:when test="question_type='true-false'">
				.cl-var-true-false .cl-spot { position: relative; width: 20px; height: 20px; vertical-align: top; box-sizing: border-box; border-style: solid; border-color: <xsl:value-of select="$main.sSpotColor"/>; border-radius: 50%; }
				.cl-var-selected .cl-var-true-false .cl-spot-point { position: relative; background-color: <xsl:value-of select="$main.sSpotColor"/>; border-radius: 50%; }
			</xsl:when>
			<xsl:when test="question_type='choice'">
				.cl-var-choice .cl-spot { width: 20px; height: 20px; vertical-align: top; box-sizing: border-box; border-style: solid; border-color: <xsl:value-of select="$main.sSpotColor"/>; border-radius: 50%; }
				.cl-var-selected .cl-var-choice .cl-spot-point { position: relative; background-color: <xsl:value-of select="$main.sSpotColor"/>; border-radius: 50%; }
			</xsl:when>
			<xsl:when test="question_type='select'">
				.cl-var-select .cl-spot { width: 18px; height: 18px; vertical-align: top; box-sizing: border-box; border-style: solid; border-color: <xsl:value-of select="$main.sSpotColor"/>; }
				.cl-var-select .cl-inner-part { text-align: center; fill: <xsl:value-of select="$main.sSpotColor"/>; }
			</xsl:when>
			<xsl:when test="question_type='order'"></xsl:when>
			<xsl:when test="question_type='numeric'">
				.cl-var-numeric .cl-var-input { width: 100px; height: 30px; text-align: left; padding: 2px; font-family: <xsl:value-of select="$_basic_font_family"/>; font-size: 12px; color: <xsl:value-of select="$_font_color"/>; border-style: solid; border-color: <xsl:value-of select="$main.sSpotColor"/>; }
			</xsl:when>
			<xsl:when test="question_type='fib'">
				.cl-var-fib .cl-var-input { width: 200px; height: 30px; text-align: left; padding: 2px; font-family: <xsl:value-of select="$_basic_font_family"/>; font-size: 12px; color: <xsl:value-of select="$_font_color"/>; border-style: solid; border-color: <xsl:value-of select="$main.sSpotColor"/>; }
			</xsl:when>
			<xsl:when test="question_type='oto'">
				.cl-oto-connector { width: 40px; min-width: 40px; height: 1px; overflow: hidden; background-color: <xsl:value-of select="$main.sSpotColor"/>; }
				.cl-oto-table .cl-left-part { width: <xsl:value-of select="q_base_width"/>%; }
				.cl-oto-table .cl-right-part { width: <xsl:value-of select="100-number(q_base_width)"/>%; }
				.cl-var-target { padding: <xsl:value-of select="q_base_padding"/>px; font-family: <xsl:value-of select="$_basic_font_family"/>; color: <xsl:value-of select="$_font_color"/>; border-color: <xsl:value-of select="$main.sSpotColor"/>; }
				.cl-var-bullet { padding: <xsl:value-of select="q_base_padding"/>px; font-family: <xsl:value-of select="$_basic_font_family"/>; color: <xsl:value-of select="$_font_color"/>; border-color: <xsl:value-of select="$main.sSpotColor"/>; }
			</xsl:when>
			<xsl:when test="question_type='otm'">
				.cl-otm-table { width: 100%; border-spacing: 0; }
				.cl-otm-table .cl-left-part { width: 50%; }
				.cl-otm-table .cl-center-part { width: 40px; min-width: 40px; }
				.cl-otm-table .cl-right-part { width: 50%; }
				.cl-otm-table .cl-var-target { position: relative; margin: 2.5px 0; font-family: <xsl:value-of select="$_basic_font_family"/>; color: <xsl:value-of select="$_font_color"/>; padding: 10px; border-style: solid; border-color: <xsl:value-of select="$main.sSpotColor"/>; }
				.cl-otm-table .cl-var-target-contacts { position: relative; margin: 0 0 -5px 0; padding: 5px 0 0 0; text-align: right; }
				.cl-otm-table .cl-var-target-contacts { position: relative; margin: 0 0 -5px 0; padding: 5px 0 0 0; text-align: right; }
				.cl-otm-table .cl-contacts-table { position: relative; margin: 0 0 0 auto; }
				.cl-otm-table .cl-contacts-table td { padding: 0 0 0 5px; }
				.cl-otm-table .cl-contact { width: 10px; height: 5px; background-color: <xsl:value-of select="$main.sSpotColor"/>; overflow: hidden; }
			</xsl:when>
			<xsl:when test="question_type='mtm'">
				.cl-mtm-table { width: 100%; border-spacing: 0; }
				.cl-mtm-table .cl-left-part { width: 50%; vertical-align: top; }
				.cl-mtm-table .cl-center-part { width: 40px; min-width: 40px; }
				.cl-mtm-table .cl-right-part { width: 50%; vertical-align:top; }
				.cl-mtm-table .cl-var-target { position: relative; margin: 2.5px 0; font-family: <xsl:value-of select="$_basic_font_family"/>; color: <xsl:value-of select="$_font_color"/>; padding: 10px; border-style: solid; border-color: <xsl:value-of select="$main.sSpotColor"/>; }
				.cl-mtm-table .cl-var-bullet { position: relative; margin: 2.5px 0; font-family: <xsl:value-of select="$_basic_font_family"/>; color: <xsl:value-of select="$_font_color"/>; padding: 10px; border-style: solid; border-color: <xsl:value-of select="$main.sSpotColor"/>; }
				.cl-mtm-table .cl-var-target-contacts { position: relative; margin: 0 0 -5px 0; padding: 5px 0 0 0; text-align: right; }
				.cl-mtm-table .cl-contacts-table { position: relative; margin: 0 0 0 auto; }
				.cl-mtm-table .cl-contacts-table td { padding: 0 0 0 5px; }
				.cl-mtm-table .cl-contact { width: 10px; height: 5px; background-color: <xsl:value-of select="$main.sSpotColor"/>; overflow: hidden; }
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="theme='light'">
				.cl-theme-light .cl-q-area { border: solid 1px <xsl:value-of select="$border-color-fixed"/>; border-radius: 5px; box-shadow: <xsl:value-of select="$_shadow_string"/>;}
				.cl-theme-light .cl-q-question-txt { padding: 15px; border-radius: 5px 5px 0 0; border-bottom: solid 1px <xsl:value-of select="$border-color-fixed"/>; background-image: linear-gradient(0deg, <xsl:value-of select="$_fill_color"/>, <xsl:value-of select="$_gradient_color"/>); }
				.cl-theme-light .cl-q-vars { padding: 15px; <xsl:if test="display_question_text!='yes'">border-radius: 5px 5px 0 0;</xsl:if> }
				.cl-theme-light .cl-q-timer { padding: 10px 15px; border-top: solid 1px <xsl:value-of select="$border-color-fixed"/>; }
				.cl-theme-light .cl-q-timer-box { border-color: <xsl:value-of select="$border-color-fixed"/>; border-radius: 5px; }
				.cl-theme-light .cl-q-timer-indicator { border-radius: 5px; <xsl:value-of select="$_css_timer_gradient"/> }
				.cl-theme-light .cl-q-manager { padding: 10px; border-top: solid 1px <xsl:value-of select="$border-color-fixed"/>; }
				.cl-theme-light .cl-btn-std { border-width: 1px; border-color: <xsl:value-of select="$border-color-fixed"/>; border-radius: 5px; background-color: <xsl:value-of select="$_fill_color"/>; background-image: linear-gradient(0deg, <xsl:value-of select="$_fill_color"/>, <xsl:value-of select="$_gradient_color"/>); }
				.cl-theme-light .cl-btn-std .cl-btn-cell { color: <xsl:value-of select="$border-color-fixed"/>; }
				.cl-theme-light .cl-q-feedback { border-radius: 5px; }
				<xsl:choose>
					<xsl:when test="question_type='true-false'">
						.cl-theme-light .cl-var-true-false .cl-spot { border-width: 1px; }
						.cl-theme-light .cl-var-selected .cl-var-true-false .cl-spot-point { margin: 5px auto; width: 8px; height: 8px; }
					</xsl:when>
					<xsl:when test="question_type='choice'">
						.cl-theme-light .cl-var-choice .cl-spot { border-width: 1px; }
						.cl-theme-light .cl-var-selected .cl-spot-point { margin: 5px auto; width: 8px; height:8px; }
					</xsl:when>
					<xsl:when test="question_type='select'">
						.cl-theme-light .cl-var-select .cl-spot { border-width: 1px; border-radius: 5px; }
					</xsl:when>
					<xsl:when test="question_type='order'">
						.cl-theme-light .cl-var-order .cl-inner-part { white-space: nowrap; line-height: 0; padding: 5px; font-family: <xsl:value-of select="$_basic_font_family"/>; font-size: 24px; font-weight: bold; color: <xsl:value-of select="$main.sSpotColor"/>; }
					</xsl:when>
					<xsl:when test="question_type='numeric'">
						.cl-theme-light .cl-var-numeric .cl-var-input { border-width: 1px; border-radius: 5px; }
					</xsl:when>
					<xsl:when test="question_type='fib'">
						.cl-theme-light .cl-var-fib .cl-var-input { border-width: 1px; border-radius: 5px; }
					</xsl:when>
					<xsl:when test="question_type='oto'">
						.cl-theme-light .cl-var-target { border-radius: 5px; border-width: 1px; background-color: <xsl:value-of select="$_fill_color"/>; background-image: linear-gradient(0deg, <xsl:value-of select="$_fill_color"/>, <xsl:value-of select="$_gradient_color"/>); }
						.cl-theme-light .cl-var-bullet { border-radius: 5px; border-width: 1px; background-color: <xsl:value-of select="$_fill_color"/>; background-image: linear-gradient(0deg, <xsl:value-of select="$_fill_color"/>, <xsl:value-of select="$_gradient_color"/>); }
					</xsl:when>
					<xsl:when test="question_type='otm'">
						.cl-theme-light .cl-otm-table .cl-var-target { border-radius: 5px; border-width: 1px; background-color: <xsl:value-of select="$_fill_color"/>; background-image: linear-gradient(0deg, <xsl:value-of select="$_fill_color"/>, <xsl:value-of select="$_gradient_color"/>); }
					</xsl:when>
					<xsl:when test="question_type='mtm'">
						.cl-theme-light .cl-mtm-table .cl-var-target { border-radius: 5px; border-width: 1px; background-color: <xsl:value-of select="$_fill_color"/>; background-image: linear-gradient(0deg, <xsl:value-of select="$_fill_color"/>, <xsl:value-of select="$_gradient_color"/>); }
						.cl-theme-light .cl-mtm-table .cl-var-bullet { border-radius: 5px; border-width: 1px; background-color: <xsl:value-of select="$_fill_color"/>; background-image: linear-gradient(0deg, <xsl:value-of select="$_fill_color"/>, <xsl:value-of select="$_gradient_color"/>); }
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="theme='simple'">
				.cl-theme-simple .cl-q-question-txt { padding: 10px; border: solid 2px <xsl:value-of select="$border-color-fixed"/>; }
				.cl-theme-simple .cl-q-vars { margin: 2px 0 0 0; padding: 0; }
				.cl-theme-simple .cl-q-timer { margin: 2px 0 0 0; padding: 5px 10px; border: solid 2px <xsl:value-of select="$bg-color-fixed"/>; background-color: <xsl:value-of select="$base-color-fixed"/>; }
				.cl-theme-simple .cl-q-timer-box { border-color: #666; background-color: #999; }
				.cl-theme-simple .cl-q-timer-indicator { <xsl:value-of select="$_css_timer_gradient"/> }
				.cl-theme-simple .cl-q-manager { margin: 2px 0 0 0; padding: 5px 10px; border: solid 2px <xsl:value-of select="$border-color-fixed"/>; background-color: <xsl:value-of select="$bg-color-fixed"/>;  }
				.cl-theme-simple .cl-btn-std { border-width: 2px; border-color: <xsl:value-of select="$border-color-fixed"/>; background-color: <xsl:value-of select="$_fill_color"/>; background-image: linear-gradient(0deg, <xsl:value-of select="$_fill_color"/>, <xsl:value-of select="$_gradient_color"/>); }
				.cl-theme-simple .cl-btn-std .cl-btn-cell { color: <xsl:value-of select="$border-color-fixed"/>; font-weight: bold; }
				<xsl:choose>
					<xsl:when test="question_type='true-false'">
						.cl-theme-simple .cl-var-true-false { margin: 2px 0 0 0; box-sizing: border-box; border: solid 2px <xsl:value-of select="$border-color-fixed"/>; background-color: <xsl:value-of select="$base-color-fixed"/>; padding: 5px;}
						.cl-theme-simple .cl-var-true-false .cl-spot { border-width: 2px; }
						.cl-theme-simple .cl-var-selected  .cl-var-true-false .cl-spot-point { margin: 3px auto; width: 10px; height:10px; background-image: linear-gradient(0deg, <xsl:value-of select="$main.sSpotColor"/>, <xsl:value-of select="$_spot_gradient_color"/>); }
					</xsl:when>
					<xsl:when test="question_type='choice'">
						.cl-theme-simple .cl-var-choice { margin: 2px 0 0 0; box-sizing: border-box; border: solid 2px <xsl:value-of select="$border-color-fixed"/>; background-color: <xsl:value-of select="$base-color-fixed"/>; padding: 5px;}
						.cl-theme-simple .cl-var-choice .cl-spot { border-width: 2px; }
						.cl-theme-simple .cl-var-selected .cl-spot-point { margin: 3px auto; width: 10px; height:10px; background-image: linear-gradient(0deg, <xsl:value-of select="$main.sSpotColor"/>, <xsl:value-of select="$_spot_gradient_color"/>); }
					</xsl:when>
					<xsl:when test="question_type='select'">
						.cl-theme-simple .cl-var-select { margin: 2px 0 0 0; box-sizing: border-box; border: solid 2px <xsl:value-of select="$border-color-fixed"/>; background-color: <xsl:value-of select="$base-color-fixed"/>; padding: 5px;}
						.cl-theme-simple .cl-var-select .cl-spot { border-width: 2px; }
					</xsl:when>
					<xsl:when test="question_type='order'">
						.cl-theme-simple .cl-var-order { margin: 2px 0 0 0; box-sizing: border-box; border: solid 2px <xsl:value-of select="$border-color-fixed"/>; background-color: <xsl:value-of select="$base-color-fixed"/>; padding: 5px;}
						.cl-theme-simple .cl-var-order .cl-inner-part { fill: <xsl:value-of select="$main.sSpotColor"/>; width: 20px; height: 10px;  }
					</xsl:when>
					<xsl:when test="question_type='numeric'">
						.cl-theme-simple .cl-var-numeric { margin: 2px 0 0 0; box-sizing: border-box; border: solid 2px <xsl:value-of select="$border-color-fixed"/>; background-color: <xsl:value-of select="$base-color-fixed"/>; padding: 5px;}
						.cl-theme-simple .cl-var-numeric .cl-var-input { border-width: 2px; }
					</xsl:when>
					<xsl:when test="question_type='fib'">
						.cl-theme-simple .cl-var-fib { margin: 2px 0 0 0; box-sizing: border-box; border: solid 2px <xsl:value-of select="$border-color-fixed"/>; background-color: <xsl:value-of select="$base-color-fixed"/>; padding: 5px;}
						.cl-theme-simple .cl-var-fib .cl-var-input { border-width: 2px; }
					</xsl:when>
					<xsl:when test="question_type='oto'">
						.cl-theme-simple .cl-var-target { border-width: 2px; background-color: <xsl:value-of select="$base-color-fixed"/>; }
						.cl-theme-simple .cl-var-bullet { border-width: 2px; background-color: <xsl:value-of select="$base-color-fixed"/>; }
					</xsl:when>
					<xsl:when test="question_type='otm'">
						.cl-theme-simple .cl-otm-table .cl-var-target { border-width: 2px; background-color: <xsl:value-of select="$base-color-fixed"/>; }
					</xsl:when>
					<xsl:when test="question_type='mtm'">
						.cl-theme-simple .cl-mtm-table .cl-var-target { border-width: 2px; background-color: <xsl:value-of select="$base-color-fixed"/>; }
						.cl-theme-simple .cl-mtm-table .cl-var-bullet { border-width: 2px; background-color: <xsl:value-of select="$base-color-fixed"/>; }
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="theme='standard'">
				.cl-theme-standard .cl-extra-wrapper { padding: 10px; border: solid 2px <xsl:value-of select="$border-color-fixed"/>; background-color: <xsl:value-of select="$base-color-fixed"/>; border-radius: 10px; box-shadow: <xsl:value-of select="$_shadow_string"/>; }
				.cl-theme-standard .cl-q-question-txt { padding: 15px; border: solid 1px <xsl:value-of select="$border-color-fixed"/>; border-radius: 5px; background-image: linear-gradient(0deg, <xsl:value-of select="$_fill_color"/>, <xsl:value-of select="$_gradient_color"/>); }
				.cl-theme-standard .cl-q-vars { padding: 0 0 15px 0; <xsl:if test="display_question_text!='yes'"> border-radius: 5px 5px 0 0;</xsl:if>  }
				.cl-theme-standard .cl-q-timer { padding: 10px 15px; text-align: center; border-top: dotted 1px <xsl:value-of select="$border-color-fixed"/>; }
				.cl-theme-standard .cl-q-timer-box { border-color: <xsl:value-of select="$border-color-fixed"/>; border-radius: 5px; }
				.cl-theme-standard .cl-q-timer-indicator { border-radius: 5px; <xsl:value-of select="$_css_timer_gradient"/> }
				.cl-theme-standard .cl-q-manager { padding: 10px; border-top: dotted 1px <xsl:value-of select="$border-color-fixed"/>;  }
				.cl-theme-standard .cl-btn-std { border-width: 1px; border-color: <xsl:value-of select="$border-color-fixed"/>; border-radius: 5px; background-color: <xsl:value-of select="$border-color-fixed"/>; background-image: linear-gradient(0deg, <xsl:value-of select="$border-color-fixed"/>, <xsl:value-of select="$_border_gradient_color"/>); border-radius: 5px; }
				.cl-theme-standard .cl-btn-std .cl-btn-cell { color: <xsl:value-of select="$base-color-fixed"/>; font-weight: bold; }
				.cl-theme-standard .cl-var { margin: 2.5px 0; }
				.cl-theme-standard .cl-q-feedback { border-radius: 5px; }
				<xsl:choose>
					<xsl:when test="question_type='true-false'">
						.cl-theme-standard .cl-var-true-false { font-family: <xsl:value-of select="$_basic_font_family"/>; color: <xsl:value-of select="$_font_color"/>; padding: 10px;
							border-radius: 5px; border: solid 1px <xsl:value-of select="$border-color-fixed"/>;
							background-color: <xsl:value-of select="$_fill_color"/>; background-image: linear-gradient(0deg, <xsl:value-of select="$_fill_color"/>, <xsl:value-of select="$_gradient_color"/>);
						}
						.cl-theme-standard .cl-var-true-false .cl-spot { border-width: 2px; background-color: <xsl:value-of select="$base-color-fixed"/>; }
						.cl-theme-standard .cl-var-selected .cl-var-true-false .cl-spot-point { margin: 3px auto; width: 10px; height:10px; background-image: linear-gradient(0deg, <xsl:value-of select="$main.sSpotColor"/>, <xsl:value-of select="$_spot_gradient_color"/>); }
					</xsl:when>
					<xsl:when test="question_type='choice'">
						.cl-theme-standard .cl-var-choice { font-family: <xsl:value-of select="$_basic_font_family"/>; color: <xsl:value-of select="$_font_color"/>; padding: 10px; border-radius: 5px; border: solid 1px <xsl:value-of select="$border-color-fixed"/>; background-color: <xsl:value-of select="$_fill_color"/>; background-image: linear-gradient(0deg, <xsl:value-of select="$_fill_color"/>, <xsl:value-of select="$_gradient_color"/>); }
						.cl-theme-standard .cl-var-choice .cl-spot { border-width: 2px; background-color: <xsl:value-of select="$base-color-fixed"/>; }
						.cl-theme-standard .cl-var-selected .cl-spot-point { margin: 3px auto; width: 10px; height:10px; background-image: linear-gradient(0deg, <xsl:value-of select="$main.sSpotColor"/>, <xsl:value-of select="$_spot_gradient_color"/>); }
					</xsl:when>
					<xsl:when test="question_type='select'">
						.cl-theme-standard .cl-var-select { font-family: <xsl:value-of select="$_basic_font_family"/>; color: <xsl:value-of select="$_font_color"/>; padding: 10px; border-radius: 5px; border: solid 1px <xsl:value-of select="$border-color-fixed"/>; background-color: <xsl:value-of select="$_fill_color"/>; background-image: linear-gradient(0deg, <xsl:value-of select="$_fill_color"/>, <xsl:value-of select="$_gradient_color"/>); }
						.cl-theme-standard .cl-var-select .cl-spot { border-width: 2px; background-color: <xsl:value-of select="$base-color-fixed"/>; }
					</xsl:when>
					<xsl:when test="question_type='order'">
						.cl-theme-standard .cl-var-order { font-family: <xsl:value-of select="$_basic_font_family"/>; color: <xsl:value-of select="$_font_color"/>; padding: 10px; border-radius: 5px; border: solid 1px <xsl:value-of select="$border-color-fixed"/>; background-color: <xsl:value-of select="$_fill_color"/>; background-image: linear-gradient(0deg, <xsl:value-of select="$_fill_color"/>, <xsl:value-of select="$_gradient_color"/>); }
						.cl-theme-standard .cl-var-order .cl-inner-part { fill: <xsl:value-of select="$main.sSpotColor"/>; width: 20px; height: 10px;  }
					</xsl:when>
					<xsl:when test="question_type='numeric'">
						.cl-theme-standard .cl-var-numeric { font-family: <xsl:value-of select="$_basic_font_family"/>; color: <xsl:value-of select="$_font_color"/>; padding: 10px; border-radius: 5px; border: solid 1px <xsl:value-of select="$border-color-fixed"/>; background-color: <xsl:value-of select="$_fill_color"/>; background-image: linear-gradient(0deg, <xsl:value-of select="$_fill_color"/>, <xsl:value-of select="$_gradient_color"/>); }
						.cl-theme-standard .cl-var-numeric .cl-var-input { border-width: 1px; border-radius: 5px; }
					</xsl:when>
					<xsl:when test="question_type='fib'">
						.cl-theme-standard .cl-var-fib { font-family: <xsl:value-of select="$_basic_font_family"/>; color: <xsl:value-of select="$_font_color"/>; padding: 10px; border-radius: 5px; border: solid 1px <xsl:value-of select="$border-color-fixed"/>; background-color: <xsl:value-of select="$_fill_color"/>; background-image: linear-gradient(0deg, <xsl:value-of select="$_fill_color"/>, <xsl:value-of select="$_gradient_color"/>); }
						.cl-theme-standard .cl-var-fib .cl-var-input { border-width: 1px; border-radius: 5px; }
					</xsl:when>
					<xsl:when test="question_type='oto'">
						.cl-theme-standard .cl-var-target { border-radius: 5px; border-width: 1px; background-color: <xsl:value-of select="$_fill_color"/>; background-image: linear-gradient(0deg, <xsl:value-of select="$_fill_color"/>, <xsl:value-of select="$_gradient_color"/>); }
						.cl-theme-standard .cl-var-bullet { border-radius: 5px; border-width: 1px; background-color: <xsl:value-of select="$_fill_color"/>; background-image: linear-gradient(0deg, <xsl:value-of select="$_fill_color"/>, <xsl:value-of select="$_gradient_color"/>); }
					</xsl:when>
					<xsl:when test="question_type='otm'">
						.cl-theme-standard .cl-otm-table .cl-var-target { border-radius: 5px; border-width: 1px; background-color: <xsl:value-of select="$_fill_color"/>; background-image: linear-gradient(0deg, <xsl:value-of select="$_fill_color"/>, <xsl:value-of select="$_gradient_color"/>); }
					</xsl:when>
					<xsl:when test="question_type='mtm'">
						.cl-theme-standard .cl-mtm-table .cl-var-target { border-radius: 5px; border-width: 1px; background-color: <xsl:value-of select="$_fill_color"/>; background-image: linear-gradient(0deg, <xsl:value-of select="$_fill_color"/>, <xsl:value-of select="$_gradient_color"/>); }
						.cl-theme-standard .cl-mtm-table .cl-var-bullet { border-radius: 5px; border-width: 1px; background-color: <xsl:value-of select="$_fill_color"/>; background-image: linear-gradient(0deg, <xsl:value-of select="$_fill_color"/>, <xsl:value-of select="$_gradient_color"/>); }
					</xsl:when>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</style>
</xsl:template>

<xsl:template name="question-main">
	<xsl:param name="bDesign"/>

	<xsl:variable name="_attempts">
		<xsl:choose>
			<xsl:when test="question_type='true-false'">1</xsl:when>
			<xsl:when test="question_type='choice'">
				<xsl:choose>
					<xsl:when test="q_scoring_type_choice='byvar'">1</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="q_attempts_type='auto'"><xsl:value-of select="count(q_variants_choice/item) - 1"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="q_attempts"/></xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="question_type='select'">
				<xsl:choose>
					<xsl:when test="q_scoring_type_select='sum' or q_scoring_type_select='max' or q_scoring_type_select='min' or q_scoring_type_select='avg'">1</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="q_attempts_type='auto'"><xsl:value-of select="count(q_variants_select/item) - 1"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="q_attempts"/></xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="question_type='order'">
				<xsl:choose>
					<xsl:when test="q_scoring_type_match='sum' or q_scoring_type_match='max' or q_scoring_type_match='min' or q_scoring_type_match='avg'">1</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="q_attempts_type='auto'"><xsl:value-of select="count(q_variants_order/item) - 1"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="q_attempts"/></xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="question_type='numeric'">
				<xsl:choose>
					<xsl:when test="q_attempts_type='auto'"><xsl:value-of select="count(q_variants_numeric/item) - 1"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="q_attempts"/></xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="question_type='fib'">
				<xsl:choose>
					<xsl:when test="q_attempts_type='auto'"><xsl:value-of select="count(q_variants_fib/item) - 1"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="q_attempts"/></xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="question_type='oto'">
				<xsl:choose>
					<xsl:when test="q_scoring_type_match='sum' or q_scoring_type_match='max' or q_scoring_type_match='min' or q_scoring_type_match='avg'">1</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="q_attempts_type='auto'"><xsl:value-of select="count(q_variants_oto/item) - 1"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="q_attempts"/></xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="q_attempts"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="_spot_0_path">
		<xsl:choose>
			<xsl:when test="$bDesign='yes'">
				<xsl:choose>
					<xsl:when test="string-length(q_spot_0)=0"><xsl:value-of select="$imagesFolder"/>broken-image.gif</xsl:when>
					<xsl:otherwise><xsl:value-of select="substring-before($moduleImagesFolder,'images\')"/><xsl:value-of select="translate(q_spot_0,'/','\')"/></xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="string-length(q_spot_0)=0"><xsl:value-of select="$imagesFolder"/>broken-image.gif</xsl:when>
					<xsl:otherwise><xsl:value-of select="q_spot_0"/></xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="_spot_1_path">
		<xsl:choose>
			<xsl:when test="$bDesign='yes'">
				<xsl:choose>
					<xsl:when test="string-length(q_spot_1)=0"><xsl:value-of select="$imagesFolder"/>broken-image.gif</xsl:when>
					<xsl:otherwise><xsl:value-of select="substring-before($moduleImagesFolder,'images\')"/><xsl:value-of select="translate(q_spot_1,'/','\')"/></xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="string-length(q_spot_1)=0"><xsl:value-of select="$imagesFolder"/>broken-image.gif</xsl:when>
					<xsl:otherwise><xsl:value-of select="q_spot_1"/></xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="_btn_a0_path">
		<xsl:choose>
			<xsl:when test="$bDesign='yes'">
				<xsl:choose>
					<xsl:when test="string-length(q_abtn_0)=0"><xsl:value-of select="$imagesFolder"/>broken-image.gif</xsl:when>
					<xsl:otherwise><xsl:value-of select="substring-before($moduleImagesFolder,'images\')"/><xsl:value-of select="translate(q_abtn_0,'/','\')"/></xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="string-length(q_abtn_0)=0"><xsl:value-of select="$imagesFolder"/>broken-image.gif</xsl:when>
					<xsl:otherwise><xsl:value-of select="q_abtn_0"/></xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="_btn_a1_path">
		<xsl:choose>
			<xsl:when test="$bDesign='yes'">
				<xsl:choose>
					<xsl:when test="string-length(q_abtn_1)=0"><xsl:value-of select="$imagesFolder"/>broken-image.gif</xsl:when>
					<xsl:otherwise><xsl:value-of select="substring-before($moduleImagesFolder,'images\')"/><xsl:value-of select="translate(q_abtn_1,'/','\')"/></xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="string-length(q_abtn_1)=0"><xsl:value-of select="$imagesFolder"/>broken-image.gif</xsl:when>
					<xsl:otherwise><xsl:value-of select="q_abtn_1"/></xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="_btn_s0_path">
		<xsl:choose>
			<xsl:when test="$bDesign='yes'">
				<xsl:choose>
					<xsl:when test="string-length(q_sbtn_0)=0"><xsl:value-of select="$imagesFolder"/>broken-image.gif</xsl:when>
					<xsl:otherwise><xsl:value-of select="substring-before($moduleImagesFolder,'images\')"/><xsl:value-of select="translate(q_sbtn_0,'/','\')"/></xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="string-length(q_sbtn_0)=0"><xsl:value-of select="$imagesFolder"/>broken-image.gif</xsl:when>
					<xsl:otherwise><xsl:value-of select="q_sbtn_0"/></xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="_btn_s1_path">
		<xsl:choose>
			<xsl:when test="$bDesign='yes'">
				<xsl:choose>
					<xsl:when test="string-length(q_sbtn_1)=0"><xsl:value-of select="$imagesFolder"/>broken-image.gif</xsl:when>
					<xsl:otherwise><xsl:value-of select="substring-before($moduleImagesFolder,'images\')"/><xsl:value-of select="translate(q_sbtn_1,'/','\')"/></xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="string-length(q_sbtn_1)=0"><xsl:value-of select="$imagesFolder"/>broken-image.gif</xsl:when>
					<xsl:otherwise><xsl:value-of select="q_sbtn_1"/></xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<div>
		<xsl:attribute name="class">cl-container cl-theme-<xsl:value-of select="theme"/></xsl:attribute>
		<div>
			<xsl:attribute name="class">cl-extra-wrapper</xsl:attribute>
			<div>
				<xsl:attribute name="class">cl-workarea</xsl:attribute>

				<xsl:call-template name="question-scored">
					<xsl:with-param name="bScored" select="q_scored"/>
					<xsl:with-param name="sCreditText"><xsl:value-of select="q_credit_msg"/></xsl:with-param>
					<xsl:with-param name="sNoCreditText"><xsl:value-of select="q_nocredit_msg"/></xsl:with-param>
				</xsl:call-template>

				<div>
					<xsl:attribute name="class">cl-q-area</xsl:attribute>
					<xsl:call-template name="question-text">
						<xsl:with-param name="bDisplayQuestion" select="display_question_text"/>
						<xsl:with-param name="sQuestionText"><xsl:value-of select="text_main" disable-output-escaping="yes"/></xsl:with-param>
					</xsl:call-template>


					<xsl:choose>
						<xsl:when test="question_type='true-false'">
							<xsl:call-template name="question-goal">
								<xsl:with-param name="sGoalText" select="q_goal_tf"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="question_type='choice'">
							<xsl:call-template name="question-goal">
								<xsl:with-param name="sGoalText" select="q_goal_choice"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="question_type='select'">
							<xsl:call-template name="question-goal">
								<xsl:with-param name="sGoalText" select="q_goal_select"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="question_type='order'">
							<xsl:call-template name="question-goal">
								<xsl:with-param name="sGoalText" select="q_goal_order"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="question_type='numeric'">
							<xsl:call-template name="question-goal">
								<xsl:with-param name="sGoalText" select="q_goal_numeric"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="question_type='fib'">
							<xsl:call-template name="question-goal">
								<xsl:with-param name="sGoalText" select="q_goal_fib"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="question_type='oto'">
							<xsl:call-template name="question-goal">
								<xsl:with-param name="sGoalText" select="q_goal_oto"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="question_type='otm'">
							<xsl:call-template name="question-goal">
								<xsl:with-param name="sGoalText" select="q_goal_otm"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="question_type='mtm'">
							<xsl:call-template name="question-goal">
								<xsl:with-param name="sGoalText" select="q_goal_mtm"/>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
					<table>
						<xsl:attribute name="class">cl-vars-table</xsl:attribute>
						<tr>
							<xsl:if test="q_img='left'">
								<td>
									<xsl:attribute name="class">cl-q-img-cell cl-q-img-cell-left</xsl:attribute>
									<div>
										<xsl:attribute name="class">cl-q-img-container</xsl:attribute>
										<img>
											<xsl:attribute name="class">cl-q-img</xsl:attribute>
											<xsl:attribute name="src">
												<xsl:choose>
													<xsl:when test="string-length(q_img_file)=0"><xsl:value-of select="$imagesFolder"/>broken-image.gif</xsl:when>
													<xsl:otherwise><xsl:value-of select="substring-before($moduleImagesFolder,'images\')"/><xsl:value-of select="translate(q_img_file,'/','\')"/></xsl:otherwise>
												</xsl:choose>
											</xsl:attribute>
										</img>
									</div>
								</td>
							</xsl:if>
							<td>
								<xsl:attribute name="class">cl-vars-cell</xsl:attribute>
								<xsl:call-template name="question-vars">
									<xsl:with-param name="bDesign" select="$bDesign"/>
									<xsl:with-param name="sQuestionType" select="question_type"/>
									<xsl:with-param name="bCustomSpots" select="q_customspot"/>
									<xsl:with-param name="sCustomSpotPathIdle"><xsl:value-of select="$_spot_0_path"/></xsl:with-param>
									<xsl:with-param name="sCustomSpotPathSelected"><xsl:value-of select="$_spot_1_path"/></xsl:with-param>
								</xsl:call-template>
							</td>
							<xsl:if test="q_img='right'">
								<td>
									<xsl:attribute name="class">cl-q-img-cell cl-q-img-cell-right</xsl:attribute>
									<div>
										<xsl:attribute name="class">cl-q-img-container</xsl:attribute>
										<img>
											<xsl:attribute name="class">cl-q-img</xsl:attribute>
											<xsl:attribute name="src">
												<xsl:choose>
													<xsl:when test="string-length(q_img_file)=0"><xsl:value-of select="$imagesFolder"/>broken-image.gif</xsl:when>
													<xsl:otherwise><xsl:value-of select="substring-before($moduleImagesFolder,'images\')"/><xsl:value-of select="translate(q_img_file,'/','\')"/></xsl:otherwise>
												</xsl:choose>
											</xsl:attribute>
										</img>
									</div>
								</td>
							</xsl:if>
						</tr>
					</table>
					<xsl:call-template name="question-timer">
						<xsl:with-param name="bDisplayTimer" select="q_timer_switch"/>
						<xsl:with-param name="sSkin" select="theme"/>
						<xsl:with-param name="sTimerTitle" select="q_timer_msg"/>
						<xsl:with-param name="sTimerValue" select="q_timer"/>
						<xsl:with-param name="sTimerSec" select="q_timer_sec"/>
					</xsl:call-template>

					<xsl:call-template name="question-manager">
						<xsl:with-param name="sButtonLayout" select="button_layout"/>
						<xsl:with-param name="sSkipType" select="q_skip"/>
						<xsl:with-param name="sSubmitText" select="q_a_tooltip"/>
						<xsl:with-param name="sSkipText" select="q_s_tooltip"/>
						<xsl:with-param name="bCustomButtons" select="q_custombutton"/>
						<xsl:with-param name="sCustomButtonType" select="q_button_type"/>
						<xsl:with-param name="sSubmitBtnIdlePath" select="$_btn_a0_path"/>
						<xsl:with-param name="sSubmitBtnOverPath" select="$_btn_a1_path"/>
						<xsl:with-param name="sSkipBtnIdlePath" select="$_btn_s0_path"/>
						<xsl:with-param name="sSkipBtnOverPath" select="$_btn_s1_path"/>
						<xsl:with-param name="sAttemptsText" select="q_attempts_msg"/>
						<xsl:with-param name="iAttemptsQty" select="$_attempts"/>
					</xsl:call-template>

				</div>
			</div>
		</div>

		<xsl:if test="q_fb_switch='yes'">
			<xsl:choose>
				<xsl:when test="$bDesign='yes'">
					<xsl:if test="q_fb_correct_preview='yes'">
						<xsl:call-template name="feedback">
							<xsl:with-param name="sFBType">correct</xsl:with-param>
							<xsl:with-param name="sFBText" select="q_fb_correct"/>
							<xsl:with-param name="bDesign" select="$bDesign"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="q_fb_incorrect_preview='yes'">
						<xsl:call-template name="feedback">
							<xsl:with-param name="sFBType">incorrect</xsl:with-param>
							<xsl:with-param name="sFBText" select="q_fb_incorrect"/>
							<xsl:with-param name="bDesign" select="$bDesign"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="q_fb_lastattempt_preview='yes'">
						<xsl:call-template name="feedback">
							<xsl:with-param name="sFBType">lastattempt</xsl:with-param>
							<xsl:with-param name="sFBText" select="q_fb_lastattempt"/>
							<xsl:with-param name="bDesign" select="$bDesign"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="q_fb_exceed_preview='yes'">
						<xsl:call-template name="feedback">
							<xsl:with-param name="sFBType">exceed</xsl:with-param>
							<xsl:with-param name="sFBText" select="q_fb_exceed"/>
							<xsl:with-param name="bDesign" select="$bDesign"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="q_fb_timeout_preview='yes'">
						<xsl:call-template name="feedback">
							<xsl:with-param name="sFBType">timeout</xsl:with-param>
							<xsl:with-param name="sFBText" select="q_fb_timeout"/>
							<xsl:with-param name="bDesign" select="$bDesign"/>
						</xsl:call-template>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="feedback">
						<xsl:with-param name="sFBType">-</xsl:with-param>
						<xsl:with-param name="sFBText">-</xsl:with-param>
						<xsl:with-param name="bDesign" select="$bDesign"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</div>
</xsl:template>
<xsl:template name="question-vars">
	<xsl:param name="bDesign"/>
	<xsl:param name="sQuestionType"/>
	<xsl:param name="bCustomSpots"/>
	<xsl:param name="sCustomSpotPathIdle"/>
	<xsl:param name="sCustomSpotPathSelected"/>
	<div>
		<xsl:attribute name="class">cl-q-vars cl-q-vars-<xsl:value-of select="$sQuestionType"/></xsl:attribute>
		<xsl:choose>
			<xsl:when test="$sQuestionType='true-false'">
				<xsl:choose>
					<xsl:when test="q_elements_layout='v'">
						<xsl:call-template name="var-true-false">
							<xsl:with-param name="iValue">
								<xsl:choose>
									<xsl:when test="q_elements_order='ft'">0</xsl:when>
									<xsl:when test="q_elements_order='tf'">1</xsl:when>
									<xsl:otherwise>1</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="iSelect">
								<xsl:choose>
									<xsl:when test="$bDesign!='yes'">0</xsl:when>
									<xsl:when test="q_elements_order='ft' and q_eval='false'">1</xsl:when>
									<xsl:when test="(q_elements_order='tf' or q_elements_order='random') and q_eval='true'">1</xsl:when>
									<xsl:otherwise>0</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="sQType" select="$sQuestionType"/>
							<xsl:with-param name="sSkin" select="theme"/>
							<xsl:with-param name="bCustomSpot" select="$bCustomSpots"/>
							<xsl:with-param name="sCustomSpotPath0"><xsl:value-of select="$sCustomSpotPathIdle"/></xsl:with-param>
							<xsl:with-param name="sCustomSpotPath1"><xsl:value-of select="$sCustomSpotPathSelected"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="var-true-false">
							<xsl:with-param name="iValue">
								<xsl:choose>
									<xsl:when test="q_elements_order='ft'">1</xsl:when>
									<xsl:when test="q_elements_order='tf'">0</xsl:when>
									<xsl:otherwise>0</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="iSelect">
								<xsl:choose>
									<xsl:when test="$bDesign!='yes'">0</xsl:when>
									<xsl:when test="(q_elements_order='tf' or q_elements_order='random') and q_eval='false'">1</xsl:when>
									<xsl:when test="q_elements_order='ft' and q_eval='true'">1</xsl:when>
									<xsl:otherwise>0</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="sQType" select="question_type"/>
							<xsl:with-param name="sSkin" select="theme"/>
							<xsl:with-param name="bCustomSpot" select="$bCustomSpots"/>
							<xsl:with-param name="sCustomSpotPath0"><xsl:value-of select="$sCustomSpotPathIdle"/></xsl:with-param>
							<xsl:with-param name="sCustomSpotPath1"><xsl:value-of select="$sCustomSpotPathSelected"/></xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<table>
							<xsl:attribute name="class">cl-q-vars-tf-h-table</xsl:attribute>
							<tr>
								<td>
									<xsl:attribute name="class">cl-q-vars-tf-h-td</xsl:attribute>
									<xsl:call-template name="var-true-false">
										<xsl:with-param name="iValue">
											<xsl:choose>
												<xsl:when test="q_elements_order='ft'">0</xsl:when>
												<xsl:when test="q_elements_order='tf'">1</xsl:when>
												<xsl:otherwise>1</xsl:otherwise>
											</xsl:choose>
										</xsl:with-param>
										<xsl:with-param name="iSelect">
											<xsl:choose>
												<xsl:when test="$bDesign!='yes'">0</xsl:when>
												<xsl:otherwise>
													<xsl:choose>
														<xsl:when test="q_elements_order='ft' and q_eval='false'">1</xsl:when>
														<xsl:when test="(q_elements_order='tf' or q_elements_order='random') and q_eval='true'">1</xsl:when>
														<xsl:otherwise>0</xsl:otherwise>
													</xsl:choose>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:with-param>
										<xsl:with-param name="sQType" select="$sQuestionType"/>
										<xsl:with-param name="sSkin" select="theme"/>
										<xsl:with-param name="bCustomSpot" select="$bCustomSpots"/>
										<xsl:with-param name="sCustomSpotPath0"><xsl:value-of select="$sCustomSpotPathIdle"/></xsl:with-param>
										<xsl:with-param name="sCustomSpotPath1"><xsl:value-of select="$sCustomSpotPathSelected"/></xsl:with-param>
									</xsl:call-template>
								</td>
								<td>
									<xsl:attribute name="class">cl-q-vars-tf-h-td</xsl:attribute>
									<xsl:call-template name="var-true-false">
										<xsl:with-param name="iValue">
											<xsl:choose>
												<xsl:when test="q_elements_order='ft'">1</xsl:when>
												<xsl:when test="q_elements_order='tf'">0</xsl:when>
												<xsl:otherwise>0</xsl:otherwise>
											</xsl:choose>
										</xsl:with-param>
										<xsl:with-param name="iSelect">
											<xsl:choose>
												<xsl:when test="$bDesign!='yes'">0</xsl:when>
												<xsl:otherwise>
													<xsl:choose>
														<xsl:when test="(q_elements_order='tf' or q_elements_order='random') and q_eval='false'">1</xsl:when>
														<xsl:when test="q_elements_order='ft' and q_eval='true'">1</xsl:when>
														<xsl:otherwise>0</xsl:otherwise>
													</xsl:choose>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:with-param>
										<xsl:with-param name="sQType" select="question_type"/>
										<xsl:with-param name="sSkin" select="theme"/>
										<xsl:with-param name="bCustomSpot" select="$bCustomSpots"/>
										<xsl:with-param name="sCustomSpotPath0"><xsl:value-of select="$sCustomSpotPathIdle"/></xsl:with-param>
										<xsl:with-param name="sCustomSpotPath1"><xsl:value-of select="$sCustomSpotPathSelected"/></xsl:with-param>
									</xsl:call-template>
								</td>
							</tr>
						</table>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$sQuestionType='choice'">
				<xsl:for-each select="q_variants_choice/item">
					<xsl:call-template name="var-choice">
						<xsl:with-param name="iPosition" select="position()"/>
						<xsl:with-param name="iLast" select="last()"/>
						<xsl:with-param name="iSelect">
							<xsl:choose>
								<xsl:when test="$bDesign!='yes'">0</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="q_right='yes'">1</xsl:when>
										<xsl:otherwise>0</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="sQType" select="$sQuestionType"/>
						<xsl:with-param name="sSkin" select="../../theme"/>
						<xsl:with-param name="bCustomSpot" select="$bCustomSpots"/>
						<xsl:with-param name="sCustomSpotPath0"><xsl:value-of select="$sCustomSpotPathIdle"/></xsl:with-param>
						<xsl:with-param name="sCustomSpotPath1"><xsl:value-of select="$sCustomSpotPathSelected"/></xsl:with-param>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="$sQuestionType='select'">
				<xsl:for-each select="q_variants_select/item">
					<xsl:call-template name="var-select">
						<xsl:with-param name="iPosition" select="position()"/>
						<xsl:with-param name="iLast" select="last()"/>
						<xsl:with-param name="iSelect">
							<xsl:choose>
								<xsl:when test="$bDesign!='yes'">0</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="q_right='yes'">1</xsl:when>
										<xsl:otherwise>0</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="sQType" select="$sQuestionType"/>
						<xsl:with-param name="sSkin" select="../../theme"/>
						<xsl:with-param name="bCustomSpot" select="$bCustomSpots"/>
						<xsl:with-param name="sCustomSpotPath0"><xsl:value-of select="$sCustomSpotPathIdle"/></xsl:with-param>
						<xsl:with-param name="sCustomSpotPath1"><xsl:value-of select="$sCustomSpotPathSelected"/></xsl:with-param>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="$sQuestionType='order'">
				<xsl:for-each select="q_variants_order/item">
					<xsl:call-template name="var-order">
						<xsl:with-param name="iPosition" select="position()"/>
						<xsl:with-param name="iLast" select="last()"/>
						<xsl:with-param name="sQType" select="$sQuestionType"/>
						<xsl:with-param name="sSkin" select="../../theme"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="$sQuestionType='numeric'">
				<xsl:for-each select="q_variants_numeric/item">
					<xsl:call-template name="var-numeric">
						<xsl:with-param name="iPosition" select="position()"/>
						<xsl:with-param name="sExpPosition">
							<xsl:choose>
								<xsl:when test="q_exp_position='left'">left</xsl:when>
								<xsl:otherwise>right</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="$sQuestionType='fib'">
				<xsl:for-each select="q_variants_fib/item">
					<xsl:call-template name="var-fib">
						<xsl:with-param name="iPosition" select="position()"/>
						<xsl:with-param name="sExpPosition">
							<xsl:choose>
								<xsl:when test="q_exp_position='left'">left</xsl:when>
								<xsl:otherwise>right</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="$sQuestionType='oto'">
				<table>
					<xsl:attribute name="class">cl-oto-table</xsl:attribute>
					<xsl:for-each select="q_variants_oto/item">
						<xsl:call-template name="var-oto">
							<xsl:with-param name="iPosition" select="position()"/>
						</xsl:call-template>
					</xsl:for-each>
				</table>
			</xsl:when>
			<xsl:when test="$sQuestionType='otm'">
				<xsl:variable name="_otm_bullets_total" select="count(q_variants_otm/item/q_bullets/item)"/>
				<xsl:variable name="_otm_bullets_max">
					<xsl:for-each select="q_variants_otm/item">
						<xsl:sort data-type="number" order="descending" select="count(q_bullets/item)"/>
						<xsl:if test="position()=1"><xsl:value-of select="count(q_bullets/item)"/></xsl:if>
					</xsl:for-each>
				</xsl:variable>

				<table>
					<xsl:attribute name="class">cl-otm-table</xsl:attribute>
					<xsl:for-each select="q_variants_otm/item">
						<xsl:call-template name="var-otm">
							<xsl:with-param name="iPosition" select="position()"/>
							<xsl:with-param name="sContacts" select="../../q_contacts_otm"/>
							<xsl:with-param name="iContactsLocal" select="count(q_bullets/item)"/>
							<xsl:with-param name="iContactsMax" select="$_otm_bullets_max"/>
							<xsl:with-param name="iContactsTotal" select="$_otm_bullets_total"/>
							<xsl:with-param name="iContactsManual" select="../../q_contacts_manual_otm"/>
						</xsl:call-template>
					</xsl:for-each>
				</table>
			</xsl:when>
			<xsl:when test="$sQuestionType='mtm'">
				<xsl:variable name="_mtm_bullets_total" select="count(q_variants_mtm/item/q_connections/item)"/>
				<xsl:variable name="_mtm_bullets_max">
					<xsl:for-each select="q_variants_mtm/item">
						<xsl:sort data-type="number" order="descending" select="count(q_connections/item)"/>
						<xsl:if test="position()=1"><xsl:value-of select="count(q_connections/item)"/></xsl:if>
					</xsl:for-each>
				</xsl:variable>

				<table>
					<xsl:attribute name="class">cl-mtm-table</xsl:attribute>
					<tr>
						<td>
							<xsl:attribute name="class">cl-left-part</xsl:attribute>
							<xsl:for-each select="q_variants_mtm/item">
								<xsl:call-template name="var-mtm-target">
									<xsl:with-param name="iPosition" select="position()"/>
									<xsl:with-param name="sContacts" select="../../q_contacts_mtm"/>
									<xsl:with-param name="iContactsLocal" select="count(q_connections/item)"/>
									<xsl:with-param name="iContactsMax" select="$_mtm_bullets_max"/>
									<xsl:with-param name="iContactsTotal" select="$_mtm_bullets_total"/>
									<xsl:with-param name="iContactsManual" select="../../q_contacts_manual_mtm"/>
								</xsl:call-template>
							</xsl:for-each>
						</td>
						<td>
							<xsl:attribute name="class">cl-center-part</xsl:attribute>
							&#160;
						</td>
						<td>
							<xsl:attribute name="class">cl-right-part</xsl:attribute>
							<xsl:for-each select="q_bullets_mtm/item">
								<xsl:call-template name="var-mtm-bullet">
									<xsl:with-param name="iPosition" select="position()"/>
									<xsl:with-param name="sBulletId" select="q_bullet_number"/>
								</xsl:call-template>
							</xsl:for-each>
						</td>
					</tr>
				</table>
			</xsl:when>
		</xsl:choose>
	</div>
</xsl:template>
<xsl:template name="question-goal">
	<xsl:param name="sGoalText"/>
	<div>
		<xsl:attribute name="class">cl-q-question-goal</xsl:attribute>
		<xsl:value-of select="$sGoalText"/>
	</div>
</xsl:template>

<xsl:template name="question-scored">
	<xsl:param name="bScored"/>
	<xsl:param name="sCreditText"/>
	<xsl:param name="sNoCreditText"/>
	<xsl:if test="($bScored='yes' and $sCreditText!='') or ($bScored!='yes' and $sNoCreditText!='')">
		<div>
			<xsl:attribute name="class">cl-q-credit</xsl:attribute>
			<xsl:choose>
				<xsl:when test="$bScored='yes'"><xsl:value-of select="$sCreditText"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="$sNoCreditText"/></xsl:otherwise>
			</xsl:choose>
		</div>
	</xsl:if>
</xsl:template>
<xsl:template name="question-text">
	<xsl:param name="bDisplayQuestion"/>
	<xsl:param name="sQuestionText"/>
	<xsl:if test="$bDisplayQuestion='yes'">
		<div>
			<xsl:attribute name="class">cl-q-question-txt</xsl:attribute>
			<xsl:value-of select="$sQuestionText" disable-output-escaping="yes"/>
		</div>
	</xsl:if>
</xsl:template>
<xsl:template name="question-timer">
	<xsl:param name="bDisplayTimer"/>
	<xsl:param name="sTimerTitle"/>
	<xsl:param name="sTimerValue"/>
	<xsl:param name="sTimerSec"/>
	<xsl:if test="$bDisplayTimer='yes'">
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_Q_TIMER</xsl:attribute>
			<xsl:attribute name="class">cl-q-timer</xsl:attribute>
			<table cellspacing="0" cellpadding="0" border="0">
				<xsl:attribute name="class">cl-q-timer-table</xsl:attribute>
				<tr>
					<td>
						<xsl:attribute name="class">cl-q-timer-title</xsl:attribute>
						<xsl:value-of select="$sTimerTitle"/>
					</td>
					<td>
						<xsl:attribute name="class">cl-q-timer-progress</xsl:attribute>
						<div>
							<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_Q_TIMER_BOX</xsl:attribute>
							<xsl:attribute name="class">cl-q-timer-box</xsl:attribute>
							<div>
								<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_Q_TIMER_INDICATOR</xsl:attribute>
								<xsl:attribute name="class">cl-q-timer-indicator cl-q-timer-indicator-idle</xsl:attribute>
								&#160;
							</div>
						</div>
					</td>
					<td>
						<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_Q_TIMER_VALUE</xsl:attribute>
						<xsl:attribute name="class">cl-q-timer-value</xsl:attribute>
						<span class="cl-q-timer-value-number"><xsl:value-of select="$sTimerValue"/></span>&#160;<span class="cl-q-timer-value-unit"><xsl:value-of select="$sTimerSec"/></span>
					</td>
				</tr>
			</table>
		</div>
	</xsl:if>
</xsl:template>
<xsl:template name="question-manager">
	<xsl:param name="sButtonLayout"/>
	<xsl:param name="sSkipType"/>
	<xsl:param name="sSubmitText"/>
	<xsl:param name="sSkipText"/>
	<xsl:param name="bCustomButtons"/>
	<xsl:param name="sCustomButtonType"/>
	<xsl:param name="sSubmitBtnIdlePath"/>
	<xsl:param name="sSubmitBtnOverPath"/>
	<xsl:param name="sSkipBtnIdlePath"/>
	<xsl:param name="sSkipBtnOverPath"/>
	<xsl:param name="sAttemptsText"/>
	<xsl:param name="iAttemptsQty"/>
	<div>
		<xsl:attribute name="class">cl-q-manager</xsl:attribute>
		<table cellpadding="0" cellspacing="0" border="0">
			<xsl:attribute name="class">cl-q-manager-table</xsl:attribute>
			<tr>
				<td>
					<xsl:attribute name="class">cl-q-manager-td cl-q-manager-td-left</xsl:attribute>

					<xsl:choose>
						<xsl:when test="$sButtonLayout='left'">

							<xsl:call-template name="question-button">
								<xsl:with-param name="sAction">submit</xsl:with-param>
								<xsl:with-param name="sPosition">left</xsl:with-param>
								<xsl:with-param name="sButtonText" select="$sSubmitText"/>
								<xsl:with-param name="sButtonTooltip" select="$sSubmitText"/>
								<xsl:with-param name="bCustomButton" select="$bCustomButtons"/>
								<xsl:with-param name="sButtonType" select="$sCustomButtonType"/>
								<xsl:with-param name="sCustomButtonPath" select="$sSubmitBtnIdlePath"/>
								<xsl:with-param name="sCustomButtonPathOver" select="$sSubmitBtnOverPath"/>
							</xsl:call-template>

						</xsl:when>
						<xsl:when test="$sButtonLayout='right' and $sSkipType!='none'">

							<xsl:call-template name="question-button">
								<xsl:with-param name="sAction">skip</xsl:with-param>
								<xsl:with-param name="sPosition">left</xsl:with-param>
								<xsl:with-param name="sButtonText" select="$sSkipText"/>
								<xsl:with-param name="sButtonTooltip" select="$sSkipText"/>
								<xsl:with-param name="bCustomButton" select="$bCustomButtons"/>
								<xsl:with-param name="sButtonType" select="$sCustomButtonType"/>
								<xsl:with-param name="sCustomButtonPath" select="$sSkipBtnIdlePath"/>
								<xsl:with-param name="sCustomButtonPathOver" select="$sSkipBtnOverPath"/>
							</xsl:call-template>

						</xsl:when>
						<xsl:otherwise>&#160;</xsl:otherwise>
					</xsl:choose>
				</td>
				<td>
					<xsl:attribute name="class">cl-q-attempts</xsl:attribute>
					<xsl:call-template name="question-attempts">
						<xsl:with-param name="sAttText" select="$sAttemptsText"/>
						<xsl:with-param name="iAttQty" select="$iAttemptsQty"/>
					</xsl:call-template>
				</td>
				<td>
					<xsl:attribute name="class">cl-q-manager-td cl-q-manager-td-right</xsl:attribute>
					<xsl:choose>
						<xsl:when test="$sButtonLayout='left' and $sSkipType!='none'">

							<xsl:call-template name="question-button">
								<xsl:with-param name="sAction">skip</xsl:with-param>
								<xsl:with-param name="sPosition">right</xsl:with-param>
								<xsl:with-param name="sButtonText" select="$sSkipText"/>
								<xsl:with-param name="sButtonTooltip" select="$sSkipText"/>
								<xsl:with-param name="bCustomButton" select="$bCustomButtons"/>
								<xsl:with-param name="sButtonType" select="$sCustomButtonType"/>
								<xsl:with-param name="sCustomButtonPath" select="$sSkipBtnIdlePath"/>
								<xsl:with-param name="sCustomButtonPathOver" select="$sSkipBtnOverPath"/>
							</xsl:call-template>

						</xsl:when>
						<xsl:when test="$sButtonLayout='right'">

							<xsl:call-template name="question-button">
								<xsl:with-param name="sAction">submit</xsl:with-param>
								<xsl:with-param name="sPosition">right</xsl:with-param>
								<xsl:with-param name="sButtonText" select="$sSubmitText"/>
								<xsl:with-param name="sButtonTooltip" select="$sSubmitText"/>
								<xsl:with-param name="bCustomButton" select="$bCustomButtons"/>
								<xsl:with-param name="sButtonType" select="$sCustomButtonType"/>
								<xsl:with-param name="sCustomButtonPath" select="$sSubmitBtnIdlePath"/>
								<xsl:with-param name="sCustomButtonPathOver" select="$sSubmitBtnOverPath"/>
							</xsl:call-template>

						</xsl:when>
						<xsl:otherwise>&#160;</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
		</table>
	</div>

</xsl:template>
<xsl:template name="question-button">
	<xsl:param name="sAction"/>
	<xsl:param name="sPosition"/>
	<xsl:param name="sButtonText"/>
	<xsl:param name="sButtonTooltip"/>
	<xsl:param name="bCustomButton"/>
	<xsl:param name="sButtonType"/>
	<xsl:param name="sCustomButtonPath"/>
	<xsl:param name="sCustomButtonPathOver"/>

	<xsl:choose>
		<xsl:when test="$bCustomButton='yes'">
			<xsl:choose>
				<xsl:when test="$sButtonType='picture'">
					<div>
						<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_BUTTON_<xsl:value-of select="$sAction"/></xsl:attribute>
						<xsl:attribute name="class">cl-btn cl-btn-from-img cl-btn-idle</xsl:attribute>
						<xsl:attribute name="data-action"><xsl:value-of select="$sAction"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="$sButtonTooltip"/></xsl:attribute>
						<img border="0">
							<xsl:attribute name="class">cl-btn-img cl-btn-img-idle</xsl:attribute>
							<xsl:attribute name="src"><xsl:value-of select="$sCustomButtonPath"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="$sButtonTooltip"/></xsl:attribute>
							<xsl:attribute name="data-action"><xsl:value-of select="$sAction"/></xsl:attribute>
						</img>
						<img border="0">
							<xsl:attribute name="class">cl-btn-img cl-btn-img-over</xsl:attribute>
							<xsl:attribute name="src"><xsl:value-of select="$sCustomButtonPathOver"/></xsl:attribute>
							<xsl:attribute name="title"><xsl:value-of select="$sButtonTooltip"/></xsl:attribute>
							<xsl:attribute name="data-action"><xsl:value-of select="$sAction"/></xsl:attribute>
						</img>
					</div>
				</xsl:when>
				<xsl:otherwise>
					<input type="button">
						<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_BUTTON_<xsl:value-of select="$sAction"/></xsl:attribute>
						<xsl:attribute name="class">cl-btn cl-btn-html cl-btn-idle</xsl:attribute>
						<xsl:attribute name="value"><xsl:value-of select="$sButtonText"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="$sButtonTooltip"/></xsl:attribute>
						<xsl:attribute name="data-action"><xsl:value-of select="$sAction"/></xsl:attribute>
					</input>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
			<div>
				<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_BUTTON_<xsl:value-of select="$sAction"/></xsl:attribute>
				<xsl:attribute name="class">cl-btn cl-btn-std cl-btn-idle</xsl:attribute>
				<xsl:attribute name="data-action"><xsl:value-of select="$sAction"/></xsl:attribute>
				<xsl:attribute name="title"><xsl:value-of select="$sButtonTooltip"/></xsl:attribute>
				<table cellpadding="0" cellspacing="0" border="0" align="center">
					<xsl:attribute name="class">cl-btn-table</xsl:attribute>
					<tr>
						<td>
							<xsl:attribute name="class">cl-btn-cell</xsl:attribute>
							<xsl:value-of select="$sButtonText"/>
						</td>
					</tr>
				</table>
			</div>
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>
<xsl:template name="question-attempts">
	<xsl:param name="sAttText"/>
	<xsl:param name="iAttQty"/>
	<div>
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_q_attempts_container</xsl:attribute>
		<table cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td>
					<xsl:attribute name="class">cl-q-attempts-txt</xsl:attribute>
					<xsl:value-of select="$sAttText"/>
				</td>
				<td>
					<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_q_attempts_count</xsl:attribute>
					<xsl:attribute name="class">cl-q-attempts-num</xsl:attribute>
					<xsl:value-of select="$iAttQty"/>
				</td>
			</tr>
		</table>
	</div>
</xsl:template>

<xsl:template match="*" name="feedback">
	<xsl:param name="sFBType"/>
	<xsl:param name="sFBText"/>
	<xsl:param name="bDesign"/>
	<div>
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_Q_FB</xsl:attribute>
		<xsl:attribute name="class">cl-q-feedback <xsl:if test="$bDesign='yes'">cl-q-feedback-<xsl:value-of select="$sFBType"/></xsl:if></xsl:attribute>
		<xsl:if test="$bDesign!='yes'"><xsl:attribute name="style">display: none;</xsl:attribute></xsl:if>
		<div>
			<xsl:attribute name="class">cl-q-feedback-inner</xsl:attribute>
			<div>
				<xsl:attribute name="class">cl-q-feedback-btn unselectable</xsl:attribute>
				&#215;
			</div>
			<div>
				<xsl:attribute name="class">cl-q-feedback-txt-cnt</xsl:attribute>
				<div>
					<xsl:attribute name="class">cl-q-feedback-txt</xsl:attribute>
					<xsl:value-of select="$sFBText" disable-output-escaping="yes" />
				</div>
			</div>
		</div>
	</div>
</xsl:template>
<xsl:template match="item" name="var-true-false">
	<xsl:param name="iValue"/>
	<xsl:param name="iSelect"/>
	<xsl:param name="sSkin"/>
	<xsl:param name="bCustomSpot"/>
	<xsl:param name="sCustomSpotPath0"/>
	<xsl:param name="sCustomSpotPath1"/>
	<xsl:param name="sButton"/>

	<div>
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_Q_VAR_<xsl:value-of select="$iValue"/></xsl:attribute>
		<xsl:attribute name="data-vid"><xsl:value-of select="$iValue"/></xsl:attribute>
		<xsl:attribute name="class">cl-var <xsl:choose><xsl:when test="number($iSelect)=1"> cl-var-selected </xsl:when><xsl:otherwise> cl-var-idle </xsl:otherwise></xsl:choose></xsl:attribute>
		<div>
			<xsl:attribute name="class">cl-var-inner cl-var-true-false cl-var-true-false-<xsl:value-of select="$sSkin"/></xsl:attribute>
			<table cellpadding="0" cellspacing="0" border="0">
				<xsl:attribute name="class">cl-var-table</xsl:attribute>
				<tr>
					<td>
						<xsl:attribute name="class">cl-var-spot-td</xsl:attribute>
						<xsl:choose>
							<xsl:when test="$bCustomSpot='yes'">
								<img border="0">
									<xsl:attribute name="class">cl-var-spot-img-idle</xsl:attribute>
									<xsl:attribute name="src"><xsl:value-of select="$sCustomSpotPath0"/></xsl:attribute>
								</img>
								<img border="0">
									<xsl:attribute name="class">cl-var-spot-img-selected</xsl:attribute>
									<xsl:attribute name="src"><xsl:value-of select="$sCustomSpotPath1"/></xsl:attribute>
								</img>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="spot-true-false">
									<xsl:with-param name="iPosition" select="$iValue"/>
									<xsl:with-param name="sSkin" select="$sSkin"/>
									<xsl:with-param name="sButtonType" select="$sButton"/>
									<xsl:with-param name="sCorrect" select="q_right"/>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</td>
					<td>
						<xsl:attribute name="class">cl-var-txt-td</xsl:attribute>
						<div>
							<xsl:attribute name="class">cl-var-txt</xsl:attribute>
							<xsl:choose>
								<xsl:when test="number($iValue)=1"><xsl:value-of select="q_text_true" disable-output-escaping="yes"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="q_text_false" disable-output-escaping="yes"/></xsl:otherwise>
							</xsl:choose>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
</xsl:template>
<xsl:template match="item" name="var-choice">
	<xsl:param name="iPosition"/>
	<xsl:param name="iLast"/>
	<xsl:param name="iSelect"/>
	<xsl:param name="sSkin"/>
	<xsl:param name="bCustomSpot"/>
	<xsl:param name="sCustomSpotPath0"/>
	<xsl:param name="sCustomSpotPath1"/>
	<xsl:param name="sButton"/>

	<div>
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_Q_VAR_<xsl:value-of select="$iPosition"/></xsl:attribute>
		<xsl:attribute name="data-vid"><xsl:value-of select="$iPosition"/></xsl:attribute>
		<xsl:attribute name="class">cl-var <xsl:choose><xsl:when test="number($iSelect)=1"> cl-var-selected </xsl:when><xsl:otherwise> cl-var-idle </xsl:otherwise></xsl:choose></xsl:attribute>
		<div>
			<xsl:attribute name="class">cl-var-inner cl-var-choice cl-var-choice-<xsl:value-of select="$sSkin"/> <xsl:if test="$iPosition=1"> cl-var-first </xsl:if><xsl:if test="$iPosition=$iLast"> cl-var-last </xsl:if></xsl:attribute>
			<table cellpadding="0" cellspacing="0" border="0">
				<xsl:attribute name="class">cl-var-table</xsl:attribute>
				<tr>
					<td>
						<xsl:attribute name="class">cl-var-spot-td</xsl:attribute>
						<xsl:choose>
							<xsl:when test="$bCustomSpot='yes'">
								<img border="0">
									<xsl:attribute name="class">cl-var-spot-img-idle</xsl:attribute>
									<xsl:attribute name="src"><xsl:value-of select="$sCustomSpotPath0"/></xsl:attribute>
								</img>
								<img border="0">
									<xsl:attribute name="class">cl-var-spot-img-selected</xsl:attribute>
									<xsl:attribute name="src"><xsl:value-of select="$sCustomSpotPath1"/></xsl:attribute>
								</img>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="spot-choice">
									<xsl:with-param name="iPosition" select="$iPosition"/>
									<xsl:with-param name="sSkin" select="$sSkin"/>
									<xsl:with-param name="sCorrect" select="q_right"/>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</td>
					<td>
						<xsl:attribute name="class">cl-var-txt-td</xsl:attribute>
						<div>
							<xsl:attribute name="class">cl-var-txt</xsl:attribute>
							<xsl:value-of select="q_variant" disable-output-escaping="yes"/>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
</xsl:template>
<xsl:template match="item" name="var-select">
	<xsl:param name="iPosition"/>
	<xsl:param name="iLast"/>
	<xsl:param name="iSelect"/>
	<xsl:param name="sSkin"/>
	<xsl:param name="bCustomSpot"/>
	<xsl:param name="sCustomSpotPath0"/>
	<xsl:param name="sCustomSpotPath1"/>

	<div>
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_Q_VAR_<xsl:value-of select="$iPosition"/></xsl:attribute>
		<xsl:attribute name="data-vid"><xsl:value-of select="$iPosition"/></xsl:attribute>
		<xsl:attribute name="class">cl-var <xsl:choose><xsl:when test="number($iSelect)=1"> cl-var-selected </xsl:when><xsl:otherwise> cl-var-idle </xsl:otherwise></xsl:choose></xsl:attribute>
		<div>
			<xsl:attribute name="class">cl-var-inner cl-var-select</xsl:attribute>
			<table cellpadding="0" cellspacing="0" border="0">
				<xsl:attribute name="class">cl-var-table</xsl:attribute>
				<tr>
					<td>
						<xsl:attribute name="class">cl-var-spot-td</xsl:attribute>
						<xsl:choose>
							<xsl:when test="$bCustomSpot='yes'">
								<img border="0">
									<xsl:attribute name="class">cl-var-spot-img-idle</xsl:attribute>
									<xsl:attribute name="src"><xsl:value-of select="$sCustomSpotPath0"/></xsl:attribute>
								</img>
								<img border="0">
									<xsl:attribute name="class">cl-var-spot-img-selected</xsl:attribute>
									<xsl:attribute name="src"><xsl:value-of select="$sCustomSpotPath1"/></xsl:attribute>
								</img>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="spot-select">
									<xsl:with-param name="iPosition" select="$iPosition"/>
									<xsl:with-param name="sSkin" select="$sSkin"/>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
					</td>
					<td>
						<xsl:attribute name="class">cl-var-txt-td</xsl:attribute>
						<div>
							<xsl:attribute name="class">cl-var-txt</xsl:attribute>
							<xsl:value-of select="q_variant" disable-output-escaping="yes"/>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
</xsl:template>
<xsl:template match="item" name="var-order">
	<xsl:param name="iPosition"/>
	<xsl:param name="iLast"/>
	<xsl:param name="sSkin"/>

	<div>
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_Q_VAR_<xsl:value-of select="$iPosition"/></xsl:attribute>
		<xsl:attribute name="data-vid"><xsl:value-of select="$iPosition"/></xsl:attribute>
		<xsl:attribute name="class">cl-var </xsl:attribute>
		<div>
			<xsl:attribute name="class">cl-var-inner cl-var-order <xsl:if test="$iPosition=1"> cl-var-first </xsl:if><xsl:if test="$iPosition=$iLast"> cl-var-last </xsl:if></xsl:attribute>
			<table cellpadding="0" cellspacing="0" border="0">
				<xsl:attribute name="class">cl-var-table</xsl:attribute>
				<tr>
					<td>
						<xsl:attribute name="class">cl-var-spot-td</xsl:attribute>
						<xsl:call-template name="spot-order">
							<xsl:with-param name="iPosition" select="$iPosition"/>
							<xsl:with-param name="sSkin" select="$sSkin"/>
						</xsl:call-template>
					</td>
					<td>
						<xsl:attribute name="class">cl-var-txt-td</xsl:attribute>
						<div>
							<xsl:attribute name="class">cl-var-txt</xsl:attribute>
							<xsl:value-of select="q_variant" disable-output-escaping="yes"/>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
</xsl:template>
<xsl:template match="item" name="var-numeric">
	<xsl:param name="iPosition"/>
	<xsl:param name="sExpPosition"/>

	<div>
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_Q_VAR_<xsl:value-of select="$iPosition"/></xsl:attribute>
		<xsl:attribute name="data-vid"><xsl:value-of select="$iPosition"/></xsl:attribute>
		<xsl:attribute name="class">cl-var </xsl:attribute>
		<div>
			<xsl:attribute name="class">cl-var-inner cl-var-numeric</xsl:attribute>
			<table cellpadding="0" cellspacing="0" border="0">
				<xsl:attribute name="class">cl-var-table</xsl:attribute>
				<tr>
					<xsl:if test="$sExpPosition='left'">
						<td>
							<xsl:attribute name="class">cl-var-txt-td cl-var-exp-left</xsl:attribute>
							<div>
								<xsl:attribute name="class">cl-var-txt</xsl:attribute>
								<xsl:value-of select="q_explanation" disable-output-escaping="yes"/>
							</div>
						</td>
					</xsl:if>
					<td>
						<xsl:attribute name="class">cl-var-spot-td cl-var-input-cell-<xsl:value-of select="$sExpPosition"/></xsl:attribute>
						<input type="text">
							<xsl:attribute name="class">cl-var-input</xsl:attribute>
						</input>
					</td>
					<xsl:if test="$sExpPosition='right'">
						<td>
							<xsl:attribute name="class">cl-var-txt-td cl-var-exp-right</xsl:attribute>
							<div>
								<xsl:attribute name="class">cl-var-txt</xsl:attribute>
								<xsl:value-of select="q_explanation" disable-output-escaping="yes"/>
							</div>
						</td>
					</xsl:if>
				</tr>
			</table>
		</div>
	</div>
</xsl:template>
<xsl:template match="item" name="var-fib">
	<xsl:param name="iPosition"/>
	<xsl:param name="sExpPosition"/>

	<div>
		<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_Q_VAR_<xsl:value-of select="$iPosition"/></xsl:attribute>
		<xsl:attribute name="data-vid"><xsl:value-of select="$iPosition"/></xsl:attribute>
		<xsl:attribute name="class">cl-var </xsl:attribute>
		<div>
			<xsl:attribute name="class">cl-var-inner cl-var-fib</xsl:attribute>
			<table cellpadding="0" cellspacing="0" border="0">
				<xsl:attribute name="class">cl-var-table</xsl:attribute>
				<tr>
					<xsl:if test="$sExpPosition='left'">
						<td>
							<xsl:attribute name="class">cl-var-txt-td cl-var-exp-left</xsl:attribute>
							<div>
								<xsl:attribute name="class">cl-var-txt</xsl:attribute>
								<xsl:value-of select="q_explanation" disable-output-escaping="yes"/>
							</div>
						</td>
					</xsl:if>
					<td>
						<xsl:attribute name="class">cl-var-spot-td cl-var-input-cell-<xsl:value-of select="$sExpPosition"/></xsl:attribute>
						<input type="text">
							<xsl:attribute name="class">cl-var-input</xsl:attribute>
						</input>
					</td>
					<xsl:if test="$sExpPosition='right'">
						<td>
							<xsl:attribute name="class">cl-var-txt-td cl-var-exp-right</xsl:attribute>
							<div>
								<xsl:attribute name="class">cl-var-txt</xsl:attribute>
								<xsl:value-of select="q_explanation" disable-output-escaping="yes"/>
							</div>
						</td>
					</xsl:if>
				</tr>
			</table>
		</div>
	</div>
</xsl:template>
<xsl:template match="item" name="var-oto">
	<xsl:param name="iPosition"/>

	<tr>
		<td>
			<xsl:attribute name="class">cl-left-part</xsl:attribute>
			<div>
				<xsl:attribute name="class">cl-var-target cl-var-target-<xsl:value-of select="$iPosition"/></xsl:attribute>
				<xsl:attribute name="data-target-id"><xsl:value-of select="$iPosition"/></xsl:attribute>
				<xsl:value-of select="q_target" disable-output-escaping="yes"/>
			</div>
		</td>
		<td>
			<xsl:attribute name="class">cl-center-part</xsl:attribute>
			<div>
				<xsl:attribute name="class">cl-oto-connector</xsl:attribute>
				&#160;
			</div>
		</td>
		<td>
			<xsl:attribute name="class">cl-right-part</xsl:attribute>
			<div>
				<xsl:attribute name="class">cl-var-bullet cl-var-bullet-<xsl:value-of select="$iPosition"/></xsl:attribute>
				<xsl:attribute name="data-bullet-id"><xsl:value-of select="$iPosition"/></xsl:attribute>
				<xsl:value-of select="q_bullet" disable-output-escaping="yes"/>
			</div>
		</td>
	</tr>
</xsl:template>
<xsl:template match="item" name="var-otm">
	<xsl:param name="iPosition"/>
	<xsl:param name="sContacts"/>
	<xsl:param name="iContactsLocal"/>
	<xsl:param name="iContactsMax"/>
	<xsl:param name="iContactsTotal"/>
	<xsl:param name="iContactsManual"/>
	<tr>
		<td>
			<xsl:attribute name="class">cl-left-part</xsl:attribute>
			<div>
				<xsl:attribute name="class">cl-var-target cl-var-target-<xsl:value-of select="$iPosition"/></xsl:attribute>
				<div>
					<xsl:attribute name="class">cl-var-target-text</xsl:attribute>
					<xsl:value-of select="q_target" disable-output-escaping="yes"/>
				</div>
				<xsl:if test="$sContacts!='none'">
					<xsl:variable name="_qty">
						<xsl:choose>
							<xsl:when test="$sContacts='byvar'"><xsl:value-of select="$iContactsLocal"/></xsl:when>
							<xsl:when test="$sContacts='auto'"><xsl:value-of select="$iContactsMax"/></xsl:when>
							<xsl:when test="$sContacts='total'"><xsl:value-of select="$iContactsTotal"/></xsl:when>
							<xsl:when test="$sContacts='manual'"><xsl:value-of select="$iContactsManual"/></xsl:when>
							<xsl:otherwise>1</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<div>
						<xsl:attribute name="class">cl-var-target-contacts</xsl:attribute>
						<table>
							<xsl:attribute name="class">cl-contacts-table</xsl:attribute>
							<tr>
								<xsl:call-template name="contacts">
									<xsl:with-param name="pStart" select="1"/>
									<xsl:with-param name="pEnd" select="$_qty"/>
								</xsl:call-template>
							</tr>
						</table>
					</div>
				</xsl:if>
			</div>
		</td>
		<td>
			<xsl:attribute name="class">cl-center-part</xsl:attribute>
			&#160;
		</td>
		<td>
			<xsl:attribute name="class">cl-right-part</xsl:attribute>
			&#160;
		</td>
	</tr>
</xsl:template>
<xsl:template match="item" name="var-mtm-target">
	<xsl:param name="iPosition"/>
	<xsl:param name="sContacts"/>
	<xsl:param name="iContactsLocal"/>
	<xsl:param name="iContactsMax"/>
	<xsl:param name="iContactsTotal"/>
	<xsl:param name="iContactsManual"/>

	<div>
		<xsl:attribute name="class">cl-var-target cl-var-target-<xsl:value-of select="$iPosition"/></xsl:attribute>
		<xsl:attribute name="data-group-number"><xsl:value-of select="$iPosition"/></xsl:attribute>
		<div>
			<xsl:attribute name="class">cl-var-target-text</xsl:attribute>
			<xsl:value-of select="q_target" disable-output-escaping="yes"/>
		</div>
		<xsl:if test="$sContacts!='none'">
			<xsl:variable name="_qty">
				<xsl:choose>
					<xsl:when test="$sContacts='byvar'"><xsl:value-of select="$iContactsLocal"/></xsl:when>
					<xsl:when test="$sContacts='auto'"><xsl:value-of select="$iContactsMax"/></xsl:when>
					<xsl:when test="$sContacts='total'"><xsl:value-of select="$iContactsTotal"/></xsl:when>
					<xsl:when test="$sContacts='manual'"><xsl:value-of select="$iContactsManual"/></xsl:when>
					<xsl:otherwise>1</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<div>
				<xsl:attribute name="class">cl-var-target-contacts</xsl:attribute>
				<table>
					<xsl:attribute name="class">cl-contacts-table</xsl:attribute>
					<tr>
						<xsl:call-template name="contacts">
							<xsl:with-param name="pStart" select="1"/>
							<xsl:with-param name="pEnd" select="$_qty"/>
						</xsl:call-template>
					</tr>
				</table>
			</div>
		</xsl:if>
	</div>
</xsl:template>
<xsl:template match="item" name="var-mtm-bullet">
	<xsl:param name="iPosition"/>
	<xsl:param name="sBulletId"/>
	<div>
		<xsl:attribute name="class">cl-var-bullet cl-var-bullet-<xsl:value-of select="$iPosition"/></xsl:attribute>
		<xsl:attribute name="data-element-id"><xsl:value-of select="$sBulletId"/></xsl:attribute>
		<xsl:attribute name="data-element-number"><xsl:value-of select="$iPosition"/></xsl:attribute>
		<xsl:value-of select="q_bullet" disable-output-escaping="yes"/>
	</div>
</xsl:template>
<xsl:template name="contacts">
	<xsl:param name="pStart"/>
	<xsl:param name="pEnd"/>

	<xsl:if test="not($pStart &gt; $pEnd)">
		<xsl:choose>
			<xsl:when test="$pStart = $pEnd">
				<td>
					<div>
						<xsl:attribute name="class">cl-contact</xsl:attribute>
						<xsl:value-of select="$pStart"/>
					</div>
				</td>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="vMid" select="floor(($pStart + $pEnd) div 2)"/>
				<xsl:call-template name="contacts">
					<xsl:with-param name="pStart" select="$pStart"/>
					<xsl:with-param name="pEnd" select="$vMid"/>
				</xsl:call-template>
				<xsl:call-template name="contacts">
					<xsl:with-param name="pStart" select="$vMid+1"/>
					<xsl:with-param name="pEnd" select="$pEnd"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:if>
</xsl:template>


<xsl:template name="spot-true-false">
	<xsl:param name="iPosition"/>
	<xsl:param name="sSkin"/>
	<xsl:param name="sButtonType"/>
	<xsl:param name="sCorrect"/>

	<xsl:choose>
		<xsl:when test="$sSkin='simple' or $sSkin='standard' or $sSkin='light'">
			<div>
				<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_Q_SPOT_<xsl:value-of select="$iPosition"/></xsl:attribute>
				<xsl:attribute name="class">cl-spot <xsl:choose><xsl:when test="$sCorrect='yes'">cl-spot-selected</xsl:when><xsl:otherwise>cl-spot-idle</xsl:otherwise></xsl:choose></xsl:attribute>
				<xsl:attribute name="data-vid"><xsl:value-of select="$iPosition"/></xsl:attribute>
				<div>
					<xsl:attribute name="class">cl-inner-part selected</xsl:attribute>
					<div>
						<xsl:attribute name="class">cl-spot-point</xsl:attribute>
						&#160;
					</div>
				</div>
			</div>
		</xsl:when>
	</xsl:choose>
</xsl:template>
<xsl:template name="spot-choice">
	<xsl:param name="iPosition"/>
	<xsl:param name="sSkin"/>
	<xsl:param name="sCorrect"/>

	<xsl:choose>
		<xsl:when test="$sSkin='simple'">
			<div>
				<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_Q_SPOT_<xsl:value-of select="$iPosition"/></xsl:attribute>
				<xsl:attribute name="class">cl-spot <xsl:choose><xsl:when test="$sCorrect='yes'">cl-spot-selected</xsl:when><xsl:otherwise>cl-spot-idle</xsl:otherwise></xsl:choose></xsl:attribute>
				<xsl:attribute name="data-vid"><xsl:value-of select="$iPosition"/></xsl:attribute>
				<div>
					<xsl:attribute name="class">cl-inner-part selected</xsl:attribute>
					<div>
						<xsl:attribute name="class">cl-spot-point</xsl:attribute>
						&#160;
					</div>
				</div>
			</div>
		</xsl:when>
		<xsl:when test="$sSkin='standard'">
			<div>
				<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_Q_SPOT_<xsl:value-of select="$iPosition"/></xsl:attribute>
				<xsl:attribute name="class">cl-spot <xsl:choose><xsl:when test="$sCorrect='yes'">cl-spot-selected</xsl:when><xsl:otherwise>cl-spot-idle</xsl:otherwise></xsl:choose></xsl:attribute>
				<xsl:attribute name="data-vid"><xsl:value-of select="$iPosition"/></xsl:attribute>
				<div>
					<xsl:attribute name="class">cl-inner-part selected</xsl:attribute>
					<div>
						<xsl:attribute name="class">cl-spot-point</xsl:attribute>
						&#160;
					</div>
				</div>
			</div>
		</xsl:when>
		<xsl:when test="$sSkin='light'">
			<div>
				<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_Q_SPOT_<xsl:value-of select="$iPosition"/></xsl:attribute>
				<xsl:attribute name="class">cl-spot <xsl:choose><xsl:when test="$sCorrect='yes'">cl-spot-selected</xsl:when><xsl:otherwise>cl-spot-idle</xsl:otherwise></xsl:choose></xsl:attribute>
				<xsl:attribute name="data-vid"><xsl:value-of select="$iPosition"/></xsl:attribute>
				<div>
					<xsl:attribute name="class">cl-inner-part selected</xsl:attribute>
					<div>
						<xsl:attribute name="class">cl-spot-point</xsl:attribute>
						&#160;
					</div>
				</div>
			</div>
		</xsl:when>
	</xsl:choose>
</xsl:template>
<xsl:template name="spot-select">
	<xsl:param name="iPosition"/>
	<xsl:param name="sSkin"/>

	<xsl:choose>
		<xsl:when test="$sSkin='simple'">
			<div>
				<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_Q_SPOT_<xsl:value-of select="$iPosition"/></xsl:attribute>
				<xsl:attribute name="class">cl-spot cl-spot-idle</xsl:attribute>
				<xsl:attribute name="data-vid"><xsl:value-of select="$iPosition"/></xsl:attribute>
				<div>
					<xsl:attribute name="class">cl-inner-part selected</xsl:attribute>
					<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 14px 14px">
						<path>
							<xsl:attribute name="d">M0.7,7.7 L2.1,5.6 L2.8,5.6 L4.9,8.96 L14.0,0.0 L14.0,0.7 L5.6,12.6 Z</xsl:attribute>
							<xsl:attribute name="stroke">none</xsl:attribute>
							<xsl:attribute name="stroke-width">0</xsl:attribute>
						</path>
					</svg>
				</div>
			</div>
		</xsl:when>
		<xsl:when test="$sSkin='standard'">
			<div>
				<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_Q_SPOT_<xsl:value-of select="$iPosition"/></xsl:attribute>
				<xsl:attribute name="class">cl-spot cl-spot-idle</xsl:attribute>
				<xsl:attribute name="data-vid"><xsl:value-of select="$iPosition"/></xsl:attribute>
				<div>
					<xsl:attribute name="class">cl-inner-part selected</xsl:attribute>
					<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 14px 14px">
						<path>
							<xsl:attribute name="d">M0.7,7.7 L2.1,5.6 L2.8,5.6 L4.9,8.96 L14.0,0.0 L14.0,0.7 L5.6,12.6 Z</xsl:attribute>
							<xsl:attribute name="stroke">none</xsl:attribute>
							<xsl:attribute name="stroke-width">0</xsl:attribute>
						</path>
					</svg>
				</div>
			</div>
		</xsl:when>
		<xsl:when test="$sSkin='light'">
			<div>
				<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_Q_SPOT_<xsl:value-of select="$iPosition"/></xsl:attribute>
				<xsl:attribute name="class">cl-spot cl-spot-idle</xsl:attribute>
				<xsl:attribute name="data-vid"><xsl:value-of select="$iPosition"/></xsl:attribute>
					<div>
						<xsl:attribute name="class">cl-inner-part selected</xsl:attribute>
						<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 14px 14px">
							<path>
								<xsl:attribute name="d">M0.7,7.7 L2.1,5.6 L2.8,5.6 L4.9,8.96 L12.0,2.0 L12.8,3.7 L5.6,12.6 Z</xsl:attribute>
								<xsl:attribute name="stroke">none</xsl:attribute>
								<xsl:attribute name="stroke-width">0</xsl:attribute>
							</path>
						</svg>
					</div>
				</div>
		</xsl:when>
	</xsl:choose>
</xsl:template>
<xsl:template name="spot-order">
	<xsl:param name="iPosition"/>
	<xsl:param name="sSkin"/>

	<xsl:choose>
		<xsl:when test="$sSkin='simple'">
			<div>
				<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_Q_SPOT_<xsl:value-of select="$iPosition"/></xsl:attribute>
				<xsl:attribute name="class">cl-spot cl-spot-basic</xsl:attribute>
				<xsl:attribute name="data-vid"><xsl:value-of select="$iPosition"/></xsl:attribute>
				<div>
					<xsl:attribute name="class">cl-inner-part arrow arrow-up</xsl:attribute>
					<svg xmlns="http://www.w3.org/2000/svg" width="20" height="10" viewBox="0 0 20px 10px">
						<path>
							<xsl:attribute name="d">M10,0 L18,4 L18,8 L10,4 L2,8 L2,4 Z</xsl:attribute>
							<xsl:attribute name="stroke">none</xsl:attribute>
							<xsl:attribute name="stroke-width">0</xsl:attribute>
						</path>
					</svg>
				</div>
				<div>
					<xsl:attribute name="class">cl-inner-part arrow arrow-down</xsl:attribute>
					<svg xmlns="http://www.w3.org/2000/svg" width="20" height="10" viewBox="0 0 20px 10px">
						<path>
							<xsl:attribute name="d">M10,10 L18,6 L18,2 L10,6 L2,2 L2,6 Z</xsl:attribute>
							<xsl:attribute name="stroke">none</xsl:attribute>
							<xsl:attribute name="stroke-width">0</xsl:attribute>
						</path>
					</svg>
				</div>
			</div>
		</xsl:when>
		<xsl:when test="$sSkin='standard'">
			<div>
				<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_Q_SPOT_<xsl:value-of select="$iPosition"/></xsl:attribute>
				<xsl:attribute name="class">cl-spot cl-spot-basic</xsl:attribute>
				<xsl:attribute name="data-vid"><xsl:value-of select="$iPosition"/></xsl:attribute>
				<div>
					<xsl:attribute name="class">cl-inner-part arrow arrow-up</xsl:attribute>
					<svg xmlns="http://www.w3.org/2000/svg" width="20" height="10" viewBox="0 0 20px 10px">
						<path>
							<xsl:attribute name="d">M10,0 L18,4 L18,8 L10,4 L2,8 L2,4 Z</xsl:attribute>
							<xsl:attribute name="stroke">none</xsl:attribute>
							<xsl:attribute name="stroke-width">0</xsl:attribute>
						</path>
					</svg>
				</div>
				<div>
					<xsl:attribute name="class">cl-inner-part arrow arrow-down</xsl:attribute>
					<svg xmlns="http://www.w3.org/2000/svg" width="20" height="10" viewBox="0 0 20px 10px">
						<path>
							<xsl:attribute name="d">M10,10 L18,6 L18,2 L10,6 L2,2 L2,6 Z</xsl:attribute>
							<xsl:attribute name="stroke">none</xsl:attribute>
							<xsl:attribute name="stroke-width">0</xsl:attribute>
						</path>
					</svg>
				</div>
			</div>
		</xsl:when>
		<xsl:when test="$sSkin='light'">
			<div>
				<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_Q_SPOT_<xsl:value-of select="$iPosition"/></xsl:attribute>
				<xsl:attribute name="class">cl-spot cl-spot-idle</xsl:attribute>
				<xsl:attribute name="data-vid"><xsl:value-of select="$iPosition"/></xsl:attribute>
				<div>
					<xsl:attribute name="class">cl-inner-part selected</xsl:attribute>
					<span>
						<xsl:attribute name="class">order-up</xsl:attribute>
						&#8593;
					</span>
					<span>
						<xsl:attribute name="class">order-down</xsl:attribute>
						&#8595;
					</span>
				</div>
			</div>
		</xsl:when>
	</xsl:choose>
</xsl:template>
<xsl:template name="scoring">
	<xsl:variable name="score">
		<xsl:choose>
			<xsl:when test="q_scored='yes'">
				<xsl:choose>
					<xsl:when test="q_scoring_type='var'">
						<xsl:for-each select="q_variants/item">
							<xsl:sort data-type="number" order="descending" select="q_weight_by_connection"/>
							<xsl:if test="position()=1"><xsl:value-of select="q_weight_by_connection"/></xsl:if>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="q_pointset_auto='yes'">
								<xsl:choose>
									<xsl:when test="q_att_auto='yes'"><xsl:value-of select="number(q_weight) * (count(q_variants/item)-1)"/></xsl:when>
									<xsl:otherwise><xsl:value-of select="number(q_weight) * number(q_attempts)"/></xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise><xsl:value-of select="q_weight"/></xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
				</xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="correct.qty"><xsl:value-of select="count(q_variants/item[q_right='yes'])"/></xsl:variable>

	<div>
		<xsl:attribute name="style">display: inline; position: absolute; top: 0px; left: 0px; width: <xsl:value-of select="q_feedbackwidth"/>px; background-color: #EEEEEE; border: solid 2px #6666CC; font-family: Tahoma, sans-serif; font-size: 10px; padding: 10px;</xsl:attribute>
		<p align="center">
			<xsl:attribute name="style">font-family: Tahoma, sans-serif; font-size: 11px; font-weight: bold; color: #6666CC;</xsl:attribute>
			<xsl:value-of select="hidden.label.header"/>
		</p>
		<table width="100%" border="0" cellpadding="3" cellspacing="0">
			<xsl:attribute name="style">font-family: Tahoma, sans-serif; font-size: 10px;</xsl:attribute>
			<tr>
				<td align="right" valign="top" style="border-bottom: solid 1px #999999; font-weight: bold;"><xsl:value-of select="hidden.label.question"/>&#160;</td>
				<td valign="top" style="border-bottom: solid 1px #999999">
					<xsl:choose>
						<xsl:when test="q_scored='yes'"><xsl:value-of select="hidden.label.credit"/></xsl:when>
						<xsl:otherwise><xsl:value-of select="hidden.label.nocredit"/></xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
			<xsl:if test="q_scored='yes'">
				<tr>
					<td align="right" valign="top" style="border-bottom: solid 1px #999999; font-weight: bold;"><xsl:value-of select="hidden.label.scoring"/>&#160;</td>
					<td valign="top" style="border-bottom: solid 1px #999999">
						<xsl:choose>
							<xsl:when test="q_scoring_type='byobj'"><xsl:value-of select="hidden.label.byobj"/></xsl:when>
							<xsl:when test="q_scoring_type='var'"><xsl:value-of select="hidden.label.var"/></xsl:when>
							 <xsl:otherwise>
								<xsl:choose>
									<xsl:when test="q_pointset_auto='yes'"><xsl:value-of select="hidden.label.regressive"/></xsl:when>
									<xsl:otherwise><xsl:value-of select="hidden.label.plain"/></xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
				<tr>
					<td align="center" colspan="2" nowrap="nowrap" style="border-bottom: solid 1px #999999; font-weight: bold;"><xsl:value-of select="hidden.label.maxscore"/>&#160;</td>
				</tr>
				<xsl:choose>
					<xsl:when test="count(q_scoreboards/item) &lt; 1">
						<tr>
							<td align="center" colspan="2" style="border-bottom: solid 1px #999999; font-weight: bold; color: #CC0000"><xsl:value-of select="hidden.label.noobj"/></td>
						</tr>
					</xsl:when>
					<xsl:when test="q_scoring_type!='var' and number($correct.qty)!=1">
						<tr>
							<td align="center" colspan="2" style="border-bottom: solid 1px #999999; font-weight: bold; color: #CC0000"><xsl:value-of select="hidden.label.toomany"/></td>
						</tr>
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each select="q_scoreboards/item">
							<tr>
								<td align="right" valign="top" style="border-bottom: solid 1px #999999; font-style: italic;"><xsl:value-of select="q_board"/></td>
								<td valign="top" style="border-bottom: solid 1px #999999">
									<xsl:choose>
										<xsl:when test="../../q_scoring_type='byobj'">
											<xsl:choose>
												<xsl:when test="../../q_scored='yes'"><xsl:value-of select="q_weight_byobj"/></xsl:when>
												<xsl:otherwise>0</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<xsl:otherwise>
											<xsl:choose>
												<xsl:when test="../../q_scored='yes'"><xsl:value-of select="format-number($score, '#.#######')"/></xsl:when>
												<xsl:otherwise>0</xsl:otherwise>
											</xsl:choose>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
						</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</table>
		<xsl:if test="q_scored='yes'"><p style="margin-top: 6px; text-align: justify"><xsl:value-of select="hidden.label.useit"/></p></xsl:if>
		<p style="margin-top: 0px; color: #999999; text-align: justify"><xsl:value-of select="hidden.label.hide"/></p>
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
