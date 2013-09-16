GitLab Cookbook
===============

Chef to install The GitLab.

* GitLab: 6.0.0
* GitLab Shell: 1.7.1
* Ruby: 2.0.0
* Redis: 2.6.13
* Git: 1.7.12
* Nginx: 1.1.19
* PostgreSQL: 9.1.9
* MySQL: 5.5.31

## Requirements

* [Berkshelf](http://berkshelf.com/)
* [Vagrant](http://www.vagrantup.com/)

### Vagrant Plugin

* [vagrant-berkshelf](https://github.com/RiotGames/vagrant-berkshelf)
* [vagrant-omnibus](https://github.com/schisamo/vagrant-omnibus)
* [vagrant-aws](https://github.com/mitchellh/vagrant-aws)


### Platform:

* Ubuntu (12.04, 12.10)
* CentOS (6.4)


## Attributes

* Package
* User
* GitLab shell
* GitLab shell config
* GitLab hq
* GitLab hq config
* Gems
* Git


## Installation

### Vagrant

#### VirtualBox 

```bash
$ gem install berkshelf
$ vagrant plugin install vagrant-berkshelf
$ vagrant plugin install vagrant-omnibus
$ git clone git://github.com/ogom/cookbook-gitlab ./gitlab
$ cd ./gitlab/
$ vagrant up
```

#### Amazon Web Services

Create instance.

```bash
$ gem install berkshelf
$ vagrant plugin install vagrant-berkshelf
$ vagrant plugin install vagrant-omnibus
$ vagrant plugin install vagrant-aws
$ vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box
$ git clone git://github.com/ogom/cookbook-gitlab ./gitlab
$ cd ./gitlab/
$ cp ./example/Vagrantfile_aws ./Vagrantfile
$ vagrant up --provider=aws
```

HostName setting.

```bash
$ vagrant ssh-config | awk '/HostName/ {print $2}'
$ editor ./Vagrantfile
$ vagrant provision
```

### knife-solo

```bash
$ gem install berkshelf
$ gem install knife-solo
$ knife configure
$ knife solo init ./chef-repo
$ cd ./chef-repo/
$ echo 'cookbook "gitlab", github: "ogom/cookbook-gitlab"' >> ./Berksfile
$ berks install --path ./cookbooks
$ knife solo prepare vagrant@127.0.0.1 -p 2222 -i ~/.vagrant.d/insecure_private_key
$ editor ./nodes/127.0.0.1.json
$ knife solo cook vagrant@127.0.0.1 -p 2222 -i ~/.vagrant.d/insecure_private_key --no-chef-check
```


## Usage

Example of node config.

```json
{
  "postfix": {
    "mail_type": "client",
    "myhostname": "mail.example.com",
    "mydomain": "example.com",
    "myorigin": "mail.example.com",
    "smtp_use_tls": "no"
  },
  "postgresql": {
    "password": {
      "postgres": "psqlpass"
    }
  },
  "mysql": {
    "server_root_password": "rootpass",
    "server_repl_password": "replpass",
    "server_debian_password": "debianpass"
  },
  "gitlab": {
    "host": "example.com",
    "url": "http://example.com/",
    "email_from": "gitlab@example.com",
    "support_email": "support@example.com",
    "database_adapter": "postgresql",
    "database_password": "datapass"
  },
  "run_list":[
    "postfix",
    "gitlab::initial",
    "gitlab::install"
  ]
}
```

### Database use mysql.

Set `mysql` to `database_adapter`.  

```json
{
...
  "gitlab": {
    "database_adapter": "mysql"
  }
}
```

### GitLab Update

Add `gitlab::update` to `run_list`.  

```json
{
...
  "run_list":[
    "gitlab::update",
    "gitlab::initial",
    "gitlab::install"
  ]
}
```

## Done!

`http://localhost:8080/` or your server for your first GitLab login.

```
admin@local.host
5iveL!fe
```

## Links

* [GitLab Installation](https://github.com/gitlabhq/gitlabhq/blob/master/doc/install/installation.md)
* [Qiita Document](http://qiita.com/items/6491a268bfc95d0a5be4)


## License 

* MIT
