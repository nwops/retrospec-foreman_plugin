require 'find'
require 'fileutils'
module Retrospec
  module Foreman
    module Helpers

      def cleanup(module_path, snake_plugin_name)
        puts 'All done!'
        puts "Add this to Foreman's bundler configuration:"
        puts ''
        puts "  gem '#{snake_plugin_name}', :path => '#{module_path}'"
        puts ''
        puts 'Happy hacking!'
      end
    end
  end
end

class String
  def camel_case
    return self if self !~ /_/ && self =~ /[A-Z]+.*/
    split('_').map(&:capitalize).join
  end
end
