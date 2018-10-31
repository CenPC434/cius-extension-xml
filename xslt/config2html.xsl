<?xml version="1.0" encoding="UTF-8"?>
<!-- 
  Sketchy draft of how easily can be machine readable specification of CIUS/Extensions
  turned into human readable HTML
  -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:c="urn:cen.eu:en16931:cius-extension:2018"
  exclude-result-prefixes="xs c"
  expand-text="yes"
  version="3.0">
  
  <xsl:output html-version="5.0"/>
  
  <xsl:template match="/c:config">
    <html>
      <head>
        <title>{c:meta/c:shortName} — {c:meta/c:name}</title>
        <style xsl:expand-text="no">
          html { 
            font-family: Calibri, Arial, sans-serif;
            margin-left: auto;
            margin-right: auto;
            max-width: 50em;
          }
          h1, h2, h3 { color: navy; }
          dt { color: navy; font-weight: bold; }                    
        </style>
      </head>
      <body>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="c:meta">
    <h1>{c:shortName}</h1>
    <h1>{c:name}</h1>

    <dl>
      <dt>Publisher:</dt>
      <dd><xsl:apply-templates select="c:publisher"/></dd>

      <dt>Governed by:</dt>
      <dd><xsl:apply-templates select="c:governor"/></dd>

      <dt>Version:</dt>
      <dd><xsl:apply-templates select="c:version"/></dd>

      <dt>Date of publication:</dt>
      <dd><xsl:apply-templates select="c:date"/></dd>
    </dl>
    
    <h2>Introduction</h2>
    <xsl:apply-templates select="c:abstract"/>

    <h2>Indetifying {c:shortName}</h2>
    <xsl:call-template name="gen-identification-clause"/>
  </xsl:template>

  <xsl:template match="c:publisher">
    <xsl:apply-templates mode="htmlize"/>
  </xsl:template>

  <xsl:template match="c:abstract">
    <div class="abstract">
      <xsl:apply-templates mode="htmlize"/>
    </div>
  </xsl:template>

  <xsl:template match="c:description">
    <div class="description">
      <xsl:apply-templates mode="htmlize"/>
    </div>
  </xsl:template>

  <xsl:template match="c:rules">
    <h2>New rules imposed by this specification</h2>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="c:rule">
    <div class="rule">
      <xsl:apply-templates select="c:description"/>
    </div>
  </xsl:template>

  <!-- Put reference to business rule at the start of description -->
  <xsl:template match="text()[parent::c:description/parent::c:rule][not(preceding-sibling::text())]" mode="#all" priority="10">
    [{parent::c:description/parent::c:rule/@id}]
    <xsl:next-match/>
  </xsl:template>

  <!-- Put list of affected terms at the end of description -->
  <xsl:template match="text()[parent::c:description/parent::c:rule][not(following-sibling::text())]" mode="#all">    
    <xsl:next-match/>
    [<xsl:value-of select="ancestor::c:rule//c:term" separator=", "/>]
  </xsl:template>
  
  <xsl:template name="gen-identification-clause">
    <p>An identification of the specification containing the total set of rules regarding semantic content,
      cardinalities and business rules to which the data contained in the instance document conforms is reported
      in BT-24 “Specification identification”. The identifier for this CIUS is:</p>
    <table border="1">
      <tr>
        <td>BT-24</td>
        <td>1..1</td>
        <td>Specification identification</td>
        <td>{c:id}</td>
      </tr>
    </table>
    <p>According to the e-Invoice instance document syntax the specification identification will be:</p>
    <p>UBL 2.1:</p>
    <pre>&lt;cbc:CustomizationID>{c:id}&lt;/cbc:CustomizationID></pre>
    <p>CII 16B:</p>
    <pre>&lt;rsm:ExchangedDocumentContext> 
  &lt;ram:GuidelineSpecifiedDocumentContextParameter>
    &lt;ram:ID>{c:id}&lt;/ram:ID>
  &lt;/ram:GuidelineSpecifiedDocumentContextParameter>
&lt;/rsm:ExchangedDocumentContext></pre>    
  </xsl:template>

  <!-- Configuration has HTML elements in a namespace we must strip this NS -->
  <xsl:template match="*" mode="htmlize">
    <xsl:element name="{local-name()}">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates mode="#current"/>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>