# Schema to Scaffold

[![Code Climate](https://codeclimate.com/github/frenesim/schema_to_scaffold.png)](https://codeclimate.com/github/frenesim/schema_to_scaffold)

This Gem generates Rails command strings based on a Rails database schema you already have. Unlike traditional migrations, which modify the database as they generate Rails scaffolding code, this Gem reads the schema for your database and generates the Rails code which matches your database's existing columns.

This Gem does not modify anything; it simply prints a string which you can then use to invoke the Rails generators, and optionally copies the string to your clipboard. Generated string commands available are:
```bash
rails generate scaffold <model_name> <field[:type]>
rails generate factory_bot:model <ModelName> <field[:type]>
```

Use your schema.rb file from `<rails_app>/db` or generated with `rake db:schema:dump`. You can optionally rename schema.rb to `schema_your_fav_name.rb` and it will still be found. Unique schema file names will prevent schema.rb from being overwritten if you use migrations and run `rake db:migrate`.

Schema to Scaffold output looks like this:

    rails generate scaffold users fname:string lname:string bdate:date email:string encrypted_password:string

It's possible to generate scripts for all your tables at once. Just enter `*` when selecting the table.

## Installation

Assuming that you have rubygems-bundler installed, just type:

    gem install schema_to_scaffold

## Usage

```bash
$ scaffold [options]
```

Generate a rails scaffold script for a given schema.rb
```
 -h             Displays help.
 -p <path>      It specifies a path to a folder or to a file.
 -c             Will copy the script to your clipboard. Requires xclip be installed on Linux.
 -f             Generates a factory_bot:model rather than a full scaffold.
 -m             Add migration (use if your schema comes from a different database)
```
Examples:
```bash
$ scaffold
$ scaffold -c -p ~/work/rails/my_app
$ scaffold -c -p ~/work/rails/my_app/db/schema.rb
```

## Generators

Since this gem assists you in invoking Rails generators for your scaffolding, make sure you've configured your generators with your preferred settings before you start. There's a good [Rails Guide](http://guides.rubyonrails.org/generators.html) and you can invoke `$ rails g scaffold -h` to see options.

Generator options are configured in `config/application.rb`. Here is an example setting:

```ruby
module YourApplication
  class Application < Rails::Application
    config.generators do |g|
      g.hidden_namespaces << :test_unit << :erb # Hide unwanted generators
      g.template_engine :slim # Select template engine
      g.helper false # Don't create view helpers
      g.test_framework  :rspec, :view_specs => false
      g.integration_tool :rspec
      g.fixture_replacement :factory_bot # Choose between fixtures and factories
      g.factory_bot dir: 'spec/factories'
      g.javascript_engine :js # Disable coffeescript
      g.scaffold_controller "responders_controller" # from responders gem
    end
  end
end
```
If you configure factory_bot as your fixture_replacement here, there is no need to invoke factory_bot separately with the `scaffold -f` command.

## Migrations

Schema to Scaffold is set up by default to support creating scaffolds for your existing database, presuming that you have generated schema.rb with `rake db:schema:dump`. Therefore, no migrations are necessary, because the database already contains the desired table. If instead you are using a schema.rb that was generated from a database other than current development database, you can use the `-m` option to build a generator command that includes migrations.

## To install xclip on Linux

    `apt-get install xclip`

## Contributing

	Want to contribute? Great!

1. Fork it.
2. Create a branch (`git checkout -b my_schema_to_scaffold`)
3. Commit your changes (`git commit -am "Added great stuff"`)
4. Push to the branch (`git push origin my_schema_to_scaffold`)
5. Open a [Pull Request][1]
6. That's all!!

[1]: http://github.com/frenesim/schema_to_scaffold/pulls

## Collaborate

	If you want to collaborate, please send me an email, or just create an issue or pull request.
