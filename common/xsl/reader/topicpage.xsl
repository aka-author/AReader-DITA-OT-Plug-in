<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cpm="http://www.cpmonster.com/xslt/funcs"
    exclude-result-prefixes="cpm xs"
    version="2.0">
    
    <xsl:import href="splitter.xsl"/>
    <xsl:import href="breadcrambs.xsl"/>
    <xsl:import href="toc.xsl"/>
    <xsl:import href="layout.xsl"/>
    
    <!-- 
        Transforming topics to pages
    -->
    
    <!-- Page title -->
    
    <xsl:template match="*" mode="htmlTitle">
        <title>
            <xsl:value-of select="cpm:plainTextTitle(.)"/>
        </title>
    </xsl:template>
    
    
    <!-- Head -->
    
    <xsl:template match="*" mode="htmlHead">
        <head>
            <xsl:apply-templates select="." mode="htmlTitle"/>
            <xsl:apply-templates select="." mode="htmlLinkShellCss"/>
            <xsl:apply-templates select="." mode="htmlLinkAppCss"/>
            <xsl:apply-templates select="." mode="htmlScriptShellJs"/>
            <xsl:apply-templates select="." mode="htmlScriptAppJs"/>
        </head>
    </xsl:template>
    
    
    <!-- Header and footer -->
    
    <xsl:template match="*" mode="htmlLogo">
        <div class="logo">
            <img src="{cpm:uriLogo(.)}" class="logo"/>
        </div>
    </xsl:template>
    
    <xsl:template match="*" mode="htmlHeader">
        <div id="header">
            <xsl:apply-templates select="." mode="htmlLogo"/>
            <xsl:apply-templates select="." mode="htmlBreadCrambs"/>
        </div>
    </xsl:template>
    
    <xsl:template match="*" mode="htmlFooter">
        <div id="footer">
            <p>footer</p>
        </div>
    </xsl:template>
    
    
    <!-- TOC navigation pane -->
    
    <xsl:template match="*[cpm:isTopic(.)]" mode="htmlTocPane">
        <div id="pageTocArea">
            <div id="tocTree"></div>
            <!--
            <xsl:apply-templates select="." mode="htmlToc">
                <xsl:with-param name="currTopicId" select="cpm:id(.)"/>
            </xsl:apply-templates>
            -->
        </div>
    </xsl:template>
    
    
    <!-- Main content of a topic -->
    
    <xsl:template match="*" mode="html">
        <xsl:apply-templates select="node()"/>
    </xsl:template>
    
    <xsl:template match="title" mode="html">
        <h1>
            <xsl:value-of select="cpm:plainTextTitle(..)"/>
        </h1>
    </xsl:template>
    
    
    <xsl:template match="*[cpm:isTopic(.)]" mode="htmlTopicPane">
        <div id="topic">
            <xsl:apply-templates select="title" mode="html"/>
            <xsl:apply-templates select="*[cpm:isBody(.)]" mode="html"/>
        </div>
    </xsl:template>
    
    
    <!-- Body -->
    
    <xsl:template match="*" mode="htmlBody"/>
    
    <xsl:template match="*[cpm:isTopic(.)]" mode="htmlBody">
        <body onload="GLOBAL_APP.run()" onunload="GLOBAL_APP.quit()">
            <xsl:apply-templates select="." mode="htmlHeader"/>
            <xsl:element name="div" use-attribute-sets="pageContentArea">
                <xsl:apply-templates select="." mode="htmlTocPane"/>
                <xsl:call-template name="htmlPageSplitter"/>
                <xsl:apply-templates select="." mode="htmlTopicPane"/>
            </xsl:element>
            <xsl:apply-templates select="." mode="htmlFooter"/>
        </body>
    </xsl:template>
    
    <xsl:template match="*[cpm:isTopic(.)]" mode="html">
        <xsl:text disable-output-escaping="yes">
        <![CDATA[<!DOCTYPE html>]]>
        </xsl:text>
        <html>
            <xsl:apply-templates select="." mode="htmlHead"/>
            <xsl:apply-templates select="." mode="htmlBody"/>
        </html>
    </xsl:template>
    
    
</xsl:stylesheet>