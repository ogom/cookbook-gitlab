#
# Cookbook Name:: gitlab
# Recipe:: install
#

gitlab = node['gitlab']

# Merge environmental variables
gitlab = Chef::Mixin::DeepMerge.merge(gitlab,gitlab[gitlab['env']])

include_recipe "gitlab::gitlab_shell"
include_recipe "gitlab::database_#{gitlab['database_adapter']}"
include_recipe "gitlab::gitlab"
include_recipe "gitlab::nginx" if gitlab['env'] == 'production'
