require 'jslint/tasks'
JSLint.config_path = ".jslint.yml"

require 'coveralls/rake/task'
Coveralls::RakeTask.new

namespace :test do
  desc 'Run all tests, coverage and code quality reports'
  task :all do
    Rake::Task['spec'].invoke
    Rake::Task['cucumber'].invoke
    Rake::Task['jslint'].invoke
    Rake::Task['rubocop'].invoke
    Rake::Task['brakeman'].invoke
    Rake::Task['coveralls:push'].invoke
  end
end
