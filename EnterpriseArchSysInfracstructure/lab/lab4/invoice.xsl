<?xml version ="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:template match="/">
		<h1>Invoice Number: <xsl:value-of select="invoice/invoice_number"/>
		</h1>
		<h3>Invoice Date: <xsl:value-of select="invoice/invoice_date"/>
		</h3>
		<!-- <xsl:for-each select = "invoice/item"> -->
			<!-- <strong> Item: <xsl:value-of select="item_name"/></strong><br/> -->
			<!-- Price: <xsl:value-of select="price"/><br/> -->
			<!-- Quantity: <xsl:value-of select="quantity"/><br/> -->
		<!-- </xsl:for-each> -->
		<xsl:apply-templates select="invoice/item">
		<xsl:sort data-type = "number" order = "ascending" select = "quantity">
			<xsl:if>
				<xsl:when test = "@quantity > 1">
				</xsl:when>
			</xsl:if>
		</xsl:sort>
		</xsl:apply-templates>
		<h1>Payment info: <xsl:value-of select="invoice/payment_information"/></h1>
	</xsl:template>
</xsl:stylesheet>