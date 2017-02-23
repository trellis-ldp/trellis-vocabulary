<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:owl="http://www.w3.org/2002/07/owl#"
    xmlns:vann="http://purl.org/vocab/vann/"
    xmlns:vs="http://www.w3.org/2003/06/sw-vocab-status/ns#"
    exclude-result-prefixes="xsd rdf rdfs owl" version="1.0">
  <xsl:output method="html" indent="yes" encoding="utf-8"/>

  <xsl:variable name="title" select="/rdf:RDF/rdf:Description[rdf:type/@rdf:resource='http://www.w3.org/2002/07/owl#Ontology']/rdfs:label"/>
  <xsl:variable name="namespace" select="/rdf:RDF/rdf:Description[rdf:type/@rdf:resource='http://www.w3.org/2002/07/owl#Ontology']/vann:preferredNamespaceUri"/>
  <xsl:variable name="prefix" select="/rdf:RDF/rdf:Description[rdf:type/@rdf:resource='http://www.w3.org/2002/07/owl#Ontology']/vann:preferredNamespacePrefix"/>

  <xsl:template match="/rdf:RDF">
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
    <html lang="en">
      <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        <title><xsl:value-of select="$title"/></title>
      </head>
      <body>
        <header id="banner">
          <xsl:text> </xsl:text>
        </header>
        <main>
          <h1><xsl:value-of select="$title"/></h1>
          <table>
            <xsl:for-each select="/rdf:RDF/rdf:Description[rdf:type/@rdf:resource='http://www.w3.org/2002/07/owl#Ontology']">
              <xsl:if test="position() = 1">
                <tr>
                  <td><b>Namespace</b></td>
                  <td><pre><xsl:value-of select="vann:preferredNamespaceUri"/></pre></td>
                </tr>
                <tr>
                  <td><b>Description</b></td>
                  <td><p><xsl:value-of select="rdfs:comment"/></p></td>
                </tr>
                <tr>
                  <td><b>Version</b></td>
                  <td><xsl:value-of select="owl:versionInfo"/></td>
                </tr>
                <xsl:if test="rdfs:seeAlso">
                  <tr>
                    <td><b>See Also</b></td>
                    <td>
                      <p>
                        <xsl:for-each select="rdfs:seeAlso">
                          <a>
                            <xsl:attribute name="href">
                              <xsl:value-of select="@rdf:resource"/>
                            </xsl:attribute>
                            <xsl:value-of select="@rdf:resource"/>
                          </a>
                          <xsl:if test="position() != last()">
                            <xsl:text>, </xsl:text>
                          </xsl:if>
                        </xsl:for-each>
                      </p>
                    </td>
                  </tr>
                </xsl:if>
              </xsl:if>
            </xsl:for-each>

            <xsl:if test="/rdf:RDF/rdf:Description[rdf:type/@rdf:resource='http://www.w3.org/2000/01/rdf-schema#Class']">
              <tr class="category">
                <td colspan="2">
                  <h2>Classes</h2>
                </td>
              </tr>
              <xsl:for-each select="/rdf:RDF/rdf:Description[rdf:type/@rdf:resource='http://www.w3.org/2000/01/rdf-schema#Class']">
                <xsl:sort select="@rdf:about"/>
                <xsl:call-template name="description"/>
              </xsl:for-each>
            </xsl:if>

            <xsl:if test="/rdf:RDF/rdf:Description[rdf:type/@rdf:resource='http://www.w3.org/1999/02/22-rdf-syntax-ns#Property']">
              <tr class="category">
                <td colspan="2">
                  <h2>Properties</h2>
                </td>
              </tr>
              <xsl:for-each select="/rdf:RDF/rdf:Description[rdf:type/@rdf:resource='http://www.w3.org/1999/02/22-rdf-syntax-ns#Property']">
                <xsl:sort select="@rdf:about"/>
                <xsl:call-template name="description"/>
              </xsl:for-each>
            </xsl:if>

            <xsl:if test="/rdf:RDF/rdf:Description[not(rdf:type/@rdf:resource='http://www.w3.org/2002/07/owl#Ontology' or rdf:type/@rdf:resource='http://www.w3.org/1999/02/22-rdf-syntax-ns#Property' or rdf:type/@rdf:resource='http://www.w3.org/2000/01/rdf-schema#Class')]">
              <tr class="category">
                <td colspan="2">
                  <h2>Named Individuals</h2>
                </td>
              </tr>
              <xsl:for-each select="/rdf:RDF/rdf:Description[not(rdf:type/@rdf:resource='http://www.w3.org/2002/07/owl#Ontology' or rdf:type/@rdf:resource='http://www.w3.org/1999/02/22-rdf-syntax-ns#Property' or rdf:type/@rdf:resource='http://www.w3.org/2000/01/rdf-schema#Class')]">
                <xsl:sort select="@rdf:about"/>
                <xsl:call-template name="description"/>
              </xsl:for-each>
            </xsl:if>
          </table>
        </main>
        <footer>
          <a href="https://amherst.edu">Amherst College</a> • 220 South Pleasant Street, Amherst, MA 01002 • (413) 542-2000 • <a href="https://www.amherst.edu">Amherst.edu</a>
        </footer>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="description">
    <tr class="preamble">
      <td colspan="2"><xsl:text> </xsl:text></td>
    </tr>
    <tr>
      <th colspan="2">
        <p>
          <a>
            <xsl:attribute name="href">
              <xsl:text>#</xsl:text>
              <xsl:value-of select="substring-after(@rdf:about,$namespace)"/>
            </xsl:attribute>
            <xsl:attribute name="id">
              <xsl:value-of select="substring-after(@rdf:about,$namespace)"/>
            </xsl:attribute>
            <xsl:value-of select="$prefix"/>
            <xsl:text>:</xsl:text>
            <xsl:value-of select="substring-after(@rdf:about,$namespace)"/>
          </a>
        </p>
      </th>
    </tr>
    <tr>
      <td><b>URI</b></td>
      <td><pre><xsl:value-of select="@rdf:about"/></pre></td>
    </tr>
    <tr>
      <td><b>Label</b></td>
      <td><xsl:value-of select="rdfs:label"/></td>
    </tr>
    <tr>
      <td><b>Description</b></td>
      <td><xsl:value-of select="rdfs:comment"/></td>
    </tr>
    <xsl:if test="rdfs:domain">
      <tr>
        <td><b>Domain</b></td>
        <td>
          <p>
            <xsl:for-each select="rdfs:domain">
              <xsl:call-template name="link"/>
              <xsl:if test="position() != last()">
                <xsl:text>, </xsl:text>
              </xsl:if>
            </xsl:for-each>
          </p>
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="rdfs:range">
      <tr>
        <td><b>Range</b></td>
        <td>
          <xsl:for-each select="rdfs:range">
            <xsl:call-template name="link"/>
            <xsl:if test="position() != last()">
              <xsl:text>, </xsl:text>
            </xsl:if>
          </xsl:for-each>
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="rdf:type">
      <tr>
        <td><b>Type</b></td>
        <td>
          <xsl:for-each select="rdf:type">
            <xsl:call-template name="link"/>
            <xsl:if test="position() != last()">
              <xsl:text>, </xsl:text>
            </xsl:if>
          </xsl:for-each>
        </td>
      </tr>
    </xsl:if>
    <xsl:if test="owl:inverseOf">
      <tr>
`        <td><b>Inverse Of</b></td>
        <td>
          <xsl:for-each select="owl:inverseOf">
            <xsl:call-template name="link"/>
            <xsl:if test="position() != last()">
              <xsl:text>, </xsl:text>
            </xsl:if>
          </xsl:for-each>
        </td>
      </tr>
    </xsl:if>
  </xsl:template>

  <xsl:template name="link">
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="@rdf:resource"/>
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="contains(@rdf:resource, 'http://www.w3.org/1999/02/22-rdf-syntax-ns#')">
          <xsl:text>rdf:</xsl:text>
          <xsl:value-of select="substring-after(@rdf:resource, 'http://www.w3.org/1999/02/22-rdf-syntax-ns#')"/>
        </xsl:when>
        <xsl:when test="contains(@rdf:resource, 'http://www.w3.org/2000/01/rdf-schema#')">
          <xsl:text>rdfs:</xsl:text>
          <xsl:value-of select="substring-after(@rdf:resource, 'http://www.w3.org/2000/01/rdf-schema#')"/>
        </xsl:when>
        <xsl:when test="contains(@rdf:resource, 'http://www.w3.org/ns/ldp#')">
          <xsl:text>ldp:</xsl:text>
          <xsl:value-of select="substring-after(@rdf:resource, 'http://www.w3.org/ns/ldp#')"/>
        </xsl:when>
        <xsl:when test="contains(@rdf:resource, 'http://www.w3.org/2002/07/owl#')">
          <xsl:text>owl:</xsl:text>
          <xsl:value-of select="substring-after(@rdf:resource, 'http://www.w3.org/2002/07/owl#')"/>
        </xsl:when>
        <xsl:when test="contains(@rdf:resource, $namespace)">
          <xsl:value-of select="$prefix"/>
          <xsl:text>:</xsl:text>
          <xsl:value-of select="substring-after(@rdf:resource, $namespace)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@rdf:resource"/>
        </xsl:otherwise>
      </xsl:choose>
    </a>
  </xsl:template>
</xsl:stylesheet>
