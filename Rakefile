#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Eshelf::Application.load_tasks

if Rails.env.test?
  # RSpec deletes the test task as a default
  # We need to add it back here
  task default: :test
end
