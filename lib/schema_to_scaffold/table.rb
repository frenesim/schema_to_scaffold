module SchemaToScaffold
  require 'active_support/inflector'
  ##
  # fetch table names and convert them to a scaffold syntax

  class Table

    attr_reader :attributes, :name

    def initialize(name, attributes)
      @name, @attributes = name, attributes
    end

    def to_script(target, migration_flag)
      begin
        attributes_list = attributes.map(&:to_script).reject { |x| x.nil? || x.empty? }.join(' ')
      rescue => e
        puts "\n ---------------------------------------------"
        puts e.message
        puts "Table \n\n\n #{self.inspect} \n\n\n"
        puts "\n ---------------------------------------------"
      end
      script = []
      script << "rails generate #{target} #{modelize(name)} #{attributes_list}"
      script << " --no-migration" unless migration_flag
      script << "\n\n"
      script
    end

    def self.parse(table_data)
      return unless name = table_data[/table "([^"]+?)"/]
      name = $1
      atts = table_data.lines.to_a.select { |line| line =~ /t\.\w+/ }.map { |att| Attribute.parse(att) }
      Table.new(name, atts)
    end

    private

    def modelize(string)
      string.camelize.singularize
    end

  end
end
