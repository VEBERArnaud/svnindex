<?xml version="1.0"?>
<!--

 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.

-->


<!-- A sample XML transformation style sheet for displaying the Subversion
  directory listing that is generated by mod_dav_svn when the "SVNIndexXSLT"
  directive is used. -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output method="html"/>

  <xsl:template match="*"/>

  <xsl:template match="svn">
    <html>
      <head>
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title>
          <xsl:if test="string-length(index/@name) != 0">
            <xsl:value-of select="index/@name"/>
            <xsl:text>: </xsl:text>
          </xsl:if>
          <xsl:value-of select="index/@path"/>
        </title>
        <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css"/>
        <link rel="stylesheet" type="text/css" href="/svntools/svnindex.css"/>
        <link href="//netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet"/>
        
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
      </head>
      <body>
        <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
          <div class="container-fluid">
            <div class="navbar-header">
              <a class="navbar-brand" href="#">
                <span class="fa fa-fw fa-code-fork"></span>
                YOUR SUBVERSION SERVER NAME HERE
              </a>
            </div>

            <div class="collapse navbar-collapse">
              <ul class="nav navbar-nav">
              </ul>
              <ul class="nav navbar-nav navbar-right">
              </ul>
            </div>
          </div>
        </nav>

        <xsl:apply-templates/>

        <nav class="navbar navbar-default navbar-fixed-bottom hidden-xs hidden-sm" role="navigation">
          <div class="container-fluid">
            <p class="navbar-text">
              Design by @VEBERArnaud
            </p>
            <p class="navbar-text navbar-right">
              <xsl:text>Powered by </xsl:text>
              <xsl:element name="a">
                <xsl:attribute name="href">
                  <xsl:value-of select="@href"/>
                </xsl:attribute>
                <xsl:text>Subversion</xsl:text>
              </xsl:element>
              <xsl:text> </xsl:text>
              <xsl:value-of select="@version"/>
            </p>
          </div>
        </nav>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="index">
    <section class="jumbotron">
      <div class="container-fluid">
        <div class="page-header">
          <h1>
            <span class="fa fa-fw fa-sitemap hidden-xs hidden-sm"></span>
            <span class="hidden-xs hidden-sm">&#160;</span>
            <xsl:value-of select="@name"/>
            <xsl:value-of select="@base"/> 
            <small>
              <xsl:text> Revision </xsl:text>
              <xsl:value-of select="@rev"/>
            </small>
          </h1>
        </div>
      </div>
    </section>

    <section class="container-fluid">
      <div class="row">
        <div class="col-xs-12">
          <div class="breadcrumb">
            <h4>
              <span class="fa fa-fw fa-road"></span>
              <span>&#160;</span>
              <xsl:value-of select="@name"/>
              <xsl:value-of select="@base"/>
              <xsl:value-of select="@path"/>
            </h4>
          </div>
          <div class="list-group">
            <xsl:apply-templates select="updir"/>
            <xsl:apply-templates select="dir"/>
            <xsl:apply-templates select="file"/>
          </div>
        </div>
      </div>
    </section>
  </xsl:template>

  <xsl:template match="updir">
      <xsl:element name="a">
	<xsl:attribute name="class">list-group-item updir</xsl:attribute>
        <xsl:attribute name="href">..</xsl:attribute>
        <span class="fa fa-fw fa-level-up"></span>
        &#160;
        <xsl:text>..</xsl:text>
      </xsl:element>
  </xsl:template>

  <xsl:template match="dir">
      <xsl:element name="a">
	<xsl:attribute name="class">list-group-item dir</xsl:attribute>
        <xsl:attribute name="href">
          <xsl:value-of select="@href"/>
        </xsl:attribute>
        <span class="fa fa-fw fa-folder-o"></span>
        &#160;
        <xsl:value-of select="@name"/>
        <xsl:text>/</xsl:text>
      </xsl:element>
  </xsl:template>

  <xsl:template match="file">
      <xsl:element name="a">
	<xsl:attribute name="class">list-group-item file</xsl:attribute>
        <xsl:attribute name="href">
          <xsl:value-of select="@href"/>
        </xsl:attribute>
        <span class="fa fa-fw fa-file-o"></span>
        &#160;
        <xsl:value-of select="@name"/>
      </xsl:element>
  </xsl:template>

</xsl:stylesheet>
