<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <!-- 22-tei-markdown-croala-normalized: 
        local modifications of TEI to markdown conversion, 
        use @norm forms to reconstitute markdown text
        Neven Jovanović  -->
    <xsl:import href="file:/home/neven/Oxygen%20XML%20Editor%2024/frameworks/tei/xml/tei/stylesheet/markdown/tei-to-markdown.xsl"/>
    <xsl:template match="//teiHeader"><xsl:text>---
title: </xsl:text><xsl:value-of select="normalize-space(fileDesc/titleStmt/title/string())"/>
<xsl:text>
lang: lat
--- 
</xsl:text>
        <xsl:call-template name="newline"/>
        <xsl:call-template name="newline"/>
    </xsl:template>
    
    <xsl:template match="opener|head">
        <xsl:call-template name="newline"/>
        <xsl:call-template name="newline"/><xsl:text># </xsl:text>
        <xsl:value-of select="w/@norm"/>
        <xsl:call-template name="newline"/>
        <xsl:call-template name="newline"/>
    </xsl:template>
    <xsl:template match="w[@norm and not(@xml:lang) and not(@type)]">
        <xsl:value-of select="@norm"/>
    </xsl:template>
    <xsl:template match="pc">
        <xsl:value-of select="normalize-space(.)"/>
    </xsl:template>
    <xsl:template match="l">
        <xsl:apply-templates/><xsl:text>  </xsl:text>
        <xsl:call-template name="newline"/>
    </xsl:template>
    
    <xsl:template match="salute|closer">
        <xsl:call-template name="newline"/>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="cell">
        <xsl:apply-templates/><xsl:text>  </xsl:text>
        <xsl:call-template name="newline"/>
    </xsl:template>
    <xsl:template match="gap[@reason]">
        <xsl:call-template name="newline"/>
        <xsl:apply-templates/><xsl:text> [---] </xsl:text>
        <xsl:call-template name="newline"/>
    </xsl:template>
    <xsl:template match="note[@resp='transcriber']">
    </xsl:template>
</xsl:stylesheet>