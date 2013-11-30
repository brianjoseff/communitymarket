source 'https://rubygems.org'

gem 'rails', '>= 3.2'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'omniauth-facebook'

group :development do
  #gem 'mysql2'
  gem 'sqlite3'
  #gem 'pg'
end
#group :production do
#  gem 'pg'
#end
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'jquery-fileupload-rails'
  gem 'sass-rails', '~> 3.2.6'
  gem 'coffee-rails'
  #gem 'chosen-rails'
  gem 'jquery-rails'
  gem 'jquery-ui-rails'
  gem 'jquery-modal-rails'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end

#ENV variable management
gem 'figaro'

#form gems- validations etc.
gem 'simple_form'
gem 'client_side_validations'
gem 'client_side_validations-simple_form'

gem 'will_paginate'
gem 'kaminari'
gem 'rails_tokeninput'

gem 'stripe'

#gems that help with seed files
gem 'forgery'
gem 'faker'

gem 'bootstrap-sass'
# gem 'jquery-rails'
# gem 'jquery-ui-rails'

#search gem
gem 'ransack'

#auth gem
gem 'clearance'

#image uploading
gem 'paperclip'
gem 'aws-sdk'

# gem 'fog'
# gem 'carrierwave'
# gem 'rmagick'
# gem 'carrierwave_direct'
# gem 'sidekiq'

#heroku db compatibility
gem 'pg'

#transactional email
gem 'mandrill-api'

#GEOCODER GEM...gets location of IP address and stores in cookie, also manages our location based Group searching and interaction
gem 'geocoder'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

gem "localtunnel"
group :development, :test do
  gem "rspec-rails"
  gem "guard-rspec"
  gem "factory_girl_rails"
end

gem "haml", ">= 3.0.0"
gem "haml-rails"

gem 'jquery-ui-rails'