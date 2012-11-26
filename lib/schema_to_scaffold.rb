require 'active_support/inflector'
require 'schema_to_scaffold/version'
require 'schema_to_scaffold/schema'
require 'schema_to_scaffold/table'
require 'schema_to_scaffold/attribute'

module SchemaToScaffold
  extend self

  def self.generate_script(schema, table=nil)
    schema = Schema.new(schema) unless schema.is_a? Schema
    return schema.to_script if table.nil?
    schema.table(table).to_script
  end
end
