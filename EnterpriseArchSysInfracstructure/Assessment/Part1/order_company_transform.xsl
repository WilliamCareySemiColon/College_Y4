<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html>
    <head><title>Transform to Company Y standards</title></head>
    <body>
        <b>Order document: </b><xsl:text> </xsl:text><xsl:value-of select="order/@orderid"/><br/><br/>
        <b>Person Responsible: </b><xsl:text> </xsl:text><xsl:value-of select="order/person"/><br/><br/>
        <b>parties:</b><br/><br/>
        <b>ship_to_party: </b><br/>
        <b>Name: </b><xsl:value-of select="order/shipto/name"/><br/>
        <b>address_line: </b><xsl:value-of select="order/shipto/address"/><br> 
        <b>city:</b><xsl:value-of select="order/shipto/city"/><br> 
        <b>destination_country:</b><xsl:value-of select="order/shipto/country"/><br/><br/>

        <b>Items:</b><br/><br/>
        <b>Item Name: </b><xsl:value-of select="order/item/item-name"/><br/>
        <b>Title: </b><xsl:value-of select="order/item/title"/><br/>
        <b>Id: </b><xsl:value-of select="order/item/id"/><br/>
        <b>Note: </b><xsl:value-of select="order/item/note"/><br/>
        <b>Quantity: </b><xsl:value-of select="order/item/quantity"/><br/>
        <b>Price: </b><xsl:value-of select="order/item/price"/><br/>
    </body>
</html>
</xsl:template>
</xsl:stylesheet>	