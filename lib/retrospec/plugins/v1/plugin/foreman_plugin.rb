require 'retrospec/plugins/v1'
require_relative 'spec_object'
require_relative 'foreman_helpers'

module Retrospec
  module Plugins
    module V1
      class ForemanPlugin < Retrospec::Plugins::V1::Plugin

        attr_reader :template_dir, :context
        include Retrospec::Foreman::Helpers

        # retrospec will initilalize this class so its up to you
        # to set any additional variables you need to get the job done.
        def initialize(supplied_module_path=nil,config={})
          super
          # below is the Spec Object which serves as a context for template rendering
          # you will need to initialize this object, so the erb templates can get the binding
          # the SpecObject can be customized to your liking as its different for every plugin gem.
          @context = ::Foreman::SpecObject.new(module_path, config)
          validate_name(context.plugin_name)
        end

        def validate_name(name)
          unless name =~ /^foreman_/
            puts "The name of the plugin must start with foreman_  yours starts with #{name}"
            exit -1
          end
          if name == name.camel_case
            puts "Could not camelize '#{name}' - exiting"
            exit 1
          end
        end

        # used to display subcommand options to the cli
        # the global options are passed in for your usage
        # http://trollop.rubyforge.org
        # all options here are available in the config passed into config object
        def self.cli_options(global_opts)
          Trollop::options do
            opt :name, "The name of the new plugin", :require => false, :short => '-n', :type => :string, :default => File.basename(File.expand_path(global_opts[:module_path]))
          end
        end

        # this is the main entry point that retrospec will use to make magic happen
        # this is called after everything has been initialized
        def run
          # the safe_create_module_files will render every file under the templates/module_files
          # folder in your gem and copy them to the destination.
          safe_create_module_files(template_dir, module_path, context)
          # Should you need to change the file name of the copied file you will have to move
          # the file outside of the module_files directory and
          # render it using: safe_create_template_file(file_path, template, context)
          replace_template_name(module_path, context.plugin_name)
          rename_files(module_path, context.plugin_name)
          cleanup(module_path, context.plugin_name)

        end

        # the template directory located inside the your retrospec plugin gem
        # you should not have to modify this unless you move the templates directory
        def template_dir
          @template_dir ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
        end
      end
    end
  end
end
