require 'active_support/inflector'

schema = File.open("./schema.rb", "r") {|f| f.read.split(/create_/) }
puts "Loaded tables:"
tables = schema.map.with_index do |s,i|
  s.scan(/table "(.*)"/) {|table| puts "#{i}. #{table.first}"; table }
end
i = [(print 'choose model:'), gets.rstrip.to_i][1]
t = tables[i]
puts "Showing #{t} fields"
scaffold_model_fields = schema[i].scan(/t\.(\w+)\s+"([a-z0-9_]+)/).inject("") { |str, s| str << "#{s[1]}:#{s[0]} "}
t="Joy"
if t==t.singularize || t==t.camelcase; puts"";puts"I should change the table name according with rails convention" end 
t.came
puts "rails generate scaffold #{t.singularize.camelize} #{scaffold_model_fields}"
