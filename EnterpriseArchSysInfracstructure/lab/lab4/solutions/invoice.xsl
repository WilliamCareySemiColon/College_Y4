<?xml version ="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"/>

<xsl:template match="/">
  <html>

	<h1>Invoice Number:  <xsl:value-of select="invoice/invoice_number"/></h1>
	<h2>Invoice Date:  <xsl:value-of select="invoice/invoice_date"/></h2>
	
	<xsl:apply-templates select="invoice/item">
		<xsl:sort select="quantity" data-type="number" order="ascending"/>
	</xsl:apply-templates>

	<h2>Payment Info:  <xsl:value-of select="invoice/payment_information"/></h2>

	<a href="http://www.tudublin.ie">www.tudublin.ie</a>
	<br/>
	<xsl:element name="a">		
		<xsl:attribute name="href">http://www.tudublin.ie</xsl:attribute>		
		www.tudublin.ie
	</xsl:element>
	
  </html>		
</xsl:template>
 
 
<xsl:template match="item">	

	<xsl:if test="quantity>1">

		<h4>Item: <xsl:value-of select="item_name"/></h4>
		<div>
			Price: <xsl:value-of select="price"/><br/>						
			Quantity:  <xsl:value-of select="quantity"/>
		</div>		
		
	</xsl:if>
</xsl:template>
	
 

</xsl:stylesheet>
