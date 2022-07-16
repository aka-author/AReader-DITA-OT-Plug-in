<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cpm="http://www.cpmonster.com/xslt/funcs"
    exclude-result-prefixes="cpm xs"
    version="2.0">
    
    <xsl:import href="toc.xsl"/>
    
    <xsl:template match="*[cpm:isMap(.)]" mode="html">
        <html>
            <head>
                <title>User's Guide</title>
                <xsl:apply-templates select="." mode="htmlLinkCss"/>
                <xsl:apply-templates select="." mode="htmlScriptJs"/>
            </head>
            <body>
                
                <xsl:apply-templates select="." mode="htmlToc">
                    <xsl:with-param name="currTopicId" select="''"/>
                </xsl:apply-templates>
                
            </body>
        </html>
    </xsl:template>
    
</xsl:stylesheet>