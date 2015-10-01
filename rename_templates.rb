#!/usr/bin/env ruby
require 'find'
template_path = 'lib/retrospec/plugins/v1/plugin/templates/module_files'
require 'fileutils'
files = Find.find(template_path).reject {|f| f =~ /\.erb/ }

 files.each do |file_path|

	  next unless File.file?(file_path)
  	  # Change content on all files
      original_text = File.read(file_path)
      text = original_text.gsub('foreman_plugin_template', '<%= plugin_name %>')
      text = text.gsub('ForemanPluginTemplate', '<%= plugin_name_camel %>')
      if original_text != text
      	dir_name = File.dirname(file_path)
      	base_name = File.basename(file_path)
      	new_name = File.join(dir_name, "#{base_name}.retrospec.erb")
      	puts new_name
      	File.open(file_path, 'w') {|f| f.write(text)}
      	FileUtils.mv(file_path, new_name)
      end

 end