source 'https://rubygems.org'

# Specify your gem's dependencies in secret_data.gemspec
gemspec

group :test, :development do
  gem 'rspec'
  gem 'simplecov'
  gem 'fakefs'
end

group :development do
  gem 'redcarpet'

  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-yard'

  # Watch file change events instead of polling
  gem 'rb-fsevent', :require => false, :group => :darwin              # OSX
  gem 'rb-inotify', :require => false, :group => :linux               # Linux
  gem 'wdm',        :require => false, :platforms => [:mswin, :mingw] # Windows
end
