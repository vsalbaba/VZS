source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'rails-i18n', '~> 0.6.3'
gem 'json', '~> 1.6.6'
gem 'jquery-rails', '~> 2.0.2'
gem 'jquery-ui-rails', '~> 2.0.0'
gem 'authlogic', '~> 3.1.0'
gem 'cancan', '~> 1.6.7'
gem 'formtastic', '~> 2.2.1'
gem 'formtastic-bootstrap', '~> 2.0.0'

gem 'twitter-bootstrap-rails'
gem 'less-rails'
gem 'will_paginate', '~> 3.0.3'
#gem 'validation_reflection'
gem 'paperclip', '~> 2.0'

gem 'acts_as_list'
gem 'audited-activerecord', '~> 3.0'

gem "phony" # formatuje cisla na telefoni cisla

gem 'auto_html'

gem 'newrelic_rpm'

gem 'shareable'

group :development do
  gem 'wirble'
  gem 'quiet_assets'
  gem 'nifty-generators', '~> 0.4.6'
  gem 'sqlite3', '~> 1.3.6'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :production do
  gem 'mysql2'
  gem 'passenger'
end

group :development, :test do
  gem "rspec-rails", "~> 2.8"
  gem "mocha", :group => :test
  gem "syntax"
  gem "ruby-debug", :platforms => :mri_18
  gem "guard"
  gem "guard-rspec"
  gem "factory_girl_rails", "~> 1.2"
  gem "timecop"
  gem "shoulda"
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer'
  gem 'uglifier', '>= 1.0.3'
end

# Deploy with Capistrano
group :deploy do
 gem 'capistrano'
 gem 'capistrano-ext'
 gem 'capistrano_colors'
 gem 'rvm-capistrano'
end

