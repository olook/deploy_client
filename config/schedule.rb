require 'yaml'

set :output, '/var/log/cron.log'

crondate_path = File.dirname(__FILE__) + '/crondate.yml'
crondate_yaml = YAML.load_file(crondate_path)
crondate      = crondate_yaml['crondate']

every crondate do
  command "/usr/bin/deploy.rb"
end

