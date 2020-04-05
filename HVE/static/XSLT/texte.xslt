<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" encoding="UTF-8"/>
    
    <xsl:param name="numero"/>
    
    <xsl:template match="/" >
        <div class="container">
            <xsl:choose>
                <xsl:when test="//text[@n=$numero]//note">
                    <div class="row">
                        <div class="col-9">
                            <xsl:apply-templates select="//text"/> 
                        </div>
                        <div class="col-3">
                            <div class="note-global" style="font-size : 80%; margin-top : 50px;">
                                <h6>Notes philologiques : </h6>
                                <xsl:apply-templates select="//note[@type='philo']/p"/> 
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="note-global" style="font-size : 70%; margin-top : 25px;">
                            <h5>Notes : comparaisons avec les textes d'origines</h5>
                            <xsl:apply-templates select="//note[@type='comp']/p"/>
                        </div>
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <div class="col-11">
                        <xsl:apply-templates select="//text"/> 
                    </div>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>
    
    <xsl:template match="text">
        <xsl:if test="./@n=$numero">
            <xsl:apply-templates/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="body">
        <xsl:apply-templates select="./div1"/>
    </xsl:template>
    
    <xsl:template match="div1">
        <xsl:element name="div">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="head">
        <xsl:element name="h5">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="div2">
        <xsl:element name="span">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="p">
        <xsl:element name="p">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="lb">
        <xsl:element name="br"/>
    </xsl:template>
    
    <xsl:template match="note[@type='philo']">
        <xsl:if test="ancestor::text/@n=$numero">
        <xsl:element name="sup">
            <xsl:element name="a">
                <xsl:attribute name="href">
                    <xsl:text>#</xsl:text>
                    <xsl:number count="note[@type='philo']" level="any" format="1"/>
                </xsl:attribute>
                <xsl:number count="note[@type='philo']" level="any" format="1"/>
            </xsl:element>
        </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="note[@type='comp']">
        <xsl:if test="ancestor::text/@n=$numero">
        <xsl:element name="sup">
            <xsl:element name="a">
                <xsl:attribute name="href">
                    <xsl:text>#</xsl:text>
                    <xsl:number count="note[@type='comp']" level="any" format="a"/>
                </xsl:attribute>
                <xsl:number count="note[@type='comp']" level="any" format="a"/>
            </xsl:element>
        </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="note[@type='philo']/p">
        <xsl:if test="ancestor::text/@n=$numero">
        <xsl:element name="p">
            <xsl:attribute name="id">
                <xsl:number count="note[@type='philo']" level="any" format="1"/>
            </xsl:attribute>
            <xsl:number count="note[@type='philo']" level="any" format="1"/>
            <xsl:text>. </xsl:text>
            <xsl:value-of select="."/>
        </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="note[@type='comp']/p">
        <xsl:if test="ancestor::text/@n=$numero">
        <xsl:element name="p">
            <xsl:attribute name="id">
                <xsl:number count="note[@type='comp']" level="any" format="a"/>
            </xsl:attribute>
            <xsl:number count="note[@type='comp']" level="any" format="a"/>
            <xsl:text>. </xsl:text>
            <xsl:value-of select="."/>
        </xsl:element>
        </xsl:if>
    </xsl:template>
    
    
</xsl:stylesheet>
