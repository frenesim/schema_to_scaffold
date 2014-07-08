require 'schema_to_scaffold/version'
require 'schema_to_scaffold/schema'
require 'schema_to_scaffold/table'
require 'schema_to_scaffold/attribute'
require 'schema_to_scaffold/path'

module SchemaToScaffold
  extend self

  ## Usage help text to print in all platforms

  GENERIC_HELP = <<-END_OF_HELP
  
Usage: scaffold [options] 
Generate a rails scaffold script for a given schema.rb
 -h             Displays help.
 -p <path>      It specifies a path to a folder or to a file.
 -c             Will copy the script to your clipboard. Requires xclip be installed on Linux.
 -f             Generates a factory_girl:model rather than a full scaffold.
 -m             Add migration (use if your schema comes from a different database)

END_OF_HELP


  ## Windows specific usage help text

  WINDOWS_HELP = <<-WINDOWS_SAMPLE
Examples:
scaffold 
scaffold -p C:\\Users\\JohnDoe
scaffold -c -p C:\\Users\\JohnDoe\\Documents\\schema.rb
WINDOWS_SAMPLE

  ## Linux specific usage help text

  LINUX_HELP = <<-LINUX_SAMPLE
Examples:
scaffold
scaffold -c -p ~/work/rails/my_app
scaffold -c -p ~/work/rails/my_app/db/schema.rb
LINUX_SAMPLE

  def help_msg
    return GENERIC_HELP +
    case RUBY_PLATFORM
    when /darwin/i then LINUX_HELP
    when /linux/i  then LINUX_HELP
    when /mingw/i  then WINDOWS_HELP
    when /win/i    then WINDOWS_HELP
    end
  end

  ##
  # Parses ARGV and returns a hash of options.

  def parse_arguments(argv)
    if argv_index = argv.index("-p")
      path = argv.delete_at(argv_index+1)
      argv.delete('-p')
    end
    args = {
      :clipboard => argv.delete('-c'),    # check for clipboard flag
      :factory_girl => argv.delete('-f'), # factory_girl instead of scaffold
      :migration => argv.delete('-m'),   # generate migrations
      :help =>  argv.delete('-h'),        # check for help flag
      :path =>  path                      # get path to file(s)
    }
    unless argv.empty?
      puts "\n------\nWrong set of arguments.\n------\n" 
      puts help_msg
      exit
    else
      args
    end

  end

  ##
  # Generates the rails scaffold script

  def self.generate_script(schema, table=nil,target)
    schema = Schema.new(schema) unless schema.is_a? Schema
    return schema.to_script if table.nil?
    schema.table(table).to_script target
  end
end
