<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://www.cpmonster.com/xslt/funcs"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- Transforming text of a topic to HTML -->
    <xsl:import href="../matter/matter.xsl"/>

    <!-- Assembling layout features -->
    <xsl:import href="layout.xsl"/>

    <!-- Assembling topic pages -->
    <xsl:import href="topicpage.xsl"/>

    <!-- Assembling an index page -->
    <xsl:import href="indexpage.xsl"/>

    <!-- Assembling a document DTO -->
    <xsl:import href="dto.xsl"/>

    <xsl:output method="text"/>


    <!-- Writing out topic pages -->

    <xsl:function name="cpm:pagePath">
        <xsl:param name="topic"/>
        <xsl:value-of select="cpm:pageFileName($topic)"/>
    </xsl:function>

    <xsl:template match="*" mode="pageTopic"/>

    <xsl:template match="*[cpm:isTopic(.)]" mode="pageTopic">
        <xsl:result-document href="{cpm:pagePath(.)}" method="html">
            <xsl:apply-templates select="." mode="html"/>
        </xsl:result-document>
    </xsl:template>


    <!-- Writing out a document DTO -->

    <xsl:template match="*" mode="jsDto"/>

    <xsl:template match="*[cpm:isMap(.)]" mode="jsDto">
        <xsl:result-document href="!docdto.js" method="text">
            <xsl:apply-templates select="." mode="dto"/>
        </xsl:result-document>
    </xsl:template>


    <!-- Writing out an index page -->

    <xsl:template match="*" mode="pageToc"/>

    <xsl:template match="*[cpm:isMap(.)]" mode="pageToc">
        <xsl:apply-templates select="." mode="html"/>
    </xsl:template>


    <!-- Processing a root -->

    <xsl:template match="/">
        <xsl:apply-templates select="//*[cpm:isTopic(.)]" mode="pageTopic"/>
        <xsl:apply-templates select="*[cpm:isMap(.)]" mode="jsDto"/>
        <xsl:apply-templates select="*[cpm:isMap(.)]" mode="pageToc"/>
    </xsl:template>

</xsl:stylesheet>
