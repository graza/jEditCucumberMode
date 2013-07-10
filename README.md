jEdit Cucumber Mode
===================

The files in this directory are used to provide syntax highlighting of
Cucumber's feature files.  Various XML techniques are used to detect and
switch to appropriate keywords when the language is specified at the top
of the file.  This happens dynamically as the "# language:" set at the top
of the file is changed.

The language defaults to English if it can't be matched.

Installation
------------

The jEdit installation bundle comes with two locations from which edit modes
are retrieved.  The first comes with the jEdit install bundle and should be
left alone.  The second is for users' own edit modes.  The user area can be
found using the "Utilities -> Settings Directory" menu.

The files in this repository can be dropped into the user area, although
the cucumber\_\*.xml files will unfortunately need to be modified slightly
to get them working.  (See the Issues section below for the reason why.)

See the location on the line starting with:

> \<!ENTITY % cucumber_pe SYSTEM

It must point to a valid location.  If you're having difficulties, check for
errors under the menu item "Utilities -> Troubleshooting -> Activity Log".

Alternatively, to regenerate the catalog and XML files to be in line with
the version of Gherkin you currently have installed, you can run the included
generate_xml_files.rb file in the modes directory.

*NOTE* Each of the locations has a "catalog" file that lists the modes and
references an XML file that defines the rules for that mode.

This project includes such a file and you might already have your own file.
Also note that the generate_xml_files.rb script overwrites the file.
Please be careful backup/merge your own file if you have one.

Language Support
----------------

The catalog, cucumber.xml, and all cucumber\_\*.xml files included have
been generated by the generate_xml_files.rb script.  This uses the
'gherkin/i18n' library to get all the details of the languages included.
If you've got your own version of gherkin with its own dialect, then
re-running this script should work.

Alternatively Keywords for additional languages can be manually added by
creating an appropriate language file with its own keyword values.  
See cucumber_en.xml for a starting point.

Then a reference needs to be added to the catalog file, and delegation
must be added to the file cucumber.xml.

Issues
------

I can't figure out how to get jEdit to load DTD components from a relative
path.  It just defaults to looking in the APPPATH directory.  So the files
in this repository reflect the jEdit modes directory on my own machine.  As
discussed above, the files can easily be regenerated for your environment
and installation of Gherkin.

Credits
-------

This started from work by [Gabriel](http://rhaseventh.blogspot.ie/ "blog")
[Medina](https://github.com/rha7dotcom/ "github")
[posted](https://groups.google.com/d/topic/cukes/NGXp2wrKFK0/discussion)
to the Cukes Google group.
