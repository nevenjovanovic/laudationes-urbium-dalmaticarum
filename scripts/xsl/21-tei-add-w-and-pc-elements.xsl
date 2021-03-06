<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    exclude-result-prefixes="tei">
    <xsl:output method = "xml" indent="yes" omit-xml-declaration="no" /> 
    <!-- add-w-and-pc-elements: in each s wrap \w+ into w and \p{P} into pc -->
    <xsl:include href="copy.xsl"/>
    <xsl:template match="//*:text//*:s">
        <xsl:copy>
            <xsl:apply-templates select="@* "/> 
            <xsl:for-each select="text()">
        <xsl:analyze-string select="." regex="\p{{P}}">
            <xsl:matching-substring>
            <xsl:element name="pc" namespace="http://www.tei-c.org/ns/1.0"><xsl:value-of select="."/></xsl:element>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:analyze-string select="." regex="\w+">
                    <xsl:matching-substring>
                        <xsl:element name="w" namespace="http://www.tei-c.org/ns/1.0"><xsl:value-of select="."/></xsl:element>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring/>
                    
                </xsl:analyze-string>
            </xsl:non-matching-substring>
            
        </xsl:analyze-string>
                
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>

