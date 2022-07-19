<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cpm="http://www.cpmonster.com/xslt/funcs"
    exclude-result-prefixes="cpm xs" version="2.0">

    <xsl:import href="splitter.xsl"/>
    <xsl:import href="breadcrambs.xsl"/>
    <xsl:import href="toc.xsl"/>
    <xsl:import href="layout.xsl"/>


    <!-- 
        Publishing the matter 
    -->

    <xsl:template match="*" mode="html">
        <xsl:apply-templates select="node()"/>
    </xsl:template>

    <xsl:template match="title" mode="html">
        <xsl:element name="h1">
            <xsl:value-of select="cpm:plainTextTitle(..)"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="*[cpm:isTopic(.)]" mode="topMatterLine">
        <xsl:element name="div">
            <xsl:attribute name="id" select="'divTopMatterLine'"/>
            <xsl:element name="div">
                <xsl:attribute name="id" select="'divTopMatterLineWrapper'"/>
                <xsl:element name="div">
                    <xsl:attribute name="id" select="'divBreadCrumbs'"/>
                    <xsl:apply-templates select="." mode="htmlBreadCrambs"/>
                </xsl:element>
                <xsl:element name="div">
                    <xsl:attribute name="id" select="'divPrintButton'"/>
                    <xsl:element name="img">
                        <xsl:attribute name="id" select="'imgPrintButton'"/>
                        <xsl:attribute name="src" select="'front/img/print.svg'"/>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="*[cpm:isTopic(.)]" mode="htmlMatter">
        <xsl:element name="div">
            <xsl:attribute name="id" select="'divMatter'"/>
            <xsl:apply-templates select="." mode="topMatterLine"/>
            <xsl:apply-templates select="title" mode="html"/>
            <xsl:apply-templates select="*[cpm:isBody(.)]" mode="html"/>
        </xsl:element>
    </xsl:template>


    <!-- 
        Assembling framelets 
    -->

    <xsl:template name="htmlFrameletHeader">
        <xsl:param name="id"/>
        <xsl:element name="div">
            <xsl:attribute name="id" select="$id"/>
            <xsl:attribute name="class" select="'frameletHeader'"/>
            <xsl:element name="img">
                <xsl:attribute name="src" select="'front/img/search.svg'"/>
                <xsl:attribute name="class" select="'searchInFramelet'"/>
            </xsl:element>
            <xsl:element name="img">
                <xsl:attribute name="src" select="'front/img/close_small.svg'"/>
                <xsl:attribute name="class" select="'closeFramelet'"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template name="htmlFrameletPane">

        <xsl:param name="id"/>
        <xsl:param name="htmlContent"/>

        <xsl:element name="div">
            <xsl:attribute name="id" select="$id"/>
            <xsl:attribute name="class" select="'frameletPane'"/>
            <xsl:copy-of select="$htmlContent"/>
        </xsl:element>

    </xsl:template>

    <xsl:template name="htmlHeaderlessFrameletPane">

        <xsl:param name="id"/>
        <xsl:param name="htmlContent"/>

        <xsl:element name="div">
            <xsl:attribute name="id" select="$id"/>
            <xsl:attribute name="class" select="'frameletHeaderlessPane'"/>
            <xsl:copy-of select="$htmlContent"/>
        </xsl:element>

    </xsl:template>

    <xsl:function name="cpm:frameletHeaderId">
        <xsl:param name="frameletId"/>
        <xsl:value-of select="concat($frameletId, 'Header')"/>
    </xsl:function>

    <xsl:function name="cpm:frameletPaneId">
        <xsl:param name="frameletId"/>
        <xsl:value-of select="concat($frameletId, 'Pane')"/>
    </xsl:function>

    <xsl:template name="htmlFramelet">

        <xsl:param name="id"/>
        <xsl:param name="canClose" select="'yes'"/>
        <xsl:param name="canHResize" select="'yes'"/>
        <xsl:param name="canVResize" select="'yes'"/>
        <xsl:param name="htmlContent"/>

        <xsl:element name="div">

            <xsl:attribute name="id" select="$id"/>
            <xsl:attribute name="class" select="'framelet'"/>

            <xsl:choose>

                <xsl:when test="$canClose = 'yes'">
                    <xsl:if test="$canClose = 'yes'">
                        <xsl:call-template name="htmlFrameletHeader">
                            <xsl:with-param name="id" select="cpm:frameletHeaderId($id)"/>
                        </xsl:call-template>
                    </xsl:if>
                    <xsl:call-template name="htmlFrameletPane">
                        <xsl:with-param name="id" select="cpm:frameletPaneId($id)"/>
                        <xsl:with-param name="htmlContent" select="$htmlContent"/>
                    </xsl:call-template>
                </xsl:when>

                <xsl:otherwise>
                    <xsl:call-template name="htmlHeaderlessFrameletPane">
                        <xsl:with-param name="id" select="cpm:frameletPaneId($id)"/>
                        <xsl:with-param name="htmlContent" select="$htmlContent"/>
                    </xsl:call-template>
                </xsl:otherwise>

            </xsl:choose>

        </xsl:element>

    </xsl:template>


    <!-- 
        Transforming a topic to a pages
    -->

    <!-- Title -->

    <xsl:template match="*" mode="htmlTitle">
        <xsl:element name="title">
            <xsl:value-of select="cpm:plainTextTitle(.)"/>
        </xsl:element>
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


    <!-- Page header -->

    <xsl:template match="*" mode="htmlLogoArea">
        <xsl:element name="div">
            <xsl:attribute name="id" select="'divLogo'"/>
            <xsl:element name="img">
                <xsl:attribute name="src" select="cpm:uriLogo(.)"/>
                <xsl:attribute name="class" select="'logo'"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="*" mode="htmlSearchArea">
        <xsl:element name="div">
            <xsl:attribute name="class" select="'searchArea'"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="*" mode="htmlLangSelectorArea">
        <xsl:element name="div">
            <xsl:attribute name="class" select="'langSelectorArea'"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="*" mode="htmlHeader">
        <xsl:element name="div">
            <xsl:attribute name="id" select="'divPageHeader'"/>
            <xsl:element name="div">
                <xsl:attribute name="id" select="'divPageHeaderBlocks'"/>
                <xsl:apply-templates select="." mode="htmlLogoArea"/>
                <xsl:apply-templates select="." mode="htmlSearchArea"/>
                <xsl:apply-templates select="." mode="htmlLangSelectorArea"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>


    <!-- 
        A page
    -->

    <!-- Toc framelet -->

    <xsl:template match="*" mode="htmlTocArea"/>

    <xsl:template match="*[cpm:isTopic(.)]" mode="htmlTocArea">
        <xsl:element name="div">
            <xsl:attribute name="id" select="'divDocTitle'"/>
            <xsl:value-of select="cpm:DocTitle(.)"/>
        </xsl:element>
        <xsl:element name="div">
            <xsl:attribute name="id" select="'divTocTree'"/>
        </xsl:element>
    </xsl:template>


    <xsl:template match="*" mode="htmlTocFramelet"/>

    <xsl:template match="*[cpm:isTopic(.)]" mode="htmlTocFramelet">
        <xsl:call-template name="htmlFramelet">
            <xsl:with-param name="id" select="'divTocFramelet'"/>
            <xsl:with-param name="htmlContent">
                <xsl:apply-templates select="." mode="htmlTocArea"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>


    <!-- Reader framelet -->

    <xsl:template match="*" mode="htmlReaderFramelet"/>

    <xsl:template match="*[cpm:isTopic(.)]" mode="htmlReaderFramelet">
        <xsl:call-template name="htmlFramelet">
            <xsl:with-param name="id" select="'divMatterFramelet'"/>
            <xsl:with-param name="canClose" select="'no'"/>
            <xsl:with-param name="htmlContent">
                <xsl:element name="div">
                    <xsl:attribute name="id" select="'divMatterArea'"/>
                    <xsl:apply-templates select="." mode="htmlMatter"/>
                </xsl:element>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>


    <!-- Reader console -->

    <xsl:template match="*" mode="htmlReaderConsole"/>

    <xsl:template match="*[cpm:isTopic(.)]" mode="htmlReaderConsole">
        <xsl:element name="div">
            <xsl:attribute name="id" select="'divReaderConsole'"/>
            <xsl:apply-templates select="." mode="htmlTocFramelet"/>
            <xsl:apply-templates select="." mode="htmlReaderFramelet"/>
        </xsl:element>
    </xsl:template>


    <!-- Console Keeper -->

    <xsl:template match="*" mode="htmlConsoleKeeper"/>

    <xsl:template match="*[cpm:isTopic(.)]" mode="htmlConsoleKeeper">
        <xsl:element name="div">
            <xsl:attribute name="id" select="'divConsoleKeeper'"/>
            <xsl:element name="div">
                <xsl:attribute name="id" select="'divConsoles'"/>
                <xsl:apply-templates select="." mode="htmlReaderConsole"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>


    <!-- Body -->

    <xsl:template match="*" mode="htmlBody"/>

    <xsl:template match="*[cpm:isTopic(.)]" mode="htmlBody">
        <xsl:element name="body">
            <xsl:attribute name="onload" select="'GLOBAL_APP.run()'"/>
            <xsl:attribute name="onunload" select="'GLOBAL_APP.quit()'"/>
            <xsl:apply-templates select="." mode="htmlHeader"/>
            <xsl:apply-templates select="." mode="htmlConsoleKeeper"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="*[cpm:isTopic(.)]" mode="html">
        <xsl:text disable-output-escaping="yes"><![CDATA[<!DOCTYPE html>]]></xsl:text>
        <xsl:element name="html">
            <xsl:apply-templates select="." mode="htmlHead"/>
            <xsl:apply-templates select="." mode="htmlBody"/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
