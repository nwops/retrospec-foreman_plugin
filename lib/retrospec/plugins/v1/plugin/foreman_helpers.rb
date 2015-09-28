require 'find'
require 'fileutils'
module Retrospec
  module Foreman
    module Helpers
      def rename_files(module_path, snake_plugin_name)
        Find.find(module_path) do |path|
          # Change all the paths to the new snake_case name
          if path =~ /foreman_plugin_template/i
            new_file = path.gsub('foreman_plugin_template', snake_plugin_name)
            # Recursively copy the directory and store the original for deletion
            # Check for $ because we don't need to copy template/hosts for example
            if File.directory?(path) && path =~ /foreman_plugin_template$/i
              FileUtils.mv(path, new_file)
            else
              # gsub replaces all instances, so it will work on the new directories
              FileUtils.mv(path, new_file)
            end
          end
        end

      end

      def replace_template_name(module_path, snake)
        camel = snake.camel_case
        Find.find(module_path) do |file_path|
          next unless File.file?(file_path)
          next if file_path =~ /\.git/
          # Change content on all files
          text = File.read(file_path)
          File.write(file_path, text.gsub('foreman_plugin_template', snake))
          File.write(file_path, text.gsub('ForemanPluginTemplate', camel))
        end
      end

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
