<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://www.cpmonster.com/xslt/funcs"
    exclude-result-prefixes="cpm xs" version="2.0">

    <xsl:import href="../../cfg/webhelp/attrs/shell-settings.xsl"/> 

    <xsl:import href="links.xsl"/>


    <!-- 
        TOC entry heading
    -->

    <!-- TOC entry open control -->

    <xsl:template match="*" mode="tocEntryOpenId"/>

    <xsl:template match="*[cpm:isFolderTopic(.)]" mode="tocEntryOpenId">
        <xsl:value-of select="concat(cpm:id(.), $tocEntryOpenControlIdSuffix)"/>
    </xsl:template>

    <xsl:function name="cpm:tocEntryOpenId">
        <xsl:param name="topic"/>
        <xsl:apply-templates select="$topic" mode="tocEntryOpenId"/>
    </xsl:function>


    <xsl:template match="*" mode="tocEntryOpenOnclick"/>
    
    <xsl:template match="*[cpm:isFolderTopic(.)]" mode="tocEntryOpenOnclick">
        <xsl:value-of select="$tocEntryOpenFuncName"/>
        <xsl:text>('</xsl:text>
        <xsl:value-of select="cpm:id(.)"/>
        <xsl:text>');</xsl:text>
    </xsl:template>
    
    <xsl:function name="cpm:tocEntryOpenOnclick">
        <xsl:param name="topic"/>
        <xsl:apply-templates select="$topic" mode="tocEntryOpenOnclick"/>
    </xsl:function>
    
    
    <xsl:template match="*[cpm:isFolderTopic(.)]" mode="tocEntryOpenControlIcon">
        <xsl:value-of select="$tocEntryOpenChr"/>
    </xsl:template>


    <xsl:template match="*[cpm:isFolderTopic(.)]" mode="tocEntryOpenControl">
        <xsl:element name="span" use-attribute-sets="tocEntryOpenControl">
            <xsl:attribute name="id" select="cpm:tocEntryOpenId(.)"/>
            <xsl:attribute name="onclick" select="cpm:tocEntryOpenOnclick(.)"/>
            <xsl:apply-templates select="." mode="tocEntryOpenControlIcon"/>
        </xsl:element>
    </xsl:template>
    
  
    <!-- TOC entry close control -->

    <xsl:template match="*" mode="tocEntryCloseId"/>

    <xsl:template match="*[cpm:isFolderTopic(.)]" mode="tocEntryCloseId">
        <xsl:value-of select="concat(cpm:id(.), $tocEntryCloseControlIdSuffix)"/>
    </xsl:template>

    <xsl:function name="cpm:tocEntryCloseId">
        <xsl:param name="topic"/>
        <xsl:apply-templates select="$topic" mode="tocEntryCloseId"/>
    </xsl:function>


    <xsl:template match="*" mode="tocEntryCloseOnclick"/>
        
    <xsl:template match="*[cpm:isFolderTopic(.)]" mode="tocEntryCloseOnclick">
        <xsl:value-of select="$tocEntryCloseFuncName"/>
        <xsl:text>('</xsl:text>
        <xsl:value-of select="cpm:id(.)"/>
        <xsl:text>');</xsl:text>
    </xsl:template>

    <xsl:function name="cpm:tocEntryCloseOnclick">
        <xsl:param name="topic"/>
        <xsl:apply-templates select="$topic" mode="tocEntryCloseOnclick"/>
    </xsl:function>


    <xsl:template match="*[cpm:isFolderTopic(.)]" mode="tocEntryCloseControlIcon">
        <xsl:value-of select="$tocEntryCloseChr"/>
    </xsl:template>


    <xsl:template match="*[cpm:isFolderTopic(.)]" mode="tocEntryCloseControl">
        <xsl:element name="span" use-attribute-sets="tocEntryCloseControl">
            <xsl:attribute name="id" select="cpm:tocEntryCloseId(.)"/>
            <xsl:attribute name="onclick" select="cpm:tocEntryCloseOnclick(.)"/>
            <xsl:apply-templates select="." mode="tocEntryCloseControlIcon"/>
        </xsl:element>
    </xsl:template>


    <xsl:template match="*[cpm:isTerminalTopic(.)]" mode="htmlTocEntryHeading">
        
        <xsl:param name="currTopicId" select="''"/>
        
        <xsl:apply-templates select="." mode="htmlNavLink">
            <xsl:with-param name="currTopicId" select="$currTopicId"/>
            <xsl:with-param name="className" select="$tocLinkClassName"/>
        </xsl:apply-templates>
        
    </xsl:template>


    <xsl:template match="*[cpm:isFolderTopic(.)]" mode="htmlTocEntryHeading">

        <xsl:param name="currTopicId" select="''"/>

        <div xsl:use-attribute-sets="tocEntryFolderHeading">

            <xsl:apply-templates select="." mode="tocEntryOpenControl"/>

            <xsl:apply-templates select="." mode="tocEntryCloseControl"/>

            <xsl:apply-templates select="." mode="htmlNavLink">
                <xsl:with-param name="currTopicId" select="$currTopicId"/>
                <xsl:with-param name="className" select="$tocLinkClassName"/>
            </xsl:apply-templates>

        </div>

    </xsl:template>


    <!-- 
        TOC entry 
    -->
    
    <!-- TOC entry body ID -->
    
    <xsl:template match="*" mode="tocEntryBodyId"/>
    
    <xsl:template match="*[cpm:isFolderTopic(.)]" mode="tocEntryBodyId">
        <xsl:value-of select="concat(cpm:id(.), $tocEntryBodyIdSuffix)"/>
    </xsl:template>
    
    <xsl:function name="cpm:tocEntryBodyId">
        <xsl:param name="topic"/>
        <xsl:apply-templates select="$topic" mode="tocEntryBodyId"/>
    </xsl:function>
    
    
    <!-- TOC entry class name -->
    
    <xsl:function name="cpm:tocEntryClassName">
        <xsl:param name="topic"/>
        <xsl:value-of select="concat($tocEntryClassNameBase, cpm:level($topic))"/>
    </xsl:function>
    

    <!-- TOC entry body -->
    
    <xsl:template match="*" mode="htmlTocEntryBody"/>
    
    <xsl:template match="*[cpm:isFolderTopic(.)]" mode="htmlTocEntryBody">

        <xsl:param name="currTopicId"/>

        <div xsl:use-attribute-sets="tocEntryBody">

            <xsl:attribute name="id" select="cpm:tocEntryBodyId(.)"/>

            <xsl:apply-templates select="*[cpm:isTopic(.)]" mode="htmlTocEntry">
                <xsl:with-param name="currTopicId" select="$currTopicId"/>
            </xsl:apply-templates>

        </div>

    </xsl:template>

    
    <!-- Entire TOC entry -->
    
    <xsl:template match="*[cpm:isTopic(.)]" mode="htmlTocEntry">

        <xsl:param name="currTopicId"/>

        <div class="{cpm:tocEntryClassName(.)}">

            <xsl:apply-templates select="." mode="htmlTocEntryHeading">
                <xsl:with-param name="currTopicId" select="$currTopicId"/>
            </xsl:apply-templates>
            
            <xsl:apply-templates select="." mode="htmlTocEntryBody">
                <xsl:with-param name="currTopicId" select="$currTopicId"/>
            </xsl:apply-templates>
            
        </div>

    </xsl:template>


    <!-- 
        Entire global TOC 
    -->

    <xsl:template match="*" mode="htmlToc">

        <xsl:param name="currTopicId"/>

        <div xsl:use-attribute-sets="toc" >
            <xsl:apply-templates select="root(.)/*/*[cpm:isTopic(.)]" mode="htmlTocEntry">
                <xsl:with-param name="currTopicId" select="$currTopicId"/>
            </xsl:apply-templates>
        </div>

    </xsl:template>

</xsl:stylesheet>
