require 'spec_helper'
require 'retrospec'

describe "foreman_plugin" do
  let(:plugin) do
    Retrospec::Plugins::V1::ForemanPlugin.new('/tmp/testplugin_dir', {:name => 'testplugin', :config1 => 'test'})
  end

  it "can create plugin instance" do
    expect(plugin).to be_a Retrospec::Plugins::V1::ForemanPlugin
  end

  it 'can get config data' do
    expect(plugin.config_data[:config1]).to eq('test')
  end

  it 'can module_path from context' do
    expect(plugin.context.module_path).to eq('/tmp/testplugin_dir')
  end

  it 'can get module name' do
    expect(plugin.context.module_name).to eq('testplugin')
  end

  it 'can run without error' do
    expect{plugin.run}.to_not raise_error
  end
end
