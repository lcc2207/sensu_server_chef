# sensu cookbook attributes
default['sensu']['use_ssl'] = false
default['sensu']['version'] = '1.2.1-2'

# sensu_server_chef cookbook attributes
default['sensu_server_chef']['mail_from'] = 'chef-sensu@scalr.com'
default['sensu_server_chef']['mail_to'] = 'lynn@scar.com'
default['sensu_server_chef']['smtp_address'] = 'test.scar.com'
default['sensu_server_chef']['smtp_port'] = '25'
default['sensu_server_chef']['smtp_domain'] = 'scalr.com'
