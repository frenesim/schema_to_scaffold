require 'active_support/inflector'

file = File.open("C:/Users/hpinto/git/gestorreservas/db/schema.rb", "r")
schema = file.read.split(/create_table/)
table=Array.new
schema.each_with_index do |s,i| 
  table<<s.scan(/"(.*)".*\|$/)
  if i!=0 then puts "#{i}. #{table[i][0][0]}" end
end
i = [(print 'choose model:'), gets.rstrip][1]
t = table[i.to_i][0][0]
puts "showing table #{t} fields"
scaffold_model_fields = String.new
schema[i.to_i].scan(/t\.(\w+)\s+"([a-z0-9_]+)/).each { |s| scaffold_model_fields << "#{s[1]}:#{s[0]} "}
t="Joy"
if t==t.singularize || t==t.camelcase; puts"";puts"I should change the table name according with rails convention" end 
t.came
puts "rails generate scaffold #{t.singularize.camelize} #{scaffold_model_fields}"
