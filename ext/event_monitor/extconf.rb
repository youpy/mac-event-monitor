if RUBY_VERSION < '1.9.0'
  $LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')
end

require "mkmf"

# Name your extension
extension_name = 'event_monitor'

# Set your target name
dir_config(extension_name)

$LDFLAGS += ' -framework AppKit'

begin
  MACRUBY_VERSION # Only MacRuby has this constant.
  $CFLAGS += ' -fobjc-gc' # Enable MacOSX's GC for MacRuby
rescue
end

# Do the work
create_makefile(extension_name)
