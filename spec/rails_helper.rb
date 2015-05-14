# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'

require 'combustion'
Combustion.initialize! :active_record, :active_job  do
  config.active_job.queue_adapter = :test
end

require 'rspec/rails'
require 'active_job'
require 'job_camera'


RSpec.configure do |config|

end
