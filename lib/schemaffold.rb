require 'active_support/inflector'

module Schemaffold
  extend self

  class NotFollowingConventionsError < StandardError ; end

  class Schema

    ERROR_MSG = "Warning: You should change the table names according to rails conventions."

    attr_reader :data, :tables

    def initialize(data)
      @data, @tables = data, Schema.parse(data)
    end

    def table_names
      tables.map(&:name)
    end

    def check_rails_naming_conventions
      raise NotFollowingConventionsError, ERROR_MSG if table_names.any? {|n| n == n.singularize or n == n.camelcase }
    end

    def table(id)
      case id
      when Symbol then table(id.to_s)
      when String then tables[table_names.index(id)]
      when Fixnum then tables[id]
      else nil
      end
    end

    def to_script
      tables.map(&:to_script)
    end

    def self.parse(data)
      data.split(/create_/)[1..-1].map {|table_data| Table.parse table_data }
    end
  end

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

  class Attribute
    attr_reader :name, :type

    def initialize(type, name)
      @name, @type = name, type
    end

    def to_script
      "#{name}:#{type}"
    end

    def self.parse(attribute)
      Attribute.new(*attribute.match(/t\.(\w+)\s+"(\w+)"/).captures)
    end
  end

  def self.generate_script(schema, table=nil)
    schema = Schema.new(schema) unless schema.is_a? Schema
    return schema.to_script if table.nil?
    schema.table(table).to_script
  end
end
