<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cpm="http://www.cpmonster.com/xslt/funcs"
    exclude-result-prefixes="cpm xs"
    version="2.0">
    
    <xsl:import href="links.xsl"/>
    
    <xsl:template match="*" mode="htmlBreadCrambsEntry"/>
    
    <xsl:template match="*[cpm:isTopic(.)]" mode="htmlBreadCrambsEntry">
        
        <xsl:param name="currTopicId" select="''"/>
        
        <span class="breadCrambsItem">
            
            <xsl:if test="parent::*[cpm:isTopic(.)]">
                <xsl:text> / </xsl:text>
            </xsl:if>
            
            <xsl:apply-templates select="." mode="htmlNavLink">
                <xsl:with-param name="currTopicId" select="$currTopicId"/>
                <xsl:with-param name="className" select="'breadCrambsItemLink'"/>
            </xsl:apply-templates>
            
        </span>
        
    </xsl:template>
    
    <xsl:template match="*" mode="htmlBreadCrambs"/>
    
    <xsl:template match="*[cpm:isTopic(.)]" mode="htmlBreadCrambs">
        
        <xsl:variable name="currTopicId" select="cpm:id(.)"/>
        
        <xsl:variable name="breadCrambs">
            <xsl:for-each select="ancestor::*">
                <xsl:apply-templates select="." mode="htmlBreadCrambsEntry">
                    <xsl:with-param name="currTopicId" select="$currTopicId"/>
                </xsl:apply-templates>
            </xsl:for-each>
        </xsl:variable>
        
        <div class="breadCrambs">
            <xsl:copy-of select="reverse($breadCrambs)"/>
        </div>
        
    </xsl:template>
    
    
</xsl:stylesheet>