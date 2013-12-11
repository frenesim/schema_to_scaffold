module SchemaToScaffold
  class Attribute

    attr_reader :name, :type

    def initialize(type, name)
      @name, @type = name, type
    end

    def to_script
      "#{name}:#{type}" unless ["created_at","updated_at"].include? name
    end

    def self.parse(attribute)
      match = attribute.match(/t\.(\w+)\s+"(\w+)"/)
      if match
        Attribute.new(*match.captures)
      end
    end


  end
end
