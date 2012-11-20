require 'active_support/inflector'
require './lib/schemaffold'
require 'find'

homes = ["HOME", "HOMEPATH"]
realHome = homes.detect {|h| ENV[h] != nil}

puts 'looking for schema.rb in '+ ENV[realHome]
schema_paths =  Array.new
Find.find(ENV[realHome]) do |path|
  path.match(/.*schema\.rb$/) ? schema_paths<<path : nil
end
schema_paths.each_with_index {|path,i|  puts "#{i}. #{path}" }
begin
    print "\nSelect a path to the target schema: "
end while !(id = gets.chomp.to_i).is_a?(Fixnum)


#path = "#{ENV[realHome]}/git/gestorreservas/db/schema.rb".gsub(/\\/,'/') 
data = File.open(schema_paths[id], 'r') {|f| f.read }
schema = Schemaffold::Schema.new(data)
  
  begin
    schema.check_rails_naming_conventions
  rescue NotFollowingConventionsError => msg
    puts msg
  end
  
  puts "\nLoaded tables:"
  schema.table_names.each_with_index {|name,i|  puts "#{i}. #{name}" }

  begin
    print "\nSelect a table: "
  end while !(table_id = gets.chomp.to_i).is_a?(Fixnum)

  script = Schemaffold.generate_script(schema, table_id)
  puts "\n#{script}"