require 'service_config/provider'

describe ServiceConfig::Provider do
  it 'provides the services as configured' do
    ENV['FOO'] = 'yo'
    service_config = build_service_config(:use_env => true) do |c|
      c.provides :foo
    end

    service_config.should respond_to(:foo)
    service_config.method(:foo).should_not be_nil
    service_config.foo.should == 'yo'
  end

  it 'raises if an environment variable is not set, if configured globally' do
    expect {
      build_service_config(:raise_if_nil => true) { |c| c.provides :unset }
    }.to raise_error('must set UNSET')

    expect {
      build_service_config(:raise_if_nil => false) { |c| c.provides :unset }
    }.not_to raise_error
  end

  it 'raises if an environment variable is not set, if configured on specific variable' do
    expect {
      build_service_config(:raise_if_nil => false) { |c| c.provides :unset, nil, :raise_if_nil => true }
    }.to raise_error('must set UNSET')

    expect {
      build_service_config(:raise_if_nil => true) { |c| c.provides :unset, nil, :raise_if_nil => false }
    }.to_not raise_error
  end

  it 'defines the value as "" if the environment variable is unset' do
    service_config = build_service_config(:raise_if_nil => false, :use_env => true) { |c| c.provides :unknown }
    service_config.unknown.should == ''
  end

  it 'provides the optional value if given and environment variable is unset' do
    service_config = build_service_config(:raise_if_nil => false, :use_env => true) { |c| c.provides :not_set, 'optional value' }
    service_config.not_set.should == 'optional value'
  end

  it 'does not look at the environment variable in the test environment' do
    ENV['NOT_SET'] = 'value'
    service_config = build_service_config(:use_env => false) { |c| c.provides :not_set }
    service_config.not_set.should == ''
  end

  def build_service_config(opts = {}, &block)
    default_opts = { :raise_if_nil => true, :use_env => true }
    ServiceConfig::Provider.new(default_opts.merge(opts)) do |config|
      block.call(config)
    end
  end
end
