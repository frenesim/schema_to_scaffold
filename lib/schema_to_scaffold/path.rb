require 'find'
module SchemaToScaffold
  ##
  # Deal with the path argument

  class Path

    def initialize(path)
      @path = path || Dir.pwd
    end

    ##
    # Return the chosen path
    def choose
      validate_path
      search_paths_list = search_paths
      if search_paths_list.empty?
        puts "\nThere is no /schema[^\/]*.rb$/ in the directory #{@path}"
        exit
      end

      search_paths_list.each_with_index {|path,indx|  puts "#{indx}. #{path}" }

      begin
        print "\nSelect a path to the target schema: "
        while search_paths_list[(id = STDIN.gets.to_i)].nil?; end
      rescue Interrupt => e
        puts "Interrupted, #{e}"
        exit 1
      end 


      search_paths_list[id]
    end

    private
    ##
    # Validate if a given path leads to a directory
    def validate_path
      if File.directory?(@path.to_s)
        puts "\nLooking for schema.rb in #{@path}"
      else
        puts "\nSorry #{@path} is not a valid directory!\nHere is an example:\nscaffold -p /home/foo/bar"
        exit
      end
    end

    ##
    # Will search for /schema[^\/]*.rb$/ in the current directory
    def search_paths
      result = []
      Find.find(@path) do |s_p|
        result << s_p if s_p[/schema[^\/]*.rb$/]
      end
      result
    end

  end
end
