# encoding: utf-8
# Record factory
FactoryBot.define do
  factory :record do

    trait :external do
      sequence(:external_id) { |n| "external#{n}"}
      external_system 'external_system1'
      format 'format1'
      title 'title 1'
      author 'author 1'
      url 'https://dev.getit.library.nyu.edu/resolve?openurl=1&rft.true=true'
      title_sort 'title sort 1'
      content_type 'book'
    end

    trait :primo do
      external_system 'primo'
    end

    trait :xerxes do
      sequence(:external_id) { |n| "xerxes#{n}"}
      external_system 'xerxes'
    end

    trait :a_place_for_hemingway do
      content_type 'article'
      data <<-XERXES_DATA
<?xml version="1.0"?>
<record>
  <openurl_kev_co>some_kev</openurl_kev_co>
  <xerxes_record>
    <call_number>(Dummy Call Number)</call_number>
    <title_normalized>A Place for Hemingway</title_normalized>
    <journal_title>Boston Globe (Pre-1997 Fulltext)</journal_title>
    <primary_author>Staff, Robert Taylor Globe </primary_author>
    <full_text_bool>1</full_text_bool>
    <authors>
      <author type="personal" rank="1">
        <aulast>Staff</aulast>
        <aufirst>Robert Taylor Globe</aufirst>
        <display>Robert Taylor Globe Staff</display>
      </author>
    </authors>
    <standard_numbers>
      <issn>07431791</issn>
    </standard_numbers>
    <links>
      <link type="online">
        <display>Full Text</display>
        <url>http://search.proquest.com/docview/293982479/fulltext/embedded/QVMANQ6EQ5MPB8OD?source=fedsrch</url>
      </link>
      <link type="none">
        <display></display>
        <url>http://search.proquest.com/docview/293982479/abstract/embedded/QVMANQ6EQ5MPB8OD?source=fedsrch</url>
      </link>
    </links>
    <metalib_id>NYU00727</metalib_id>
    <result_set>001022</result_set>
    <record_number>000001</record_number>
    <source>PQ_MS</source>
    <database_name>ProQuest Newsstand</database_name>
    <format>Article</format>
    <non_sort>A </non_sort>
    <title>PLACE FOR HEMINGWAY</title>
    <year>1980</year>
    <journal>Boston Globe (pre-1997 Fulltext) (Jul 21, 1980), p. 1</journal>
    <start_page>1</start_page>
    <abstract>Abstract</abstract>
    <summary>Summary</summary>
    <summary_type>abstract</summary_type>
    <id>322488</id>
    <original_id>2012-05-22:001022:000001</original_id>
  </xerxes_record>
</record>
      XERXES_DATA
    end

    trait :virtual_inequality_id do
      external_id 'nyu_aleph000980206'
    end

    trait :travels_with_my_aunt_id do
      external_id 'nyu_aleph000570570'
    end

    trait :with_creator do
      external_id 'nyu_aleph001086361'
      format 'pnx'
      data <<-PRIMO_DATA
<?xml version="1.0" encoding="UTF-8"?>
<record>
  <control>
    <sourcerecordid>001086361</sourcerecordid>
    <sourceid>nyu_aleph</sourceid>
    <recordid>nyu_aleph001086361</recordid>
    <originalsourceid>NYU01</originalsourceid>
    <ilsapiid>NYU01001086361</ilsapiid>
    <sourceformat>MARC21</sourceformat>
    <sourcesystem>Aleph</sourcesystem>
  </control>
  <display>
    <type>book</type>
    <title>Crossing the digital divide : race, writing, and technology in the classroom</title>
    <creator>Barbara Jean  Monroe  1948-</creator>
    <publisher>New York ; Teachers College Press</publisher>
    <creationdate>c2004</creationdate>
    <format>xiv, 154 p. : ill. ; 23 cm.</format>
    <language>eng</language>
    <relation>$$Cseries $$VLanguage and literacy series (New York, N.Y.)</relation>
    <source>nyu_aleph</source>
    <lds02>nyu_aleph001086361</lds02>
    <lds01>NYU</lds01>
    <availinstitution>$$INYU$$Savailable</availinstitution>
    <availpnx>available</availpnx>
  </display>
  <links>
    <openurl>$$Topenurl_journal</openurl>
    <backlink>$$Taleph_backlink$$DMore bibliographic information</backlink>
    <thumbnail>$$Tamazon_thumb</thumbnail>
    <linktotoc>$$Tamazon_toc$$DCheck for Amazon Search Inside</linktotoc>
    <openurlfulltext>$$Topenurlfull_journal</openurlfulltext>
    <linktoholdings>$$Taleph_holdings</linktoholdings>
    <linktoreview>$$TpersistentUrl$$DCopy item link</linktoreview>
    <linktouc>$$Tamazon_uc$$DCheck Amazon</linktouc>
    <linktouc>$$Tworldcat_isbn$$DCheck other libraries (WorldCat®)</linktouc>
    <linktoexcerpt>$$Tsyndetics_excerpt$$DExcerpt from item</linktoexcerpt>
  </links>
  <search>
    <creatorcontrib>Barbara Jean,  Monroe  1948-</creatorcontrib>
    <creatorcontrib>Monroe, Barbara Jean, 1948-</creatorcontrib>
    <creatorcontrib>Monroe, B</creatorcontrib>
    <creatorcontrib>Barbara Monroe ; foreword by Victor Villanueva.</creatorcontrib>
    <title>Crossing the digital divide : race, writing, and technology in the classroom /</title>
    <subject>English language  Composition and exercises Study and teaching United States</subject>
    <subject>English language  Composition and exercises Study and teaching Data processing</subject>
    <subject>English language  Rhetoric Study and teaching Data processing</subject>
    <subject>English language  Rhetoric Study and teaching United States</subject>
    <subject>English language  Rhetoric Computer-assisted instruction</subject>
    <subject>Report writing  Study and teaching Data processing</subject>
    <subject>Report writing  Computer-assisted instruction</subject>
    <subject>Educational technology  United States</subject>
    <subject>African Americans  Education</subject>
    <subject>Word processing in education</subject>
    <subject>Research report writing</subject>
    <subject>Term paper writing</subject>
    <subject>Research paper writing</subject>
    <subject>Technology in education</subject>
    <subject>Instructional technology</subject>
    <general>Teachers College Press,</general>
    <sourceid>nyu_aleph</sourceid>
    <recordid>nyu_aleph001086361</recordid>
    <isbn>0807744638</isbn>
    <isbn>080774462X</isbn>
    <isbn>9780807744635</isbn>
    <isbn>9780807744628</isbn>
    <rsrctype>book</rsrctype>
    <creationdate>2004</creationdate>
    <addtitle>Language and literacy series</addtitle>
    <addtitle>Language and literacy series (New York, N.Y.)</addtitle>
    <searchscope>BOBST</searchscope>
    <searchscope>BOBST Main Collection</searchscope>
    <searchscope>nyu_aleph</searchscope>
    <searchscope>NYU</searchscope>
    <scope>BOBST</scope>
    <scope>BOBST Main Collection</scope>
    <scope>nyu_aleph</scope>
    <scope>NYU</scope>
    <lsr01>PE1405.U6 M66 2004</lsr01>
    <lsr01>PE1405 .U6 M66 2004</lsr01>
    <lsr02>Teachers College Press,</lsr02>
  </search>
  <sort>
    <title>Crossing the digital divide : race, writing, and technology in the classroom /</title>
    <creationdate>2004</creationdate>
    <author>Monroe, Barbara Jean, 1948-</author>
    <lso01>2004</lso01>
  </sort>
  <facets>
    <language>eng</language>
    <creationdate>2004</creationdate>
    <topic>English language–Composition and exercises–Study and teaching–United States</topic>
    <topic>English language–Composition and exercises–Study and teaching–Data processing</topic>
    <topic>English language–Rhetoric–Study and teaching–Data processing</topic>
    <topic>English language–Rhetoric–Study and teaching–United States</topic>
    <topic>English language–Rhetoric–Computer-assisted instruction</topic>
    <topic>Report writing–Study and teaching–Data processing</topic>
    <topic>Report writing–Computer-assisted instruction</topic>
    <topic>Educational technology–United States</topic>
    <topic>African Americans–Education</topic>
    <topic>Word processing in education</topic>
    <collection>BOBST</collection>
    <toplevel>available</toplevel>
    <prefilter>books</prefilter>
    <rsrctype>books</rsrctype>
    <creatorcontrib>Monroe, B</creatorcontrib>
    <library>BOBST</library>
    <lfc01>Main Collection</lfc01>
    <classificationlcc>P - Language and literature.–English</classificationlcc>
  </facets>
  <dedup>
    <t>1</t>
    <c1>2003068697</c1>
    <c2>0807744638;080774462X;9780807744635;9780807744628</c2>
    <c3>crossingthedigitaldieclassroom</c3>
    <c4>2004</c4>
    <f1>2003068697</f1>
    <f3>0807744638;080774462X;9780807744635;9780807744628</f3>
    <f5>crossingthedigitaldieclassroom</f5>
    <f6>2004</f6>
    <f7>crossing the digital divide race writing and technology in the classroom</f7>
    <f8>nyu</f8>
    <f9>xiv, 154 p. :</f9>
    <f10>teachers college press</f10>
    <f11>monroe barbara jean 1948</f11>
  </dedup>
  <frbr>
    <t>1</t>
    <k1>$$Kmonroe barbara jean 1948$$AA</k1>
    <k3>$$Kbookcrossing the digital divide race writing and technology in the classroom$$AT</k3>
  </frbr>
  <delivery>
    <institution>NYU</institution>
    <delcategory>Physical Item</delcategory>
  </delivery>
  <enrichment>
    <classificationlcc>PE1405.U6</classificationlcc>
  </enrichment>
  <ranking>
    <booster1>1</booster1>
    <booster2>1</booster2>
  </ranking>
  <addata>
    <aulast>Monroe</aulast>
    <aufirst>Barbara Jean,</aufirst>
    <au>Monroe, Barbara Jean, 1948-</au>
    <btitle>Crossing the digital divide : race, writing, and technology in the classroom</btitle>
    <seriestitle>Language and literacy series (New York, N.Y.)</seriestitle>
    <date>2004</date>
    <risdate>c2004.</risdate>
    <isbn>0807744638</isbn>
    <isbn>080774462X</isbn>
    <isbn>9780807744635</isbn>
    <isbn>9780807744628</isbn>
    <format>book</format>
    <genre>book</genre>
    <ristype>BOOK</ristype>
    <notes>Includes bibliographical references (p. 127-141) and index.</notes>
    <cop>New York %3B</cop>
    <pub>Teachers College Press</pub>
    <lccn>2003068697</lccn>
    <lad01>BOBST</lad01>
    <lad01>Physical Item</lad01>
  </addata>
</record>
      PRIMO_DATA
    end

    trait :with_contributor do
      external_id 'ebrroutebr10569356'
      format 'pnx'
      data <<-PRIMO_DATA
<?xml version="1.0" encoding="UTF-8"?>
<record>
  <control>
    <sourcerecordid>ebr10569356</sourcerecordid>
    <sourceid>ebrrout</sourceid>
    <recordid>ebrroutebr10569356</recordid>
    <ilsapiid>ebr10569356</ilsapiid>
    <sourceformat>MARC Exchange</sourceformat>
    <sourcesystem>Other</sourcesystem>
  </control>
  <display>
    <type>book</type>
    <title>Information technology, development, and social change</title>
    <contributor>Fay Patel</contributor>
    <publisher>New York : Routledge</publisher>
    <creationdate>2012</creationdate>
    <format>xxii, 157 p. : ill.</format>
    <subject>Information technology; Economic development; Digital divide; Social change; Electronic books</subject>
    <language>eng</language>
    <relation>$$Cseries $$VRoutledge studies in development and society ; 32</relation>
    <source>ebrrout</source>
    <lds02>ebrroutebr10569356</lds02>
    <lds01>NYU</lds01>
    <lds01>NYUAD</lds01>
  </display>
  <links>
    <openurl>$$Topenurl_journal</openurl>
    <openurlfulltext>$$Topenurlfull_journal</openurlfulltext>
    <linktoreview>$$TpersistentUrl$$DCopy item link</linktoreview>
    <linktouc>$$Tworldcat_oclc$$DCheck other libraries (WorldCat®)</linktouc>
  </links>
  <search>
    <creatorcontrib>edited by Fay Patel ... [et al.].</creatorcontrib>
    <creatorcontrib>Fay  Patel</creatorcontrib>
    <creatorcontrib>Patel, F</creatorcontrib>
    <creatorcontrib>ebrary, Inc.</creatorcontrib>
    <title>Information technology, development, and social change</title>
    <subject>Information technology</subject>
    <subject>Economic development</subject>
    <subject>Digital divide</subject>
    <subject>Social change</subject>
    <subject>Electronic books</subject>
    <subject>Ebooks</subject>
    <subject>E-books</subject>
    <subject>Online books</subject>
    <general>Routledge,</general>
    <general>[electronic resource] /</general>
    <sourceid>ebrrout</sourceid>
    <recordid>ebrroutebr10569356</recordid>
    <isbn>9780415502689</isbn>
    <isbn>0415502683</isbn>
    <isbn>9780203121207</isbn>
    <rsrctype>book</rsrctype>
    <creationdate>2012</creationdate>
    <addtitle>Routledge studies in development and society ; 32</addtitle>
    <searchscope>ebrrout</searchscope>
    <searchscope>NYU</searchscope>
    <searchscope>NYUAD</searchscope>
    <searchscope>BOBST</searchscope>
    <searchscope>IFA</searchscope>
    <searchscope>IFAC</searchscope>
    <searchscope>ISAW</searchscope>
    <searchscope>COUR</searchscope>
    <searchscope>REI</searchscope>
    <scope>ebrrout</scope>
    <scope>NYU</scope>
    <scope>NYUAD</scope>
    <scope>BOBST</scope>
    <scope>IFA</scope>
    <scope>IFAC</scope>
    <scope>ISAW</scope>
    <scope>COUR</scope>
    <scope>REI</scope>
    <lsr02>Routledge,</lsr02>
  </search>
  <sort>
    <title>Information technology, development, and social change</title>
    <creationdate>2012</creationdate>
    <author>Patel, Fay.</author>
    <lso01>2012</lso01>
  </sort>
  <facets>
    <language>eng</language>
    <creationdate>2012</creationdate>
    <topic>Information technology</topic>
    <topic>Economic development</topic>
    <topic>Digital divide</topic>
    <topic>Social change</topic>
    <toplevel>online_resources</toplevel>
    <prefilter>books</prefilter>
    <rsrctype>books</rsrctype>
    <creatorcontrib>Patel, F</creatorcontrib>
    <creatorcontrib>ebrary, Inc</creatorcontrib>
    <genre>Electronic books</genre>
    <library>BOBST</library>
    <library>IFA</library>
    <library>IFAC</library>
    <library>ISAW</library>
    <library>COUR</library>
    <library>REI</library>
  </facets>
  <dedup>
    <t>1</t>
    <c1>2011042898</c1>
    <c2>9780415502689;0415502683;9780203121207</c2>
    <c3>informationtechnologcialchange</c3>
    <c4>2012</c4>
    <f2>2011042898</f2>
    <f4>9780415502689;0415502683;9780203121207</f4>
    <f5>informationtechnologcialchange</f5>
    <f6>2012</f6>
    <f7>information technology development and social change</f7>
    <f8>nyu</f8>
    <f9>xxii, 157 p. :</f9>
    <f10>routledge</f10>
  </dedup>
  <frbr>
    <t>1</t>
    <k1>$$Kpatel fay$$AA</k1>
    <k1>$$Kebrary inc$$AA</k1>
    <k3>$$Kbookinformation technology development and social change$$AT</k3>
  </frbr>
  <delivery>
    <institution>NYU</institution>
    <institution>NYUAD</institution>
    <delcategory>Online Resource</delcategory>
  </delivery>
  <enrichment>
    <classificationlcc>HC79.I55</classificationlcc>
  </enrichment>
  <ranking>
    <booster1>1</booster1>
    <booster2>1</booster2>
  </ranking>
  <addata>
    <aulast>Patel</aulast>
    <aufirst>Fay</aufirst>
    <addau>Patel, Fay</addau>
    <addau>ebrary, Inc</addau>
    <btitle>Information technology, development, and social change</btitle>
    <seriestitle>Routledge studies in development and society ; 32</seriestitle>
    <date>2012</date>
    <risdate>2012.</risdate>
    <format>book</format>
    <genre>book</genre>
    <ristype>BOOK</ristype>
    <notes>Includes bibliographical references and indexes.</notes>
    <cop>New York</cop>
    <pub>Routledge</pub>
    <oclcid>796812677</oclcid>
    <lad01>Online Resource</lad01>
  </addata>
</record>
      PRIMO_DATA
    end

    trait :without_author do
      external_id 'dedupmrg39204437'
      format 'pnx'
      data <<-PRIMO_DATA
<?xml version="1.0" encoding="UTF-8"?>
<record>
  <control>
    <sourcerecordid>$$V000319086$$Onyu_aleph000319086</sourcerecordid>
    <sourcerecordid>$$V003172025$$Onyu_aleph003172025</sourcerecordid>
    <sourceid>$$Vnyu_aleph$$Onyu_aleph000319086</sourceid>
    <sourceid>$$Vnyu_aleph$$Onyu_aleph003172025</sourceid>
    <recordid>dedupmrg39204437</recordid>
    <originalsourceid>$$VNYU01$$Onyu_aleph000319086</originalsourceid>
    <originalsourceid>$$VNYU01$$Onyu_aleph003172025</originalsourceid>
    <sourceformat>$$VMARC21$$Onyu_aleph000319086</sourceformat>
    <sourceformat>$$VMARC21$$Onyu_aleph003172025</sourceformat>
    <sourcesystem>$$VAleph$$Onyu_aleph000319086</sourcesystem>
    <sourcesystem>$$VAleph$$Onyu_aleph003172025</sourcesystem>
    <ilsapiid>$$VNYU01000319086$$Onyu_aleph000319086</ilsapiid>
    <ilsapiid>$$VNYU01003172025$$Onyu_aleph003172025</ilsapiid>
  </control>
  <display>
    <type>book</type>
    <title>Funding and implementing universal access : innovation and experience from Uganda</title>
    <creationdate>2005</creationdate>
    <format>xiii, 90 p. : ill. ; 23 cm.</format>
    <identifier>$$Cisbn$$V997002518X; $$Cisbn$$V9789970025183</identifier>
    <language>eng</language>
    <source>$$Vnyu_aleph$$Onyu_aleph000319086</source>
    <source>$$Vnyu_aleph$$Onyu_aleph003172025</source>
    <availinstitution>$$INYU$$Scheck_holdings</availinstitution>
    <availinstitution>$$INS$$Scheck_holdings</availinstitution>
    <availpnx>available</availpnx>
    <lds01>NYU</lds01>
    <lds01>GEN</lds01>
    <lds01>NYU</lds01>
    <lds01>NS</lds01>
    <lds01>NYUAD</lds01>
    <lds02>nyu_aleph000319086</lds02>
    <lds02>nyu_aleph003172025</lds02>
  </display>
  <links>
    <linktoholdings>$$V$$Taleph_holdings$$Onyu_aleph000319086</linktoholdings>
    <linktoholdings>$$V$$Taleph_holdings$$Onyu_aleph003172025</linktoholdings>
    <backlink>$$V$$Taleph_backlink$$DMore bibliographic information$$Onyu_aleph000319086</backlink>
    <backlink>$$V$$Taleph_backlink$$DMore bibliographic information$$Onyu_aleph003172025</backlink>
    <linktorsrc>$$V$$Uhttp://site.ebrary.com/lib/newschool/Doc?id=10120554$$DOnline Version$$Onyu_aleph003172025</linktorsrc>
    <openurl>$$V$$Topenurl_journal$$Onyu_aleph000319086</openurl>
    <openurl>$$V$$Topenurl_journal$$Onyu_aleph003172025</openurl>
    <openurlfulltext>$$V$$Topenurlfull_journal$$Onyu_aleph000319086</openurlfulltext>
    <openurlfulltext>$$V$$Topenurlfull_journal$$Onyu_aleph003172025</openurlfulltext>
    <linktotoc>$$Tamazon_toc$$DCheck for Amazon Search Inside</linktotoc>
    <linktoexcerpt>$$Tsyndetics_excerpt$$DExcerpt from item</linktoexcerpt>
    <linktoreview>$$TpersistentUrl$$DCopy item link</linktoreview>
    <linktouc>$$Tamazon_uc$$DCheck Amazon</linktouc>
    <linktouc>$$Tworldcat_isbn$$DCheck other libraries (WorldCat®)</linktouc>
    <linktouc>$$Tamazon_uc$$DCheck Amazon</linktouc>
    <linktouc>$$Tworldcat_isbn$$DCheck other libraries (WorldCat®)</linktouc>
    <thumbnail>$$Tamazon_thumb</thumbnail>
  </links>
  <search>
    <title>Funding and implementing universal access : innovation and experience from Uganda /</title>
    <subject>Uganda Communications Commission</subject>
    <subject>Telephone  Government policy Uganda</subject>
    <subject>Digital divide  Uganda</subject>
    <subject>Information technology  Government policy Uganda</subject>
    <subject>Communication in rural development  Uganda</subject>
    <subject>IT (Information technology)</subject>
    <subject>Telephone service</subject>
    <subject>Telephones</subject>
    <subject>GDD (Global digital divide)</subject>
    <subject>Divide, Digital</subject>
    <subject>Global digital divide</subject>
    <general>Fountain Publishers : Uganda Communications Commission ; International Development Research Centre,</general>
    <sourceid>nyu_aleph</sourceid>
    <recordid>nyu_aleph000319086</recordid>
    <isbn>997002518X</isbn>
    <isbn>9789970025183</isbn>
    <rsrctype>book</rsrctype>
    <creationdate>2005</creationdate>
    <searchscope>BOBST</searchscope>
    <searchscope>BOBST Main Collection</searchscope>
    <searchscope>WEB</searchscope>
    <searchscope>WEB Internet Resources</searchscope>
    <searchscope>nyu_aleph</searchscope>
    <searchscope>NYU</searchscope>
    <searchscope>GEN</searchscope>
    <scope>BOBST</scope>
    <scope>BOBST Main Collection</scope>
    <scope>WEB</scope>
    <scope>WEB Internet Resources</scope>
    <scope>nyu_aleph</scope>
    <scope>NYU</scope>
    <scope>GEN</scope>
    <lsr01>HE9534.Z5 U33 2005</lsr01>
    <lsr01>HE9534 .Z5 U33 2005</lsr01>
    <lsr02>Fountain Publishers : Uganda Communications Commission ; International Development Research Centre,</lsr02>
    <title>Funding and implementing universal access innovation and experience from Uganda.</title>
    <subject>Information technology  Uganda</subject>
    <subject>Telecommunication  Law and legislation Uganda</subject>
    <subject>Electronic books</subject>
    <subject>Telecommunications</subject>
    <subject>Electric communication</subject>
    <subject>Telecom</subject>
    <subject>Telecommunication industry</subject>
    <general>Fountain Publishers ; International Research Development Centre,</general>
    <general>[electronic resource] :</general>
    <recordid>nyu_aleph003172025</recordid>
    <isbn>1552501884</isbn>
    <isbn>9781552501887</isbn>
    <addtitle>Canadian electronic library. Books collection.</addtitle>
    <searchscope>BWEB</searchscope>
    <searchscope>BWEB Internet Resources</searchscope>
    <searchscope>TWEB</searchscope>
    <searchscope>TWEB Internet Resources</searchscope>
    <searchscope>NS</searchscope>
    <searchscope>NYUAD</searchscope>
    <searchscope>IFA</searchscope>
    <searchscope>IFAC</searchscope>
    <searchscope>ISAW</searchscope>
    <searchscope>COUR</searchscope>
    <searchscope>REI</searchscope>
    <searchscope>NSSC</searchscope>
    <searchscope>NSFO</searchscope>
    <searchscope>NSGI</searchscope>
    <searchscope>NSKE</searchscope>
    <scope>BWEB</scope>
    <scope>BWEB Internet Resources</scope>
    <scope>TWEB</scope>
    <scope>TWEB Internet Resources</scope>
    <scope>NS</scope>
    <scope>NYUAD</scope>
    <scope>IFA</scope>
    <scope>IFAC</scope>
    <scope>ISAW</scope>
    <scope>COUR</scope>
    <scope>REI</scope>
    <scope>NSSC</scope>
    <scope>NSFO</scope>
    <scope>NSGI</scope>
    <scope>NSKE</scope>
    <lsr01>HC79.I55 F855 2005eb</lsr01>
    <lsr01>HC79 .I55 F855 2005eb</lsr01>
    <lsr02>Fountain Publishers ; International Research Development Centre,</lsr02>
  </search>
  <sort>
    <title>Funding and implementing universal access : innovation and experience from Uganda /</title>
    <creationdate>2005</creationdate>
    <lso01>2005</lso01>
  </sort>
  <facets>
    <language>eng</language>
    <creationdate>2005</creationdate>
    <topic>Uganda Communications Commission</topic>
    <topic>Telephone–Government policy–Uganda</topic>
    <topic>Digital divide–Uganda</topic>
    <topic>Information technology–Government policy–Uganda</topic>
    <topic>Communication in rural development–Uganda</topic>
    <collection>BOBST</collection>
    <collection>WEB</collection>
    <toplevel>available</toplevel>
    <toplevel>online_resources</toplevel>
    <prefilter>books</prefilter>
    <rsrctype>books</rsrctype>
    <library>BOBST</library>
    <library>WEB</library>
    <lfc01>Main Collection</lfc01>
    <lfc01>Internet Resources</lfc01>
    <classificationlcc>H - Social sciences.–Transportation and communications</classificationlcc>
    <topic>Information technology–Uganda</topic>
    <topic>Telecommunication–Law and legislation–Uganda</topic>
    <collection>TWEB</collection>
    <genre>Electronic books</genre>
    <library>IFA</library>
    <library>IFAC</library>
    <library>ISAW</library>
    <library>COUR</library>
    <library>REI</library>
    <library>NSSC</library>
    <library>NSFO</library>
    <library>NSGI</library>
    <library>NSKE</library>
  </facets>
  <dedup>
    <t>1</t>
    <c1>2005325831</c1>
    <c2>997002518X;9789970025183</c2>
    <c3>fundingandimplementifromuganda</c3>
    <c4>2005</c4>
    <f1>2005325831</f1>
    <f3>997002518X;9789970025183</f3>
    <f5>fundingandimplementifromuganda</f5>
    <f6>2005</f6>
    <f7>funding and implementing universal access innovation and experience from uganda</f7>
    <f8>ug</f8>
    <f9>xiii, 90 p. :</f9>
    <f10>fountain publishers</f10>
    <f11>uganda communications commission</f11>
  </dedup>
  <frbr>
    <t>1</t>
    <k1>$$Kuganda communications commission$$AA</k1>
    <k3>$$Kbookfunding and implementing universal access innovation and experience from uganda$$AT</k3>
    <k1>$$Kinternational development research centre canada$$AA</k1>
  </frbr>
  <delivery>
    <institution>$$VNYU$$Onyu_aleph000319086</institution>
    <institution>$$VGEN$$Onyu_aleph000319086</institution>
    <delcategory>$$VOnline Resource$$Onyu_aleph000319086</delcategory>
    <institution>$$VNYU$$Onyu_aleph003172025</institution>
    <institution>$$VNS$$Onyu_aleph003172025</institution>
    <institution>$$VNYUAD$$Onyu_aleph003172025</institution>
    <delcategory>$$VOnline Resource$$Onyu_aleph003172025</delcategory>
  </delivery>
  <enrichment>
    <classificationlcc>HE9534.Z5</classificationlcc>
  </enrichment>
  <ranking>
    <booster1>1</booster1>
    <booster2>1</booster2>
  </ranking>
  <addata>
    <btitle>Funding and implementing universal access : innovation and experience from Uganda</btitle>
    <date>2005</date>
    <risdate>2005.</risdate>
    <isbn>997002518X</isbn>
    <isbn>9789970025183</isbn>
    <format>book</format>
    <genre>book</genre>
    <ristype>BOOK</ristype>
    <notes>Includes bibliographical references (p. 85-87) and index.</notes>
    <cop>Kampala : Ottawa</cop>
    <pub>Fountain Publishers : Uganda Communications Commission ; International Development Research Centre</pub>
    <oclcid>62303076</oclcid>
    <lccn>2005325831</lccn>
    <lad01>BOBSTWEB</lad01>
    <lad01>Online Resource</lad01>
    <btitle>Funding and implementing universal access innovation and experience from Uganda.</btitle>
    <seriestitle>Canadian electronic library. Books collection</seriestitle>
    <risdate>c2005.</risdate>
    <isbn>9781552501887</isbn>
    <cop>Kampala, Uganda : Ottawa, Ont.</cop>
    <pub>Fountain Publishers ; International Research Development Centre</pub>
    <lad01>BWEBTWEB</lad01>
  </addata>
</record>
      PRIMO_DATA
    end

    trait :user_record do
      user
    end

    trait :tmp_user_record do
      tmp_user
    end

    factory :primo_record_with_creator, traits: [:primo, :with_creator]
    factory :primo_record_with_contributor, traits: [:primo, :with_contributor]
    factory :primo_record_without_author, traits: [:primo, :without_author]
    factory :user_record, traits: [:user_record, :external]
    factory :user_primo_record1, traits: [:virtual_inequality_id, :primo, :user_record]
    factory :user_primo_record2, traits: [:travels_with_my_aunt_id, :primo, :user_record]
    factory :user_xerxes_record1, traits: [:a_place_for_hemingway, :xerxes, :user_record]
    factory :tmp_user_record, traits: [:tmp_user_record, :external]
    factory :tmp_user_primo_record1, traits: [:tmp_user_record, :primo, :virtual_inequality_id]
    factory :tmp_user_primo_record2, traits: [:tmp_user_record, :primo, :travels_with_my_aunt_id]

    after(:build) do |record|
      record.becomes_external_system.save
    end

  end
end
