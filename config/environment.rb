# Load the rails application
require File.expand_path('../application', __FILE__)
require "aws/s3"
require 'will_paginate/array'
ENV['RAILS_ENV'] = 'development'
# Initialize the rails application
Communitymarket::Application.initialize!
