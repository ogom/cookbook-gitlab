#
# Cookbook Name:: gitlab
# Recipe:: install
#

gitlab = node['gitlab']

# Merge environmental variables
gitlab = gitlab.merge(gitlab[gitlab['env']])

include_recipe "gitlab::gitlab_shell"
include_recipe "gitlab::database_#{gitlab['database_adapter']}"
include_recipe "gitlab::gitlab"

case gitlab['env']
when 'production'
  include_recipe "gitlab::nginx"
end
