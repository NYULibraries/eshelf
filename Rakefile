#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Eshelf::Application.load_tasks

if Rails.env.test?
  # Add the coveralls task as the default with the appropriate prereqs
  require 'coveralls/rake/task'
  Coveralls::RakeTask.new
  task default: [:test, :spec, :teaspoon, 'coveralls:push']
end
