require 'active_support'
require 'sinatra'
# require 'puma'
# require 'zip'
# require 'mimemagic'
require 'pry' if ENV['RAILS_ENV'] != 'production'

WEBSITES_DATA_DIR = '/home/app/data/websites'

`mkdir -p #{WEBSITES_DATA_DIR}`

post '/api/v1/receive' do
  file_parameter_value = params.values.first
  `cp -f #{file_parameter_value["tempfile"].path} #{WEBSITES_DATA_DIR}/#{file_parameter_value['filename']}`
  if ENV['RAILS_ENV'] == 'production'
    `passenger-config restart-app /home/app/weblab-public --ignore-app-not-running`
  end
end

# curl -F 'file=@./data/websites/kubergui-master.zip' http://localhost:8081/api/v1/receive
