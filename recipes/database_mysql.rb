#
# Cookbook Name:: gitlab
# Recipe:: database_mysql
#

mysql = node['mysql']
gitlab = node['gitlab']

# Merge environmental variables
gitlab = Chef::Mixin::DeepMerge.merge(gitlab,gitlab[gitlab['env']])

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
gitlab['environments'].each do |environment|
  mysql_database "gitlabhq_#{environment}" do
    connection mysql_connexion
    action :create
  end

  mysql_database_user gitlab['user'] do
    connection mysql_connexion
    password gitlab['database_password']
    database_name "gitlabhq_#{environment}"
    host 'localhost'
    privileges ["SELECT", "UPDATE", "INSERT", "DELETE", "CREATE", "DROP", "INDEX", "ALTER", "LOCK TABLES"]
    action :grant
  end
end
