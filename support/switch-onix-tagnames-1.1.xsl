<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:variable name="release" select="/*/@release"/>
<xsl:variable name="target"><xsl:choose>
	<xsl:when test="/ONIXMessage">short</xsl:when>
	<xsl:otherwise>reference</xsl:otherwise>
</xsl:choose></xsl:variable>
<xsl:variable name="dtd-url">http://www.editeur.org/onix/<xsl:value-of select="$release"/>/<xsl:value-of select="$target"/>/onix-international.dtd</xsl:variable>
<xsl:output method="xml" doctype-system="{$dtd-url}"/>
<xsl:template match="*">
	<xsl:variable name="target-name">
		<xsl:choose>
			<xsl:when test="$target='short'"><xsl:value-of select="@shortname"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="@refname"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
 <xsl:element name="{$target-name}">
  <xsl:copy-of select="@*[not(name()='refname' or name()='shortname')]"/>
  <xsl:apply-templates select="*|text()"/>
 </xsl:element>
</xsl:template>
<xsl:template match="text()">
 <xsl:copy/>
</xsl:template>
</xsl:stylesheet>
