<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:variable name="target"><xsl:choose>
	<xsl:when test="/ONIXMessage">short</xsl:when>
	<xsl:otherwise>reference</xsl:otherwise>
</xsl:choose></xsl:variable>
<xsl:output method="xml" doctype-system="http://www.editeur.org/onix/2.1/reference/onix-international.dtd"/>
<xsl:template match="*">
	<xsl:variable name="target-name">
		<xsl:choose>
			<xsl:when test="$target='short' and @shortname"><xsl:value-of select="@shortname"/></xsl:when>
			<xsl:when test="$target='reference' and @refname"><xsl:value-of select="@refname"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="name()"/></xsl:otherwise>
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
