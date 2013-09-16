#
# Cookbook Name:: gitlab
# Recipe:: update
#

gitlab = node['gitlab']

# Merge environmental variables
gitlab = Chef::Mixin::DeepMerge.merge(gitlab,gitlab[gitlab['env']])

# Stop server
service "gitlab" do
  action :stop
end

# Ruby
include_recipe "ruby_build"
ruby_build_ruby gitlab['ruby'] do
  prefix_path "/usr/local/"
  action :reinstall
end

# Get latest code
## gitlab and gitlab-shell
file File.join(gitlab['home'], ".gitlab_start") do
  action :delete
end

## bundle install
file File.join(gitlab['home'], ".gemrc") do
  action :delete
end

## rake db:migrate
file File.join(gitlab['home'], ".gitlab_migrate") do
  action :delete
end
