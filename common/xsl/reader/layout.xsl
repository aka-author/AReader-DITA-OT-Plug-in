<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://www.cpmonster.com/xslt/funcs"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Graphic files 
    -->

    <xsl:template match="*" mode="uriLogo">
        <xsl:value-of select="'front/layout/img/logo.png'"/>
    </xsl:template>

    <xsl:function name="cpm:uriLogo">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="uriLogo"/>
    </xsl:function>


    <!-- 
        Page core layout and behavior
    -->

    <xsl:template match="*" mode="htmlLinkShellCss">
        <link href="front/shell/css/shell.css" rel="stylesheet"/>
    </xsl:template>

    <xsl:template match="*" mode="htmlScriptShellJs">
        <!--
        <script src="front/shell/js/utils.js"/>
        <script src="front/shell/js/bureaucrat.js"/>
        <script src="front/shell/js/uicontrol.js"/>
        <script src="front/shell/js/toc.js"/>
        <script src="front/shell/js/splitter.js"/>
        <script src="front/shell/js/app.js"/>
        <script src="front/shell/js/shell.js"/>
        -->
        <script src="front/shell/js/arnav.js"/>
        <script src="front/shell/js/reader.js"/>
        <script src="!docdto.js"/>
    </xsl:template>


    <!-- 
        Custom layout and behavior
    -->

    <xsl:template match="*" mode="htmlLinkAppCss">
        <link href="front/layout/css/layout.css" rel="stylesheet"/>
    </xsl:template>

    <xsl:template match="*" mode="htmlScriptAppJs">
        <script src="front/layout/js/layout.js"/>
    </xsl:template>

</xsl:stylesheet>
