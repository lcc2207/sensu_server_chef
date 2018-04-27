name 'sensu_server_chef'
maintainer 'Lynn Caldwell'
maintainer_email 'lynn@scalr.com'
license 'All Rights Reserved'
description 'Installs/Configures sensu_server_chef'
long_description 'Installs/Configures sensu_server_chef'
version '0.1.3'
chef_version '>= 12.1' if respond_to?(:chef_version)

%w(centos redhat ubuntu).each do |os|
  supports os
end

issues_url 'https://github.ge.com/lcc2207/sensu_server_chef'
source_url 'https://github.ge.com/lcc2207/sensu_server_chef'

depends 'sensu', '~> 4.3.1'
