include_recipe 'apt::default' if ubuntu?

if amazon_linux?
  # fix issue with sensu gem installs on AWS linux
  link '/bin/install' do
    to '/usr/bin/install'
  end

  node.default['sensu']['yum_repo_releasever'] = 6
  node.default['sensu']['version_suffix'] = '.el6'
end

# Install extra packages
node['sensu_server_chef']['packages'].each do |pkg|
  package pkg do
    action :install
  end
end

# install monitoring
include_recipe 'sensu::default'

# Install sensu client plugins
node['sensu_server_chef']['plugins'].each do |plugin, version|
  sensu_gem plugin do
    version version
  end
end

# Set up the client configuration
sensu_client node.name do
  address node['ipaddress']
  subscriptions node['sensu_server_chef']['subscriptions'].uniq
  additional(contacts: node['sensu_server_chef']['contact'])
end

# setup sudo for sensu
template '/etc/sudoers.d/sensu' do
  source 'sudoers.erb'
  mode '0440'
  owner 'root'
  group 'root'
  variables(
    user: node['sensu_server_chef']['sensu-user'],
    commands: node['sensu_server_chef']['sensu-client']['sudocommand']
  )
end

# create folder for standalone checks
directory '/etc/sensu/conf.d/checks' do
  action :create
  owner node['sensu_server_chef']['sensu-user']
  group node['sensu_server_chef']['sensu-user']
end

# setup standalone BASE checks
node['sensu_server_chef']['sensu_base_checks'].each do |checkname|
  sensu_check checkname[0] do
    command "#{checkname[0]}.rb #{checkname[1]}"
    handlers node['sensu_server_chef']['handlers']
    interval node['sensu_server_chef']['checktime']
    standalone true
    notifies :restart, 'sensu_service[sensu-client]', :delayed
  end
end

# setup Docker checks
node['sensu_server_chef']['docker']['sensu_checks'].each do |checkname|
  sensu_check checkname[0] do
    command "#{checkname[0]}.rb #{checkname[1]}"
    handlers node['sensu_server_chef']['handlers']
    interval node['sensu_server_chef']['checktime']
    standalone true
    notifies :restart, 'sensu_service[sensu-client]', :delayed
    only_if node['sensu_server_chef']['docker']['monitoring']
  end
end

# run client servcies
include_recipe 'sensu::client_service'
