Schema to Scaffold
==================

After I cross with rake db:schema:dump I feel that it could do a litle more in my case. So there it is.

Usage
-------

The code is very simple and the usage is not friendly but almost.

1. download the zip (or copy paste de code) 
2. save main.rb in a folder.
3. cd folder
4. edit the main.rb and change the path to point to your schema.rb  (genereted with the rake db:schema:dump)
5. close and save
6. ruby main.rb 
7. chose your table
8. copy the rails generate scaffold command
9. paste the command in your project

* Nine quick steps that will save you a lot of time
It will give some alerts if your names are not following the rails convention.
read a litle about [rails convention](http://itsignals.cascadia.com.au/?p=7) -- d 

* [.markdown, .mdown, .md](http://daringfireball.net/projects/markdown/) -- `gem install redcarpet` (https://github.com/vmg/redcarpet)
* [.textile](http://www.textism.com/tools/textile/) -- `gem install RedCloth`
* [.rdoc](http://rdoc.sourceforge.net/) -- `gem install rdoc -v 3.6.1`
* [.org](http://orgmode.org/) -- `gem install org-ruby`
* [.creole](http://wikicreole.org/) -- `gem install creole`
* [.mediawiki](http://www.mediawiki.org/wiki/Help:Formatting) -- `gem install wikicloth`
* [.rst](http://docutils.sourceforge.net/rst.html) -- `easy_install docutils`
* [.asciidoc](http://www.methods.co.nz/asciidoc/) -- `brew install asciidoc`
* [.pod](http://search.cpan.org/dist/perl/pod/perlpod.pod) -- `Pod::Simple::HTML`
  comes with Perl >= 5.10. Lower versions should install Pod::Simple from CPAN.


Contributing
------------

Want to contribute? Great!

1. Fork it.
2. Create a branch (`git checkout -b my_markup`)
3. Commit your changes (`git commit -am "Added Snarkdown"`)
4. Push to the branch (`git push origin my_markup`)
5. Open a [Pull Request][1]
6. Enjoy a refreshing Diet Coke and wait

[1]: http://github.com/frenesim/schema_to_scaffold/pulls

