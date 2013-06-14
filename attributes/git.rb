# Git
default['gitlab']['git']['prefix'] = "/usr/local"
default['gitlab']['git']['version'] = "1.7.12.4"
default['gitlab']['git']['url'] = "https://github.com/git/git/archive/v#{node['gitlab']['git']['version']}.zip"
default['gitlab']['git']['packages'] = %w{unzip libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev}
