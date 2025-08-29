require 'sidekiq'
require 'sidekiq-cron'

Sidekiq.configure_server do |config|
  schedule_file = "config/sidekiq.yml"

  if File.exist?(schedule_file)
    yaml = YAML.load_file(schedule_file)
    schedule = yaml['cron'] || {}
    Sidekiq::Cron::Job.load_from_hash(schedule)
  end
end

Sidekiq.configure_client do |config|
  # Client configuration if needed
end
