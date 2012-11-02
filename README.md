[![Build Status](https://secure.travis-ci.org/wenzowski/secret_data.png)](http://travis-ci.org/wenzowski/secret_data)

SecretData
==========

A helper class for silencing secret data.


Installation
------------

Add this line to your application's Gemfile:

    gem 'secret_data'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install secret_data


Usage
-----

Example usage with VCR gem to silence api credentials.

    require 'secret_data'
    require 'vcr'

    secret_data = SecretData.new(:yml_path => 'your_config.yml')

    VCR.configure do |c|
      secret_data.silence do |find, replace|
        c.filter_sensitive_data(replace) { find }
      end
    end

Configuration via block is also allowed.

    secret_data.new.configure { |config|
      config.message = '~*~GOODBYE_{{var}}~*~'  # optional
      config.add_from_env('API_SECRET')         # reads ENV['API_SECRET']
    }.silence { |secret, message|
      puts "Have some ultra-confidential data: #{secret}!"
      puts "...whoops, I should have shown you #{message}."
    }


Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
