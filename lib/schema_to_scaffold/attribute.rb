module SchemaToScaffold
  class Attribute

    attr_reader :name, :type

    def initialize(name, type)
      @name, @type = name, type
    end

    def to_script
      "#{name}:#{type}" unless ["created_at","updated_at"].include?(name)
    end

    def self.parse(attribute)
      match = attribute.match(/t\.(\w+)\s+"(\w+)"/)
      if match
        name = match.captures[1].sub(/_id$/, "")
        type = $&.nil? ? match.captures[0] : "references"
        Attribute.new(name, type)
      end
    end

  end
end
