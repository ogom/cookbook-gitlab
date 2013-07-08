# Git
default['gitlab']['git']['prefix'] = "/usr/local"
default['gitlab']['git']['version'] = "1.7.12.4"
default['gitlab']['git']['url'] = "https://github.com/git/git/archive/v#{node['gitlab']['git']['version']}.zip"

if platform_family?("rhel")
  packages = %w{expat-devel gettext-devel libcurl-devel openssl-devel perl-ExtUtils-MakeMaker zlib-devel}
else
  packages = %w{unzip build-essential libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev}  
end

default['gitlab']['git']['packages'] = packages
