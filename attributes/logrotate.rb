# Logrotate
default['gitlab']['logrotate']['path'] = "/etc/logrotate.d/"

default['gitlab']['logrotate']['user'] = "root"
default['gitlab']['logrotate']['group'] = "root"

default['gitlab']['logrotate']['packages'] = %w{logrotate}