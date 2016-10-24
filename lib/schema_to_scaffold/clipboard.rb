module SchemaToScaffold
  class Clipboard
    attr_reader :output

    def initialize(output)
      @output = output
    end

    def command
      case platform
        when /darwin/i then darwin_command
        when /linux/i  then linux_command
        when /mingw/i  then win_command
        when /win/i    then win_command
      end
    end

    private

    def darwin_command
      exec("echo '#{output}' | tr -d '\n' | pbcopy")
    end

    def linux_command
      exec("echo '#{output}' | tr -d '\n' | xclip -selection c")
    end

    def win_command
      exec("echo '#{output}' | clip")
    end

    def platform
      RUBY_PLATFORM
    end
  end
end
