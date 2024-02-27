<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<!--
'*	media_003_video#.xsl
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
		<xsl:attribute name="class">clo-media_003_video</xsl:attribute>
		<xsl:choose>
			<xsl:when test="$main.sMoviePath=''">
				<table>
					<xsl:attribute name="class">cl-no-src-table</xsl:attribute>
					<xsl:attribute name="style">width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px;</xsl:attribute>
					<tr>
						<td>
							<xsl:attribute name="class">cl-no-src-cell</xsl:attribute>
							<svg height="54" viewBox="0 0 16 18" width="48" xmlns="http://www.w3.org/2000/svg">
								<g fill="none" fill-rule="evenodd" id="Page-1" stroke="none" stroke-width="1">
									<g fill="#0080C0" transform="translate(-214.000000, -465.000000)">
										<g transform="translate(214.000000, 465.000000)">
											<path d="M14,0 L14,2 L12,2 L12,0 L4,0 L4,2 L2,2 L2,0 L0,0 L0,18 L2,18 L2,16 L4,16 L4,18 L12,18 L12,16 L14,16 L14,18 L16,18 L16,0 L14,0 L14,0 Z M4,14 L2,14 L2,12 L4,12 L4,14 L4,14 Z M4,10 L2,10 L2,8 L4,8 L4,10 L4,10 Z M4,6 L2,6 L2,4 L4,4 L4,6 L4,6 Z M14,14 L12,14 L12,12 L14,12 L14,14 L14,14 Z M14,10 L12,10 L12,8 L14,8 L14,10 L14,10 Z M14,6 L12,6 L12,4 L14,4 L14,6 L14,6 Z"/>
										</g>
									</g>
								</g>
							</svg>
							<br/>
							<xsl:value-of select="hidden.label.nosrc"/>
						</td>
					</tr>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$main.sPlayerType='html5'">
						<table>
							<xsl:attribute name="class">cl-html5-table</xsl:attribute>
							<xsl:attribute name="style">width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px;</xsl:attribute>
							<tr>
								<td>
									<xsl:attribute name="class">cl-html5-cell</xsl:attribute>
									<svg height="64" viewBox="0 0 512 512" width="64" xmlns="http://www.w3.org/2000/svg">
										<g transform="translate(0.32800146,0.07000866)">
											<g style="fill:#e44d26;">
												<path d="m 511.672,255.92999 c 0,141.3849 -114.61511,256 -256,256 -141.3849,0 -256.00000293,-114.6151 -256.00000293,-256 C -0.32800293,114.5451 114.2871,-0.07000732 255.672,-0.07000732 c 141.38489,0 256,114.61510732 256,255.99999732 z"/>
											</g>
											<g transform="translate(546.9375,-48.721188)">
												<polygon points="255.8,486.486 389.249,449.489 418.938,116.909 93.063,116.909 122.719,449.542" style="fill: #ffffff; fill-rule:evenodd" transform="matrix(0.67510549,0,0,0.67510549,-464.09284,131.48662)"/>
												<path d="m -353.99731,163.21455 h -12.80338 v -13.82818 h -13.99561 v 41.87544 h 13.99629 v -14.02262 h 12.8027 v 14.02262 h 13.99629 v -41.87544 h -13.99697 v 13.82818 z m 20.08101,0.0581 h 12.32203 v 27.9892 h 13.99696 v -27.9892 h 12.32742 v -13.88624 h -38.64641 v 13.88624 z m 68.35173,0.82768 -8.97823,-14.71392 h -14.59375 v 41.87544 h 13.69451 v -20.75612 l 9.63578,14.88945 h 0.24102 l 9.62903,-14.88945 v 20.75612 h 13.93822 v -41.87544 h -14.59983 l -8.96675,14.71392 z m 44.53401,13.31983 v -28.03375 h -14.00034 v 41.87544 h 33.68372 v -13.84169 h -19.68338 z" style="fill: #ffffff; fill-rule:evenodd"/>
												<path d="m -360.5,255.75 138.25,0 -2.25,28.5 -105.75,0 3,27.5 99.5,0 -7,85.25 -56,15.25 -56.75,-15.25 -4.25,-43.5 27.75,0 2.25,21.5 30.75,8.75 30.75,-8.75 3,-35.25 -95.5,0 z" style="fill: #e44d26; stroke:none" transform="translate(-0.32800146,-0.07000866)"/>
											</g>
										</g>
									</svg>
									<br/>
									<xsl:value-of select="$main.sMoviePath"/>
								</td>
							</tr>
						</table>
					</xsl:when>
					<xsl:when test="$main.sPlayerType='wmp'">
						<table>
							<xsl:attribute name="class">cl-wmp-table</xsl:attribute>
							<xsl:attribute name="style">width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px;</xsl:attribute>
							<tr>
								<td>
									<xsl:attribute name="class">cl-wmp-cell</xsl:attribute>
									<svg height="64" viewBox="0 0 512 512" width="64" xmlns="http://www.w3.org/2000/svg">
										<g transform="translate(136.1786,108.25001)">
											<path d="m -733.62329,72.267944 c 0,203.804876 -165.21649,369.021366 -369.02141,369.021366 -203.8048,0 -369.0213,-165.21649 -369.0213,-369.021366 0,-203.804874 165.2165,-369.021364 369.0213,-369.021364 203.80492,0 369.02141,165.21649 369.02141,369.021364 z"  style="fill: #0db3f1; fill-rule: nonzero; stroke:none" transform="matrix(0.69372682,0,0,0.69372682,884.75558,97.615782)"/>
											<path d="m 17.751219,7.7603724 c 21.735,-8.66709995 40.802,-13.0217 58.2513,-13.3438 9.1617,0 17.8097,0.9851 26.009201,2.8903 12.4813,3.18560005 29.75431,12.5389 36.33621,16.2954996 L 107.09852,120.01198 C 91.174819,109.85748 71.958319,99.994282 45.972219,99.729782 h -0.023 c -17.3305,0 -36.1599003,3.990498 -57.9792,12.182398 L 17.751219,7.7603724 z m 48.9401,255.1890176 c 7.728,-26.1242 26.2852,-89.22091 31.8244,-108.08091 -4.0174,-2.438 -8.1114,-4.8837 -12.3012,-7.1453 -16.0808,-8.2225 -31.7055,-12.3894 -46.46,-12.3894 -2.001,0 -4.0097,0.061 -6.0413,0.2339 -18.8294,1.5486 -36.0142003,6.4975 -47.0849,10.3385 -2.9363,1.0695 -5.9263,2.2003 -9.0352,3.4538 L -52.67869,253.77239 c 20.803509,-7.659 39.184309,-11.3812 56.0319087,-11.3812 27.2396003,0 46.9966003,10.1315 63.3381003,20.5582 z M 250.98273,185.13648 c -19.7531,6.3442 -38.7013,9.5604 -56.4228,9.5604 -32.3265,0 -54.9585,-10.4267 -69.2339,-20.4355 L 94.858719,279.60139 c 9.039001,5.152 39.445011,21.482 62.736311,21.482 18.7987,0 39.8399,-4.7993 64.2927,-14.6893 l 29.095,-101.25761 z M 292.32144,42.498072 c -19.81831,7.659 -39.15371,11.5613 -57.62271,11.5613 -30.889,0 -53.6667,-10.6604 -68.425,-20.9108 l -30.981,106.704708 c 20.8073,13.3171 43.2285,20.0752 66.7537,20.0752 19.1858,0 39.0578,-4.5847 59.1138,-13.6428 l -0.061,-0.7399 1.2574,-0.3028 29.96511,-102.744908 z" style="fill: #ffffff;"/>
										</g>
									</svg>
									<br/>
									<xsl:value-of select="$main.sMoviePath"/>
								</td>
							</tr>
						</table>
					</xsl:when>
					<xsl:when test="$main.sPlayerType='qtp'">
						<table>
							<xsl:attribute name="class">cl-qt-table</xsl:attribute>
							<xsl:attribute name="style">width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px;</xsl:attribute>
							<tr>
								<td>
									<xsl:attribute name="class">cl-qt-cell</xsl:attribute>
									<img>
										<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>qt.png</xsl:attribute>
									</img>
									<br/>
									<xsl:value-of select="$main.sMoviePath"/>
								</td>
							</tr>
						</table>
					</xsl:when>
					<xsl:when test="$main.sPlayerType='flv'">
						<table>
							<xsl:attribute name="class">cl-flv-table</xsl:attribute>
							<xsl:attribute name="style">width: <xsl:value-of select="$width"/>px; height: <xsl:value-of select="$height"/>px;</xsl:attribute>
							<tr>
								<td>
									<xsl:attribute name="class">cl-flv-cell</xsl:attribute>
									<img>
										<xsl:attribute name="src"><xsl:value-of select="$imagesFolder"/>flv.png</xsl:attribute>
									</img>
									<br/>
									<xsl:value-of select="$main.sMoviePath"/>
								</td>
							</tr>
						</table>
					</xsl:when>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</div>
</xsl:template>
</xsl:stylesheet>
