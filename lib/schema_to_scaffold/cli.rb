require "schema_to_scaffold"
module SchemaToScaffold
  class CLI

    TABLE_OPTIONS = "\nOptions are:\n4 for table 4; (4..6) for table 4 to 6; [4,6] for tables 4 and 6; * for all Tables"

    def self.start(*args)
      ## Argument conditions
      opts = parse_arguments(args)

      if opts[:help]
        puts Help.message
        exit 0
      end

      ## looking for /schema\S*.rb$/ in user directory
      paths = Path.new(opts[:path])
      path = paths.choose unless opts[:path].to_s.match(/\.rb$/)

      ## Opening file
      path ||= opts[:path]
      begin
        data = File.open(path, 'r') { |f| f.read }
      rescue
        puts "\nUnable to open file '#{path}'"
        exit 1
      rescue Interrupt => e
        exit 1
      end

      ## Generate scripts from schema
      schema = Schema.new(data)

      begin
        raise if schema.table_names.empty?
        puts "\nLoaded tables:"
        schema.print_table_names
        puts TABLE_OPTIONS
        print "\nSelect a table: "
      rescue
        puts "Could not find tables in '#{path}'"
        exit 1
      end

      input = STDIN.gets.strip
      begin
        tables = schema.select_tables(input)
        raise if tables.empty?
      rescue
        puts "Not a valid input. #{TABLE_OPTIONS}"
        exit 1
      rescue Interrupt => e
        exit 1
      end

      script = []
      target = opts[:factory_girl] ? "factory_girl:model" : "scaffold"
      migration_flag = opts[:migration] ? true : false

      tables.each do |table_id|
        script << generate_script(schema, table_id, target, migration_flag)
      end
      output = script.join("")
      puts "\nScript for #{target}:\n\n"
      puts output

      if opts[:clipboard]
        puts("\n(copied to your clipboard)")
        Clipboard.new(output).command
      end
    end

    ##
    # Parses ARGV and returns a hash of options.
    def self.parse_arguments(argv)
      if argv_index = argv.index("-p")
        path = argv.delete_at(argv_index + 1)
        argv.delete('-p')
      end

      args = {
        clipboard: argv.delete('-c'),    # check for clipboard flag
        factory_girl: argv.delete('-f'), # factory_girl instead of scaffold
        migration: argv.delete('-m'),   # generate migrations
        help: argv.delete('-h'),        # check for help flag
        path: path                      # get path to file(s)
      }

      if argv.empty?
        args
      else
        puts "\n------\nWrong set of arguments.\n------\n" 
        puts Help.message
        exit
      end
    end

    ##
    # Generates the rails scaffold script
    def self.generate_script(schema, table=nil, target, migration_flag)
      schema = Schema.new(schema) unless schema.is_a?(Schema)
      return schema.to_script if table.nil?
      schema.table(table).to_script(target, migration_flag)
    end

  end
end
