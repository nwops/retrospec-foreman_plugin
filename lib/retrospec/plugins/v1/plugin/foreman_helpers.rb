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
              safe_move_file(path, new_file)
            else
              # gsub replaces all instances, so it will work on the new directories
              safe_move_file(path, new_file)
            end
          end
        end
      end

      def safe_move_file(src,dest)
        if File.exists?(dest)
          $stderr.puts "!! #{dest} already exists and differs from template".warning
        else
          FileUtils.mv(src,dest)
          puts " + #{dest}".info
        end
      end

      def destructive_create_file(dest,content)
        File.open(dest, 'w') {|f| f.write(content)}
        puts "+ #{dest} was forcefully created".info
      end

      def replace_template_name(module_path, snake)
        camel = snake.camel_case
        Find.find(module_path) do |file_path|
          next unless File.file?(file_path)
          next if file_path =~ /\.git/
          # Change content on all files
          text = File.read(file_path)
          text = text.gsub('foreman_plugin_template', snake)
          text = text.gsub('ForemanPluginTemplate', camel)
          destructive_create_file(file_path, text)
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
