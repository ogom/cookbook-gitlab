#
# Cookbook Name:: gitlab
# Recipe:: nginx
#

gitlab = node['gitlab']

# Merge environmental variables
gitlab = Chef::Mixin::DeepMerge.merge(gitlab,gitlab[gitlab['env']])

# 7. Nginx
## Installation
package "nginx" do
  action :install
end

## Site Configuration
path = platform_family?("rhel") ? "/etc/nginx/conf.d/gitlab.conf" : "/etc/nginx/sites-available/gitlab"
template path do
  source "nginx.erb"
  mode 0644
  variables({
    :path => gitlab['path'],
    :host => gitlab['host'],
    :port => gitlab['port']
  })
end

if platform_family?("rhel")
  directory gitlab['home'] do
    mode 0755
  end
else
  link "/etc/nginx/sites-enabled/gitlab" do
    to "/etc/nginx/sites-available/gitlab"
  end

  file "/etc/nginx/sites-enabled/default" do
    action :delete
  end
end

## Restart
service "nginx" do
  action :restart
end
