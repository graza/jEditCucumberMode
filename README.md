jEdit Cucumber Mode
===================

The files in this directory are used to provide syntax highlighting of
Cucumber's feature files.  Various XML techniques are used to detect and
switch to appropriate keywords when the language is specified at the top
of the file.  This happens dynamically as the "# language:" set at the top
of the file is changed.

The language defaults to English if it can't be mathed.

Adding Languages
----------------

Keywords for additional languages can be added by adding an appropriate
language file with its own keyword values.  See cucumber_en.xml for a
starting point.

Then a reference needs to be added to the catalog file, and delegation
must be added to the file cucumber.xml.

Issues
------

I can't figure out how to get jEdit to load DTD components from a relative
path.  It just defaults to looking in the APPPATH directory.  So I've had to
hard code the location of cucumber.dtd in the XML files that use it.
