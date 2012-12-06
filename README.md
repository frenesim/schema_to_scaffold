# Schema to Scaffold

Generate rails scaffold pages based on a rails database schema you already have.

Use your schema.rb file from `<rails_app>/db` or generated with `rake db:schema:dump`


SchemaToScaffold will generate rails scaffolding scripts by table like this:

    rails g scaffold users fname:string lname:string bdate:date email:string encrypted_password:string


## Installation

Assuming that you have rubygems-bundler installed, just type:

    gem install schema_to_scaffold


## Usage

Just type:

    scaffold [options]
    
	[options]
    -h				Displays help.
	-p <path>		It specifies a search path or a path to a file 
					ex: -p /user/path  or  /path/to/your/schema.rb
	-c				Works only on linux. Will copy the script copied to your clipboard.
					You will need to have xclip installed(see below).

### To install xclip

    sudo apt-get install xclip
    
### Contributing

	Want to contribute? Great!

1. Fork it.
2. Create a branch (`git checkout -b my_schema_to_scafold`)
3. Commit your changes (`git commit -am "Added great stuff"`)
4. Push to the branch (`git push origin my_schema_to_scafold`)
5. Open a [Pull Request][1]
6. That's all!! 

[1]: http://github.com/frenesim/schema_to_scaffold/pulls

### Colaborate

	if you want to colaborate send me an email please. 
