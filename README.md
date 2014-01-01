# ServiceConfig
![Gem version](https://badge.fury.io/rb/service_config.png)
Use this gem to expose environment variables to your code, with clear
defaults and error handling for when the environment variables are
unset.

## Installation

Add this line to your application's Gemfile:

    gem 'service_config'

And then execute:

    $ bundle

## Usage

    ENV['INTERNAL_SERVER'] = 'http://localhost:3000/'

    provider = ServiceConfig::Provider.new(:raise_if_nil => false, :use_env => true) do |config|
      config.provides :internal_server
      config.provides :soundcloud_server, 'http://api.soundcloud.com/'
    end

    provider.internal_server # => 'http://localhost:3000/'
    provider.soundcloud_server # => 'http://api.soundcloud.com/'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
