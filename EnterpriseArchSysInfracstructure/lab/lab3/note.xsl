<?xml version ="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>
<xsl:template match="/">
	To: <xsl:value-of select="note/to"/>
	<br/>
	From: <xsl:value-of select="note/from"/>
	<br/>
	CC: <xsl:value-of select="note/cc"/>
	<br/>
	Heading: <xsl:value-of select="note/heading"/>
	<br/>
	Body: <xsl:value-of select="note/body"/>
	<br/>
	PS: <xsl:for-each select="note/ps/*"/>
	<br/>
</xsl:template>
</xsl:stylesheet>