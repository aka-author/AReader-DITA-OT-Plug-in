<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://www.cpmonster.com/xslt/funcs"
    exclude-result-prefixes="cpm xs" version="2.0">

    <!-- 
        Detecting element properties
    -->

    <!-- Getting an element ID -->

    <xsl:template match="*" mode="id">
        <xsl:value-of select="generate-id(.)"/>
    </xsl:template>

    <xsl:template match="*[@id]" mode="id">
        <xsl:value-of select="@id"/>
    </xsl:template>

    <xsl:function name="cpm:id">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="id"/>
    </xsl:function>


    <!-- Detecting maps -->

    <xsl:template match="*" mode="isMap" as="xs:boolean">
        <xsl:sequence select="false()"/>
    </xsl:template>

    <xsl:template match="*[contains(@class, 'map/map')]" mode="isMap" as="xs:boolean">
        <xsl:sequence select="true()"/>
    </xsl:template>

    <xsl:function name="cpm:isMap" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="isMap"/>
    </xsl:function>


    <!-- Detecting topics -->

    <xsl:template match="*" mode="isTopic" as="xs:boolean">
        <xsl:sequence select="false()"/>
    </xsl:template>

    <xsl:template match="*[contains(@class, 'topic/topic')]" mode="isTopic" as="xs:boolean">
        <xsl:sequence select="true()"/>
    </xsl:template>

    <xsl:function name="cpm:isTopic" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="isTopic"/>
    </xsl:function>


    <!-- Detecting terminal topics -->

    <xsl:template match="*" mode="isTerminalTopic" as="xs:boolean">
        <xsl:sequence select="false()"/>
    </xsl:template>

    <xsl:template match="*[cpm:isTopic(.)]" mode="isTerminalTopic" as="xs:boolean">
        <xsl:sequence select="not(exists(child::*[cpm:isTopic(.)]))"/>
    </xsl:template>

    <xsl:function name="cpm:isTerminalTopic" as="xs:boolean">
        <xsl:param name="topic"/>
        <xsl:apply-templates select="$topic" mode="isTerminalTopic"/>
    </xsl:function>


    <!-- Detecting folder topics -->

    <xsl:template match="*" mode="isFolderTopic" as="xs:boolean">
        <xsl:sequence select="false()"/>
    </xsl:template>

    <xsl:template match="*[cpm:isTopic(.)]" mode="isFolderTopic" as="xs:boolean">
        <xsl:sequence select="exists(child::*[cpm:isTopic(.)])"/>
    </xsl:template>

    <xsl:function name="cpm:isFolderTopic" as="xs:boolean">
        <xsl:param name="topic"/>
        <xsl:apply-templates select="$topic" mode="isFolderTopic"/>
    </xsl:function>


    <!-- Detecting body elements -->

    <xsl:template match="*" mode="isBody" as="xs:boolean">
        <xsl:sequence select="false()"/>
    </xsl:template>

    <xsl:template match="*[contains(@class, 'topic/body')]" mode="isBody" as="xs:boolean">
        <xsl:sequence select="true()"/>
    </xsl:template>

    <xsl:function name="cpm:isBody" as="xs:boolean">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="isBody"/>
    </xsl:function>


    <!-- Detecting elements containing direct text -->

    <xsl:template match="*" mode="hasDirectContent" as="xs:boolean">
        <xsl:sequence select="false()"/>
    </xsl:template>

    <xsl:template match="*[*[cpm:isBody(.)]]" mode="hasDirectContent" as="xs:boolean">
        <xsl:sequence select="true()"/>
    </xsl:template>

    <xsl:function name="cpm:hasDirectContent" as="xs:boolean">
        <xsl:param name="topic"/>
        <!--
        <xsl:apply-templates select="$topic" mode="hasDirectContent"/>
        -->
        <xsl:sequence select="true()"/>
    </xsl:function>


    <!-- Calculating the topic level -->

    <xsl:template match="*" mode="level" as="xs:integer">
        <xsl:sequence select="0"/>
    </xsl:template>

    <xsl:template match="*[cpm:isTopic(.)]" mode="level" as="xs:integer">
        <xsl:value-of select="count(parent::*[cpm:isTopic(.)]) + 1"/>
    </xsl:template>

    <xsl:function name="cpm:level" as="xs:integer">
        <xsl:param name="topic"/>
        <xsl:apply-templates select="$topic" mode="level"/>
    </xsl:function>


    <!-- Element title -->

    <xsl:template match="*" mode="plainTextTitle">
        <xsl:value-of select="normalize-space(title)"/>
    </xsl:template>

    <xsl:function name="cpm:plainTextTitle">
        <xsl:param name="element"/>
        <xsl:apply-templates select="$element" mode="plainTextTitle"/>
    </xsl:function>


</xsl:stylesheet>
