#
# Cookbook Name:: gitlab
# Recipe:: install
#

gitlab = node['gitlab']

include_recipe "gitlab::gitlab_shell"
include_recipe "gitlab::database_#{gitlab['database_adapter']}"
include_recipe "gitlab::gitlab"
include_recipe "gitlab::nginx"
