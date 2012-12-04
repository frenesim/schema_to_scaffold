# Schema to Scaffold #

Generate rails scaffold pages based on a rails database schema you already have.

Use your schema.rb file from `<rails_app>/db` or generated with `rake db:schema:dump`


SchemaToScaffold will generate rails scaffolding scripts by table like this:

    rails g scaffold users fname:string lname:string bdate:date email:string encrypted_password:string


## Installation ##

We assume you have rubygems-bundler installed, just type:

    gem install schema_to_scaffold


## Usage ##

Just type:

    scaffold [options]

\[OPTIONS\]
 -h					Displays help.
 -p <path>			It specifies a file ex: -p /path/to/your/schema.rb
 -c					Works only on linux. Will copy the script copied to your clipboard.	You will need to have xclip installed(see below).

### To install xclip ###

    sudo apt-get install xclip
