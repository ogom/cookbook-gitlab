#
# Cookbook Name:: gitlab
# Recipe:: nginx
#

gitlab = node['gitlab']

# 7. Nginx
## Installation
package "nginx" do 
  action :install
end

## Site Configuration
template "/etc/nginx/sites-available/gitlab" do
  source "nginx.erb"
    mode 0644
  variables({
    :path => gitlab['path'],
    :host => gitlab['host'],
    :port => gitlab['port']
  })
end

link "/etc/nginx/sites-enabled/gitlab" do
  to "/etc/nginx/sites-available/gitlab"
end

file "/etc/nginx/sites-enabled/default" do
  action :delete
end

## Restart
service "nginx" do
  action :restart
end
