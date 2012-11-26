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

    scaffold /path/to/your/schema.rb

or if you are using linux you can use -x

    scaffold /path/to/your/schema.rb -x

to have the script copied to your clipboard, you will need to have xclip installed(see below).

### To install xclip ###

    sudo apt-get install xclip
