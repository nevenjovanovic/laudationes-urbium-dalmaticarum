<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    exclude-result-prefixes="tei">
    <xsl:output method = "xml" indent="yes" omit-xml-declaration="no" /> 
    <!-- 21croala-remove-elements-simplify: copy everything, remove editorial notes and elements to produce simplified version for segmentation -->
    <!-- note -->
    <xsl:include href="copy.xsl"/>
    
    <xsl:template match="//tei:text//tei:p//tei:l">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="//tei:text//tei:l">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="//tei:text//tei:lg">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="//tei:text//tei:lg/tei:l">
        <xsl:apply-templates/>
    </xsl:template>
    
</xsl:stylesheet>

