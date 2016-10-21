require 'find'
module SchemaToScaffold
  
  ##
  # Deal with the path argument

  class Path
    
    def initialize(path)
      @search_path = Dir.pwd
      @path = path
    end

    ##
    # Validate if a given path leads to a directory
    def check_directory
      unless File.directory?(@search_path)
        puts "\nSorry #{@search_path} is not a valid directory!\nHere is an example:\nscaffold -p /home/foo/bar"
        exit
      end
      puts "\nLooking for schema.rb in #{@search_path}"
    end
    

    ##
    # Return the chosen path
    def choose
      search_rb
      if @schema_paths.empty?
        puts "\nSorry there is none /schema[^\/]*.rb$/ in the directory #{@search_path}"
        exit
      end
      @schema_paths.each_with_index {|path,indx|  puts "#{indx}. #{path}" }
      begin
          print "\nSelect a path to the target schema: "
      end while @schema_paths[(id = STDIN.gets.to_i)].nil?
      @schema_paths[id]
    end

    private
    ##
    # Will search for /schema[^\/]*.rb$/ in the current directory
    def search_rb
      @search_path = @path.to_s unless @path.nil?
      check_directory
      @schema_paths = Array.new
      Find.find(@search_path) do |s_p|
        @schema_paths<<s_p if s_p[/schema[^\/]*.rb$/]
      end
    end

  end
  
end
