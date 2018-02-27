require 'puppet-lint/tasks/puppet-lint'
require 'metadata-json-lint/rake_task'

Rake::Task[:lint].clear
task :lint => [:puppet_lint, :metadata_lint]

PuppetLint::RakeTask.new :puppet_lint do |config|
  config.pattern = 'manifests/**/*.pp'
  config.with_context = true
  config.fix = true
  config.show_ignored = true
  config.relative = true
end
