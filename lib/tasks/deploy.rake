require 'cucumber/rake/task'

namespace :deploy do
  Cucumber::Rake::Task.new(:check, 'Post-deploy checks') do |t|
    t.cucumber_opts = "smokes --format html --out reports/deploy.html"
    t.fork = true # You may get faster startup if you set this to false
  end
end
