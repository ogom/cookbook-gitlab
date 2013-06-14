#
# Cookbook Name:: gitlab
# Recipe:: install
#

include_recipe "gitlab::gitlab_shell"
include_recipe "gitlab::database"
include_recipe "gitlab::gitlab"
include_recipe "gitlab::nginx"
