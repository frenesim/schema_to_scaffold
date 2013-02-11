require 'find'
module SchemaToScaffold
  
  PATH_NAMES = ["HOME", "HOMEPATH", "USERPROFILE"]
  
  ##
  # Deal with the path argument
  
  class Path
    
    def initialize(path)
      @search_path = ENV[PATH_NAMES.detect {|home| ENV[home] != nil}]
      @path = path
    end
    
    def check_directory
      unless File.directory?(@search_path)
        puts "\nSorry #{@search_path} is not a valid directory!"
        exit
      end
      puts "\nLooking for schema.rb in #{@search_path}"
    end
    
    ##
    # Will search for schema.rb in the user directory
    def search_rb
      @search_path = @path.to_s unless @path.nil?
      check_directory
      @schema_paths = Array.new
      Find.find(@search_path) do |s_p|
        @schema_paths<<s_p if s_p[/schema\S*\.rb$/]
      end
    end
    
    ##
    # Return the chosen path
    def choose
      @schema_paths.each_with_index {|path,indx|  puts "#{indx}. #{path}" }
      begin
          print "\nSelect a path to the target schema: "
      end while @schema_paths[(id = gets.to_i)].nil?
      @schema_paths[id]
    end
    
    
  end
  
end
