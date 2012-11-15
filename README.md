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
* It will give some alerts if your names are not following the rails convention.

read a litle about [rails convention](http://itsignals.cascadia.com.au/?p=7) 

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

