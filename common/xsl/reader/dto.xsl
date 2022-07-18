<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://www.cpmonster.com/xslt/funcs"
    exclude-result-prefixes="cpm xs" version="2.0">

    <xsl:import href="queries.xsl"/>
    <xsl:import href="links.xsl"/>

    <xsl:function name="cpm:dtoProp">
        <xsl:param name="paramName"/>
        <xsl:param name="paramValue"/>
        <xsl:value-of select="concat('&quot;', $paramName, '&quot;')"/>
        <xsl:text>: </xsl:text>
        <xsl:value-of select="concat('&quot;', $paramValue, '&quot;')"/>
    </xsl:function>

    <xsl:template match="*[cpm:isTopic(.)]" mode="dtoId">
        <xsl:value-of select="cpm:dtoProp('id', cpm:pageFileName(.))"/>
    </xsl:template>

    <xsl:template match="*[cpm:isTopic(.)]" mode="dtoTitle">
        <xsl:value-of select="cpm:dtoProp('title', cpm:plainTextTitle(.))"/>
    </xsl:template>

    <xsl:template match="*[cpm:isTopic(.)]" mode="dtoUrl">
        <xsl:value-of select="cpm:dtoProp('uri', cpm:pageFileName(.))"/>
    </xsl:template>

    <xsl:template match="*[cpm:isTopic(.)]" mode="dto">
        <xsl:text>{</xsl:text>
        <xsl:apply-templates select="." mode="dtoId"/>
        <xsl:text>, </xsl:text>
        <xsl:apply-templates select="." mode="dtoTitle"/>
        <xsl:text>, </xsl:text>
        <xsl:apply-templates select="." mode="dtoUrl"/>
        <xsl:if test="exists(*[cpm:isTopic(.)])">
            <xsl:text>, </xsl:text>
            <xsl:text>"entries": [</xsl:text>
            <xsl:apply-templates select="*[cpm:isTopic(.)]" mode="dto"/>
            <xsl:text>]</xsl:text>
        </xsl:if>
        <xsl:text>}</xsl:text>
        <xsl:if test="exists(following-sibling::*[cpm:isTopic(.)])">
            <xsl:text>,</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="*[cpm:isMap(.)]" mode="dto">
        <xsl:text>var GLOBAL_DOC_DTO = {</xsl:text>
        <xsl:value-of select="cpm:dtoProp('id', cpm:id(.))"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="cpm:dtoProp('title', //mainbooktitle)"/>
        <xsl:text>, </xsl:text>
        <xsl:text>"toc": {</xsl:text>
        <xsl:text>"entries": [</xsl:text>
        <xsl:apply-templates select="*[cpm:isTopic(.)]" mode="dto"/>
        <xsl:text>]</xsl:text>
        <xsl:text>}</xsl:text>
        <xsl:text>};</xsl:text>
    </xsl:template>

</xsl:stylesheet>
