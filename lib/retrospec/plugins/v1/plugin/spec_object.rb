require 'retrospec/plugins/v1/context_object'

module Foreman
  # this object is passed to the templates for erb template rendering
  # you can use data contained in this object in your templates
  class SpecObject < Retrospec::Plugins::V1::ContextObject

    attr_reader :instance, :module_path, :module_name

    def initialize(mod_path, data)
      @instance = data
      @module_path = mod_path
    end

    def module_path
      @module_path
    end

    def plugin_name
      instance[:name]
    end
  end
end
