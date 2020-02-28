#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Eshelf::Application.load_tasks

if Rails.env.test?
  # Add the coveralls task as the default with the appropriate prereqs
  require 'coveralls/rake/task'
  Coveralls::RakeTask.new
  # task test_concat: [:teaspoon, :test, :spec, 'coveralls:push']
  task :test_concat do
    # Rake::Task["teaspoon"].invoke
    Rake::Task["spec"].invoke
    # Rake::Task["test"].invoke
    Rake::Task["coveralls:push"].invoke
  end
end
