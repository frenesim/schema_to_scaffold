$:.unshift File.expand_path('../lib', File.dirname(__FILE__))
require 'schema_to_scaffold'
require 'find'

## Argument conditions

opts = SchemaToScaffold.parse_arguments(ARGV)

if opts[:help]
  puts SchemaToScaffold.help_msg
  exit 0
end

## looking for schema.rb in user directory
if opts[:path].nil?
  paths = SchemaToScaffold::Path.new
  paths.search
  paths.choose
end

begin
  path = opts[:path] || paths.schema_path
  data = File.open(path, 'r') {|f| f.read }
rescue
  puts "Unable to open file '#{path}'"
  exit 1
end

## Generate script from schema

schema = SchemaToScaffold::Schema.new(data)

puts "\nLoaded tables:"
schema.table_names.each_with_index {|name,i|  puts "#{i}. #{name}" }

begin
  print "\nSelect a table: "
end while schema.table_names[(table_id = gets.to_i)].nil?

script = SchemaToScaffold.generate_script(schema, table_id)
puts "\n#{script}"
if opts[:xclip]
  puts("\n(copied to your clipboard)")
  exec("echo '#{script}' | xclip -selection c")
end
