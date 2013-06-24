#
# Cookbook Name:: gitlab
# Recipe:: database_mysql
#

mysql = node['mysql']
gitlab = node['gitlab']

# 5.Database
include_recipe "mysql::server"
include_recipe "database::mysql"

mysql_connexion = {
      :host => 'localhost',
  :username => 'root',
  :password => mysql['server_root_password']
}

## Create a user for GitLab.
mysql_database_user gitlab['user'] do
  connection mysql_connexion
    password gitlab['database_password']
      action :create
end

## Create the GitLab database & grant all privileges on database
mysql_database "gitlabhq_#{gitlab['env']}" do
  connection mysql_connexion
      action :create
end

mysql_database_user gitlab['user'] do
     connection mysql_connexion
       password gitlab['database_password']
  database_name "gitlabhq_#{gitlab['env']}"
           host 'localhost'
     privileges [:select, :update, :insert, :delete, :create, :drop, :index, :alter]
         action :grant
end
