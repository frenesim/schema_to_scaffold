require 'active_support/inflector'
require './lib/schemaffold'

homes = ["HOME", "HOMEPATH"]
realHome = homes.detect {|h| ENV[h] != nil}
if not realHome
   puts "Could not find home directory"
end

path = "#{ENV[realHome]}/git/gestorreservas/db/schema.rb".gsub(/\\/,'/') 
data = File.open(path, 'r') {|f| f.read }
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