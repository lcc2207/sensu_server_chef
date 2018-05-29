node.defautl['sensu']['rabbitmq']['host'] = 'localhost'
include_recipe 'sensu::default'
include_recipe 'sensu::rabbitmq'
include_recipe 'sensu::redis'
include_recipe 'sensu::server_service'
include_recipe 'sensu::api_service'

%w(sensu-cli sensu-plugins-mailer).each do |plugin|
  sensu_gem plugin do
    options '--no-document'
  end
end

cookbook_file '/etc/sensu/conf.d/handlers_default.json' do
  source 'handlers_default.json'
  owner 'sensu'
  group 'sensu'
  action :create
end

template '/etc/sensu/conf.d/mailer.json' do
  source 'mailer.erb'
  owner 'sensu'
  group 'sensu'
  variables(
    mail_from: node['sensu_server_chef']['mail_from'],
    mail_to: node['sensu_server_chef']['mail_to'],
    smtp_address: node['smtp_address'],
    smtp_port: node['sensu_server_chef']['smtp_port'],
    smtp_domain: node['sensu_server_chef']['smtp_domain']
  )
  notifies :restart, 'sensu_service[sensu-server]', :immediately
  notifies :restart, 'sensu_service[sensu-api]', :immediately
end

sensu_service 'sensu-server' do
  action :nothing
end

sensu_service 'sensu-api' do
  action :nothing
end
