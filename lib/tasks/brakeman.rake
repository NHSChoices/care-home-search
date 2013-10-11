desc 'Run a Brakeman security audit'
task :brakeman do
  system 'brakeman -o reports/brakeman.html -z -w3'
end
