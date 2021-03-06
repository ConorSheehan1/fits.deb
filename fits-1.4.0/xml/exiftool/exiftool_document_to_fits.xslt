<?xml version="1.0" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="exiftool_common_to_fits.xslt"/>
<xsl:template match="/">

	<fits xmlns="http://hul.harvard.edu/ois/xml/ns/fits/fits_output">
		<xsl:apply-imports/>
		
		<metadata>
		<document>
			<xsl:variable name="mime" select="exiftool/MIMEType"/>
			
			<pageCount>
				<xsl:choose>
					<!-- different file types will output a different element name -->
					<xsl:when test="exiftool/Pages">
						<xsl:value-of select="exiftool/Pages[1]"/>
					</xsl:when>
					<xsl:when test="exiftool/PageCount">
						<xsl:value-of select="exiftool/PageCount[1]"/>
					</xsl:when>
                    <xsl:when test="exiftool/Document-statisticPage-count">
                        <xsl:value-of select="exiftool/Document-statisticPage-count[1]"/>
                    </xsl:when>
				</xsl:choose>
			</pageCount>

			<wordCount>
                <xsl:choose>
	                <!-- different file types will output a different element name -->
	                <xsl:when test="exiftool/Words">
						<xsl:value-of select="exiftool/Words[1]"/>
	                </xsl:when>
                    <xsl:when test="exiftool/Document-statisticWord-count">
		                <xsl:value-of select="exiftool/Document-statisticWord-count[1]"/>
                    </xsl:when>
                </xsl:choose>
			</wordCount>
			
			<characterCount>
                <xsl:choose>
                    <!-- different file types will output a different element name -->
                    <xsl:when test="exiftool/Characters">
						<xsl:value-of select="exiftool/Characters[1]"/>
                    </xsl:when>
                    <xsl:when test="exiftool/Document-statisticCharacter-count">
                        <xsl:value-of select="exiftool/Document-statisticCharacter-count[1]"/>
                    </xsl:when>
                </xsl:choose>
			</characterCount>
			
			<xsl:if test="exiftool/Title">
				<title>
					<xsl:value-of select="exiftool/Title[1]"/>
				</title>	
			</xsl:if>

			<xsl:if test="exiftool/Author or exiftool/Creator">
				<author>
					<xsl:choose>
						<xsl:when test="exiftool/Author">
							<xsl:value-of select="exiftool/Author[1]"/>
						</xsl:when>
						<xsl:when test="exiftool/Creator">
							<xsl:value-of select="exiftool/Creator[1]"/>
						</xsl:when>
					</xsl:choose>
				</author>
			</xsl:if>
			
			<xsl:if test="exiftool/Lines">
				<lineCount>
					<xsl:value-of select="exiftool/Lines[1]"/>
				</lineCount>
			</xsl:if>
			
			<paragraphCount>
                <xsl:choose>
                    <!-- different file types will output a different element name -->
                    <xsl:when test="exiftool/Paragraphs">
                        <xsl:value-of select="exiftool/Paragraphs[1]"/>
                    </xsl:when>
                    <xsl:when test="exiftool/Document-statisticParagraph-count">
                        <xsl:value-of select="exiftool/Document-statisticParagraph-count[1]"/>
                    </xsl:when>
                </xsl:choose>
			</paragraphCount>
			
			<isRightsManaged>
				<xsl:choose>
					<xsl:when test="exiftool/Rights or exiftool/xmpRights">
						<xsl:value-of select="string('yes')"/>
					</xsl:when>
				</xsl:choose>
			</isRightsManaged>

			<isProtected>
				<xsl:choose>
					<xsl:when test="exiftool/Security and exiftool/Security='Password protected'">
						<xsl:value-of select="string('yes')"/>
					</xsl:when>
					<xsl:when test="exiftool/Encryption">
                        <xsl:value-of select="string('yes')"/>
					</xsl:when>
				</xsl:choose>
			</isProtected>
            
            <subject>
                <!-- sometimes for PDF files Exiftool will spit out an integer value which is not a real Subject -->
                <xsl:if test="exiftool/Subject and string-length(exiftool/Subject[1]) > 1">
	                <xsl:value-of select="exiftool/Subject"/>
                </xsl:if>
            </subject>
            
            <category>
                <xsl:value-of select="exiftool/Category[1]"/>
            </category>
            
            <xsl:if test="exiftool/Hyperlinks">
                <hasHyperlinks>
                    <xsl:value-of select="string('yes')"/>
                </hasHyperlinks>
            </xsl:if>
			
			<xsl:if test="exiftool/Document-statisticObject-count and exiftool/Document-statisticObject-count != '0'">
			    <hasEmbeddedResources>
			         <xsl:value-of select="string('yes')"/>
			    </hasEmbeddedResources>
			</xsl:if>
			
			<tableCount>
			    <xsl:value-of select="exiftool/Document-statisticTable-count[1]" />
			</tableCount>

			<graphicsCount>
			    <xsl:value-of select="exiftool/Document-statisticImage-count[1]" />
			</graphicsCount>
            
            <description>
                <xsl:value-of select="exiftool/Description[1]" />
            </description>
            
            <identifier>
                <xsl:value-of select="exiftool/Identifier[1]" />
            </identifier>
            
            <source>
                <xsl:value-of select="exiftool/Source[1]" />
            </source>
            
            <language>
            	<xsl:if test="exiftool/Language or exiftool/LanguageCode">
            		<xsl:variable name="lang">
		                <xsl:choose>
		                    <!-- different file types will output a different element name -->
		                    <xsl:when test="exiftool/Language">
		                    	<xsl:value-of select="exiftool/Language[1]"/>
		                    </xsl:when>
		                    <xsl:when test="exiftool/LanguageCode">
		                    	<xsl:value-of select="exiftool/LanguageCode[1]"/>
		                    </xsl:when>
		                    <xsl:otherwise>
		                    	<xsl:value-of select="string('')"/>
		                    </xsl:otherwise>
		                </xsl:choose>
            		</xsl:variable>
	                
	                <xsl:if test="$lang != ''">
	                	<xsl:choose>
	                		<xsl:when test="$lang = 'English (US)'">
	                			<xsl:value-of select="string('U.S. English')"/>
	                		</xsl:when>
	                		<xsl:when test="$lang = 'English (UK)'">
	                			<xsl:value-of select="string('U.K. English')"/>
	                		</xsl:when>
	                		<xsl:otherwise>
	                			<xsl:value-of select="$lang"/>
	                		</xsl:otherwise>
	                	</xsl:choose>
	                </xsl:if>
            	</xsl:if>
            </language>
            
            <isTagged>
                <xsl:if test="exiftool/TaggedPDF and exiftool/TaggedPDF = 'Yes'">
	                <xsl:value-of select="string('yes')"/>
                </xsl:if>
            </isTagged>
		</document>				
		</metadata>
	</fits>	

</xsl:template>
</xsl:stylesheet>