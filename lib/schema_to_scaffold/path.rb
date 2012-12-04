require 'find'
module SchemaToScaffold
  
  PATH_NAMES = ["HOME", "HOMEPATH", "USERPROFILE"]
  
  class Path
    
    def initialize
      @paths = PATH_NAMES.detect {|h| ENV[h] != nil}
    end
    
    ##
    # Will search for schema.rb in the user directory
    def search
      puts 'looking for schema.rb in '+ ENV[@paths]
      @schema_paths =  Array.new
      Find.find(ENV[@paths]) do |path|
        @schema_paths<<path if path.match(/.*schema\.rb$/)
      end
    end
    
    ##
    # Return the chosen path
    def choose
      @schema_paths.each_with_index {|path,i|  puts "#{i}. #{path}" }
      begin
          print "\nSelect a path to the target schema: "
      end while (id = gets.chomp.to_i).nil?
      @schema_paths[id]
    end
    
    
  end
  
end
