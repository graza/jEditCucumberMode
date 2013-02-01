#!/usr/bin/env ruby
require 'gherkin/i18n'

feature_element_keys = Gherkin::I18n::FEATURE_ELEMENT_KEYS
#feature_element_keys = Gherkin::I18n::KEYWORD_KEYS
step_keyword_keys = Gherkin::I18n::STEP_KEYWORD_KEYS


catalog = File.open("catalog", 'w')
catalog.puts <<-EOS
<?xml version="1.0"?>
<!DOCTYPE MODES SYSTEM "catalog.dtd">
<MODES>
<MODE NAME="cucumber" FILE="cucumber.xml" FILE_NAME_GLOB="*.feature" />
EOS
modefile = File.open("cucumber.xml", 'w')
modefile.puts <<-EOS
<?xml version="1.0" ?>
<!DOCTYPE MODE SYSTEM "xmode.dtd">
<MODE> 
  <PROPS>
    <PROPERTY NAME="noTabs" VALUE="true"/>
    <PROPERTY NAME="wrap" VALUE="none"/>
    <PROPERTY NAME="tabSize" VALUE="2"/>
    <PROPERTY NAME="indentSize" VALUE="2"/>
    <PROPERTY NAME="folding" VALUE="indent"/>
    <PROPERTY NAME="noWordSep" VALUE="_-"/>
  </PROPS>
  <RULES
    ESCAPE="\\"
    IGNORE_CASE="FALSE"
    HIGHLIGHT_DIGITS="TRUE"
    NO_WORD_SEP="-&#37;">
EOS

Gherkin::I18n.all.each do |lang|
  File.open("cucumber_#{lang.iso_code}.xml", 'w') do |f|
    catalog.puts "<MODE NAME=\"cucumber_#{lang.iso_code}\" FILE=\"cucumber_#{lang.iso_code}.xml\" />"
    modefile.puts <<-EOS
    <SPAN_REGEXP DELEGATE="cucumber_#{lang.iso_code}::gherkin" HASH_CHAR="#" TYPE="COMMENT1">
      <BEGIN>\\A#\\s*language\\s*:\\s*#{lang.iso_code}$</BEGIN> 
      <END REGEXP="TRUE">\\Z</END>
    </SPAN_REGEXP>
    EOS
    f.puts <<-EOS
<?xml version="1.0" ?>
<!DOCTYPE MODE SYSTEM "xmode.dtd" [
<!-- Need to un-comment one or other of these for jEdit to find the rest of the DTD -->
<!-- ENTITY % cucumber_pe SYSTEM "..\\..\\Users\\gagnew\\AppData\\Roaming\\jEdit\\modes\\cucumber.dtd" -->
<!-- ENTITY % cucumber_pe SYSTEM "C:\\Program Files\\Tools\\jEdit\\modes\\cucumber.dtd" -->
<!ENTITY % cucumber_pe SYSTEM "/Users/oldmac/Library/jEdit/modes/cucumber.dtd">
    EOS
    feature_element_keys.each do |keyword|
      f.puts "<!ENTITY #{keyword} \"#{lang.keywords(keyword).join("|")}\">"
    end
    s = Gherkin::I18n::STEP_KEYWORD_KEYS.collect {|k| lang.keywords(k).reject {|w| w =~ /^\* $/ } }
    f.puts "<!ENTITY step \"#{s.join("|")}|\\* \">"
    f.puts <<-EOS
%cucumber_pe;
]>
<MODE>
&props;
&gherkin_rules;
</MODE>
    EOS
  end
end
catalog.puts "</MODES>"
modefile.puts <<-EOS
    <IMPORT DELEGATE="cucumber_en::gherkin"/>
  </RULES>
</MODE>
EOS
