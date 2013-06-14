#
# Cookbook Name:: gitlab
# Recipe:: gitlab_shell
#

gitlab = node['gitlab']

# 4. GitLab shell
## Clone gitlab shell
git gitlab['shell_path'] do
  repository gitlab['shell_repository']
    revision gitlab['shell_revision']
        user gitlab['user']
       group gitlab['group']
      action :sync
end

## Edit config and replace gitlab_url
template File.join(gitlab['shell_path'], "config.yml") do
    source "gitlab_shell.yml.erb"
      user gitlab['user']
     group gitlab['group']
  notifies :run, "execute[gitlab-shell install]", :immediately
  variables({
          :user => gitlab['user'],
          :home => gitlab['home'],
           :url => gitlab['url'],
    :repos_path => gitlab['repos_path'],
    :redis_path => gitlab['redis_path'],
    :redis_host => gitlab['redis_host'],
    :redis_port => gitlab['redis_port'],
     :namespace => gitlab['namespace']
  })
end

## Do setup
execute "gitlab-shell install" do
  command "./bin/install"
      cwd gitlab['shell_path']
     user gitlab['user']
    group gitlab['group']
   action :nothing
end
