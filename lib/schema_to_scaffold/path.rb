require 'find'
module SchemaToScaffold
  
  PATH_NAMES = ["HOME", "HOMEPATH", "USERPROFILE"]
  
  class Path
    
    def initialize
      @search_path = ENV[PATH_NAMES.detect {|h| ENV[h] != nil}]
    end
    
    ##
    # Will search for schema.rb in the user directory
    def search_in(*path)
      @search_path = path.first if path.any?
      puts "looking for schema.rb in #{@search_path}"
      @schema_paths = Array.new
      Find.find(@search_path) do |s_p|
        @schema_paths<<s_p if s_p[/schema\.rb$/]
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
