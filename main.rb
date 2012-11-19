require 'active_support/inflector'

schema = File.open("C:/Users/hpinto/git/gestorreservas/db/schema.rb", "r") {|f| f.read.split(/create_/) }
schema.shift
tables = schema.map { |s| s.scan(/table "(.*)"/).first }
tables.each_with_index{|tbl,i|  puts "#{i}. #{tbl.first}"}
i = [(print 'Select a Table:'), gets.rstrip.to_i][1]
t = tables[i].first
scaffold_model_fields = schema[i].scan(/t\.(\w+)\s+"([a-z0-9_]+)/).inject("") { |str, s| str << "#{s[1]}:#{s[0]} "}
if t==t.singularize || t==t.camelcase; puts"";puts"You should change the name of the table according with rails convention" end 
puts "rails generate scaffold #{t.singularize.camelize} #{scaffold_model_fields}"
