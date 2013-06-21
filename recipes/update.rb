#
# Cookbook Name:: gitlab
# Recipe:: update
#

gitlab = node['gitlab']

service "gitlab" do
  action :stop
end

file File.join(gitlab['home'], ".gitlab_start") do
  action :delete
end

file File.join(gitlab['home'], ".gemrc") do
  action :delete
end

file File.join(gitlab['home'], ".gitlab_migrate") do
  action :delete
end
