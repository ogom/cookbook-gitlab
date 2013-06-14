#
# Cookbook Name:: gitlab
# Recipe:: gitlab
#

gitlab = node['gitlab']

# 6. GitLab
## Clone the Source
git gitlab['path'] do
  repository gitlab['repository']
    revision gitlab['revision']
        user gitlab['user']
       group gitlab['group']
      action :sync
end

## Configure it
### Copy the example GitLab config
template File.join(gitlab['path'], 'config', 'gitlab.yml') do
  source "gitlab.yml.erb"
    user gitlab['user']
   group gitlab['group']
  variables({
               :host => gitlab['host'],
               :port => gitlab['port'],
               :user => gitlab['user'],
         :email_from => gitlab['email_from'],
      :support_email => gitlab['support_email'],
    :satellites_path => gitlab['satellites_path'],
         :repos_path => gitlab['repos_path'],
         :shell_path => gitlab['shell_path']
  })
end

### Make sure GitLab can write to the log/ and tmp/ directories
%w{log tmp}.each do |path|
  directory File.join(gitlab['path'], path) do
    owner gitlab['user']
    group gitlab['group']
     mode 0755 
  end
end

### Create directory for satellites
directory gitlab['satellites_path'] do
  owner gitlab['user']
  group gitlab['group']
end

### Create directories for sockets/pids and make sure GitLab can write to them
%w{tmp/pids tmp/sockets}.each do |path|
  directory File.join(gitlab['path'], path) do
    owner gitlab['user']
    group gitlab['group']
     mode 0755 
  end
end

### Create public/uploads directory otherwise backup will fail
%w{public/uploads}.each do |path|
  directory File.join(gitlab['path'], path) do
    owner gitlab['user']
    group gitlab['group']
     mode 0755
  end
end

### Copy the example Puma config
template File.join(gitlab['path'], "config", "puma.rb") do
  source "puma.rb.erb"
    user gitlab['user']
   group gitlab['group']
  variables({
    :path => gitlab['path']
  })
end

### Configure Git global settings for git user, useful when editing via web
bash "git config" do
   code 'git config --global user.name "GitLab" && git config --global user.email "gitlab@localhost"'
   user gitlab['user']
  group gitlab['group']
  environment('HOME' => gitlab['home'])
end

## Configure GitLab DB settings
template File.join(gitlab['path'], "config", "database.yml") do
  source "database.yml.erb"
    user gitlab['user']
   group gitlab['group']
  variables({
    :password => gitlab['database_password']
  })
end

## Install Gems
gem_package "charlock_holmes" do
  version "0.6.9.4"
  options "--no-ri --no-rdoc"
end

template File.join(gitlab['home'], ".gemrc") do
    source "gemrc.erb"
      user gitlab['user']
     group gitlab['group']
  notifies :run, "execute[bundle install]", :immediately
end

execute "bundle install" do
  command "sudo -u #{gitlab['user']} -H #{gitlab['bundle_install']}"
      cwd gitlab['path']
   action :nothing
end

execute "rake db:setup" do
  command "sudo -u #{gitlab['user']} -H bundle exec rake db:setup RAILS_ENV=production"
      cwd gitlab['path']
   not_if {File.exists?(File.join(gitlab['home'], ".gitlab_setup"))}
end

file File.join(gitlab['home'], ".gitlab_setup") do
   owner gitlab['user']
   group gitlab['group']
  action :create
end

execute "rake db:seed_fu" do
  command "sudo -u #{gitlab['user']} -H bundle exec rake db:seed_fu RAILS_ENV=production"
      cwd gitlab['path']
     user "root"
   not_if {File.exists?(File.join(gitlab['home'], ".gitlab_seed"))}
end

file File.join(gitlab['home'], ".gitlab_seed") do
   owner gitlab['user']
   group gitlab['group']
  action :create
end

# Install Init Script
template "/etc/init.d/gitlab" do
    source "initd.erb"
      mode 0755
  variables({
    :path => gitlab['path'],
    :user => gitlab['user']
  })
end

## Start Your GitLab Instance
service "gitlab" do
  supports :start => true, :stop => true, :restart => true, :status => true
    action :start
    action << :enable
end
