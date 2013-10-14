require 'jslint/tasks'
JSLint.config_path = ".jslint.yml"

require 'coveralls/rake/task'
Coveralls::RakeTask.new

require File.expand_path('../config/application', __FILE__)

CareHomeSearch::Application.load_tasks

task default: ["test:all"]
