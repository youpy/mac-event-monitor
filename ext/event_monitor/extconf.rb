if RUBY_VERSION < '1.9.0'
  $LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')
end

require "mkmf"

# Name your extension
extension_name = 'event_monitor'

# Set your target name
dir_config(extension_name)

$LDFLAGS += ' -framework AppKit'

# Do the work
create_makefile(extension_name)
