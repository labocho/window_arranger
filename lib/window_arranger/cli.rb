require "thor"
require "thor/zsh_completion"

require "yaml"
require "json"

module WindowArranger
  class CLI < Thor
    include ZshCompletion::Command

    desc "list", "List windows"
    def list
      windows = WindowArranger::Script.list_windows
      puts windows.to_yaml
    end

    desc "Update", "Update size and position of windows"
    def update
      definitions = YAML.safe_load($stdin.read)
      WindowArranger::Script.update_bounds(definitions).each do |log|
        next unless log["type"] == "update"

        puts "Updated: #{log["definition"]}"
      end
      puts "Done."
    end
  end
end
