module SchemaToScaffold
  class Table

    attr_reader :attributes, :name

    def initialize(name, attributes)
      @name, @attributes = name, attributes
    end

    def to_script
      "rails g scaffold #{name} #{attributes.map(&:to_script).join(' ')}"
    end

    def self.parse(table_data)
      name = table_data.match(/table "(.+)"/).captures.first; 
      atts = table_data.lines.to_a.select {|line| line =~ /t\.\w+/ }.map {|att| Attribute.parse att }
      Table.new(name, atts)
    end
  end
end
