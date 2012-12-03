require 'find'
module SchemaToScaffold
  
  PATH_NAMES = ["HOME", "HOMEPATH", "USERPROFILE"]
  
  class Path
    
    attr_reader :schema_path
    
    def initialize
      @schema_path = :schema_path
      @paths = PATH_NAMES.detect {|h| ENV[h] != nil}
    end
    
    def search
      puts @paths
      puts 'looking for schema.rb in '+ ENV[@paths]
      @schema_paths =  Array.new
      Find.find(ENV[@paths]) do |path|
        path.match(/.*schema\.rb$/) ? @schema_paths<<path : nil
      end
    end
    
    def choose
      @schema_paths.each_with_index {|path,i|  puts "#{i}. #{path}" }
      begin
          print "\nSelect a path to the target schema: "
      end while !(id = gets.chomp.to_i).is_a?(Fixnum)
      @schema_path = @schema_paths[id]
    end
    
    
  end
  
end
