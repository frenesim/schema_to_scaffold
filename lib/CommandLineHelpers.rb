require 'active_support/inflector'

module CommandLineHelpers
  extend self

  class NotFollowingConventionsError < StandardError ; end
  
  class HelpMessages
  
    def help
     print "Usage: schemafold [OPTION] PATH
            Generate a rails scaffold script for the given schema.rb file
            PATH is the path to the schema.rb file.

            OPTIONS:
              -x     put the rails scaffold script in your clipboard using xclip, type:
                       sudo apt-get install xclip
                     if you don't have it
            "
    end
    
  end
  
end
