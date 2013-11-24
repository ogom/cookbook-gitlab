#
# Cookbook Name:: gitlab
# Recipe:: logrotate
#

gitlab = node['gitlab']

# Merge environmental variables
gitlab = Chef::Mixin::DeepMerge.merge(gitlab,gitlab[gitlab['env']])

logrotate = gitlab['logrotate']

# Install logrotate
logrotate['packages'].each do |pkg|
  package pkg
end

# Configure it
## Copy the example config
template File.join(logrotate['path'], 'gitlab') do
  source "logrotate.erb"
  user logrotate['user']
  group logrotate['group']
  variables({
    :gitlab_path => gitlab['path'],
    :gitlab_shell_path => gitlab['shell_path']
  })
end