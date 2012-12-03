require 'schema_to_scaffold/version'
require 'schema_to_scaffold/schema'
require 'schema_to_scaffold/table'
require 'schema_to_scaffold/attribute'
require 'schema_to_scaffold/path'

module SchemaToScaffold
  extend self

  ## Usage help text to print in all platforms

  GENERIC_HELP = <<-END_OF_HELP
Usage: scaffold [OPTION] PATH
Generate a rails scaffold script for the given schema.rb file
PATH is the path to the schema.rb file.

END_OF_HELP


  ## Windows specific usage help text

  WINDOWS_HELP = <<-WINDOWS_SAMPLE
Example: scaffold C:\Users\John\ Doe\Documents\schema.rb

WINDOWS_SAMPLE

  ## Linux specific usage help text

  LINUX_HELP = <<-LINUX_SAMPLE
    OPTIONS:
      -x     put the rails scaffold script in your clipboard using xclip which should be installed

Example: scaffold ~/work/rails/my_app/db/schema.rb

LINUX_SAMPLE

  def help_msg
    return GENERIC_HELP +
    case RUBY_PLATFORM
    when /win/i   then WINDOWS_HELP
    when /mingw/i then WINDOWS_HELP
    when /linux/i then LINUX_HELP
    end
  end

  ##
  # Parses ARGV and returns a hash of options.

  def parse_arguments(argv)
    {
      xclip: argv.delete('-c'),                                # check for xclip flag
      help: argv.delete('-h'),                                 # check for help flag
      path: argv[0],                                           # get path to file, must be the last for argv[0] to work
    }
  end

  ##
  # Generates the rails scaffold script

  def self.generate_script(schema, table=nil)
    schema = Schema.new(schema) unless schema.is_a? Schema
    return schema.to_script if table.nil?
    schema.table(table).to_script
  end
end
