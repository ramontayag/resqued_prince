APP_ENV = 'test'
require File.join(File.dirname(__FILE__), '..', 'config', 'initializer')
require 'rspec'

# check that dummy is running
dummy_rb = File.join(File.dirname(__FILE__), 'dummy', 'dummy.rb')
start_dummy_command = "ruby #{File.expand_path(dummy_rb)} -p 1234" 
command = %Q{ps -ef | grep "#{start_dummy_command}" | grep -v grep}
dummy_running = !`#{command}`.empty?
unless dummy_running
  fail "Dummy must be running. Run `#{start_dummy_command}`"
end
