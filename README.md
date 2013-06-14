GitLab Cookbook
===============

Chef to install The GitLab.

* GitLab: 5.2.1
* GitLab Shell: 1.5.0
* Ruby: 1.9
* Redis: 2.6
* Git: 1.7.12

## Requirements

* [Berkshelf](http://berkshelf.com/)
* [Vagrant](http://www.vagrantup.com/)
* [vagrant-berkshelf](https://github.com/RiotGames/vagrant-berkshelf)


### Platform:

* Ubuntu (12.04, 12.10)

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

```bash
$ gem install berkshelf
$ vagrant plugin install vagrant-berkshelf
$ git clone git://github.com/ogom/cookbook-gitlab ./gitlab
$ cd ./gitlab/
$ vi ./Vagrantfile 
$ vagrant up
$ vagrant ssh
vagrant$ sudo apt-get install -y curl
vagrant$ curl -L https://www.opscode.com/chef/install.sh | sudo bash
vagrant$ exit
$ vagrant reload
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
$ vi ./nodes/127.0.0.1.json
$ knife solo cook vagrant@127.0.0.1 -p 2222 -i ~/.vagrant.d/insecure_private_key
```


## Usage

Example of node config.

```json
{
  "postfix": {
    "mail_type": "client",
    "myhostname": "mail.example.info",
    "mydomain": "example.info",
    "myorigin": "mail.example.info",
    "smtp_use_tls": "no"
  },
  "postgresql": {
    "password": {
      "postgres": "psqlpass"
    }
  },
  "gitlab": {
    "host": "gl.example.info",
    "url": "http://gl.example.info/",
    "email_from": "gitlab@example.info",
    "support_email": "support@example.info",
    "database_password": "datapass"
  },
  "run_list":[
    "postfix",
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
* [Generating SSH Keys](https://help.github.com/articles/generating-ssh-keys)


## License 


* MIT
