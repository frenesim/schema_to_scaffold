module SchemaToScaffold
  class Schema

    attr_reader :data, :tables

    ERROR_MSG = "Warning: You should change the table names according to rails conventions."

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
end
