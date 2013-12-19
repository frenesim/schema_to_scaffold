# Schema to Scaffold

[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/frenesim/schema_to_scaffold)

This Gem shall generate rails commands strings based on a rails database schema you already have.<br>
Generated string commands available are:<br>
`rails generate scaffold <model_name> <field[:type]>`<br>
`rails generate factory_girl:model <ModelName> <field[:type]>`

Important:
This gem will not run code for you. It will only generate a string for you to copy and paste

Use your schema.rb file from `<rails_app>/db` or generated with `rake db:schema:dump`
You can rename schema.rb to schema_your_fav_name.rb that I will find it too. This will prevent schema.rb from being
overwritten when one run rake db:migrate.

SchemaToScaffold will generate rails scaffolding scripts by table like this:

    rails g scaffold users fname:string lname:string bdate:date email:string encrypted_password:string

It's possible to generate scripts for all your tables at once. Just choose '*' when choosing the table.

## Installation

Assuming that you have rubygems-bundler installed, just type:

    gem install schema_to_scaffold


## Usage

Just type:

    scaffold [options]
    
	[options]
        -h			Displays help.
	-p <path>		It specifies a search path or a path to a file 
					ex: -p /user/path  or  /path/to/your/schema.rb
	-c				Works only on linux. Will copy the script copied to your clipboard.
					You will need to have xclip installed(see below).

### To install xclip

    sudo apt-get install xclip
    
### Contributing

	Want to contribute? Great!

1. Fork it.
2. Create a branch (`git checkout -b my_schema_to_scaffold`)
3. Commit your changes (`git commit -am "Added great stuff"`)
4. Push to the branch (`git push origin my_schema_to_scaffold`)
5. Open a [Pull Request][1]
6. That's all!! 

[1]: http://github.com/frenesim/schema_to_scaffold/pulls

### Collaborate

	If you want to collaborate send me an email please. 
