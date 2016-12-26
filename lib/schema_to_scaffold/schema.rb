module SchemaToScaffold
  class Schema

    attr_reader :data, :tables

    def initialize(data)
      @data, @tables = data, Schema.parse(data)
    end

    def table_names
      tables.map(&:name)
    end

    def print_table_names
      table_names.each_with_index { |name, i|  puts "#{i}. #{name}" }
    end

    def select_tables(input)
      case input
      when "*"
        table_range.to_a
      when /^\d/
        table_range.include?(input.to_i) ? [input.to_i] : []
      end
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
      data.split(/^\s*create_/)[1..-1].map {|table_data| Table.parse(table_data) }.reject{ |e| e.nil? }
    end

    private

    def table_range
      0...table_names.count
    end
  end
end
