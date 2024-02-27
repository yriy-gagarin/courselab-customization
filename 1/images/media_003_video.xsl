<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<!--
'*	media_003_video.xsl
'*	Copyright (c) Websoft Ltd.  All rights reserved.
-->
<xsl:output method="xml" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:param name="moduleImagesFolder"></xsl:param>
<xsl:param name="imagesFolder"></xsl:param>
<xsl:param name="objectID"></xsl:param>
<xsl:param name="width"></xsl:param>
<xsl:param name="height"></xsl:param>
<xsl:template match="/"><xsl:apply-templates select="params"/></xsl:template>

<xsl:template match="params">

	<xsl:variable name="main.sMoviePath">
		<xsl:choose>
			<xsl:when test="source='file'"><xsl:value-of select="video_uri"/></xsl:when>
			<xsl:when test="source='url'"><xsl:value-of select="video_url"/></xsl:when>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="main.sPlayerType">
		<xsl:choose>
			<xsl:when test="player!='auto'"><xsl:value-of select="player"/></xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="contains($main.sMoviePath,'.ogg') or contains($main.sMoviePath,'.ogv')">html5</xsl:when>
					<xsl:when test="contains($main.sMoviePath,'.webm')">html5</xsl:when>
					<xsl:when test="contains($main.sMoviePath,'.mp4')">html5</xsl:when>
					<xsl:when test="contains($main.sMoviePath,'.mp3')">html5</xsl:when>
					<xsl:when test="contains($main.sMoviePath,'.mov') or contains($main.sMoviePath,'.3gp')">qtp</xsl:when>
					<xsl:when test="contains($main.sMoviePath,'.flv') or contains($main.sMoviePath,'.f4v')">flv</xsl:when>
					<xsl:otherwise>wmp</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<div>
		<xsl:attribute name="class">cl-container unselectable</xsl:attribute>
		<xsl:attribute name="data-player"><xsl:value-of select="$main.sPlayerType"/></xsl:attribute>
		<xsl:choose>
			<xsl:when test="$main.sPlayerType='html5'">
				<video>
					<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_HTML5</xsl:attribute>
					<xsl:attribute name="src"><xsl:value-of select="$main.sMoviePath"/></xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute>
					<xsl:attribute name="height"><xsl:value-of select="$height"/></xsl:attribute>
					<xsl:attribute name="autobuffer">true</xsl:attribute>
					<xsl:if test="video_autostart='yes'"><xsl:attribute name="autoplay">true</xsl:attribute></xsl:if>
					<xsl:if test="video_controls!='no' and video_controls!='none'"><xsl:attribute name="controls">true</xsl:attribute></xsl:if>
				</video>
			</xsl:when>
			<xsl:when test="$main.sPlayerType='qtp'">
				<object>
					<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_QTP</xsl:attribute>
					<xsl:attribute name="style">position: absolute; top: 0px; left: 0px; width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px;</xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute>
					<xsl:attribute name="height"><xsl:value-of select="$height"/></xsl:attribute>
					<xsl:attribute name="type">video/quicktime</xsl:attribute>
					<xsl:attribute name="data"><xsl:value-of select="$main.sMoviePath"/></xsl:attribute>
					<param name="scale" value="tofit"/>
					<param name="postdomevents" value="true" />
					<param name="autoplay">
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="video_autostart='yes'">true</xsl:when>
								<xsl:otherwise>false</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</param>
					<param name="controller">
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="video_controls!='no' and video_controls!='none'">true</xsl:when>
								<xsl:otherwise>false</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</param>
				</object>
			</xsl:when>
			<xsl:when test="$main.sPlayerType='wmp'">
				<object>
					<xsl:attribute name="id"><xsl:value-of select="$objectID"/>_WMP</xsl:attribute>
					<xsl:attribute name="style">position: absolute; top: 0px; left: 0px; width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px;</xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute>
					<xsl:attribute name="height"><xsl:value-of select="$height"/></xsl:attribute>
					<xsl:attribute name="type">application/x-ms-wmp</xsl:attribute>
					<xsl:attribute name="data"><xsl:value-of select="$main.sMoviePath"/></xsl:attribute>
					<param name="uiMode">
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="video_invisible='no'">
									<xsl:choose>
										<xsl:when test="video_controls!='no' and video_controls!='none'"><xsl:value-of select="video_controls"/></xsl:when>
										<xsl:otherwise>none</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>invisible</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</param>
					<param name="ShowControls">
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="video_controls='no' or video_controls='none'">0</xsl:when>
								<xsl:otherwise>1</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</param>
					<param name="ShowStatusBar" value="0"/>
					<param name="AutoStart">
						<xsl:attribute name="value">
							<xsl:choose>
								<xsl:when test="video_autostart='no'">0</xsl:when>
								<xsl:otherwise>1</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</param>
					<param name="src">
						<xsl:attribute name="value"><xsl:value-of select="$main.sMoviePath"/></xsl:attribute>
					</param>
					<param name="AutoSize" value="1" />
					<param name="AutoRewind" value="0" />
					<param name="SendPlayStateChangeEvents" value="1"/>
					<param name="AllowChangeDisplaySize" value="0" />
				</object>
			</xsl:when>
			<xsl:when test="$main.sPlayerType='flv'">
				<div style="display: none">
					<xsl:attribute name="preload1"><xsl:value-of select="$imagesFolder"/>player0.swf</xsl:attribute>
					<xsl:attribute name="preload2"><xsl:value-of select="$imagesFolder"/>player1.swf</xsl:attribute>
					<xsl:attribute name="preload3"><xsl:value-of select="$main.sMoviePath"/></xsl:attribute>
					&#160;
				</div>
			</xsl:when>
		</xsl:choose>
	</div>

</xsl:template>
</xsl:stylesheet>
