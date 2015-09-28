require 'spec_helper'
require 'retrospec'

describe 'foreman_helpers' do 
  let(:plugin) do
    Retrospec::Plugins::V1::ForemanPlugin.new('/tmp/testplugin_dir', {:name => 'foreman_testplugin', :config1 => 'test'})
  end


  it 'can rename files'	do
  	allow(plugin).to receive(:rename_files).with('/tmp/testplugin_dir', 'foreman_testplugin')
    plugin.run

  end
end