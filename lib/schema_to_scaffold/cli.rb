require "schema_to_scaffold"
module SchemaToScaffold
  class CLI

    def self.start(*args)
      ## Argument conditions
      opts = SchemaToScaffold.parse_arguments(args)

      if opts[:help]
        puts SchemaToScaffold.help_msg
        exit 0
      end

      ## looking for /schema\S*.rb$/ in user directory
      paths = SchemaToScaffold::Path.new(opts[:path])
      path = paths.choose unless opts[:path].to_s.match(/\.rb$/)

      ## Opening file
      path ||= opts[:path]
      begin
        data = File.open(path, 'r') {|f| f.read }
      rescue
        puts "\nUnable to open file '#{path}'"
        exit 1
      end

      ## Generate scripts from schema
      schema = SchemaToScaffold::Schema.new(data)

      begin
        raise if schema.table_names.empty?
        puts "\nLoaded tables:"
        schema.table_names.each_with_index { |name, i|  puts "#{i}. #{name}" }

        puts "\nOptions are:\n4 for table 4; (4..6) for table 4 to 6; [4,6] for tables 4 and 6; * for all Tables"

        print "\nSelect a table: "

      rescue
        puts "Could not find tables in '#{path}'"
        exit 1
      end

      result = STDIN.gets.strip
      begin
        case result
        when "*"
          tables = (0..schema.table_names.count-1).map{|i|i}
        when /^\d/
          tables = [result.to_i]
        else
          tables = eval(result).to_a.map{|i|i}
        end

        raise if tables.empty?
      rescue
        puts "Not a valid input, \nOptions are:\n4 for table 4; (4..6) for table 4 to 6; [4,6] for tables 4 and 6; * for all Tables"
        exit 1
      end

      script = []
      target = opts[:factory_girl] ? "factory_girl:model" : "scaffold"
      migration_flag = opts[:migration] || opts[:factory_girl]
      tables.each { |table_id| script << SchemaToScaffold.generate_script(schema, table_id, target, migration_flag) }
      output = script.join("")
      puts "\nScript for #{target}:\n\n"
      puts output

      if opts[:clipboard]
        puts("\n(copied to your clipboard)")
        case RUBY_PLATFORM
          when /darwin/i then exec("echo '#{output}' | tr -d '\n' | pbcopy")
          when /linux/i  then exec("echo '#{output}' | tr -d '\n' | xclip -selection c")
          when /mingw/i  then exec("echo '#{output}' | clip")
          when /win/i    then exec("echo '#{output}' | clip")
        end
      end

    end
  end
end
