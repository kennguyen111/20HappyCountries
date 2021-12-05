<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML, 3rd Edition
   Final Project

    List of 20 happiest countries in 2021
   Author: Ken Nguyen
   Date:   11/6/2021

   Filename:  happyCountries.xsl
   Supporting Files:
-->


<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


    <xsl:key name="regionNames" match="country" use="region" />


    <xsl:output method="html"
                doctype-system="about:legacy-compat"
                encoding="UTF-8"
                indent="yes" />


    <xsl:template match="/">
        <html>
            <head>
                <title >20 happiest countries in 2021</title>
                <link href="style.css" rel="stylesheet" type="text/css" />
            </head>

            <body>
                <div id="wrap">
                    <header>

                    </header>

                    <h1>20 happiest countries in 2021</h1>

                    <section id="region_list">
                        <!-- apply template to count country for each region -->
                        <xsl:apply-templates
                                select="countries/country[not(region=preceding::country/region)]"
                                mode ="regionList">
                            <xsl:sort select="region" />

                        </xsl:apply-templates>
                    </section>

                    <!-- apply template to display country information -->
                    <xsl:for-each
                            select="//country[generate-id()=generate-id(key('regionNames', region)[1])]">
                        <xsl:sort select="region" />
                        <h2 id="{generate-id()}"><xsl:value-of select="region" /></h2>
                        <xsl:apply-templates select="key('regionNames', region)">

                        </xsl:apply-templates>
                    </xsl:for-each>

                </div>
            </body>
        </html>
    </xsl:template>

    <!-- Main content of country information -->
    <xsl:template match="country">
        <table class="head" cellpadding="2">
            <tr>
                <th>Name</th>
                <td><xsl:value-of select="name" /></td>
                <th>Population</th>
                <td><xsl:value-of select="population" /></td>
            </tr>
            <tr>
                <th>Average Income</th>
                <td><xsl:value-of select="concat('$',avgIncome)" /></td>
                <th>GDP per capita</th>
                <td><xsl:value-of select="concat('$',GDPPercapita)" /></td>
            </tr>
            <tr>
                <th>Unempployment Rate</th>
                <td><xsl:value-of select="unemploymentRate" /></td>
                <th>Rank #:</th>
                <td><xsl:value-of select="rank" /></td>
            </tr>
            <tr>
                <td class="description" colspan="4">
                    <xsl:value-of select="description" />
                </td>
            </tr>
        </table>
    </xsl:template>

    <!-- Count countries for each region -->
    <xsl:template match="country" mode="regionList">
        <a href="#{generate-id()}">
            <xsl:value-of select="region" />
        </a>
        (<xsl:value-of select="count(key('regionNames', region))" />) |

    </xsl:template>

</xsl:stylesheet>