name             'serf'
provides         'serf'
maintainer       'Tyler Fitch'
maintainer_email 'github@tfitch.com'
license          'MIT'
description      'Installs/Configures serf'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe "serf", "Installs Serf based on the default installation method"

%w{ debian ubuntu centos redhat }.each do |os|
  supports os
end