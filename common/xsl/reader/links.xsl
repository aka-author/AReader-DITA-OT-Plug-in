<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cpm="http://www.cpmonster.com/xslt/funcs"
    exclude-result-prefixes="cpm xs"
    version="2.0">
    
    <xsl:import href="queries.xsl"/>
    
    <!-- 
        Assembling navigation links
    -->
    
    <!-- Page file name -->
    
    <xsl:template match="*" mode="pageFileName">
        <xsl:variable name="items" select="tokenize(@xtrf, '\\|/')"/>
        <xsl:variable name="fileName" select="$items[count($items)]"/>
        <xsl:variable name="fileNameBase" select="substring-before($fileName, '.')"/>
        <xsl:value-of select="concat($fileNameBase, '.html')"/>
    </xsl:template>
    
    <xsl:function name="cpm:pageFileName">
        <xsl:param name="topic"/>
        <xsl:apply-templates select="$topic" mode="pageFileName"/>
    </xsl:function>
    
    <xsl:template match="*" mode="htmlNavLink">
        <xsl:param name="currTopicId" select="''"/>
        <xsl:param name="className" select="''"/>
    </xsl:template>
    
    <xsl:template match="*[cpm:isTopic(.)]" mode="htmlNavLink">
        
        <xsl:param name="currTopicId" select="''"/>
        <xsl:param name="className" select="''"/>
        
        <xsl:choose>
            <xsl:when test="cpm:id(.) != $currTopicId and cpm:hasDirectContent(.)">
                <a class="{$className}" href="{cpm:pageFileName(.)}">
                    <xsl:value-of select="cpm:plainTextTitle(.)"/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <span class="{$className}">
                    <xsl:value-of select="cpm:plainTextTitle(.)"/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
</xsl:stylesheet>