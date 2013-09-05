name             'gitlab'
maintainer       'ogom'
maintainer_email 'ogom@outlook.com'
license          'MIT'
description      'Installs/Configures GitLab'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.6.1'

recipe "gitlab::initial", "Setting the initial"
recipe "gitlab::install", "Installation"

%w{redisio ruby_build postgresql mysql database postfix yum phantomjs}.each do |dep|
  depends dep
end

%w{debian ubuntu centos}.each do |os|
  supports os
end
