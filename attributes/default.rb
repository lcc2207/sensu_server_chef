# Sensu install/config
default['sensu']['use_ssl'] = false
default['sensu']['version'] = '1.2.1-2'
default['sensu']['rabbitmq']['host'] = ''
default['sensu']['use_ssl'] = false
default['sensu']['use_embedded_ruby'] = true

# packages for sensu
default['sensu_server_chef']['packages'] = %w(g++ git make)

# sensu_server_chef cookbook attributes
default['sensu_server_chef']['mail_from'] = 'chef-sensu@scalr.com'
default['sensu_server_chef']['mail_to'] = 'demo@scalr.com'
default['sensu_server_chef']['smtp_address'] = 'test.scalr.com'
default['sensu_server_chef']['smtp_port'] = '25'
default['sensu_server_chef']['smtp_domain'] = 'scalr.com'

# Client attributes

# # docker monitoring
default['sensu_server_chef']['docker']['monitoring'] = 'false'

default['sensu_server_chef']['plugins'] = {
  'sensu-plugin' => '2.5.0',
  'sensu-plugins-cpu-checks' => '2.1.0',
  'sensu-plugins-disk-checks' => '3.0.1',
  'sensu-plugins-load-checks' => '4.0.2',
  'sensu-plugins-memory-checks' => '3.2.0',
  'sensu-plugins-network-checks' => '3.1.1',
  'sensu-plugins-process-checks' => '3.0.2',
  'sensu-plugins-docker' => '3.0.0',
}

# cookbook attributes
default['sensu_server_chef']['sensu_base_reset'] = 60
default['sensu_server_chef']['contact'] = 'support'
default['sensu_server_chef']['checktime'] = 60
default['sensu_server_chef']['subscriptions'] = %w(base)
default['sensu_server_chef']['sensu_base_checks'] = [
  ['check-memory', ' -w 500 -c 100 -p'],
  ['check-disk-usage', ' -w 80 -c 90'],
  ['check-load'],
  ['check-memory-percent', '-w 80 -c 90'],
  ['metrics-disk'],
  ['metrics-disk-usage'],
  ['metrics-cpu'],
  ['metrics-cpu-pcnt-usage'],
  ['metrics-memory'],
  ['metrics-interface'],
  ['metrics-disk-capacity'],
]

# docker sensu checks
default['sensu_server_chef']['docker']['sensu_checks'] = [
  ['check-docker-container', '-h /run/docker.sock -w 1 -c 1'],
  ['metrics-docker-stats', '-p unix -H /var/run/docker.sock'],
]

# Sensu Monitoring
default['sensu_server_chef']['sensu-client']['sudocommand'] = 'ALL'
default['sensu_server_chef']['sensu-user'] = 'sensu'
