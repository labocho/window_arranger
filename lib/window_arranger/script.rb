require "shellwords"
require "open3"
require "json"

module WindowArranger
  module Script
    class ScriptError < ::WindowArranger::Error; end

    module_function

    def osascript(script, *args)
      out, err, status = Open3.capture3("osascript", "-l", "JavaScript", "-e", script, *args)
      unless status.success?
        raise ScriptError, err
      end

      [out, err, status]
    end

    # 3s くらいかかる
    def list_windows
      script = <<~JS
        function run(argv) {
          var systemEvents = Application('System Events');
          var allWindows = [];

          systemEvents.processes().forEach(function(proc) {
            proc.windows().forEach(function(win) {
                allWindows.push({appName: proc.name(), appShortName: proc.shortName(), windowName: win.name(), position: win.position(), size: win.size()});
            });
          });

          return JSON.stringify(allWindows);
        }
      JS

      out, * = osascript(script)
      JSON.parse(out)
    end

    # 3s くらいかかる
    # definitions: [{appName: String, appShortName: String, windowName: String, position: [x, y], size: [width, height]}]
    def update_bounds(definitions)
      script = <<~JS
        function match(attributes, definition) {
          if (definition.appName && attributes.appName !== definition.appName) return false;
          if (definition.appShortName && attributes.appShortName !== definition.appShortName) return false;
          if (definition.windowName && attributes.windowName !== definition.windowName) return false;
          return true;
        }
        function run(argv) {
          var definitions = JSON.parse(argv[0]);
          var systemEvents = Application('System Events');
          var allWindows = [];

          systemEvents.processes().forEach(function(proc) {
            proc.windows().forEach(function(win) {
              var attrs = {appName: proc.name(), appShortName: proc.shortName(), windowName: win.name()};
              definitions.forEach(function(definition) {
                if (match(attrs, definition)) {
                  if (definition.position) win.position = definition.position;
                  if (definition.size) win.size = definition.size;
                }
              });
            });
          });

          return JSON.stringify(allWindows);
        }
      JS

      out, * = osascript(script, JSON.dump(definitions))
      JSON.parse(out)
    end
  end
end
